-- Create a frequency table of the number of rows for each question (CodedEvent_ID) for
-- each numeric value. We expect most questions to have a large number of rows for one
-- numeric value; zero (the missing value marker).
SELECT
    CodedEvent_ID,
    NumericValue,
    COUNT(*) AS num_rows
FROM OpenPROMPT
GROUP BY CodedEvent_ID, NumericValue
ORDER BY CodedEvent_ID, NumericValue
