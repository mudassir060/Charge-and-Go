#include <WiFi.h>
#include <HTTPClient.h>
#include <ArduinoJson.h>

const char* ssid = "TP-LINK_B9F2";
const char* password = "21075117";

void setup() {
  Serial.begin(115200);
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("Connecting to WiFi...");
  }
  Serial.println("Connected to WiFi");
  pinMode(15, OUTPUT);
}

void loop() {
  if (WiFi.status() == WL_CONNECTED) {
    HTTPClient http;
    http.begin("https://firestore.googleapis.com/v1/projects/charge-go/databases/(default)/documents/BookRide/1/");
    int httpCode = http.GET();
    if (httpCode > 0) {
      String payload = http.getString();
      DynamicJsonDocument doc(1024);
      DeserializationError error = deserializeJson(doc, payload);
      if (error) {
        Serial.print(F("deserializeJson() failed with code "));
        Serial.println(error.c_str());
        return;
      }
      int condition = doc["fields"]["condition"]["integerValue"];
      Serial.println("Condition: " + String(condition));
      if (condition == 1) {
        digitalWrite(15, HIGH);
      } else {
        digitalWrite(15, LOW);
      }
    } else {
      Serial.println("Error on HTTP request");
    }
    http.end();
  }
  delay(1000);
}
