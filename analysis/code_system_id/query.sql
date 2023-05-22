-- How many patients have each concept in each code system? Notice that we count
-- patients and not records.
SELECT
    CodeSystemId AS code_system_id,
    ConceptId AS concept_id,
    COUNT(DISTINCT Patient_ID) AS num_patients
FROM OpenPROMPT
GROUP BY CodeSystemId, ConceptId
ORDER BY CodeSystemId, ConceptId
