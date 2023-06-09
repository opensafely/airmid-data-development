-- Count the number of distinct numeric values for each question (CodedEvent_ID). We
-- expect most questions to have one distinct numeric value; although this query doesn't
-- tell us what that numeric value is, we expect it to be zero (the missing value
-- marker).
SELECT
    CodedEvent_ID,
    COUNT(CodedEvent_ID) AS num_distinct_numeric_values
FROM (
    SELECT DISTINCT
        CodedEvent_ID,
        NumericValue
    FROM OpenPROMPT
) AS t
GROUP BY CodedEvent_ID
ORDER BY num_distinct_numeric_values DESC
