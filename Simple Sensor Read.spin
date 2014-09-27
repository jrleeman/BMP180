{{                                                                                                                       
  Simple Sensor Read.spin
  J.R. Leeman
  kd5wxb@gmail.com

  A demonstration to read the sensor temperature and pressure in the
  most simple way.  This is done on the ultra-high-resolution setting
  to give the best possible data quality.
                                                                                                                                                       
                                                                                                                                                            
}}
CON
_clkmode = xtal1 + pll16x                                                      
_xinfreq = 5_000_000

  SCL = 0 'SCL Pin
  SDA = 1 'SDA Pin
  oss = 3 'Oversampling Factor (see datasheet)                                                                                                                                                                                                                                                  ' 7-bit device ID for EEPROM

VAR
  long temp,pres
OBJ
  PST : "Parallax Serial Terminal"
  BMP180 : "BMP180 Spin"

PUB Main

  'Pause to let the user start their terminal
  Pause_MS(2000)

  'Startup the PST terminal
  PST.Start(115200)

  PST.Str(String(13,"Demo of BPM180 Sensor"))
  PST.Str(String(13,"Returns Temperature in tenths of degree C"))
  PST.Str(String(13,"Returns Pressure in Pa"))

  'Start the Sensor 
  BMP180.Init(SCL,SDA,3)

  repeat 
    BMP180.Read(@temp,@pres)

    PST.Str(String(13))
    PST.dec(temp)
    PST.Str(String(","))
    PST.dec(pres)
    Pause_MS(2000)

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