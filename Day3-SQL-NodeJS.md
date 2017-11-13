# SQL Many to many relationship

```
CREATE TABLE users(
 id SERIAL PRIMARY KEY,
 lastname varchar(255),
 firstname varchar(255)
); 
```

``` 
DROP TABLE users_todos;
CREATE TABLE users_todos(
 user_id integer REFERENCES users ON DELETE CASCADE,
 todo_id integer REFERENCES todos ON DELETE CASCADE,
 PRIMARY KEY (user_id, todo_id)
);
``` 

``` 
INSERT INTO users(id, firstname, lastname) VALUES (DEFAULT, 'David', 'Ostermann');
``` 

``` 
INSERT INTO users_todos(user_id, todo_id) VALUES (1, 3);
INSERT INTO users_todos(user_id, todo_id) VALUES (1, 2);
INSERT INTO users_todos(user_id, todo_id) VALUES (1, 4);
``` 

## Spec : Trouver toutes les todos qui ont la categorie id=10 (one to many)

```SQL
SELECT * FROM todos WHERE category_id=10 
```

```SQL
SELECT * FROM todos, categories WHERE category_id=10 AND categories.id = 10;
```

```SQL
SELECT * FROM todos INNER JOIN categories ON categories.id=10 WHERE category_id=10;
```

```SQL
SELECT * FROM todos INNER JOIN categories ON categories.id=todos.category_id WHERE category_id=10;
``` 

## Spec : Trouver toutes les todos du user qui a l'id=1 (many to may)

```SQL 
SELECT * FROM todos, users_todos WHERE id = todo_id AND user_id = 1;
``` 

```SQL 
SELECT id, name, todo_id, user_id FROM todos, users_todos WHERE id = todo_id AND user_id = 1;
``` 

```SQL 
SELECT todo.id, todo.name, users_todos.todo_id, users_todos.user_id FROM todos, users_todos WHERE id = todo_id AND user_id = 1;
``` 

```SQL 
SELECT * FROM users_todos INNER JOIN todos ON todos.id = users_todos.todo_id AND users_todos.user_id=1;
``` 

## Spec : Trouver les todos correpondant à la catégorie qui à l'id 10 avec, pour chaque todo, les noms des users associés.

```SQL
SELECT todos.id, todos.name, lastname, firstname FROM todos 
INNER JOIN users_todos ON todo_id=todos.id 
INNER JOIN users ON users.id = users_todos.user_id
WHERE category_id=10;
``` 

## Spec : Donne-moi tous les users correspondant à la catégories 4

```SQL
SELECT lastname, firstname, users.id, todos.id AS todo_id, todos.name AS todo_name FROM users 
INNER JOIN users_todos ON users.id = users_todos.user_id
INNER JOIN todos ON todos.id = users_todos.todo_id
WHERE todos.category_id = 4;
```

# NodeJS 

## POST

Pour pouvoir parser ce qui arrive dans le body de la requête, il faut ajouter body-parser. Body-parser fait, à présent parti de express. Nous souhaitons utiliser JSON comme format d'échange.

Nous allons donc rajouter le middleware (body-parser) comme ceci :

```javascript
app.use(express.json());
```

```javascript 
app.post('/todo', (req, res) => {
 const { name, categoryId } = req.body; // es6 destructuring
  db.query('INSERT INTO todos(id, name, category_id) VALUES (DEFAULT, $1, $2);', [name, categoryId]).then((data) => {
    res.json(data)
  }).catch(err => {
    res.send(JSON.stringify(err))
  })
})
``` 

## GET /user/[ID]/todos

Donne-moi les todos correspondant à un user qui à l'id passé en params [ID] (cf. express doc.)

```javascript
app.get('/user/:id/todos', (req, res) => {
  const { id } = req.params;
  db.query(`SELECT * FROM todos, users_todos WHERE id = todo_id AND user_id = ${id}`).then((data) => {
    res.send(data.rows)
  }).catch(err => {
    console.log('err : ', err);
    res.json(err)
  })
})
```


## GET /category/[ID]/todos

Donne-moi les todos liées à la catégories avec l'id passé en params [ID]

```javascript
app.get('/category/:id/todos', (req, res) => {
  const { id } = req.params;
  db.query(`SELECT * FROM todos WHERE category_id=${id}`).then((data) => {
    res.send(data.rows)
  }).catch(err => {
    console.log('err : ', err);
    res.json(err)
  })
})
```

## GET /category/[ID]/todos/full (avec les users associés)

Donne-moi les todos liées à la catégories avec l'id passé en params [ID] avec pour chaque catégorie les users associés à celle-ci.


```javascript
const tranformRowResult = (acc, nextItem) => {

  if (acc[nextItem.todo_id]) {
    acc[nextItem.todo_id].users[nextItem.user_id] = nextItem.user_name
  } else {
    acc[nextItem.todo_id] = {
      id: nextItem.todo_id,
      name: nextItem.todo_name,
      users: { [nextItem.user_id]: nextItem.user_name }
    }
  }
  return acc

}

app.get('/category/:id/todos/full', (req, res) => {
  const { id } = req.params;
  db.query(`SELECT todos.id as todo_id, 
  todos.name as todo_name, users.id as user_id, 
  CONCAT(lastname,' ',firstname) as user_name FROM todos 
INNER JOIN users_todos ON todo_id=todos.id 
INNER JOIN users ON users.id = users_todos.user_id
WHERE category_id=${id};`).then((data) => {
    
    res.send(data.rows.reduce(tranformRowResult, {}))
    //res.send(data.rows)
  }).catch(err => {
    console.log('err : ', err);
    res.json(err)
  })
})
``` 

## GET /category/[ID]/users

Donne-moi les users associés à la catégories qui l'id passé en params [ID]

## PUT

### EN SQL :
```SQL
UPDATE users SET firstname = 'Faustino' WHERE id=2;
```

### EN JS :
```javascript
app.put('/user/:id', (req, res) => {
  const { id } = req.params;
  const { firstname, lastname } = req.body; // es6 destructuring
  db.query(`UPDATE users 
    SET firstname = '${firstname}', lastname = '${lastname}'
   WHERE id=${id};`).then((data) => {
    res.json(data)
  }).catch(err => {
    res.json(err)
  })
})
```

## DELETE

### EN SQL :
```SQL
DELETE FROM users WHERE id=2;
```

### EN JS :
```javascript
app.delete('/user/:id', (req, res) => {
  const { id } = req.params;
  db.query(`DELETE FROM users WHERE id=${id};`).then((data) => {
      res.json(data)
    }).catch(err => {
      res.json(err)
    })
})
```

## Accéder à notre API

Pour accéder à notre API de n'importe quel IP ou PORT, nous allons utiliser CORS

### installer cors

```bash
npm i -S cors
```

### Ajouter le middleware cors

```javascript
app.use( cors())
```

### doc de cors

https://github.com/expressjs/cors

Autrement simplement ajouter un header à toutes vos responses :

```javascript
res.header("Access-Control-Allow-Origin", "*");
```

# Docker web container in services (docker-compose)

* Ajouter un .Dockerfile
* Build : docker build .

REF : https://blog.codeship.com/using-docker-compose-for-nodejs-development/
