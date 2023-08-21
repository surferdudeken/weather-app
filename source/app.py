from flask import Flask, jsonify 
import requests 
from datetime import datetime

app = Flask(__name__)

# Endpoint for Washington DC
@app.route('/weather-app')
def get_weather():
    # Fetch Daily temps (high, low, and rain) with units set to Fahrenheit, mph, and inchs
    response = requests.get(f'https://api.open-meteo.com/v1/forecast?latitude=38.8951&longitude=-77.0364&daily=temperature_2m_max,temperature_2m_min,precipitation_sum&temperature_unit=fahrenheit&windspeed_unit=mph&precipitation_unit=inch&timezone=GMT')

    data = response.json()
    
    try:
        today_data = data['daily']
        weather_info = {
            "date": datetime.now().strftime('%Y-%m-%d'),
            "temperature_high": today_data['temperature_2m_max'][0], 
            "temperature_low": today_data['temperature_2m_min'][0],
            "precipitation": today_data['precipitation_sum'][0]
        }
        return jsonify(weather_info)
    except KeyError:
        return jsonify({"error": "Unable to retrieve daily weather data"})

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000, debug=True)