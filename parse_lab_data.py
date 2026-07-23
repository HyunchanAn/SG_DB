import os
import glob
import pandas as pd
import re

def parse_coating_weight(val):
    if pd.isna(val):
        return None, None
    val = str(val).strip()
    # Looking for pattern like (2.7)(#3)
    match = re.search(r'\(([\d\.]+)\)\(#(\d+)\)', val)
    if match:
        thickness = float(match.group(1))
        bar_num = int(match.group(2))
        return thickness, bar_num
    
    try:
        return float(val), None
    except:
        return None, None

def process_synthesis_data(raw_dir, out_dir):
    files = glob.glob(os.path.join(raw_dir, '*Lab 합성 총괄*.csv'))
    all_data = []
    
    for f in files:
        print(f"Parsing {f}...")
        df = pd.read_csv(f, sep='\t', encoding='cp949', on_bad_lines='skip')
        all_data.append(df)
        
    if all_data:
        combined_df = pd.concat(all_data, ignore_index=True)
        combined_df = combined_df.dropna(how='all')
        
        out_file = os.path.join(out_dir, 'parsed_lab_synthesis.csv')
        combined_df.to_csv(out_file, index=False, encoding='utf-8-sig')
        print(f"✅ Saved Synthesis data to {out_file} (Rows: {len(combined_df)})")

def process_coating_data(raw_dir, out_dir):
    files = glob.glob(os.path.join(raw_dir, '*Lab 도포 총괄*.csv'))
    all_data = []
    
    for f in files:
        print(f"Parsing {f}...")
        df = pd.read_csv(f, sep='\t', encoding='cp949', on_bad_lines='skip')
        all_data.append(df)
        
    if all_data:
        combined_df = pd.concat(all_data, ignore_index=True)
        combined_df = combined_df.dropna(how='all')
        
        if '도포량' in combined_df.columns:
            parsed = combined_df['도포량'].apply(parse_coating_weight)
            combined_df['도포두께_um'] = parsed.apply(lambda x: x[0])
            combined_df['바코터번호'] = parsed.apply(lambda x: x[1])
        
        out_file = os.path.join(out_dir, 'parsed_lab_coating.csv')
        combined_df.to_csv(out_file, index=False, encoding='utf-8-sig')
        print(f"✅ Saved Coating data to {out_file} (Rows: {len(combined_df)})")

if __name__ == "__main__":
    base_dir = "/Users/hyunchanan/Documents/GitHub/SG_DB"
    raw_dir = os.path.join(base_dir, "raw_data")
    out_dir = os.path.join(base_dir, "parsed_data")
    
    os.makedirs(out_dir, exist_ok=True)
    
    print("Starting Parsing Process...")
    process_synthesis_data(raw_dir, out_dir)
    process_coating_data(raw_dir, out_dir)
    print("Parsing Complete!")
