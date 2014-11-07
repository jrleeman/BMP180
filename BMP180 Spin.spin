{{                                                                                                                       
  BMP180 Pressure Sensor Object
  J.R. Leeman
  kd5wxb@gmail.com

  This is a driver that uses the I2C SPIN driver v1.2 for the I2C communication.
  Sensor details and reading methodology can be found in the datasheet from
  Bosch. Code was tested with the BMP180 breakout board from Sparkfun Electronics.

  Use:
  - Call Init with SCL,SDA pins and the oversampling setting (resolution)
        oss = 0 : Ultra Low Power - RMS noise 0.06 hPa/0.5 m
        oss = 1 : Standard        - RMS noise 0.05 hPa/0.4 m
        oss = 2 : High Resolution - RMS noise 0.04 hPa/0.3 m
        oss = 3 : Ultra High Res. - RMS noise 0.03 hPa/0.25 m

  - Read data with Read function by passing two pointers for the
    temperature and pressure.                                                                                                                                                         
                                                                                                                                                            
}}                                                                                                                                                
CON
  ' Address of the barometric pressure sensor
  ALT = %1110111

DAT
  ' Conversion time for different resolutions
   ConvTime byte 5,8,14,26

VAR
  byte CoefResponse[22]
  long CalCoefs[11]                  'Order: AC1,AC2,AC3,AC4,AC5,AC6,B1,B2,MB,MC,MD
  long UT,UP,X1,X2,X3,B3,B4,B5,B6,B7
  long T,p,oss

OBJ
  I2C  : "I2C SPIN driver v1.2"
  
PUB Init(scl,sda,inoss)

  SCL := scl
  SDA := sda
  oss := inoss

  I2C.start(SCL,SDA)

  ' Read the Calibration Coefficients from on-board EEPROM
  ReadCals

PUB Read(TempPtr,PresPtr)   
  'Uncalibrated Temp Reading
  \I2C.write(ALT,$F4,$2E)
  Pause_MS(5)
  UT := (\I2C.read(ALT,$F6) << 8) | \I2C.read(ALT,$F7)
  X1 := (UT-CalCoefs[5])*CalCoefs[4]/32768
  X2 := CalCoefs[9] * 2048 / (X1 + CalCoefs[10])
  B5 := X1 + X2
  T  := (B5 + 8) / 16
   
  'Uncalibrated Pres Reading
  \I2C.write(ALT,$F4,($34+(oss<<6)))
  Pause_MS(ConvTime[oss])
  UP := ((\I2C.read(ALT,$F6) << 16) + (\I2C.read(ALT,$F7) << 8) + \I2C.read(ALT,$F8) ) >> (8-oss)
   
  B6 := B5 - 4000
  X1 := (CalCoefs[7] * (B6 * B6 / 4096)) / 2048
  X2 := CalCoefs[1] * B6 / 2048
  X3 := X1 + X2
  B3 := (((CalCoefs[0] * 4 + X3) << oss) + 2) / 4
  X1 := CalCoefs[2] * B6 / 8192
  X2 := (CalCoefs[6] * (B6 * B6 / 4096)) / 65536
  X3 := ((X1 + X2) + 2) / 4
  B4 := CalCoefs[3] * (X3 + 32768) / 32768
  B7 := (UP - B3) * (50000 >> oss)

  IF (B7 < $80000000)
    p := (B7 * 2) / B4
    
  ELSE
    p := (B7/B4)*2
   
  X1 := (p / 256) * (p / 256)
  X1 := (X1 * 3038) / 65536
  X2 := (-7357 * p) / 65536
  p := p + (X1 + X2 + 3791) / 16

  Long[TempPtr] := T
  Long[PresPtr] := p
  
PUB ReadCals | i

  repeat i from 0 to 21
    CoefResponse[i] := \I2C.read(ALT,$AA+i)

  repeat i from 0 to 10
    CalCoefs[i] := (CoefResponse[2*i] << 8) | CoefResponse[2*i+1]
    
  repeat i from 0 to 2
    CalCoefs[i] := ~~CalCoefs[i]

  repeat i from 6 to 10
    CalCoefs[i] := ~~CalCoefs[i]

PRI Pause_MS(mS)
  waitcnt(clkfreq / 1000 * mS + cnt)

CON
{{
                            TERMS OF USE: MIT License                                                           

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
}}