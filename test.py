'''
today is 1st of december 2023
i'm using this test.py for creating a rest api for the LC3 test run
'''

from fastapi import FastAPI, HTTPException
import pandas as pd

app = FastAPI()

API_KEY = 'adewt21'
df = pd.read_csv("https://raw.githubusercontent.com/AdeWT/AdeWT-Hacktiv8-things/main/Countries.csv")
@app.get("/")
def root():
    try:
        df
        return df.to_dict(orient="records")
    except:
        return HTTPException (status_code=500, detail="Internal server error")


@app.delete("/del/{id}")
def remove_row(id:int, api_key, str=None):
    if id not in df[id]:
        raise HTTPException(status_code=404, detail=f"Item with ID {id} not found")
    else:
        if api_key is None or api_key != API_KEY:
            raise HTTPException(status_code=401, detail="Invalid API Key. You are not allowed to delete data!")
        else:
            df.pop(id)
            return {"message": f"Item with ID {id} has been deleted successfully."}