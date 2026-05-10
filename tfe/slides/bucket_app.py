from fastapi import FastAPI
from google.cloud import storage
import joblib

app = FastAPI()

PROJECT_ID = "turing-alcove-384403"
BUCKET_NAME = "my2026model"

MODEL_BLOB_PATH = "models/v1/penguin_model.joblib"

LOCAL_MODEL_PATH = "/tmp/penguin_model.joblib"

# Download model from GCS
storage_client = storage.Client(project=PROJECT_ID)

bucket = storage_client.bucket(BUCKET_NAME)

blob = bucket.blob(MODEL_BLOB_PATH)

blob.download_to_filename(LOCAL_MODEL_PATH)

# Load model
model = joblib.load(LOCAL_MODEL_PATH)

print("Model loaded from GCS!")

@app.get("/")
def health():
    return {
        "status": "running"
    }

@app.post("/predict")
def predict(
    culmen_length_mm: float,
    culmen_depth_mm: float,
    flipper_length_mm: float,
    body_mass_g: float
):

    features = [[
        culmen_length_mm,
        culmen_depth_mm,
        flipper_length_mm,
        body_mass_g
    ]]

    prediction = model.predict(features)[0]

    return {
        "prediction": prediction
    }
