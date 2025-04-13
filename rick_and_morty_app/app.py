import requests
import csv
from flask import Flask, jsonify

app = Flask(__name__)

def get_characters():
    url = "https://rickandmortyapi.com/api/character"
    params = {"species": "Human", "status": "Alive", "origin": "Earth"}

    response = requests.get(url, params=params)

    if response.status_code == 200:
        return response.json()["results"]
    else:
        print("Error fetching data from the API.")
        return []

def write_to_csv(characters):
    with open("rick_and_morty_characters.csv", mode="w", newline="") as file:
        fieldnames = ["Name", "Location", "Image"]
        writer = csv.DictWriter(file, fieldnames=fieldnames)

        writer.writeheader()
        for character in characters:
            writer.writerow(
                {
                    "Name": character["name"],
                    "Location": character["location"]["name"],
                    "Image": character["image"],
                }
            )

@app.route("/characters", methods=["GET"])
def get_characters_data():
    characters = get_characters()
    if characters:
        return jsonify(characters)
    else:
        return jsonify({"message": "No characters found."}), 404

@app.route("/healthcheck", methods=["GET"])
def health_check():
    return jsonify({"status": "healthy"})

if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0")

