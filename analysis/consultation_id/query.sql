-- How many patients and how many rows are associated with each consultation?
SELECT
    Consultation_ID AS consultation_id,
    COUNT(DISTINCT Patient_ID) AS num_patients,
    COUNT(Patient_ID) AS num_rows
FROM OpenPROMPT
GROUP BY Consultation_ID
ORDER BY Consultation_ID
