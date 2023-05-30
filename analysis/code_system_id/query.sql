-- Do values of code system ID map to values of concept ID? How may patients and how
-- many rows are associated with each mapping?
SELECT
    CodeSystemId AS code_system_id,
    ConceptId AS concept_id,
    COUNT(DISTINCT Patient_ID) AS num_patients,
    COUNT(Patient_ID) AS num_rows
FROM OpenPROMPT
GROUP BY CodeSystemId, ConceptId
ORDER BY CodeSystemId, ConceptId
