-- LIKE, AND AND OR
-- ek't gedink ons kan op die GUI vir user input vra om die employees op 'n spesifieke attribute te sort 

SELECT employee_name, employee_surname
FROM EMPLOYEE
WHERE employee_name LIKE 'J%' AND (employee_surname LIKE 'S%' OR employee_surname LIKE 'D%');