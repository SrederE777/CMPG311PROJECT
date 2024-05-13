SELECT COUNT(*) AS NumCafeTransactions,
        AVG(t.transaction_total_amount) AS avg_transaction_amount,
        MAX(t.transaction_total_amount) AS max_transaction_amount
        AVG(ct.TRANSACTION_TOTAL_AMOUNT) AS avg_cafe_transaction_amount,
        MAX(ct.TRANSACTION_TOTAL_AMOUNT) AS max_cafe_transaction_amount
        FROM CAFE_TRANSACTION ct
JOIN TRANSACTIONS t on t.TRANSACTION_ID = ct.transaction_id;


SELECT COUNT(*) AS NumCoworkTransactions, AVG(T.TRANSACTION_TOTAL_AMOUNT)
FROM COWORK_TRANSACTION cwt
JOIN TRANSACTIONS t ON t.TRANSACTION_ID = cwt.TRANSACTION_ID;
