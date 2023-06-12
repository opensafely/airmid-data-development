-- Count the number of duplicate responses to each question (CodedEvent_ID) for each
-- survey (Consultation_ID).
SELECT
    Consultation_ID,
    CodedEvent_ID,
    NumericValue,
    COUNT(*) AS num_responses
FROM OpenPROMPT
GROUP BY Consultation_ID, CodedEvent_ID, NumericValue
ORDER BY Consultation_ID, CodedEvent_ID, NumericValue
