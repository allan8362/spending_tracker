DROP TABLE IF EXISTS transactions;
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
  account_number BIGINT,
  name VARCHAR(255),
  type VARCHAR(255),
  balance FLOAT
);

CREATE TABLE transactions (
  id SERIAL PRIMARY KEY,
  transaction_date VARCHAR(255),
  amount FLOAT,
  merchant_id INT REFERENCES merchants(id) ON DELETE CASCADE,
  transaction_desc VARCHAR(255),
  bank_id INT REFERENCES banks(id) ON DELETE CASCADE,
  expense_id INT REFERENCES expenses(id) ON DELETE CASCADE
);
