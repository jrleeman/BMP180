# BMP180 Barometric Pressure Sensor

This code reads the BMP180 barometric pressure sensor by Bosch. Currently 
support for the Parallax Propeller in SPIN to supplement existing code 
for the Arduino provided by SparkFun Electronics. Testing was done with
the BMP180 breakout board (link below) and a Propeller ASC+. Different 
resolutions are selected on sensor initialization as documented in the
code.

### Sensor Details
[Sensor Breakout (Sparkfun)](www.sparkfun.com/products/11824)

[Sensor Datasheet](https://github.com/sparkfun/BMP180_Breakout/blob/master/BMP180%20Datasheet%20V2.5.pdf?raw=true)

[Arudino Github Repo (Sparkfun)](github.com/sparkfun/BMP180_Breakout)

### Setup
1. Connect the power headers of the sensor to ground and 3.3V respectively.
2. Connect the clock line to pin 0 of the propeller.
3. Connect the data line to pin 1 of the propeller.
4. Power the microcontroller and load the 'Test Sensor.spin' code
5. Watch as 10000 readings at each resolution setting stream in. You can
   use this to check the standard deviation of each setting or test the 
   real current draw of your sensor.

### Notes
* This used Chris Gadd's [I2C Routines object](http://obex.parallax.com/object/700) found on the [Parallax Object Exchange](http://obex.parallax.com/)
* Pull-ups are required with this setup, but that can be modified by using the 
  push-pull object in the I2C Routines.

### To-Do
* Return both temperature and pressure from the sensor
* Add software oversampling and averaging
* Clean code and comments