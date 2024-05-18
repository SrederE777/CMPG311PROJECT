SELECT v.VENDOR_NAME, COUNT(*) AS total_events_attended
FROM VENDOR v
JOIN VENDOR_ATTENDANCE va ON v.VENDOR_ID = va.VENDOR_ID
GROUP BY v.VENDOR_NAME;