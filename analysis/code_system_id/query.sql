-- Do values of code system ID map to values of concept ID? How may patients,
-- rows, and concept IDs are associated with each mapping? If one concept ID is
-- associated with each mapping, then we can assume that the IDs are references to the
-- same underlying concepts.
SELECT
    CodeSystemId AS code_system_id,
    ConceptId AS concept_id,
    COUNT(DISTINCT CodedEvent_ID) AS num_coded_event_ids,
    COUNT(DISTINCT Patient_ID) AS num_patients,
    COUNT(Patient_ID) AS num_rows
FROM OpenPROMPT
GROUP BY CodeSystemId, ConceptId
ORDER BY CodeSystemId, ConceptId
