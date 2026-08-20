USE banking_analytics;

INSERT INTO branches (branch_id, branch_name, city, region) VALUES
(101, 'Mumbai Central', 'Mumbai', 'West'),
(102, 'Andheri East', 'Mumbai', 'West'),
(103, 'Delhi Central', 'Delhi', 'North'),
(104, 'Connaught Place', 'Delhi', 'North'),
(105, 'Bangalore Central', 'Bangalore', 'South'),
(106, 'Whitefield', 'Bangalore', 'South'),
(107, 'Chennai Central', 'Chennai', 'South'),
(108, 'T Nagar', 'Chennai', 'South'),
(109, 'Hyderabad Central', 'Hyderabad', 'South'),
(110, 'Banjara Hills', 'Hyderabad', 'South'),
(111, 'Pune Central', 'Pune', 'West'),
(112, 'Hinjewadi', 'Pune', 'West'),
(113, 'Kolkata Central', 'Kolkata', 'East'),
(114, 'Salt Lake', 'Kolkata', 'East'),
(115, 'Ahmedabad Central', 'Ahmedabad', 'West'),
(116, 'Surat Central', 'Surat', 'West'),
(117, 'Jaipur Central', 'Jaipur', 'North'),
(118, 'Lucknow Central', 'Lucknow', 'North'),
(119, 'Kochi Central', 'Kochi', 'South'),
(120, 'Bhubaneswar Central', 'Bhubaneswar', 'East');

-- Generate customers
SET SESSION cte_max_recursion_depth = 2000;

INSERT INTO customers
    (customer_id, customer_name, gender, age, city, signup_date)
WITH RECURSIVE numbers AS (
    SELECT 1001 AS n

    UNION ALL

    SELECT n + 1
    FROM numbers
    WHERE n < 2000
)
SELECT
    n AS customer_id,
    CONCAT(
        ELT(1 + MOD(n, 10),
            'Aarav', 'Vivaan', 'Aditya', 'Arjun', 'Rahul',
            'Rohan', 'Priya', 'Sneha', 'Ananya', 'Kavya'
        ),
        ' ',
        ELT(1 + MOD(n, 10),
            'Sharma', 'Verma', 'Patel', 'Singh', 'Mehta',
            'Gupta', 'Nair', 'Das', 'Iyer', 'Roy'
        )
    ) AS customer_name,
    CASE
        WHEN MOD(n, 2) = 0 THEN 'Female'
        ELSE 'Male'
    END AS gender,
    21 + MOD(n * 7, 45) AS age,
    ELT(
        1 + MOD(n, 10),
        'Mumbai', 'Delhi', 'Bangalore', 'Chennai', 'Hyderabad',
        'Pune', 'Kolkata', 'Ahmedabad', 'Jaipur', 'Kochi'
    ) AS city,
    DATE_ADD(
        '2024-01-01',
        INTERVAL MOD(n * 13, 731) DAY
    ) AS signup_date
FROM numbers;

-- Generate accounts
INSERT INTO accounts
    (account_id, customer_id, branch_id, account_type,
     opening_date, balance, account_status)
WITH RECURSIVE numbers AS (
    SELECT 50001 AS n

    UNION ALL

    SELECT n + 1
    FROM numbers
    WHERE n < 51200
)
SELECT
    n AS account_id,
    1001 + MOD(n - 50001, 1000) AS customer_id,
    101 + MOD(n - 50001, 20) AS branch_id,
    ELT(
        1 + MOD(n, 3),
        'Savings', 'Current', 'Salary'
    ) AS account_type,
    DATE_ADD(
        '2024-01-01',
        INTERVAL MOD(n * 17, 731) DAY
    ) AS opening_date,
    ROUND(
        5000 + MOD(n * 7919, 195000),
        2
    ) AS balance,
    CASE
        WHEN MOD(n, 20) = 0 THEN 'Closed'
        WHEN MOD(n, 10) = 0 THEN 'Inactive'
        ELSE 'Active'
    END AS account_status
FROM numbers;
