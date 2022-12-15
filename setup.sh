# Creación de los contenedores
docker-compose up -d --build

# Esperamos que todos los contenedores esten listos
sleep 5

# Descarga del repositorio de Magento
docker exec dev_php_1 composer create-project --repository-url=https://repo.magento.com/ magento/project-community-edition=2.4.5p1 /var/www/html

# Permisos de los archvios y directorios
docker exec dev_php_1 find var generated vendor pub/static pub/media app/etc -type f -exec chmod g+w {} +
docker exec dev_php_1 find var generated vendor pub/static pub/media app/etc -type d -exec chmod g+ws {} +
docker exec dev_php_1 chown -R :www-data .
docker exec dev_php_1 chmod u+x bin/magento

# Instalación del repositorio de Magento
docker exec dev_php_1 bin/magento setup:install --db-host=bbdd_magento \
  --db-name=magento\
  --db-user=magento \
  --db-password=magento \
  --base-url=http://localhost/ \
  --admin-firstname=Jordi \
  --admin-lastname=Ros \
  --admin-email=jordiros@onestic.com \
  --admin-user=adminjordi \
  --admin-password='admin123' \
  --language=es_ES \
  --currency=EUR \
  --use-rewrites=1 \
  --use-secure=1 \
  --use-secure-admin=1 \
  --timezone=Europe/Madrid \
  --elasticsearch-host=es_magento \
  --elasticsearch-port=9200 \
  --amqp-host=rabbit_magento \
  --amqp-port=5672 \
  --amqp-user=rabbit\
  --amqp-password=rabbitpassword

# Configuración Redis para Magento tanto de cache backend como de páginas
docker exec --user root dev_php_1 bin/magento setup:config:set --cache-backend=redis --cache-backend-redis-server=redis_magento --cache-backend-redis-db=0
docker exec --user root dev_php_1 bin/magento setup:config:set --page-cache=redis --page-cache-redis-server=redis_magento --page-cache-redis-db=1

# Copia del archivo de claves a lacarpeta composer de Magento
docker exec dev_php_1 cp /root/.composer/auth.json /var/www/html/var/composer_home/
docker exec dev_php_1 bin/magento sampledata:deploy

# Setup y cache
docker exec dev_php_1 bin/magento setup:upgrade
docker exec dev_php_1 bin/magento cache:flush

# Reinicio de los contendores
docker-compose restart