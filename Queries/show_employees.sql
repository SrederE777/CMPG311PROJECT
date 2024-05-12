SELECT employee_name,employee_surname,contract_job_title AS JobTitle, TRUNC(MONTHS_BETWEEN(SYSDATE, e.employee_date_of_employement) / 12) AS NumYears
FROM EMPLOYEE e
JOIN EMPLOYEE_CONTRACT ec ON e.employee_contract_id = ec.employee_contract_id;