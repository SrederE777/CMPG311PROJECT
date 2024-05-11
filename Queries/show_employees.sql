SELECT employee_name,employee_surname,contract_job_title AS JobTitle, TRUNC(MONTHS_BETWEEN(SYSDATE, E.EMPLOYEE_DATE_OF_EMPLOYEMENT) / 12) AS NumYears
FROM EMPLOYEE e
JOIN EMPLOYEE_CONTRACT ec ON e.employee_contact_id = ec.employee_contract_id;