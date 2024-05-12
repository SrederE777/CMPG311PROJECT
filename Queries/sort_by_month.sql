SELECT event_name, event_date
FROM EVENT
WHERE EXTRACT(MONTH FROM event_date) = 5;