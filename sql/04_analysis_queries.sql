USE banking_analytics;

SELECT
    (SELECT COUNT(*) FROM customers) AS total_customers,
    (SELECT COUNT(*) FROM accounts) AS total_accounts,
    (SELECT COUNT(*)
     FROM accounts
     WHERE account_status = 'Active') AS active_accounts,
    (SELECT COUNT(*) FROM transactions) AS total_transactions,
    (SELECT ROUND(SUM(amount), 2)
     FROM transactions) AS total_transaction_value,
    (SELECT ROUND(AVG(amount), 2)
     FROM transactions) AS average_transaction_value,
    (SELECT COUNT(*)
     FROM transactions
     WHERE transaction_status = 'Failed') AS failed_transactions,
    (SELECT ROUND(
        SUM(transaction_status = 'Failed') * 100.0
        / COUNT(*), 2)
     FROM transactions) AS failure_rate;


SELECT
    DATE_FORMAT(transaction_date, '%Y-%m') AS month,
    COUNT(*) AS total_transactions,
    ROUND(SUM(amount), 2) AS total_transaction_value,
    ROUND(AVG(amount), 2) AS average_transaction_value
FROM transactions
GROUP BY DATE_FORMAT(transaction_date, '%Y-%m')
ORDER BY month;


SELECT
    transaction_type,
    COUNT(*) AS transaction_count,
    ROUND(SUM(amount), 2) AS total_transaction_value,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM transactions),
        2
    ) AS percentage
FROM transactions
GROUP BY transaction_type
ORDER BY transaction_count DESC;


SELECT
    payment_method,
    COUNT(*) AS total_transactions,
    ROUND(SUM(amount), 2) AS total_transaction_value,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM transactions),
        2
    ) AS transaction_share
FROM transactions
GROUP BY payment_method
ORDER BY total_transactions DESC;


SELECT
    transaction_status,
    COUNT(*) AS total_transactions,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM transactions),
        2
    ) AS percentage
FROM transactions
GROUP BY transaction_status
ORDER BY total_transactions DESC;


SELECT
    transaction_type,
    COUNT(*) AS total_transactions,
    SUM(transaction_status = 'Failed') AS failed_transactions,
    ROUND(
        SUM(transaction_status = 'Failed') * 100.0
        / COUNT(*),
        2
    ) AS failure_rate
FROM transactions
GROUP BY transaction_type
ORDER BY failure_rate DESC;


SELECT
    b.branch_name,
    b.city,
    COUNT(t.transaction_id) AS total_transactions,
    ROUND(SUM(t.amount), 2) AS total_transaction_value,
    ROUND(AVG(t.amount), 2) AS average_transaction_value
FROM branches b
JOIN accounts a
    ON b.branch_id = a.branch_id
JOIN transactions t
    ON a.account_id = t.account_id
GROUP BY
    b.branch_id,
    b.branch_name,
    b.city
ORDER BY total_transaction_value DESC;


SELECT
    b.branch_name,
    b.city,
    COUNT(t.transaction_id) AS total_transactions,
    ROUND(SUM(t.amount), 2) AS total_transaction_value
FROM branches b
JOIN accounts a
    ON b.branch_id = a.branch_id
JOIN transactions t
    ON a.account_id = t.account_id
GROUP BY
    b.branch_id,
    b.branch_name,
    b.city
ORDER BY total_transaction_value DESC
LIMIT 5;


SELECT
    c.customer_id,
    c.customer_name,
    c.city,
    COUNT(t.transaction_id) AS transaction_count,
    ROUND(SUM(t.amount), 2) AS total_transaction_value
FROM customers c
JOIN accounts a
    ON c.customer_id = a.customer_id
JOIN transactions t
    ON a.account_id = t.account_id
GROUP BY
    c.customer_id,
    c.customer_name,
    c.city
ORDER BY total_transaction_value DESC
LIMIT 10;



SELECT
    c.customer_id,
    c.customer_name,
    c.city,
    COUNT(t.transaction_id) AS total_transactions
FROM customers c
JOIN accounts a
    ON c.customer_id = a.customer_id
JOIN transactions t
    ON a.account_id = t.account_id
GROUP BY
    c.customer_id,
    c.customer_name,
    c.city
ORDER BY total_transactions DESC
LIMIT 10;


SELECT
    city,
    COUNT(*) AS customer_count
FROM customers
GROUP BY city
ORDER BY customer_count DESC;


SELECT
    account_type,
    COUNT(*) AS account_count,
    ROUND(AVG(balance), 2) AS average_balance,
    ROUND(SUM(balance), 2) AS total_balance
FROM accounts
GROUP BY account_type
ORDER BY account_count DESC;


SELECT
    account_status,
    COUNT(*) AS account_count,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM accounts),
        2
    ) AS percentage
FROM accounts
GROUP BY account_status
ORDER BY account_count DESC;


SELECT
    DAYNAME(transaction_date) AS day_of_week,
    COUNT(*) AS total_transactions,
    ROUND(SUM(amount), 2) AS total_transaction_value
FROM transactions
GROUP BY DAYNAME(transaction_date), DAYOFWEEK(transaction_date)
ORDER BY DAYOFWEEK(transaction_date);


SELECT
    HOUR(transaction_date) AS transaction_hour,
    COUNT(*) AS total_transactions,
    ROUND(SUM(amount), 2) AS total_transaction_value
FROM transactions
GROUP BY HOUR(transaction_date)
ORDER BY transaction_hour;

