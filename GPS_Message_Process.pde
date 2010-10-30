#include <NewSoftSerial.h>

NewSoftSerial mySerial(2, 12);

#define rateRequestIDFirst       9
#define rateRequestIDSecond      10
#define rateRequestMode          13
#define rateRequestRateFirst     15
#define rateRequestRateSecond    16

#define GGAtimeLoc               7
#define GGAlattitudeLoc          18
#define GGAlongitudeLoc          30
#define GGAfixValidLoc           43

// variables for reading in data from GPS
char nmeaMsg[300];
int msgIndex = 0;
char checksumMsg[2];
int checksumIndex = 0;
boolean msgStart = false;
boolean msgEnd = false;

// variables for printing out data from GPS
char lattitude[] = {'0','0','0','0','0','0','0','0','0','0','0'};
char longitude[] = {'0','0','0','0','0','0','0','0','0','0','0','0'};
char timeStamp[] = {'0','0','0','0','0','0','0','0','0','0'};
boolean locValid = false;
char lastValidReading[] = {'0','0','0','0','0','0','0','0','0','0'};


void setup()  
{
  Serial.begin(9600);      // initialize serial port for Data Output 
  mySerial.begin(4800);     // initialize serial port for GPS
}


void loop()                     
{
  // read data from the GPS unit 
  if (mySerial.available()) { 
    read_msg((char)mySerial.read()); 
  }


//  UNCOMMENT AND CHANGE TO send messages to GPS to change settings regarding availability and the rate of updates
//  if (Serial.available()) {
//      char msgID = (char)Serial.read();
//      int msgRate = 1;
//      changeRateMsg(msgID, msgRate);
//    }

}



// DEBUG CODE: print message to serial port for debugging
void printMsg(char msg[], int len) {
      for(int i = 0; i < len; i++) {
          if(msg[i] != byte(13)) Serial.print(msg[i]); 
          else break;
      }
      Serial.println();
}

// OUTPUT CODE: publish the proper message to the serial port for logging
void publishMsg(char msg[], int len) {
      for(int i = 0; i < len; i++) {
          if(msg[i] != byte(13)) Serial.print(msg[i]); 
          else break;
      }
      Serial.print(',');
}




