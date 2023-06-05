"""
Relates information in the codebook to information in the table.

We could generate this data structure from the information in the codebook; it's just
convenient to hard-code it into a module when explaining our approach.
"""
from collections import namedtuple

Question = namedtuple("Question", ["id", "ctv3_codes", "value_property"])

questions = [
    Question(
        "dm01",
        [
            "9155.",
        ],
        "numeric_value",  # FIXME: should be a date
    ),
    Question(
        "dm02",
        [
            "XactH",
            "XactI",
            "XactJ",
            "XactK",
            "XactL",
            "Xactd",
            "Xacte",
            "Xactf",
            "Xactg",
            "Xacth",
            "Xacti",
            "Xactj",
            "Xactk",
            "Xactl",
            "Xactm",
            "Xactn",
            "Xacto",
            "Xactp",
            "Y32d7",
        ],
        "ctv3_code",
    ),
]
