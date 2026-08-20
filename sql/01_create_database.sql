```sql
CREATE DATABASE banking_analytics;

USE banking_analytics;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    gender VARCHAR(10),
    age INT,
    city VARCHAR(50),
    signup_date DATE
);

CREATE TABLE branches (
    branch_id INT PRIMARY KEY,
    branch_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    region VARCHAR(30)
);

CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    branch_id INT NOT NULL,
    account_type VARCHAR(20),
    opening_date DATE,
    balance DECIMAL(12,2),
    account_status VARCHAR(20),

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    FOREIGN KEY (branch_id)
        REFERENCES branches(branch_id)
);

CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    account_id INT NOT NULL,
    transaction_date DATETIME,
    transaction_type VARCHAR(20),
    amount DECIMAL(12,2),
    payment_method VARCHAR(30),
    transaction_status VARCHAR(20),

    FOREIGN KEY (account_id)
        REFERENCES accounts(account_id)
);
```
