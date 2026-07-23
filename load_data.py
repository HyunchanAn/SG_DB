import pandas as pd
import json
import re
import psycopg2
from psycopg2.extras import Json
import os

DB_PARAMS = {
    "dbname": "sg_proj_004_db",
    "user": "sg_user",
    "password": "sg_password",
    "host": "localhost",
    "port": "5433"
}

def parse_wt_string(val):
    if pd.isna(val) or not str(val).strip():
        return None
    val_str = str(val).strip()
    result = []
    items = re.split(r'[/,\n]+', val_str)
    for item in items:
        item = item.strip()
        if not item: continue
        
        sub_info = ""
        paren_match = re.search(r'\((.*?)\)', item)
        if paren_match:
            sub_info = paren_match.group(1).strip()
            item = re.sub(r'\(.*?\)', '', item).strip()
            
        match = re.search(r'(\s+)([\d\.]+)\s*(wt%?|%)?$|([\d\.]+)\s*(wt%?|%)$', item, re.IGNORECASE)
        wt = None
        name = item
        if match:
            if match.group(2):
                wt_str = match.group(2)
                name = item[:match.start(1)].strip()
            else:
                wt_str = match.group(4)
                name = item[:match.start(4)].strip()
            try:
                wt = float(wt_str)
            except:
                pass
        
        if not name:
            name = "Unknown"
            
        entry = {"name": name, "wt_percent": wt}
        if sub_info:
            entry["note"] = sub_info
        result.append(entry)
    return result

def categorize_solvent(val):
    if pd.isna(val):
        return "알수없음"
    val_str = str(val).lower()
    if '증류수' in val_str or 'water' in val_str:
        return "수성"
    return "유성"

def normalize_text(val, col_name=None):
    if pd.isna(val): return None
    val_str = str(val).strip()
    if not val_str: return None
        
    if col_name == 'worker':
        workers = [w.strip() for w in val_str.split(',') if w.strip()]
        return ','.join(sorted(workers))
        
    if col_name == 'note':
        if any(x in val_str for x in ['겔레이션', '굳음', '점도 상승', '점도상승']):
            val_str = '[점도상승_겔화] ' + val_str
        if any(x in val_str for x in ['안좋음', 'NG', '미비', '불량']):
            val_str = '[성능미달_NG] ' + val_str
        if any(x in val_str for x in ['미세백탁', '미세오염', '그림자', '미세얼룩']):
            val_str = '[표면미세오염] ' + val_str
        if '석출' in val_str:
            val_str = '[성분석출] ' + val_str
            
    if col_name in ['heat_pressing', 'heat_resistance', 'weather_resistance', 'moisture_resistance', 'outdoor_exposure']:
        val_str = re.sub(r'\(\s*(\d+일)\s*(양호|탈리|백탁|오염|박리불가)\s*\)', r'(\1\2)', val_str)
        val_str = re.sub(r'\)\s*\(', ')*(', val_str)
        match = re.search(r'\(\s*(.*?)\s*\)\s*\*\s*\(\s*([A-Za-z]+)\s*/\s*(.*?)\s*\)', val_str)
        if match:
            val_str = f"({match.group(1)})*({match.group(3)}/{match.group(2)})"
            
    return val_str

def safe_float(val):
    if pd.isna(val): return None
    val_str = str(val).strip()
    if not val_str: return None
    try:
        return float(val_str)
    except ValueError:
        match = re.match(r'([\d\.]+)\s*[-~]\s*([\d\.]+)', val_str)
        if match:
            return (float(match.group(1)) + float(match.group(2))) / 2.0
        match = re.search(r'[\d\.]+', val_str)
        if match:
            return float(match.group(0))
        return None

