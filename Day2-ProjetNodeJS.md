### Un projet en container

  * Initialiser npm
  ```
  npm init
  ```

  * Installer les librairies 
  ```
  npm install express pg pg-promise
  ```

  * touch index.js

  ```
  // init PostgreSQL DB

  const initOptions = {
    connect(client, dc, isFresh) {
      // A connection-related success;
      console.log('Connected to datbase:', client.connectionParameters.database);
    },
    error(error, e) {
      if (e.cn) {
        // A connection-related error;
        console.log("CN:", e.cn);
        console.log("EVENT:", error.message);
      }
    }
  };

  const pgp = require('pg-promise')(initOptions);
  const db = pgp(process.env.DATABASE_URL || 'postgres://postgres:changeme@localhost:5432/tododb');

  db.connect()
    .then(function (obj) {
      obj.done(); // success, release connection;
    })
    .catch(function (error) {
      console.log("ERROR:", error.message);
    });

  // init express

  const express = require('express')
  const app = express()
  app.use(express.json())

  // routes management

  app.get('/', (req, res) => {
    return res.send('coucou')
  })

  const port = process.env.PORT || 3000

  app.listen(port, (err) => {
    if(err) {
      return err;
    }
    console.log('server listen on ', port);
    
  })

  ```





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

  REF : https://blog.codeship.com/using-docker-compose-for-nodejs-development/