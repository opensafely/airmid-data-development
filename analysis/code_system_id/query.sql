-- How many patients and how many rows are associated with each concept in each code
-- system?
SELECT
    CodeSystemId AS code_system_id,
    ConceptId AS concept_id,
    COUNT(DISTINCT Patient_ID) AS num_patients,
    COUNT(Patient_ID) AS num_rows
FROM OpenPROMPT
GROUP BY CodeSystemId, ConceptId
ORDER BY CodeSystemId, ConceptId
