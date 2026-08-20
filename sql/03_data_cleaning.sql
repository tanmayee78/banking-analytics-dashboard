USE banking_analytics;

UPDATE transactions
SET transaction_status =
    CASE
        WHEN MOD((transaction_id - 900001) * 37, 10000) < 300
            THEN 'Failed'
        WHEN MOD((transaction_id - 900001) * 37, 10000) < 900
            THEN 'Pending'
        ELSE 'Successful'
    END
WHERE transaction_id BETWEEN 900001 AND 910000;

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
