SELECT COUNT(*) AS total_transactions,
       AVG(transaction_total_amount) AS avg_transaction_amount,
       MAX(transaction_total_amount) AS max_transaction_amount
FROM TRANSACTIONS;

SELECT COUNT(*) AS NumCafeTransactions
        FROM CAFE_TRANSACTION ct
        JOIN TRANSACTIONS t on t.TRANSACTION_ID = ct.transaction_id
        
        
        AVG(transaction_total)