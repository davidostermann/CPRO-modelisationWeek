# SQL Many to many relationship

```
CREATE TABLE users(
 id SERIAL PRIMARY KEY,
 lastname varchar(255),
 firstname varchar(255)
); 
```

``` 
CREATE TABLE users_todos(
 user_id integer REFERENCES users,
 todo_id integer REFERENCES todos
); 
``` 

# NodeJS 

- POST
- PUT
- DELETE

# Docker web container in services (docker-compose)

* Ajouter un .Dockerfile
* Build : docker build .

REF : https://blog.codeship.com/using-docker-compose-for-nodejs-development/
