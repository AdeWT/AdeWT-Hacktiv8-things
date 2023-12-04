'''
==================
LIVE CODE 3 (Phase 0)
==================

Name = Ade William Tabrani
Batch = RMT-026 FTDS

This python is made as the answer to live code 3 question of making an API that shows the no outlier data
'''

from fastapi import FastAPI, HTTPException
import pandas as pd

app = FastAPI()

df = pd.read_csv("https://raw.githubusercontent.com/AdeWT/AdeWT-Hacktiv8-things/main/no_outlier.csv")
@app.get("/")
def root():
    try:
        df
        return df.to_dict(orient="records")
    except:
        return HTTPException (status_code=500, detail="Internal server error")