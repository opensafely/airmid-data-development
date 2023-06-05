-- select consultation entities
WITH consult AS (
    SELECT
        Consultation_ID, -- pk
        Patient_ID, -- fk
        CAST(ConsultationDate AS date) AS ConsultationDate,
        -- ties are permitted but are probably duplicates
        RANK() OVER (PARTITION BY Patient_ID ORDER BY ConsultationDate)
            AS Consultation_Number
    FROM
        (SELECT DISTINCT
            Consultation_ID,
            Patient_ID,
            ConsultationDate
        FROM OpenPROMPT) AS t
),

dm01 AS (
    SELECT
        Consultation_ID,
        CodedEvent_ID -- should be date not CTV3 code
    FROM OpenPROMPT
    WHERE CodedEvent_ID = '9155.'
),

dm02 AS (
    SELECT
        Consultation_ID,
        CodedEvent_ID
    FROM OpenPROMPT
    WHERE
        CodedEvent_ID IN (
            'XactH',
            'XactI',
            'XactJ',
            'XactK',
            'XactL',
            'Xactd',
            'Xacte',
            'Xactf',
            'Xactg',
            'Xacth',
            'Xacti',
            'Xactj',
            'Xactk',
            'Xactl',
            'Xactm',
            'Xactn',
            'Xacto',
            'Xactp',
            'Y32d7'
        )
),

lc03 AS (
    SELECT
        Consultation_ID,
        NumericValue
    FROM OpenPROMPT
    WHERE CodedEvent_ID = 'Y3a98'
)

SELECT
    consult.Patient_ID,
    consult.Consultation_ID,
    consult.ConsultationDate,
    consult.Consultation_Number,
    dm01.CodedEvent_ID AS dm01,
    dm02.CodedEvent_ID AS dm02,
    lc03.NumericValue AS lc03
FROM consult
LEFT JOIN dm01 ON consult.Consultation_ID = dm01.Consultation_ID
LEFT JOIN dm02 ON consult.Consultation_ID = dm02.Consultation_ID
LEFT JOIN lc03 ON consult.Consultation_ID = lc03.Consultation_ID
