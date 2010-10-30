void requestMsg(char ID) { 
  sendMsg(ID, 0, 1);  
}


void changeRateMsg(char ID, int rate) {
  sendMsg(ID, rate, 0);
}


void sendMsg(char ID, int rate, int requestOrRate) {
     char genCtrlRateMsg[] = {'$','P','S','R','F','1','0','3',',','0','0',',','0','0',',','0','0',',','0','1','*'};
     char genCtrlReqMsg[] = {'$','P','S','R','F','1','0','3',',','0','0',',','0','0',',','0','0',',','0','1','*'};
     char checkSumArray[] = {0, 0};
     char hexRate[2] = {0,0};    

     checksum_hex_to_ascii(rate, hexRate);              // convert rate int value to a hexadecimal string
     genCtrlRateMsg[ctrlIDSecond] = ID;                 // update message ID
     genCtrlRateMsg[rateRequestMode] = byte(requestOrRate + 48);    // update request or rate flag
     genCtrlRateMsg[ctrlRateFirst] = hexRate[0];        // update first number of rate definition
     genCtrlRateMsg[ctrlRateSecond] = hexRate[1];       // update second number of rate definition
  
     int getCheckSum = get_checksum(genCtrlRateMsg, sizeof(genCtrlRateMsg));
     checksum_hex_to_ascii(getCheckSum, checkSumArray);
     for (int i = 0; i < sizeof(genCtrlRateMsg); i++) mySerial.print(genCtrlRateMsg[i]);
     mySerial.print(checkSumArray[0]);
     mySerial.println(checkSumArray[1]);

     Serial.println();
     for (int i = 0; i < sizeof(genCtrlRateMsg); i++) Serial.print(genCtrlRateMsg[i]);
     Serial.print(checkSumArray[0]);
     Serial.print(checkSumArray[1]);
     Serial.print(" - getCheckSum ");
     Serial.println(getCheckSum);
     delay(500);
}

