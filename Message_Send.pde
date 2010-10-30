/***********************************************************************
 * SEND REQUEST MSG FUNCTION - customized version of send msg function that 
 * sends information queries to GPS unit
 ************/
void requestMsg(char ID) { 
  sendMsg(ID, 1, 1);  
}

/***********************************************************************
 * SEND CHANGE RATE MSG FUNCTION - customized version of send msg function that 
 * sends message to change the rate of specific updates
 ************/
void changeRateMsg(char ID, int rate) {
  sendMsg(ID, rate, 0);
}

/***********************************************************************
 * SEND MSG FUNCTION - sends a rate change/query message to GPS unit based on 
 * the parameters that are provided. The ID specifies what type of update that 
 * the message refers to, the rate specifies an interval between 1 and 255 seconds,
 * the last element identifies whether the message is a query (1) or a rate setting (0)
 ************/
void sendMsg(char ID, int rate, int requestOrRate) {
     char genCtrlRateMsg[] = {'$','P','S','R','F','1','0','3',',','0','0',',','0','0',',','0','0',',','0','1','*'};
     char checkSumArray[] = {0, 0};
     char hexRate[2] = {0,0};    

     // customize the message to be sent based on the arguments provided
     checksum_hex_to_ascii(rate, hexRate);                     // convert rate int value to a hexadecimal string
     genCtrlRateMsg[rateRequestIDSecond] = ID;                 // update message ID
     genCtrlRateMsg[rateRequestMode] = byte(requestOrRate + 48);    // update request or rate flag
     genCtrlRateMsg[rateRequestRateFirst] = hexRate[0];        // update first number of rate definition
     genCtrlRateMsg[rateRequestRateSecond] = hexRate[1];       // update second number of rate definition
  
     // calculate checksum using the message that was created above
     int getCheckSum = get_checksum(genCtrlRateMsg, sizeof(genCtrlRateMsg));
     checksum_hex_to_ascii(getCheckSum, checkSumArray);

     // send the request to the GPS unit 
     for (int i = 0; i < sizeof(genCtrlRateMsg); i++) mySerial.print(genCtrlRateMsg[i]);
     mySerial.print(checkSumArray[0]);
     mySerial.println(checkSumArray[1]);

     // print the request that is sent to the GPS to the serial port as well
     for (int i = 0; i < sizeof(genCtrlRateMsg); i++) Serial.print(genCtrlRateMsg[i]);
     Serial.print(checkSumArray[0]);
     Serial.print(checkSumArray[1]);
     Serial.print(" - getCheckSum ");
     Serial.println(getCheckSum);
     delay(500);
}

