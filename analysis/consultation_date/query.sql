-- How many patients and how many rows are associated with each consultation date?
-- (ConsultationDate is a datetime so we convert it to a date.)
SELECT
    CONVERT(date, ConsultationDate) AS consultation_date,
    COUNT(DISTINCT Patient_ID) AS num_patients,
    COUNT(Patient_ID) AS num_rows
FROM OpenPROMPT
GROUP BY CONVERT(date, ConsultationDate)
ORDER BY CONVERT(date, ConsultationDate)
