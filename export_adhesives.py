import sqlite3
import csv
import json
import os

db_path = "/Users/hyunchanan/Documents/GitHub/SG_DB/sg_proj_004.db.bak"
output_csv = "/Users/hyunchanan/Documents/GitHub/SG_DB/all_adhesive_polymers.csv"

# Connect to the database
conn = sqlite3.connect(db_path)
cursor = conn.cursor()

# Query the adhesive_recipes table
cursor.execute("SELECT id, adhesive_code, formula_data FROM adhesive_recipes")
rows = cursor.fetchall()

# Parse JSON data and collect all possible keys for the CSV header
all_keys = set()
parsed_data = []

for row in rows:
    row_id, adhesive_code, formula_data_str = row
    data_dict = {"id": row_id, "adhesive_code": adhesive_code}
    try:
        formula_dict = json.loads(formula_data_str)
        data_dict.update(formula_dict)
        all_keys.update(formula_dict.keys())
    except json.JSONDecodeError:
        pass
    parsed_data.append(data_dict)

# Determine the CSV header
header = ["id", "adhesive_code"] + sorted(list(all_keys))

# Write to CSV
with open(output_csv, "w", newline="", encoding="utf-8-sig") as f:
    writer = csv.DictWriter(f, fieldnames=header)
    writer.writeheader()
    for row in parsed_data:
        writer.writerow(row)

print(f"Exported {len(parsed_data)} rows to {output_csv}")
conn.close()
