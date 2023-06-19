-- Return some basic information about values of the CodedEvent_ID column.
SELECT
    CodedEvent_ID AS ctv3_code,
    Description AS ctv3_description,
    MIN(ConsultationDate) AS min_consultation_date
FROM OpenPROMPT LEFT JOIN CTV3Dictionary ON CodedEvent_ID = CTV3Code
GROUP BY CodedEvent_ID, Description
ORDER BY CodedEvent_ID