def load_synthesis():
    df = pd.read_csv('parsed_data/final_lab_synthesis.csv')
    conn = psycopg2.connect(**DB_PARAMS)
    cur = conn.cursor()
    
    count = 0
    for _, row in df.iterrows():
        # Clean json fields
        monomers = parse_wt_string(row.get('모노머'))
        solvents = parse_wt_string(row.get('용제'))
        initiators = parse_wt_string(row.get('개시제'))
        additives = parse_wt_string(row.get('유화제 및 첨가제'))
        
        category = categorize_solvent(row.get('용제'))
        
        # Coalesce mismatched columns between Excel and Access DB
        viscosity = row.get('점도(cP)') if '점도(cP)' in row and not pd.isna(row.get('점도(cP)')) else row.get('점도(cps)')
        
        cur.execute("""
            INSERT INTO lab_synthesis (
                adhesive_id, worker, category, description,
                solid_content_theoretical, solid_content_measured, yield_percent,
                conversion_rate, coagulum_percent, ph, tg, viscosity_cp,
                initial_emulsifier_conc, particle_size_nm, scale,
                monomers, solvents, initiators, emulsifiers_additives,
                reaction_time, temperature
            ) VALUES (
                %s, %s, %s, %s,
                %s, %s, %s,
                %s, %s, %s, %s, %s,
                %s, %s, %s,
                %s, %s, %s, %s,
                %s, %s
            )
        """, (
            normalize_text(row.get('점착제')), normalize_text(row.get('작업자'), 'worker'), category, normalize_text(row.get('설명'), 'note'),
            safe_float(row.get('이론 고형분(%)')),
            safe_float(row.get('측정 고형분(%)')),
            safe_float(row.get('수율(%)')),
            safe_float(row.get('전환율(%)')),
            safe_float(row.get('응집량(%)')),
            safe_float(row.get('pH')),
            safe_float(row.get('Tg')),
            safe_float(viscosity),
            safe_float(row.get('초기 유화제 농도')),
            safe_float(row.get('입도(nm)')),
            normalize_text(row.get('Scale')),
            json.dumps(monomers, ensure_ascii=False) if monomers else None,
            json.dumps(solvents, ensure_ascii=False) if solvents else None,
            json.dumps(initiators, ensure_ascii=False) if initiators else None,
            json.dumps(additives, ensure_ascii=False) if additives else None,
            normalize_text(row.get('반응시간')), normalize_text(row.get('온도'))
        ))
        count += 1
        
    conn.commit()
    cur.close()
    conn.close()
    print(f"✅ Loaded {count} synthesis records.")

def load_coating():
    df = pd.read_csv('parsed_data/final_lab_coating.csv')
    conn = psycopg2.connect(**DB_PARAMS)
    cur = conn.cursor()
    
    count = 0
    for _, row in df.iterrows():
        # Parse Access DB unparsed "도포량" string or use Excel's split columns
        coating_weight_um = None
        bar_coater_num = None
        
        # Check Excel parsed columns first
        if '도포량_um' in row and not pd.isna(row.get('도포량_um')):
            coating_weight_um = safe_float(row.get('도포량_um'))
        if '바코터번호' in row and not pd.isna(row.get('바코터번호')):
            bar_coater_num = safe_float(row.get('바코터번호'))
            
        # If empty, try parsing Access DB raw "도포량" column
        if coating_weight_um is None and bar_coater_num is None and '도포량' in row and not pd.isna(row.get('도포량')):
            raw_coating = str(row.get('도포량')).lower()
            if 'um' in raw_coating:
                match = re.search(r'([\d\.]+)', raw_coating)
                if match: coating_weight_um = float(match.group(1))
            elif '바코터' in raw_coating or 'bar' in raw_coating or 'no' in raw_coating:
                match = re.search(r'([\d\.]+)', raw_coating)
                if match: bar_coater_num = float(match.group(1))
            elif raw_coating.isdigit():
                coating_weight_um = float(raw_coating)

        cur.execute("""
            INSERT INTO lab_coating (
                lab_serial, category, coating_date, backing, adhesive_id,
                curing_agent, additives, coating_weight_um, bar_coater_num,
                worker, adhesion, heat_pressing, heat_resistance, weather_resistance,
                moisture_resistance, outdoor_exposure, holding_power_processing,
                bending, laser_cutting, impact_resistance, note
            ) VALUES (
                %s, %s, %s, %s, %s,
                %s, %s, %s, %s,
                %s, %s, %s, %s, %s,
                %s, %s, %s,
                %s, %s, %s, %s
            )
        """, (
            normalize_text(row.get('Lab 일련번호')), normalize_text(row.get('분류')), row.get('도포 날짜'), normalize_text(row.get('원단')), normalize_text(row.get('점착제')),
            normalize_text(row.get('경화제')), normalize_text(row.get('첨가제')), 
            coating_weight_um,
            int(bar_coater_num) if bar_coater_num is not None else None,
            normalize_text(row.get('작업자'), 'worker'), normalize_text(row.get('점착력')), normalize_text(row.get('가열압착'), 'heat_pressing'), normalize_text(row.get('내열성'), 'heat_resistance'), normalize_text(row.get('내후성'), 'weather_resistance'),
            normalize_text(row.get('내습성'), 'moisture_resistance'), normalize_text(row.get('야외폭로'), 'outdoor_exposure'), normalize_text(row.get('가공/유지력')),
            normalize_text(row.get('절곡')), normalize_text(row.get('레이저컷팅')), normalize_text(row.get('내충격성')), normalize_text(row.get('비고'), 'note')
        ))
        count += 1
        
    conn.commit()
    cur.close()
    conn.close()
    print(f"✅ Loaded {count} coating records.")

if __name__ == "__main__":
    load_synthesis()
    load_coating()
