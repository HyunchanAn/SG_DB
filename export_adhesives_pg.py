import csv
import json
import subprocess
import os

output_csv = "/Users/hyunchanan/Documents/GitHub/SG_DB/all_adhesive_polymers.csv"

# Query PostgreSQL via docker exec
cmd = [
    "docker", "exec", "sg_proj_004_db", "psql",
    "-U", "sg_user",
    "-d", "sg_proj_004",
    "-t", "-A", "-F", "|||",
    "-c", "SELECT id, adhesive_code, formula_data FROM adhesive_recipes"
]

try:
    result = subprocess.run(cmd, capture_output=True, text=True, check=True)
except subprocess.CalledProcessError as e:
    print("Error executing docker command:", e)
    print(e.stderr)
    exit(1)

# Parse JSON data and collect all possible keys for the CSV header
all_keys = set()
parsed_data = []

for line in result.stdout.strip().split('\n'):
    if not line: continue
    parts = line.split('|||')
    if len(parts) >= 3:
        row_id, adhesive_code, formula_data_str = parts[0], parts[1], parts[2]
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
