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
