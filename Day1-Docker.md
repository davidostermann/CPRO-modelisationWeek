# CPRO-modelisationWeek
5 days about Database conception

# Day 1

## Docker 

### Comprendre Docker

Docker permet de gérer, de télécharger, de configurer des virtual machines avec de simple fichier de configuration.

Docker fonctionne avec les hébergeur VPC (Virtual cloud) et les platform qui supporte les CAAS (container as a servive).

Docker fonctionne aussi très bien en local grâce à Docker engine. Docker engine s'installe sur Mac, Windows et Linux.

Le grand avantage de docker est que les containers et services Docker peuvent être utilisé en local et déployé sur les serveur qui prennent en charge les containers (AWS, Digital Ocean, Heroku, Zeit Now, Google Cloud, Microsoft Azure) et sur les machines de vos collègues.

#### Docker engine

Le docker engine gére les container Docker et permet à l'utilisateur de gérer ses containers grâce à un commande cli (build, run, stop, ps, rm, ...)

#### Docker containers

Un container est une instance docker qui est géré par le docker engine (run, stop, ps, ...) et qui utilise une machine virtuelle

#### Docker Hub

Ils existent des centaines de container pré-buildé. On regardera, en particulier, node:alpine et posgres. Il existe aussi des images pour mongodb, mysql, phpmyadmin, ...

Les containers publiés peuvent être basé sur d'autre container. Et c'est super pratique pour créer ses configurations projet.

Sur le docker hub, vous pouvez eventuellement publier votre propre container.

### Une base POSTGRES et un espace d'admin avec docker-compose

1. Créer un dossier 

  ``` 
  mkdir demo-docker-compose 
  ```

2. Rentrer dans le dossier 

  ```
  cd demo-docker-compse 
  ```

3. Créer un fichier docker-compose.yml 

  ```
  touch docker-compose.yml
  ```

4. Ecrire le contenu suivant dans le fichier docker-compose.yml :

```  

version: '2'
services :
  db:
    image: postgres:10-alpine
    ports:
      - "5432:5432"
    environment:
      POSTGRES_USER: user1
      POSTGRES_PASSWORD: changeme
      POSTGRES_DB: tododb
  admin:
    image: adminer
    restart: always
    depends_on: 
      - db
    ports:
      - 8080:8080

```
cf. https://gist.github.com/davidostermann/0190da1e1544dfd1625e53ca8a74e258

5. Démarrer docker-compose

```
docker-compose up
``` 

6. Accéder à la base de donnée avec adminer : http://localhost:8080

  ```
    System : PostgreSQL
    Server : db
    Username : user1
    Password : changeme
    Database : tododb
  ```

  


  
  
  
