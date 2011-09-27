/*
TMP36 Temperature Sensor Demo
Derek Chafin
September 27, 2011
Public Domain

Demonstrates how to use the TMP36 library

Pin Connections:

+3.3V: connected to sensor Vs
analog 0: connected to voltage out on temperature sensor
aref: connected to +3.3V
*/

#include <TMP36.h>

const int pin_t = A0;
const float aref = 3.3;
TMP36 sensor_t(pin_t, aref);

void setup()
{
  Serial.begin(9600);
  
  Serial.println("Celsius,\tFahrenheit");
}

void loop()
{
  //this is required to update the values
  sensor_t.update();
  
  //this tells us how long the string is
  int string_width;

  float tempc;
  float tempf;  
  
  tempc = sensor_t.getCelsius();
  tempf = sensor_t.getFahrenheit();
  
  //The temperature sensor only has an accuracy of +-1 degree Celsius
  Serial.print(formatFloat(tempc, 0, &string_width));
  Serial.print(",\t");
  Serial.print(formatFloat(tempf, 0, &string_width));
  Serial.println("");
  
  delay(1000);
}

//this function was taken from my format float library
String formatFloat(double value, int places, int* string_width)
{
  //if value is positive infinity
  if (isinf(value) > 0)
  {
    return "+Inf";
  }
    
  //Arduino does not seem to have negative infinity
  //keeping this code block for reference
  //if value is negative infinity
  if(isinf(value) < 0)
  {
    return "-Inf";
  }
  
  //if value is not a number
  if(isnan(value) > 0)
  {
    return "NaN";
  }
  
  //always include a space for the dot
  int num_width = 1;

  //if the number of decimal places is less than 1
  if (places < 1)
  {
    //set places to 1
    places = 1;
    
    //and truncate the value
    value = (float)((int)value);
  }
  
  //add the places to the right of the decimal
  num_width += places;
  
  //if the value does not contain an integral part  
  if (value < 1.0 && value > -1.0)
  {
    //add one for the integral zero
    num_width++;
  }
  else
  {

    //get the integral part and
    //get the number of places to the left of decimal
    num_width += ((int)log10(abs(value))) + 1;
  }
  //if the value in less than 0
  if (value < 0.0)
  {
    //add a space for the minus sign
    num_width++;
  }
  
  //make a string the size of the number
  //plus 1 for string terminator
  char s[num_width + 1]; 
  
  //put the string terminator at the end
  s[num_width] = '\0';
  
  
  //initalize the array to all zeros
  for (int i = 0; i < num_width; i++)
  {
    s[i] = '0';
  }
  
  //characters that are not changed by 
  //the function below will be zeros
  
  //set the out variable string width
  //lets the caller know what we came up with
  *string_width = num_width;
  
  //use the avr-libc function dtosrtf to format the value
  return String(dtostrf(value,num_width,places,s));  
}