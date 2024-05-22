-- creating a car table with constraints
CREATE TABLE car (
  id serial PRIMARY KEY,
  car_model varchar(80) NOT NULL,
  year integer,
  CONSTRAINT chk_car_model CHECK (car_model <> '')
);

-- create a client table with constraints
CREATE TABLE client (
  id serial PRIMARY KEY,
  name varchar(80) NOT NULL,
  CONSTRAINT chk_client_name CHECK (name <> '')
);

-- creating a communication table car_client with constraints
CREATE TABLE car_client (
  car_id integer NOT NULL,
  client_id integer NOT NULL,
  CONSTRAINT fk_car FOREIGN KEY (car_id) REFERENCES car (id) ON DELETE CASCADE,
  CONSTRAINT fk_client FOREIGN KEY (client_id) REFERENCES client (id) ON DELETE CASCADE,
  PRIMARY KEY (car_id, client_id)
);

-- filling in the car table
INSERT INTO car (car_model, year)
VALUES
  ('Car_model_1', 1990),
  ('Car_model_2', 1998),
  ('Car_model_3', 2000),
  ('Car_model_4', 2020),
  ('Car_model_5', 2025);

-- filling in the client table
INSERT INTO client (name)
VALUES
  ('Mike'),
  ('John'),
  ('Jessika'),
  ('Merilin'),
  ('Kevin'),
  ('Lika');

-- filling in the communication table  car_client
INSERT INTO car_client (car_id, client_id)
VALUES
  (1, 1),
  (1, 4),
  (2, 1),
  (2, 2),
  (3, 3),
  (4, 3),
  (4, 4),
  (5, 5);

-- get information about customers and their cars
SELECT
  client.name AS client_name,
  car.car_model AS car_model,
  car.year AS car_year
FROM
  car_client
  JOIN client ON car_client.client_id = client.id
  JOIN car ON car_client.car_id = car.id;

-- get information about customers and their cars in the form of a string
SELECT
  client.name AS client_name,
  STRING_AGG(car.car_model, ', ') AS owned_cars
FROM
  car_client
  JOIN client ON car_client.client_id = client.id
  JOIN car ON car_client.car_id = car.id
GROUP BY
  client.name;

-- delete tables
DROP TABLE IF EXISTS car_client;
DROP TABLE IF EXISTS car;
DROP TABLE IF EXISTS client;

-- creating a car table with constraints
CREATE TABLE car (
  id serial PRIMARY KEY,
  car_model varchar(80) NOT NULL,
  year integer,
  CONSTRAINT chk_car_model CHECK (car_model <> ''),
  CONSTRAINT uniq_car_model UNIQUE (car_model)
);

-- creating a client table with constraints
CREATE TABLE client (
  id serial PRIMARY KEY,
  name varchar(80) NOT NULL,
  CONSTRAINT chk_client_name CHECK (name <> ''),
  CONSTRAINT uniq_client_name UNIQUE (name)
);

-- creating a connect car_client with constraints
CREATE TABLE car_client (
  car_id integer NOT NULL,
  client_id integer NOT NULL,
  CONSTRAINT fk_car FOREIGN KEY (car_id) REFERENCES car (id) ON DELETE CASCADE,
  CONSTRAINT fk_client FOREIGN KEY (client_id) REFERENCES client (id) ON DELETE CASCADE,
  PRIMARY KEY (car_id, client_id)
);

-- filling car table
INSERT INTO car (car_model, year)
VALUES
  ('Car_model_1', 1990),
  ('Car_model_2', 1998),
  ('Car_model_3', 2000),
  ('Car_model_4', 2020),
  ('Car_model_5', 2025);

-- filling client table
INSERT INTO client (name)
VALUES
  ('Mike'),
  ('John'),
  ('Jessika'),
  ('Merilin'),
  ('Kevin'),
  ('Lika');

-- filling car_client table
INSERT INTO car_client (car_id, client_id)
VALUES
  (1, 1),
  (1, 4),
  (2, 1),
  (2, 2),
  (3, 3),
  (4, 3),
  (4, 4),
  (5, 5);

-- getting information on customers who have a 2020 or later vehicle
SELECT
  client.name AS client_name,
  car.car_model AS car_model,
  car.year AS car_year
FROM
  car_client
  JOIN client ON car_client.client_id = client.id
  JOIN car ON car_client.car_id = car.id
WHERE
  car.year >= 2020;

-- retrieving information about clients whose name contains the letter 'i'
SELECT
  client.name AS client_name,
  car.car_model AS car_model,
  car.year AS car_year
FROM
  car_client
  JOIN client ON car_client.client_id = client.id
  JOIN car ON car_client.car_id = car.id
WHERE
  client.name LIKE '%i%';

-- obtaining information on customers with more than one vehicle
SELECT
  client.name AS client_name,
  COUNT(car_client.car_id) AS number_of_cars
FROM
  car_client
  JOIN client ON car_client.client_id = client.id
GROUP BY
  client.name
HAVING
  COUNT(car_client.car_id) > 1;

-- receiving information about customers and their cars in the form of a string
SELECT
  client.name AS client_name,
  STRING_AGG(car.car_model, ', ') AS owned_cars
FROM
  car_client
  JOIN client ON car_client.client_id = client.id
  JOIN car ON car_client.car_id = car.id
GROUP BY
  client.name;