-- create tables
CREATE TABLE film (
    id serial PRIMARY KEY NOT NULL,
    name varchar(80),
    year integer NOT NULL
);

CREATE TABLE genre_film (
    id serial PRIMARY KEY,
    film_id integer REFERENCES film (id),
    title_name varchar(80) NOT NULL
);

-- seeding the tables 
INSERT INTO
  film (name, year)
VALUES
  ('Film 1', 2005),
  ('Film 2', 2010),
  ('Film 3', 2015),
  ('Film 4', 2020);

INSERT INTO genre_film (film_id, title_name)
VALUES
  (1, 'Action'),
  (2, 'Drama'),
  (2, 'Action'),
  (4, 'Comedy'),
  (3, 'Comedy');

-- print 
SELECT
  film.name AS film_name,
  film.year AS film_year,
  STRING_AGG(genre_film.title_name, ', ') AS genres
FROM
  film
  JOIN genre_film ON film.id = genre_film.film_id
GROUP BY
  film.name, film.year;

-- getting information about movies released after 2010 that have a genre of 'Comedy'
SELECT
  film.name AS film_name,
  film.year AS film_year,
  STRING_AGG(genre_film.title_name, ', ') AS genres
FROM
  film
  JOIN genre_film ON film.id = genre_film.film_id
WHERE
  film.year > 2010 AND genre_film.title_name = 'Comedy'
GROUP BY
  film.name, film.year;

-- getting information about movies that fall into more than one genre
SELECT
  film.name AS film_name,
  film.year AS film_year,
  STRING_AGG(genre_film.title_name, ', ') AS genres
FROM
  film
  JOIN genre_film ON film.id = genre_film.film_id
GROUP BY
  film.name, film.year
HAVING
  COUNT(genre_film.title_name) > 1;

-- getting the average, maximum and minimum release date of movies
SELECT
  ROUND(AVG(year), 2) AS average_year,
  MAX(year) AS max_year,
  MIN(year) AS min_year
FROM
  film;

-- getting information about movies whose title contains the word 'Film'
SELECT
  film.name AS film_name,
  film.year AS film_year,
  STRING_AGG(genre_film.title_name, ', ') AS genres
FROM
  film
  JOIN genre_film ON film.id = genre_film.film_id
WHERE
  film.name LIKE '%Film%'
GROUP BY
  film.name, film.year;