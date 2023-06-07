-- Each row represents that, for a given patient, at least one consultation (survey) was
-- administered the given number of days after the first consultation was administered.
-- We're not interested in how many consultations were administered on the same day; we
-- consider that for a given day, the canonical consultation may be the first, last, or
-- some function thereof. We're interested in whether there are "spikes" around day 0
-- (there should be!) and day 30, 60, and 90.
WITH consult AS (
    SELECT DISTINCT
        Patient_ID,
        DATEDIFF(
            DAY, CAST(FirstConsultationDate AS date), CAST(ConsultationDate AS date)
        )
            AS ConsultationOffset
    FROM (
        SELECT
            Consultation_ID,
            Patient_ID,
            ConsultationDate,
            FIRST_VALUE(ConsultationDate)
                OVER (
                    PARTITION BY Patient_ID
                    ORDER BY ConsultationDate ROWS UNBOUNDED PRECEDING
                )
                AS FirstConsultationDate
        FROM (
            SELECT DISTINCT
                Consultation_ID,
                Patient_ID,
                ConsultationDate
            FROM OpenPROMPT
            -- Only include responses to a compulsory question on the Eq-5D
            -- questionnaire. Unlike the baseline questionnaire, this questionnaire was
            -- administered in each survey. Consultations that are associated with these
            -- responses are valid OpenPROMPT consultations.
            WHERE CodedEvent_ID = 'XaYwo'
        ) AS t
    ) AS t
)

-- Create a frequency table of the number of patients that were administered a
-- consultation the given number of days after the first consultation was administered.
SELECT
    ConsultationOffset AS num_days_since_first,
    COUNT(ConsultationOffset) AS num_patients
FROM consult
GROUP BY ConsultationOffset
ORDER BY ConsultationOffset
