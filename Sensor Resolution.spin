{{                                                                                                                       
  Sensor Resolution.spin
  J.R. Leeman
  kd5wxb@gmail.com

  A demonstration to show the different resolution settings on the BMP180.
  Streams 10000 readings at each resolution back to the terminal, which is
  enough to do your own statistics on, but runs quickly enough that there
  are likely not large environmental changes.
  
  oss = 0 : Ultra Low Power - RMS noise 0.06 hPa/0.5 m
  oss = 1 : Standard        - RMS noise 0.05 hPa/0.4 m
  oss = 2 : High Resolution - RMS noise 0.04 hPa/0.3 m
  oss = 3 : Ultra High Res. - RMS noise 0.03 hPa/0.25 m
                                                                                                                                                       
                                                                                                                                                            
}}
CON
_clkmode = xtal1 + pll16x                                                      
_xinfreq = 5_000_000

  SCL = 0 'SCL Pin
  SDA = 1 'SDA Pin                                                                                                                                                                                                                                               ' 7-bit device ID for EEPROM

VAR
  long temp,pres                

OBJ
  PST : "Parallax Serial Terminal"
  BMP180 : "BMP180 Spin"

PUB Main 
  Pause_MS(2000) 
  PST.Start(115200)

  PST.Str(String(13,"OSS0"))
  BMP180.Init(SCL,SDA,0) 
  repeat 10000
    BMP180.Read(@temp,@pres)
    PST.Str(String(13))
    PST.dec(temp)
    PST.Str(String(","))
    PST.dec(pres)

  PST.Str(String(13,"OSS1"))
  BMP180.Init(SCL,SDA,1)
  repeat 10000
    BMP180.Read(@temp,@pres)
    PST.Str(String(13))
    PST.dec(temp)
    PST.Str(String(","))
    PST.dec(pres)

  PST.Str(String(13,"OSS2"))
  BMP180.Init(SCL,SDA,2)
  repeat 10000
    BMP180.Read(@temp,@pres)
    PST.Str(String(13))
    PST.dec(temp)
    PST.Str(String(","))
    PST.dec(pres)

  PST.Str(String(13,"OSS3"))
  BMP180.Init(SCL,SDA,3)
  repeat 10000
    BMP180.Read(@temp,@pres)
    PST.Str(String(13))
    PST.dec(temp)
    PST.Str(String(","))
    PST.dec(pres)

PRI Pause_MS(mS)
  waitcnt(clkfreq/1000 * mS + cnt)

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