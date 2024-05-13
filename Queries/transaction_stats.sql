SELECT COUNT(*) AS total_transactions,
       AVG(transaction_total_amount) AS avg_transaction_amount,
       MAX(transaction_total_amount) AS max_transaction_amount
FROM TRANSACTIONS;




SELECT  
    'Cafe' AS transaction_type,
    AVG(t.TRANSACTION_TOTAL_AMOUNT) AS avg_cafe_transaction_amount,
    MAX(t.TRANSACTION_TOTAL_AMOUNT) AS max_cafe_transaction_amount,
    'CoWork' AS transaction_type,
    AVG(T.TRANSACTION_TOTAL_AMOUNT) AS avg_cowork_transaction_amount,
    MAX(t.TRANSACTION_TOTAL_AMOUNT) AS max_cowork_transaction_amount
FROM 
    CAFE_TRANSACTION ct
JOIN 
    TRANSACTIONS t ON t.TRANSACTION_ID = ct.transaction_id
JOIN 
    (SELECT 'CoWork' as transaction_type,
            AVG(t1.transaction_total_amount) as avg_cowork_transaction_amount,
            max(t1.transaction_total_amount) AS max_cowork_transaction_amount
     FROM 
            COWORK_TRANSACTION cwt
     JOIN 
            TRANSACTIONS t1 ON t1.TRANSACTION_ID = cwt.TRANSACTION_ID
    ) cowork_data ON 1=1;



SELECT 'CoWork' AS Transaction_Type, ROUND(AVG(T1.TRANSACTION_TOTAL_AMOUNT),2) AS Average_Transaction
FROM TRANSACTIONS t1
LEFT JOIN COWORK_TRANSACTION cwt ON cwt.TRANSACTION_ID = t1.TRANSACTION_ID
UNION ALL
SELECT 'Event' AS Transaction_Type, round(AVG(T2.TRANSACTION_TOTAL_AMOUNT),2) AS Average_Transaction
FROM TRANSACTIONS t2
LEFT JOIN EVENT_TRANSACTION et ON et.TRANSACTION_ID = t2.TRANSACTION_ID
UNION ALL
SELECT 'Cafe' AS Transaction_Type, round(AVG(T3.TRANSACTION_TOTAL_AMOUNT),2) AS Average_Transaction
FROM TRANSACTIONS t3
LEFT JOIN CAFE_TRANSACTION ct ON ct.transaction_id = t3.transaction_id;

select count(*) transaction_id from TRANSACTIONS;