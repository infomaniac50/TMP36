	/*
  TMP36.cpp - Library for reading the TMP36 temperature sensor
  Created by Derek Chafin, September 14, 2011
  Released into the public domain.
*/

#include "TMP36.h"

TMP36::TMP36(int tpin, float aref)
{
  _aref = aref;
  _tpin = tpin;
}

void TMP36::update()
{
  int reading = analogRead(_tpin);
  
  float voltage = reading * _aref;
  voltage /= 10.24;
  
  //converting from 10 mv per degree with 500 mV offset
  //to degrees (volatge - 500mV)
  _tempc = voltage - 50 ;  
  // now convert to Fahrenheight
  _tempf = (_tempc * 9.0 / 5.0) + 32.0;   
}

float TMP36::getCelsius()
{
  return _tempc;
}

float TMP36::getFahrenheit()
{
  return _tempf;
}
