/*
  TMP36.h - Library for reading the TMP36 temperature sensor
  Created by Derek Chafin, September 14, 2011
  Released into the public domain.
*/

#ifndef TMP36_h
#define TMP36_h

#if (ARDUINO >= 100)
 #include "Arduino.h"
#else
 #include "WProgram.h"
#endif

class TMP36
{
  public:
    TMP36(int tpin, float aref);
    void update();
    float getCelsius();
    float getFahrenheit();
  private:
    int _tpin;
    float _aref;      
    float _tempf;
    float _tempc;
};

#endif
