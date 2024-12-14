#include <PubSubClient.h>
#include <WiFi.h>
#include <WiFiClientSecure.h>

// Wi-Fi credentials
const char* ssid = "hidden for pivacy";
const char* password = "hidden for pivacy";

// AWS IoT credentials
const char* awsEndpoint = "hidden for pivacy";
// IoT endpoint
const char* mqttTopic = "asl/translation";

// Device certificates
const char* AWS_CERT_CA =

    "-----BEGIN CERTIFICATE-----\n"
    "hidden for pivacy"
    "-----END CERTIFICATE-----";

const char* AWS_CERT_CRT =
    "-----BEGIN CERTIFICATE-----\n"
    "hidden for pivacy"
    "-----END CERTIFICATE-----";
const char* AWS_CERT_PRIVATE =
    "-----BEGIN RSA PRIVATE KEY-----\n"
    "hidden for pivacy"
    "-----END RSA PRIVATE KEY-----";

// Wi-Fi and MQTT clients
WiFiClientSecure wifiClient;
PubSubClient client(wifiClient);

// Flex sensor pins
const int flexSensorPins[5] = {36, 38, 37, 33, 32};

// Translation Thresholds
#define THRESHOLD 1500

//  ASL Translation Map
// 0 - unbent
// 1 - bent
String getASLTranslation(String binaryState) {
  if (binaryState == "11111") return "Yes";
  if (binaryState == "00000") return "No";
  if (binaryState == "11110") return "I";
  if (binaryState == "00110") return "Love you";
  if (binaryState == "10111") return "1";
  if (binaryState == "10011") return "2";
  if (binaryState == "00011") return "3";
  return "Unknown";
}

void setup() {
  Serial.begin(9600);

  // Connect to wifi
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("Connecting to Wi-Fi...");
  }
  Serial.println("Connected to Wi-Fi!");

  // // Connect to Wi-Fi
  // Serial.println("Connecting to Wi-Fi...");
  // WiFi.begin(ssid, password);
  // while (WiFi.status() != WL_CONNECTED) {
  //   delay(1000);
  //   Serial.println("Connecting...");
  // }
  // Serial.println("Wi-Fi connected!");

  // Configure AWS IoT credentials / MQTT client
  wifiClient.setCACert(AWS_CERT_CA);
  wifiClient.setCertificate(AWS_CERT_CRT);
  wifiClient.setPrivateKey(AWS_CERT_PRIVATE);
  client.setServer(awsEndpoint, 8883);

  // Connect to AWS IoT Core
  while (!client.connected()) {
    Serial.println("Connecting to AWS IoT...");
    if (client.connect("ESP32_ASL")) {
      Serial.println("Connected to AWS IoT!");
    } else {
      Serial.print("Failed to connect. State: ");
      Serial.println(client.state());
      delay(2000);
    }
  }
}

void loop() {
  // Read all flex sensors and determine their states
  String binaryState = "";
  for (int i = 0; i < 5; i++) {
    int sensorValue = analogRead(flexSensorPins[i]);
    binaryState +=
        (sensorValue > THRESHOLD) ? "1" : "0";  // 1 for bent, 0 for straight
    Serial.println("Sensor " + String(i + 1) + ": " + String(sensorValue));
  }

  // Determine ASL translation
  String translation = getASLTranslation(binaryState);
  Serial.println("ASL Translation: " + translation);

  // Create JSON payload
  String jsonPayload = "{";
  jsonPayload += "\"binaryState\":\"" + binaryState + "\",";
  jsonPayload += "\"translation\":\"" + translation + "\"";
  jsonPayload += "}";

  // Publish translation to AWS IoT
  if (client.connected()) {
    client.publish("asl/translation", jsonPayload.c_str());
    Serial.println("Published: " + jsonPayload);
  } else {
    Serial.println("Failed to publish. MQTT not connected.");
  }

  delay(2000);  // Adjust delay as needed
}
