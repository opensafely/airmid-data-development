-- Create a frequency table of the number of surveys (consultations) that are
-- administered on the given number of dates. If the result is that all surveys
-- (consultations) are administered on one date, then we can infer that Consultation_ID
-- is an FK to a survey entity.
SELECT
    num_dates,
    COUNT(num_dates) AS num_consultations
FROM (
    SELECT
        Consultation_ID,
        COUNT(Consultation_ID) AS num_dates
    FROM (
        -- unique pairs
        SELECT DISTINCT
            Consultation_ID,
            ConsultationDate
        FROM OpenPROMPT
    ) AS t
    GROUP BY Consultation_ID
) AS t
GROUP BY num_dates
