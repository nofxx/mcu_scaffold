#define DEBUG 1  //Print to Serial
#define APPPIN 12 // Pin to Relay
#define REFRESHTIME 1 //MINUTES
#define WHILE_TO 5000 // milliseconds
#define PRINTDEBUG(STR) \
  { \
    if (DEBUG) Serial.println(STR); \
  }
#define BIAS 1
#include <ESP8266WiFi.h>
#include "TheAppParams.h" // Change this file params

//INIT
const char* ssid     = MY_SSID;
const char* password = MY_PWD;
const char* host = MY_HOST;
const char* hostIP = MY_HOSTIP;
String url = "/getIP.php?psswd=";
WiFiServer server(80);

//Class defintion of the water heater control
class appControl {
  public:
    //   appControl();
    void begin(int pin) {
      //pinMode(appPin, OUTPUT);
      //digitalWrite(appPin, currentState);
