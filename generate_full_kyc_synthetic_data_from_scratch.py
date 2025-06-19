
import pandas as pd
import numpy as np
import random
from datetime import datetime, timedelta
from faker import Faker

fake = Faker()
Faker.seed(42)
random.seed(42)

# Define countries and core systems
countries = {
    "Trinidad and Tobago": "T24",
    "Curacao": "T24",
    "Barbados": "RIBS",
    "Bahamas": "RIBS"
}

client_types = ["Personal", "Business"]
risk_ratings = ["High", "Medium", "Low"]
case_statuses = ["In Order", "Out of Order"]
contact_methods = ["SMS", "Phone Call"]

# Caribbean-style address generator
def generate_address(country):
    lines = [
        fake.street_address(),
        fake.secondary_address(),
        f"{fake.city()}, {fake.state()}",
        country
    ]
    return lines

# Generate 10,000 synthetic rows
rows = []
for i in range(10000):
    country = random.choice(list(countries.keys()))
    core_system = countries[country]
    cif = str(random.randint(800000000, 899999999))
    transit = str(random.randint(10000, 99999))
    name = fake.name()
    email = f"{name.lower().replace(' ', '.')}@example.com"
    address = generate_address(country)
    client_type = random.choice(client_types)
    risk = random.choices(risk_ratings, weights=[0.2, 0.5, 0.3])[0]
    case_status = random.choices(case_statuses, weights=[0.7, 0.3])[0]
    telephone = fake.phone_number()
    next_refresh = fake.date_between(start_date='-90d', end_date='+180d')

    # UID logic
    if core_system == "T24":
        uid = f"{cif}{next_refresh.strftime('%Y%m%d')}"
    else:
        uid = f"{transit}{cif}{next_refresh.strftime('%Y%m%d')}"

    # Notices
    notices = {"1st": "", "2nd": "", "3rd": "", "expiry": "", "response_due": ""}
    if next_refresh > datetime.today().date() and case_status == "Out of Order":
        notice1 = next_refresh + timedelta(days=30)
        notice2 = notice1 + timedelta(days=30)
        notice3 = notice2 + timedelta(days=30)
        response_due = max(next_refresh + timedelta(days=120), notice3 + timedelta(days=30))
        notices["1st"] = notice1
        notices["2nd"] = notice2
        notices["3rd"] = notice3
        notices["expiry"] = notice3 + timedelta(days=90)
        notices["response_due"] = response_due

    # Determine current case status
    today = datetime.today().date()
    current_case_status = "Due for Restrain" if notices["response_due"] and notices["response_due"] < today else case_status

    # Restraint date
    restraint_date = notices["response_due"] + timedelta(days=5) if current_case_status == "Due for Restrain" else ""

    # Exception logic
    level1 = level2 = level3 = rationale1 = rationale2 = rationale3 = duration = start = expiry = ""
    if current_case_status == "Due for Restrain":
        rand = random.random()
        if rand > 0.60:
            level1 = "Y"
            rationale1 = "Client is out of country until further notice."
            start = restraint_date + timedelta(days=10)
            expiry = restraint_date + timedelta(days=30)
            duration = (expiry - start).days
            if rand > 0.85:
                level2 = "Y"
                rationale2 = "Extension granted due to updated documentation in review."
                if rand > 0.95:
                    level3 = "Y"
                    rationale3 = "Final extension under senior compliance override."

    row = {
        "2 UID": uid,
        "3 CIF": cif,
        "4 Client Type": client_type,
        "5 Name": name,
        "6 Country": country,
        "7 Transit": transit,
        "8 Address1": address[0],
        "9 Address2": address[1],
        "10 Address3": address[2],
        "11 Address4": address[3],
        "12 Email Address": email,
        "13 Box Link": fake.url(),
        "14 Telephone Contact": telephone,
        "15 Risk Rating": risk,
        "16 Case Status": case_status,
        "17 Current Case Status": current_case_status,
        "18 Business Documents Outstanding": random.choice(["Yes", "No"]),
        "19 Entity Self-Certification Form Outstanding": random.choice(["Yes", "No"]),
        "20 UBOID Outstanding": random.choice(["Yes", "No"]),
        "21 UBO-Proof of Address Outstanding": random.choice(["Yes", "No"]),
        "22 UBO in order": random.choice(["Yes", "No"]),
        "23 ROS officer": fake.name(),
        "24 File Review Date": fake.date_between(start_date='-180d', end_date='today'),
        "25 1st Notice Date": notices["1st"],
        "26 1st Notice Type": "SMS" if notices["1st"] else "",
        "27 2nd Notice Date": notices["2nd"],
        "28 2nd Notice Type": "SMS" if notices["2nd"] else "",
        "29 3rd Notice Date": notices["3rd"],
        "30 3rd Notice Type": "SMS" if notices["3rd"] else "",
        "31 Notification Expiry date": notices["expiry"],
        "32 Refresh date (Last KYC)": fake.date_between(start_date='-365d', end_date='-91d'),
        "33 Next KYC Refresh date": next_refresh,
        "34 Client Response Due Date": notices["response_due"],
        "35 Restraint date": restraint_date,
        "36 Exception start date": start,
        "37 Exception expiry date": expiry,
        "38 Exception Duration": duration,
        "39 level1 Exception Rationale": rationale1,
        "40 level2 Exception Rationale": rationale2,
        "41 level3 Exception Rationale": rationale3,
        "42 Updates to ICN": random.choice(["Yes", "No"]),
        "43 Updates on Core": random.choice(["Yes", "No"]),
        "44 Portfolio": random.choice(["Retail", "Corporate", "SME", "Private"])
    }

    rows.append(row)

# Create dataframe and export
df = pd.DataFrame(rows)
df.to_csv("full_synthetic_kyc_dataset.csv", index=False)
