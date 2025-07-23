from flask import Flask, request, jsonify
import pickle
import numpy as np

app = Flask(__name__)

# Load the model
file_path = "random_forest_model.pkl"  # Path to your model
with open(file_path, 'rb') as file:
    model = pickle.load(file)

# Home route
@app.route('/')
def home():
    return "Welcome to the ML Prediction API!"

# Prediction route
@app.route('/predict', methods=['POST'])
def predict():
    try:
        data = request.json  # Get JSON data
        features = data['features']  # Example: [1, 0, 1, 0, 1]

        # Convert to 2D array
        features = np.array(features).reshape(1, -1)

        # Predict
        prediction = model.predict(features)

        # Return result
        return jsonify({'prediction': prediction.tolist()})

    except Exception as e:
        print("Error:", e)
        return jsonify({"error": str(e)}), 500

# Start server
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001)
