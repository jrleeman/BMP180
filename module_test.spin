CON
_clkmode = xtal1 + pll16x                                                      
_xinfreq = 5_000_000

  SCL = 0
  SDA = 1
  oss = 3                                                                                                                                                                                                                                                   ' 7-bit device ID for EEPROM

VAR
  long pt[2]
  long p                 

OBJ
  PST : "Parallax Serial Terminal"
  BMP180 : "barometric_module"

PUB Main 
  Pause_MS(1000) 
  PST.Start(115200)

  PST.Str(String(13,"OSS0"))
  BMP180.Init(SCL,SDA,0)

  repeat 10000
    p := BMP180.Read

    PST.Str(String(13))
    PST.dec(p)

  PST.Str(String(13,"OSS1"))
  BMP180.Init(SCL,SDA,1)

  repeat 10000
    p := BMP180.Read

    PST.Str(String(13))
    PST.dec(p)

  PST.Str(String(13,"OSS2"))
  BMP180.Init(SCL,SDA,2)

  repeat 10000
    p := BMP180.Read

    PST.Str(String(13))
    PST.dec(p)

  PST.Str(String(13,"OSS3"))
  BMP180.Init(SCL,SDA,3)

  repeat 10000
    p := BMP180.Read

    PST.Str(String(13))
    PST.dec(p)

PRI Pause_MS(mS)
  waitcnt(clkfreq/1000 * mS + cnt)