#include <NewSoftSerial.h>

NewSoftSerial mySerial(2, 12);

#define ctrlIDFirst        9
#define ctrlIDSecond       10
#define rateRequestMode    13
#define ctrlRateFirst      15
#define ctrlRateSecond     16

char nmeaMsg[300];
boolean msgStart = false;
boolean msgEnd = false;

void setup()  
{
  Serial.begin(57600);      // initialize serial port for Data Output 
  mySerial.begin(4800);     // initialize serial port for GPS
}


void loop()                     
{
  // Print to screen the messages from 
  if (mySerial.available()) { 
      char tempChar = (char)mySerial.read();
      Serial.print(tempChar); 
  }
  if (Serial.available()) {
      char tempChar = (char)Serial.read();
      changeRateMsg(tempChar, 5);
  }
}

void read_msg(char) {
  
}





