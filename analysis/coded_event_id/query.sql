-- Are values of CodedEvent_ID valid CTV3 codes?
SELECT
    CodedEvent_ID AS ctv3_code,
    Description AS ctv3_description,
    MIN(ConsultationDate) AS min_consultation_date
FROM OpenPROMPT LEFT JOIN CTV3Dictionary ON CodedEvent_ID = CTV3Code
GROUP BY CodedEvent_ID, Description
ORDER BY CodedEvent_ID
