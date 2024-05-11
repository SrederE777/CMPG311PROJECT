SELECT customer_name, customer_surname, customer_loyalty_points
FROM CUSTOMER
WHERE customer_loyalty_points = (SELECT MAX(customer_loyalty_points) FROM CUSTOMER);