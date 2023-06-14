import argparse

from ehrql import Dataset
from ehrql.tables.beta.tpp import open_prompt
from questions import questions

parser = argparse.ArgumentParser()
parser.add_argument(
    "--day",
    type=int,
    help="The day a survey was completed, relative to the day the first survey was completed",
)
parser.add_argument(
    "--window",
    type=int,
    default=0,
    help="The number of days +/- the day a survey was completed",
)
args = parser.parse_args()
print(f"{args.day=}")
print(f"{args.window=}")

# The number of days from the date of the earliest response to the date of the current
# response. We expect this to be >= 0.
index_date = open_prompt.where(
    # Only include responses to a compulsory question on the Eq-5D
    # questionnaire. Unlike the baseline questionnaire, this questionnaire was
    # administered in each survey. Surveys that are associated with these
    # responses are valid OpenPROMPT surveys.
    open_prompt.ctv3_code
    == "XaYwo"
).consultation_date.minimum_for_patient()
consult_offset = (open_prompt.consultation_date - index_date).days

dataset = Dataset()

dataset.define_population(open_prompt.exists_for_patient())

dataset.index_date = index_date

dataset.consult_date = (
    open_prompt.where(consult_offset == args.day)
    .sort_by(open_prompt.consultation_id)
    .last_for_patient()
    .consultation_date
)

# A row represents a response to a question in a questionnaire. There are six
# questionnaires, which are administered in four surveys on day 0, 30, 60, and 90. For
# more information, see DATA.md.
for question in questions:
    # fetch the row containing the last response to the current question from the survey
    # administered on day 0
    response_row = (
        open_prompt.where(consult_offset >= args.day - args.window)
        .where(consult_offset <= args.day + args.window)
        .where(open_prompt.ctv3_code.is_in(question.ctv3_codes))
        # If the response is a CTV3 code, then the numeric value should be zero and
        # sorting by the numeric value should have no effect. However, if the response
        # is a numeric value, then zero may represent:
        #
        # 1. a missing value, because the question was not compulsory
        # 2. a missing value, because the response failed form-validation
        # 3. a measured value
        #
        # In each case, we think that sorting by numeric value should give the true
        # response because if there are two responses, then:
        #
        # 1. the responses are identical
        # 2. the first response failed form-validation; the second response passed
        #
        # We acknowledge that the true response for 3. is undetermined.
        .sort_by(
            open_prompt.numeric_value,
            open_prompt.consultation_id,  # arbitrary but deterministic
        )
        .last_for_patient()
    )
    # the response itself may be a CTV3 code or a numeric value
    response_value = getattr(response_row, question.value_property)
    setattr(dataset, question.id, response_value)
