#ifndef ADAFRUIT_RFID_SENSOR_H
#define ADAFRUIT_RFID_SENSOR_H

#include <Adafruit_PN532.h>

#define SDA_PIN 21            // Pin SDA to PN532
#define SCL_PIN 22            // Pin SCL to PN532


/// @brief Adafruit NFC Sensor class wrapper to wrap the real thing which is the Adafruit PN532 Class Connector
class AdafruitNFCSensor {
    public:
        AdafruitNFCSensor();
        bool setup();
        char* readNFCCard(uint16_t timeout = 5000);
    
    private:
        Adafruit_PN532 _pn532Sensor;
  };


#endif