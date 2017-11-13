# Un projet en NodeJS

## Creation du projet

### Initialiser npm (creation du package.json) :

  ```
  npm init
  ```

### Installer les librairies express et node-postgres :

```
npm i -S express pg
```

### Créer le fichier de base de notre application :

```
touch index.js
```

### Créer le server :

```
const express = require('express')
const app = express()

app.listen(3000, function(err) {
  if(err) {
    console.log('NO CONNEXION')
  }
  console.log('CONNEXTION REUSSI SUR LE PORT 3000')
})
```

### Créer la première route :

```
app.get('/', (req, res) => {
  res.send('coucou')
})
```

### Créer la connexion à la base de donnée :

```
const { Client } = require('pg')
const db = new Client({
  connectionString: 'postgres://user1:changeme@localhost:5432/tododb'
})
db.connect().then( () => {
  console.log('Successfully connected')
}).catch( (err) => {
  console.log('Connection error :', err)
})
```

### Créer la routes d'api pour récupérer toutes les todos :

```
app.get('/todos', (req, res) => {
  db.query('SELECT * from todos').then( (data) => {
    res.send(data.rows)
  }).catch( err => {
    res.send(JSON.stringify(err))
  })
})
```
