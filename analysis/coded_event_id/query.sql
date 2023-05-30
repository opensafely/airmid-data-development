-- Are values of CodedEvent_ID valid CTV3 codes?
SELECT DISTINCT
    CodedEvent_ID AS coded_event_id,
    Description AS description
FROM OpenPROMPT LEFT JOIN CTV3Dictionary ON CodedEvent_ID = CTV3Code
ORDER BY CodedEvent_ID
