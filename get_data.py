# module get_data

import csv

def get_growth_table():
    growth_table = {}
    with open('state_populations.csv', 'r') as f:
        reader = csv.DictReader(f)
        for row in reader:
            row = dict(row)
            code = row["Code"]
            y2010 = float(row["2010"].replace(",", ""))
            y2018 = float(row["2018"].replace(",", ""))
            growth = y2018 - y2010
            growth_ratio = growth / y2010
            growth_pct = int(growth_ratio * 100 + 0.5)
            growth_table[code] = growth_pct
    return(growth_table)
