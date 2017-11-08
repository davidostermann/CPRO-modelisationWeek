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
INSERT INTO users(id, firstname, lastname) VALUES (DEFAULT, 'David', 'Ostermann');

INSERT INTO users_todos(user_id, todo_id) VALUES (1, 3);
INSERT INTO users_todos(user_id, todo_id) VALUES (1, 2);
INSERT INTO users_todos(user_id, todo_id) VALUES (1, 4);

# NodeJS 

- POST
- PUT
- DELETE

# Docker web container in services (docker-compose)

* Ajouter un .Dockerfile
* Build : docker build .

REF : https://blog.codeship.com/using-docker-compose-for-nodejs-development/
