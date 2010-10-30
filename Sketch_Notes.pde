/*********************************************
QUERY/RATE COMMAND

This command is used to control the output of standard NMEA messages GGA, GLL, GSA, GSV, RMC, and VTG.  
Using this command message, standard NMEA messages may be polled once, or setup for periodic output. 
Checksums may also be enabled or disabled depending on the needs of the receiving program. NMEA message 
settings are saved in battery-backed memory for each entry when the message is accepted.

Below is a sample message. The first element identifies the message as a query/rate command. The second 
element is the message ID, from the ones listed below. The third element is rate or query flag (0 for
rate set, 1 for query). The fourth element sets the rate (it hexadecimal value between 0 and 255). The 
fifth element is the checksum flag (1 for on, 0 for off). The number after the asterix is the checksum.

Sample Message: $PSRF103,00,01,00,01*25

Message ID Number
0    GGA
1    GLL
2    GSA
3    GSV
4    RMC
5    VTG
6    MSS (If internal beacon is supported)
7    Not defined
8    ZDA (if 1PPS output is supported)
9    Not defined


*********************************************/

