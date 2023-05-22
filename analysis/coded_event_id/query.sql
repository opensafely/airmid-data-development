-- How many patients are associated with each coded event?
SELECT
    CodedEvent_ID AS coded_event_id,
    COUNT(DISTINCT Patient_ID) AS num_patients
FROM OpenPROMPT
GROUP BY CodedEvent_ID
ORDER BY CodedEvent_ID
