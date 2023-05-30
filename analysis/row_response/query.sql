-- If there are odd and even numbers of rows associated with Consultation_ID groups,
-- then we can infer that one response is represented by one row, rather than two rows;
-- one row for each value of CodeSystemId.
SELECT
    is_odd,
    COUNT(is_odd) AS num_rows
FROM (
    SELECT COUNT(Consultation_ID) % 2 AS is_odd
    FROM OpenPROMPT
    GROUP BY Consultation_ID
) AS t
GROUP BY is_odd
ORDER BY is_odd
