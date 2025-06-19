
import pandas as pd
import numpy as np
import random
from datetime import datetime, timedelta

# Load the last uploaded base dataset
df = pd.read_csv("final_synthetic_kyc_data_all_rules_applied.csv")

# Step 1: Modify 15% of clients so their "Next KYC Refresh date" is over 120 days in the past
total_rows = len(df)
num_to_modify = int(0.15 * total_rows)
indices_to_modify = np.random.choice(df.index, size=num_to_modify, replace=False)

# Set their Next KYC Refresh date to 150 days ago
df.loc[indices_to_modify, "Next KYC Refresh date"] = (
    datetime.today() - timedelta(days=150)
).strftime('%Y-%m-%d')

# Recalculate Client Response Due Date = greater of (Next KYC + 120)
df["Next KYC Refresh date Parsed"] = pd.to_datetime(df["Next KYC Refresh date"], errors='coerce')
df["Client Response Due Date"] = (df["Next KYC Refresh date Parsed"] + timedelta(days=120)).dt.strftime('%Y-%m-%d')

# Step 2: Apply restraint and exception logic
def apply_restraint_exception_logic(row):
    today = datetime.today()
    response_due_date = pd.to_datetime(row.get("Client Response Due Date"), errors='coerce')

    row["Restraint date"] = ""
    row["Exception start date"] = ""
    row["Exception expiry date"] = ""
    row["Exception Duration"] = ""
    row["level1 Exception Rationale"] = ""
    row["level2 Exception Rationale"] = ""
    row["level3 Exception Rationale"] = ""

    if pd.notnull(response_due_date) and response_due_date < today:
        row["Current Case Status"] = "Due for Restrain"
        restraint_date = response_due_date + timedelta(days=5)
        row["Restraint date"] = restraint_date.strftime('%Y-%m-%d')

        rand = random.random()
        if rand <= 0.60:
            level = 0
        elif rand <= 0.85:
            level = 1
        elif rand <= 0.95:
            level = 2
        else:
            level = 3

        if level >= 1:
            exception_start = restraint_date + timedelta(days=10)
            exception_expiry = restraint_date + timedelta(days=30)
            row["Exception start date"] = exception_start.strftime('%Y-%m-%d')
            row["Exception expiry date"] = exception_expiry.strftime('%Y-%m-%d')
            row["Exception Duration"] = 20
            row["level1 Exception Rationale"] = "Client is out of country until further notice."
        if level >= 2:
            row["level2 Exception Rationale"] = "Extension granted due to updated documentation in review."
        if level == 3:
            row["level3 Exception Rationale"] = "Final extension under senior compliance override."

    return row

df = df.apply(apply_restraint_exception_logic, axis=1)
df.drop(columns=["Next KYC Refresh date Parsed"], inplace=True)

# Save final CSV
df.to_csv("final_synthetic_kyc_data_all_rules_with_restraint_and_exception_applied.csv", index=False)
