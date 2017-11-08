DROP TABLE users_todos;
DROP TABLE users;
DROP TABLE todos;
DROP TABLE categories;
CREATE TABLE categories(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE todos(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  category_id INTEGER REFERENCES categories
);

CREATE TABLE users(
 id SERIAL PRIMARY KEY,
 lastname varchar(255),
 firstname varchar(255)
);

CREATE TABLE users_todos(
 user_id integer REFERENCES users ON DELETE CASCADE,
 todo_id integer REFERENCES todos ON DELETE CASCADE,
 PRIMARY KEY (user_id, todo_id)
);

INSERT INTO categories(id, name) VALUES (DEFAULT, 'Backlogs');
INSERT INTO categories(id, name) VALUES (DEFAULT, 'A faire');
INSERT INTO categories(id, name) VALUES (DEFAULT, 'En cours');
INSERT INTO categories(id, name) VALUES (DEFAULT, 'Fait');

INSERT INTO todos(id, name, category_id) VALUES (DEFAULT, 'Faire une requête SQL', 4);
INSERT INTO todos(id, name, category_id) VALUES (DEFAULT, 'Faire une appli NodeJS', 4);
INSERT INTO todos(id, name, category_id) VALUES (DEFAULT, 'Connecter l''appli à la BDD', 3);
INSERT INTO todos(id, name, category_id) VALUES (DEFAULT, 'Créer des routes d''API', 2);
INSERT INTO todos(id, name, category_id) VALUES (DEFAULT, 'Créer la web pour interroger l''API', 2);

INSERT INTO users(id, firstname, lastname) VALUES (DEFAULT, 'David', 'Ostermann');
INSERT INTO users(id, firstname, lastname) VALUES (DEFAULT, 'Faustino', 'Kialungila');
INSERT INTO users(id, firstname, lastname) VALUES (DEFAULT, 'Paljor', 'Tsang');

INSERT INTO users_todos(user_id, todo_id) VALUES (1, 3);
INSERT INTO users_todos(user_id, todo_id) VALUES (1, 2);
INSERT INTO users_todos(user_id, todo_id) VALUES (1, 4);
INSERT INTO users_todos(user_id, todo_id) VALUES (2, 1);
INSERT INTO users_todos(user_id, todo_id) VALUES (2, 2);
INSERT INTO users_todos(user_id, todo_id) VALUES (2, 5);
INSERT INTO users_todos(user_id, todo_id) VALUES (3, 4);
INSERT INTO users_todos(user_id, todo_id) VALUES (3, 5);
INSERT INTO users_todos(user_id, todo_id) VALUES (3, 3);