DROP TABLE IF EXISTS merchants;
DROP TABLE IF EXISTS expenses;
DROP TABLE IF EXISTS banks;

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

CREATE TABLE banks (
  id SERIAL PRIMARY KEY,
  account_number INT,
  name VARCHAR(255),
  type VARCHAR(255),
  balance FLOAT
);
