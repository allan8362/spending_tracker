DROP TABLE IF EXISTS merchants;
DROP TABLE IF EXISTS expenses;

CREATE TABLE merchants (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  tag VARCHAR
);

CREATE TABLE expenses (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  budget FLOAT
);
