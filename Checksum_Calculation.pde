/************************************************************************
 * GET_CHECKSUM FUNCTION - calculates the checksum of messages to be sent 
 ************/
int get_checksum(char msg[], int len) {
  byte checksum = 0;                                    // create checksum variable and set it to 0
  for (int i = 0; i < len; i++) {                         // loop through each element in the message
    if (msg[i] == '$') {                                  // IF start characters is found ('$')
      i++; checksum = msg[i]; }                            // set the checksum to using the first character in the message
    else if (msg[i] != '*') { checksum ^= msg[i]; }  // ELSE IF msgStarted is set to true then calculate the checksum
    else { return checksum; }                 // ELSE IF the end of the message has been found ('*') get out of the loop
  }    
  return checksum;                                        // return the checksum
}


/***********************************************************************
 * GET_HEX_TO_ASCII FUNCTION - converts the checksum integer into two 
 * chars that are the hexidecimal representation
 ***********/
void checksum_hex_to_ascii(int checkInt, char *checkSum) {
  int highBit = checkInt/16;
    if (highBit > 9) { checkSum[0] = char(highBit - 9) + byte(96); } 
    else {checkSum[0] = char(highBit) + byte(48); }
  int lowBit = checkInt - (highBit*16);
    if (lowBit > 9) { checkSum[1] = char(lowBit - 9) + byte(96); } 
    else {checkSum[1] = char(lowBit) + byte(48); }
}


/***********************************************************************
 * CONFIRM_CHECKSUM FUNCTION - converts the checksum integer into two 
 * chars that are the hexidecimal representation
 ************/
boolean confirm_checksum(char msg[], int len){
  char hexChecksumCalc [2] = {0,0}; 
  char hexChecksumOrig [2] = {0,0}; 
  int checksumPos = 0;
  int tempChecksum = 0;
  
  tempChecksum = get_checksum(msg, sizeof(msg));
  checksum_hex_to_ascii(tempChecksum, hexChecksumCalc);

  for(int i = 0; i < len; i++) { if (msg[i] == '*') checksumPos = i++; }
  hexChecksumOrig[0] = msg[checksumPos];
  hexChecksumOrig[1] = msg[checksumPos+1];

  if (hexChecksumCalc[0] == hexChecksumOrig[0] && hexChecksumCalc[0] == hexChecksumOrig[0]) 
    return true;
  return false;  
}

