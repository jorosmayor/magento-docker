# Dockerizando Magento

_Instalación de Magento sobre Docker con los servcios de Redis, Elastic-Search, Rabbit-MQ, MySQL y php-fpm._

### Pre-requisitos 📋

_Necesitarás tener instalado Docker_

```
Docker 20.10.21
```

### Instalación 🔧

_Descarga el proyecto_

```
git pull
```

_Accede al directorio dev_

```
cd dev/
```

_Para el setup_

```
sh setup.sh
```

_Accede a localhost paa ver el proyecto_

_Tras el primer setup, puedes parar e iniciar los contenedores con:_

```
docker-compose down
docker-compose up -d
```

## Comprobar funcionamiento

_Redis_

```
docker exec dev_redis_1 redis-cli monitor
```
Recarga la web y observa el terminal

_Elastic-Search_

```
docker logs dev_elasticsearch_1
```
Puedes ver los logs que ha realizado tras la instalación

_Rabbit-MQ_

Accede a localhost:15672 con el usuario rabbit y contraseña rabbitpassword, puedes ver la información de las colas en el dashboard.