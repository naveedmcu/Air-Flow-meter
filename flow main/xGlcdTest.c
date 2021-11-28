                                                       /*
' * Project name:
'    xGlcdTest
'
'
'  Copyright 2009 - Pocket MicroTechnics
'                   http://www.pocketmt.com
'
'  Developed by :   M. Ahmed Lazreg
'                   octal@pocketmt.com
'
' * Description:
'     This is a simple demonstration of the X-GLCD library routines:
'     draws 3 strings at the screen using BIG fonts
' * Test configuration:
'     MCU:             PIC18F4520
'     Dev.Board:       EasyPIC5
'     Oscillator:      HS, 20.000 MHz
'     Ext. Modules:    None
'     SW:              mikroC Pro v2.50
' * NOTES:
'     None
' */

#include "hard_specific.c"  // "hard_specific.pas" contains code specific to the mcu
                            // and to initialisation of devBoard glcd pins
#include "xglcd_lib.c"
#include "propfont.h"



void delay2S(){
  delay_ms(2000);
}

void main() {
  unsigned short ii;
  unsigned int jj;
  char *someText;
  char temp_str[4];

  Init_mcu();

  //Must Initialize the LCD. xGLCD do not initialize it !!!
  //Glcd_Init(&PORTB, 2,0,3,5,7,1, &PORTD);     // Init for EasyPIC2 board
  //Glcd_Init(&PORTB, 2,3,4,5,7,6, &PORTD);       // Init for EasyPIC3 board
  Glcd_Init();       // Init for EasyPIC3 board
  Glcd_Fill(0x00);


  //Selects a X-GLCD proportional BIG font
  xGlcd_Set_Font(Broadway17x15, 17,15,32);

  //Be careful for (X,Y) coordinate passed as parameters for the drawing function
  //They are coordinate from (0..127, 0..63) there is no pages or screen sides
  //with X-GLCD lib ... all is computed automatically.

   //Draws some text
   someText = "Time 23:59";
   xGlcd_Write_Text(someText,17,1,xColorSet);
   delay2S();

  //Draws a char
  //xGlcd_Write_Char(65,10,46,xColorSet)

  //Old GLCD Fonts are still usables
  Glcd_Set_Font(System3x5, 3, 5, 32);
  someText = "GLCD OLD SMALL FONT";
  Glcd_Write_Text(someText, 3, 2, xColorSet);
  //delay2S

  //Draws some text
  someText = "Cool Big Font";
  xGlcd_Write_Text(someText,1,24,xColorSet);
  //delay2S

  //Select another font ... cooler and bigger
  xGlcd_Set_Font(Comic_Sans_MS19x23, 19,23,32);

  // Center the text : we use the X-GLCD_Text_Width function to get the real
  // width of the text since the font is proportional width, so chars have not
  // all the same width. (BTW the height is the same for all chars = Font height)
  someText = "Octal 2007";
  ii = (128-xGlcd_Text_Width(someText)) / 2;  // 128  is the width of the GLCD

  xGlcd_Write_Text(someText,ii,42,xColorSet);
  delay2S();

  xGlcd_Set_Font(Broadway17x15, 17,15,32);

  // Delete the first text we had written by drawing it in Clrar Color = 0
  someText = "Time 23:59";
  xGlcd_Write_Text(someText,17,1,xColorClear);
  delay2S();

  // Show a little counter
  someText = "Count:";
  xGlcd_Write_Text(someText,1,1,xColorSet);


  //We can Activate Transparency of Text
  //Be carefull, xGlcd_Set_Font(...) automatically set Transparency to False
  //xGlcd_Set_Transparency(true)
  //xGlcd_Write_Text(someText,1,5,xColorSet)
  //delay2S
  //xGlcd_Set_Transparency(false)
  ii=200;
  while (1==1){
   ii++;
   ByteToStr(ii,temp_str);
   xGlcd_write_text(temp_str,69,0,xColorSet);  // Write counter value
   delay_ms(1000);
   xGlcd_write_text(temp_str,69,0,xColorClear); // delete the written text
  }

  lMainLoop:
  goto lMainLoop;

}