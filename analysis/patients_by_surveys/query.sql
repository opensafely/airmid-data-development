-- Create a frequency table of the number of patients that completed the given number of
-- surveys (consultations).
SELECT
    num_consultations,
    COUNT(Patient_ID) AS num_patients
FROM (
    -- Each row represents a patient's response to a question. Questions are grouped
    -- into surveys (consultations). How many surveys (consultations) were completed by
    -- each patient?
    SELECT
        Patient_ID,
        COUNT(DISTINCT Consultation_ID) AS num_consultations
    FROM OpenPROMPT
    GROUP BY Patient_ID
) AS t
GROUP BY num_consultations
ORDER BY num_consultations
