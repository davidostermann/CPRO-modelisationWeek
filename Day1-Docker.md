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

### Un projet en container

REF : https://blog.codeship.com/using-docker-compose-for-nodejs-development/

  * Créer votre projet
  * Ajouter un .Dockerfile
  * Build : docker build .
  * Recuperer l'image de POSTGRES sur le hub : docker pull posgres
  * Ajouter un docker-compose.yml (cf. blog post)
  
  En plus du blog post :
  
  * Ajouter un port de sortie pour postgres : - "5432:5432" pour pouvoir utiliser POSTICO (sur mac OSX)
  * Pour tester psql : docker exec -ti ec6e054ece98 psql -U postgres
  * Vous pouvez ajouter PhpMyAdmin to the docker-composer (ou Admirer / iso phpMyAdmin : https://hub.docker.com/_/adminer/)
  * Au final, vous pouvez ajouter de la persistance en ajoutant un volume pour postgres dans votre docker-composer.yml.
  
  A SUIVRE : Docker swarm.
  
  
  
