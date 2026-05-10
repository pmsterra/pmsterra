from fastapi import FastAPI
import joblib

app = FastAPI()

# Load trained model
model = joblib.load("penguin_model.joblib")

@app.get("/")
def home():
    return {
        "message": "Penguin prediction API is running"
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



$ uvicorn app:app --host 0.0.0.0 --port 8000
INFO:     Started server process [8334]
INFO:     Waiting for application startup.
INFO:     Application startup complete.
INFO:     Uvicorn running on http://0.0.0.0:8000 (Press CTRL+C to quit)
