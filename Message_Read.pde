/***********************************************************************
 * READ MESSAGE FUNCTION - reads incoming message and examines the checksum.
 * If checksum is true then parse message.
 ************/
void read_msg(char newChar) {
  if(msgStart == false && newChar == '$') {
      msgStart = true;
      msgEnd = false;
      msgIndex = 0;
      nmeaMsg[msgIndex] = newChar;
      msgIndex++;    
  } else if (msgStart == true && msgEnd == false) {
     if (newChar != byte(10)) {
          nmeaMsg[msgIndex] = newChar;
          msgIndex++;    
      }  else if (newChar == byte(10)) { msgEnd = true; }
  } else if (msgStart == true && msgEnd == true) {
      if (confirm_checksum(nmeaMsg, sizeof(nmeaMsg))) {
         parse_msg();
//         printMsg(nmeaMsg, sizeof(nmeaMsg));
      } 
      msgStart = false;
  }
}


/***********************************************************************
 * PARSE MESSAGE FUNCTION - parses location information and time from the
 * GGA messages sent by the GPS module.
 ************/
void parse_msg() {
    // parse all elements into the appropriate variables
    parse_element(GGAtimeLoc, timeStamp, sizeof(timeStamp));
    parse_element(GGAlattitudeLoc, lattitude, sizeof(lattitude));
    parse_element(GGAlongitudeLoc, longitude, sizeof(longitude));
    if (nmeaMsg[GGAfixValidLoc] == '1' || nmeaMsg[GGAfixValidLoc] == '2') { 
        for (int i = 0; i < sizeof(timeStamp); i++) lastValidReading[i] = timeStamp[i]; }
    else { locValid = false; }
    print_gps_data();
    Serial.println();

}


/***********************************************************************
 * PARSE ELEMENT FUNCTION - parses individual elements from GGA messages
 * when provided with the index location, length of the data and an array
 * pointer to where the data will be saved
 ************/
void parse_element(int indexLoc, char *elementArray, int arrayLength) {
    for(int i = 0; i < arrayLength; i++) { elementArray[i] = nmeaMsg[i + indexLoc]; }
}

/***********************************************************************
 * PRINT GPS FUNCTION - prints GPS data that has been parsed and saved into
 * the timestamp, longitude and lattitude variables
 ************/
void print_gps_data() {
    // print all data elements on the serial port
    publishMsg(timeStamp, sizeof(timeStamp));
    publishMsg(lattitude, sizeof(lattitude));
    publishMsg(longitude, sizeof(longitude));
    publishMsg(lastValidReading, sizeof(lastValidReading));
}
