-- The OpenPROMPT data include some non-TPP patients. The results of this query tell us
-- how many.

-- How many patients are in Patient and OpenPROMPT?
SELECT
    'Patient and OpenPROMPT' AS tables,
    COUNT(Patient_ID) AS num_patients
FROM (
    SELECT Patient_ID FROM Patient
    INTERSECT
    SELECT Patient_ID FROM OpenPROMPT
) AS t
UNION ALL
-- How many patients are in OpenPROMPT?
SELECT
    'OpenPROMPT' AS tables,
    COUNT(DISTINCT Patient_ID) AS num_patients
FROM OpenPROMPT
