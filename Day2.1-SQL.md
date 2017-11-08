# Faire des requêtes SQL dans l'interface d'administration

## Créer la structure de la base pour une application de todos

### Spécification :

- Une todo à un id et un name
- Une todo peut avoir une catégorie
- Une categorie peut avoir plusieurs todos

## Mise en place des tables

### Démarrer la base de donnée PostgreSQL et Adminer

```
docker-compose up
```
(cf. Day1-docker.md)

### Accéder à l'espace d'administration de la BDD (Adminer)

http://localhost:8080
(cf. Day1-docker.md pour les credentials)

### Accéder à la page de requête dans Adminer

ex. http://localhost:8080/?pgsql=db&username=user1&db=tododb&ns=public&sql=

### Créer une table "todos" avec les colonnes suivantes :

  - id
  - name
  - categoy_id

  ```
  CREATE TABLE todos(
    id SERIAL PRIMARY KEY
    name VARCHAR(255)
    category_id INTEGER
  );
  ```
  
### Créer une table "categories" avec les colonnes suivantes :

  - id
  - name

  ```
  CREATE TABLE categories(
    id SERIAL PRIMARY KEY
    name VARCHAR(255)
  );
  ```
  
### Ajouter une foreign key sur category_id de todos pour lier la table todos

```
ALTER TABLE todos ADD FOREIGN KEY (category_id) REFERENCES categories(id);
```

## Insérer des données

### Ajouter des catégories

```
INSERT INTO categories(id, name) VALUES [DEFAULT, 'Backlogs'];
INSERT INTO categories(id, name) VALUES [DEFAULT, 'A faire'];
INSERT INTO categories(id, name) VALUES [DEFAULT, 'En cours'];
INSERT INTO categories(id, name) VALUES [DEFAULT, 'Fait'];
```

### Ajouter des todos liées aux catégories

```
INSERT INTO todos(id, name, category_id) VALUES (DEFAULT, 'Faire une requête SQL', 4]);
INSERT INTO todos(id, name, category_id) VALUES (DEFAULT, 'Faire une appli NodeJS', 4);
INSERT INTO todos(id, name, category_id) VALUES (DEFAULT, 'Connecter l'appli à la BDD, 3);
INSERT INTO todos(id, name, category_id) VALUES (DEFAULT, 'Créer des routes d'API', 2);
INSERT INTO todos(id, name, category_id) VALUES (DEFAULT, 'Créer la web pour interroger l''API', 2);
```

## Selectionner les données

### Selectionner toutes les todos :

```
SELECT * FROM todos;
```

### Selectionner toutes les todos :

```
SELECT * FROM todos WHERE id=2;
```
