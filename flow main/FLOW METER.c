#include "hard_specific.c"




unsigned int digital_value,lo_RAGE,hi_RAGE;
char txt[15],total_txt[15];
char PSX;
float volts=0,old_volts=1,actual_flow,TOTALLIZER=0.0;
double volts_1;
char Total_flag=0;
unsigned short ii;
char *someText;
char temp_str[4],OPEN=1;
char one_sec;
char timer_back_light=0;
char Setting_Mode_Enter=0;
//char EDAT[15],mdat[15];






void delay2S()
{
 delay_ms(2000);
}


char set_but(char active)
 {
  if  (Button(&PORTE, 0, 1, active)==255)
  {
   timer_back_light=0;
   if (BACK_LIGHT==0)
   {
    BACK_LIGHT=1;
    return 0;
   }
   return 255;
  }
  else
  return 0;
 }

char shift_but(char active)
{
 if  (Button(&PORTE, 2, 1, active)==255)
 {
  while(Button(&PORTE, 2, 1, active)==255);
  timer_back_light=0;
  if (BACK_LIGHT==0)
   {
    BACK_LIGHT=1;
    return 0;
   }
  return 255;
 }
 else
 return 0;
}

char scrl_but(char active)
{
 if  (Button(&PORTE, 1, 1, active)==255)
 {
  timer_back_light=0;
  if (BACK_LIGHT==0)
  {
   BACK_LIGHT=1;
   return 0;
  }
  return 255;
 }
 else
 return 0;
}



void boder()
{
 Glcd_H_Line(0, 127, 0, 1);
 Glcd_H_Line(0, 127, 1, 1);
 Glcd_H_Line(0, 127, 62, 1);
 Glcd_H_Line(0, 127, 63, 1);
/*
  Glcd_Rectangle(0, 0, 127, 63, 1);
  Glcd_Rectangle(1, 1, 126, 62, 1);
*/
}

void cls()
{
 Glcd_Fill(0x00);
 boder();
 OPEN=1;
}
void fill()
{
 Glcd_Fill(0xff);
}
void set_3x5()
{
 Glcd_Set_Font(Font_Glcd_System3x5 , 3, 5, 32);
}
void set_5x7()
{
 Glcd_Set_Font(Font_Glcd_5x7, 5, 7, 32);
}

void set_8x7()
{
 Glcd_Set_Font(Font_Glcd_Character8x7, 8, 7, 32);
}



void init_timer0()
{
  // Timer0 Registers:// 16-Bit Mode; Prescaler=1:128; TMRH Preset=B; TMRL Preset=DC; Freq=1.00Hz; Period=1.00 s
  T0CON.TMR0ON = 0;// Timer0 On/Off Control bit:1=Enables Timer0 / 0=Stops Timer0
  T0CON.T08BIT = 0;// Timer0 8-bit/16-bit Control bit: 1=8-bit timer/counter / 0=16-bit timer/counter
  T0CON.T0CS   = 0;// TMR0 Clock Source Select bit: 0=Internal Clock (CLKO) / 1=Transition on T0CKI pin
  T0CON.T0SE   = 0;// TMR0 Source Edge Select bit: 0=low/high / 1=high/low
  T0CON.PSA    = 0;// Prescaler Assignment bit: 0=Prescaler is assigned; 1=NOT assigned/bypassed
  T0CON.T0PS2  = 1;// bits 2-0  PS2:PS0: Prescaler Select bits
  T0CON.T0PS1  = 1;
  T0CON.T0PS0  = 0;
  TMR0H = 0xB;    // preset for Timer0 MSB register
  TMR0L = 0xDC;    // preset for Timer0 LSB register
  INTCON.TMR0IE=1;
  INTCON.TMR0IF=0;
}
void TIMER0_ON()
{
 T0CON.TMR0ON = 1;
}
void TIMER0_Off()
{
 T0CON.TMR0ON = 0;
}



#include "built_in.h"
#include "xglcd_lib.c"
#include "propfont.h"
#include "slides.c"
#include "FLOW_METER_I2C.c"
//#include "__Lib_Delays.c"








void totalizer_save()
{
 double TOTALLIZER_saved;
 TOTALLIZER_saved=TOTALLIZER*10000.0;

// write_ds1307(0x2F,0xAA);
  write_ds1307(50,Lo(TOTALLIZER_saved));
//  delay_ms(1);
  write_ds1307(51,Hi(TOTALLIZER_saved));
//  delay_ms(1);
  write_ds1307(52,Higher(TOTALLIZER_saved));
//  delay_ms(1);
  write_ds1307(53,Highest(TOTALLIZER_saved));
//  delay_ms(1);


/*
  EEPROM_Write(50,Lo(TOTALLIZER_saved));
  delay_ms(1);
  EEPROM_Write(51,Hi(TOTALLIZER_saved));
  delay_ms(1);
  EEPROM_Write(52,Higher(TOTALLIZER_saved));
  delay_ms(1);
  EEPROM_Write(53,Highest(TOTALLIZER_saved));
  delay_ms(1);
*/
}

void totalizer_read()
{

 Lo(TOTALLIZER) = read_ds1307(50);
// delay_ms(1);
 Hi(TOTALLIZER) = read_ds1307(51);
// delay_ms(1);
 Higher(TOTALLIZER) = read_ds1307(52);
// delay_ms(1);
 Highest(TOTALLIZER) = read_ds1307(53);
// delay_ms(1);

/*
 Lo(TOTALLIZER) = EEPROM_Read(50);
 delay_ms(1);
 Hi(TOTALLIZER) = EEPROM_Read(51);
 delay_ms(1);
 Higher(TOTALLIZER) = EEPROM_Read(52);
 delay_ms(1);
 Highest(TOTALLIZER) = EEPROM_Read(53);
 delay_ms(1);
*/
 TOTALLIZER/=10000.0;
}


void total_rizer_cal()
{
    if (Total_flag==1)
   {
     Total_flag=0;
//     xGlcd_write_text(total_txt,5,8,xColorClear); // delete the written text
     TOTALLIZER+=actual_flow/3600.0;
     totalizer_save();
     set_8x7();
    if (NUMBER_UNIT==3 || NUMBER_UNIT==2)
    {
//     TOTALLIZER/=1000.0;
     sprintf(total_txt, "%.3f", TOTALLIZER/1000.0);
    }
    else
    {
     sprintf(total_txt, "%.0f", TOTALLIZER);
    }
//     set_5x7();
     Glcd_write_text(total_txt,28,6,xColorSet);  // Write counter value
   }
}


void main()
{
  OSCCON.IRCF0=1;
  OSCCON.IRCF1=1;
  OSCCON.IRCF2=1;
  OSCCON.SCS1=1;
  OSCCON.SCS1=0;
  OSCTUNE.PLLEN=1;
  OSCTUNE.TUN0=0;
  OSCTUNE.TUN1=0;
  OSCTUNE.TUN2=0;
  OSCTUNE.TUN3=0;
  OSCTUNE.TUN4=0;

  trise=0;
  trise.b0=1;
  trise.b1=1;
  trise.b2=1;
  ADC_Init();
  Init_mcu();
  Glcd_Init();       // Init for EasyPIC3 board
  CLS();
 xGlcd_Set_Font(Tahoma14x15 , 14,15,46);
 set_8x7();
// delay_ms(1000);
// dafualt_timer();
// while(1);


//  xGlcd_Write_Text(someText,ii,42,xColorSet);
  fill();
  someText = "Omni_Telemetry";
  ii = (128-xGlcd_Text_Width(someText)) / 2;  // 128  is the width of the GLCD
  xGlcd_Write_Text(someText,ii,16,xColorINVERT);

  someText = "www.Omnitm.ca";
  ii = (128-xGlcd_Text_Width(someText)) / 2;  // 128  is the width of the GLCD
  xGlcd_Write_Text(someText,ii,32,xColorINVERT);
  delay_ms(5000);
  CLS();
  fill();
  someText = "Flow_Computer";
  ii = (128-xGlcd_Text_Width(someText)) / 2;  // 128  is the width of the GLCD
  xGlcd_Write_Text(someText,ii,5,xColorinvert);

  
  someText = "FCU_5400";
  ii = (128-xGlcd_Text_Width(someText)) / 2;  // 128  is the width of the GLCD
  xGlcd_Write_Text(someText,ii,21,xColorinvert);




  someText = "Intellengent";
  Glcd_Write_Text(someText, 4, 5, xColorinvert);
//  ii = (128-xGlcd_Text_Width(someText)) / 2;  // 128  is the width of the GLCD
//  xGlcd_Write_Text(someText,ii,36,xColorinvert);

  
  someText = "Flow_Metering";
  Glcd_Write_Text(someText, 4, 6, xColorinvert);
//  ii = (128-xGlcd_Text_Width(someText)) / 2;  // 128  is the width of the GLCD
//  xGlcd_Write_Text(someText,ii,52,xColorinvert);
  delay_ms(5000);

  CLS();
  if (set_but(0)==255)
  {
   set_5x7();
   someText = "ADC SETTING MODE";
   Glcd_Write_Text(someText, 4, 4, xColorinvert);
   Setting_Mode_Enter=1;
   delay_ms(3000);
  }


  CLS();
  volts=00000000;
  xGlcd_Set_Font(Tahoma15x24, 15,24,45);
  set_5x7();
  set_3x5();
  sqrt_UNIT  = EEPROM_Read(14);
   delay_ms(10);
  NUMBER_UNIT  = EEPROM_Read(15);
  delay_ms(10);
  KVALUE=EEPROM_Read(16);
  KVALUE_k=KVALUE/100.0;
  delay_ms(10);
   Lo(lo_RAGE)=EEPROM_Read(10);
   delay_ms(10);
   Hi(lo_RAGE)=EEPROM_Read(11);
   delay_ms(10);
   Lo(hi_RAGE)=EEPROM_Read(12);
   delay_ms(10);
   Hi(hi_RAGE)=EEPROM_Read(13);
   delay_ms(10);
   set_5x7();
 
  
  if (NUMBER_UNIT==1)
  {
   someText = "kg/h";
  }
  else if (NUMBER_UNIT==2)
  {
   someText = "m3/h";
  }
  else  if (NUMBER_UNIT==3)
  {
   someText = "TPH";
  }
  Glcd_Write_Text(someText, 100, 4, xColorSet);
  Glcd_H_Line(0, 127, 40 , 1);
  set_3x5();
  someText = "TOTAL";
  Glcd_Write_Text(someText, 4, 5, xColorSet);
  set_5x7();
  volts=0.0;
  sprintf(txt, "%.3f", volts);
  xGlcd_write_text(txt,5,8,xColorSet);  // Write counter value
  xGlcd_write_text(txt,5,8,xColorClear); // delete the written text

//  TOTALLIZER=939.5365;
//  totalizer_save();
  totalizer_read();
    if (NUMBER_UNIT==3)
    {
     sprintf(total_txt, "%.3f", TOTALLIZER/1000.0);
    }
    else
    {
     sprintf(total_txt, "%.0f", TOTALLIZER);
    }
  set_8x7();
  Glcd_write_text(total_txt,28,6,xColorSet);  // Write counter value
  

  
  init_timer0();
  TIMER0_ON();
  INTCON.GIE=1;
  INTCON.GIEL=1;
  
  

 for(;;)
 {
   digital_value=0;
   for (psx=0;psx<50;psx++)
   {
    digital_value+=ADC_Read(0);
    delay_ms(10);
    total_rizer_cal();
   }
   
   digital_value=digital_value/50;

   if (Setting_Mode_Enter==1)
   {
    inttostr(digital_value,txt);
    set_5x7();
    Glcd_Write_Text(txt, 90, 6, xColorSet);
   }
   
   volts=digital_value;
   ACTUAL_FLOW=volts;

//   volts*=0.0048875;
//   digital_value/=50.0;
//   volts=digital_value*0.0048875;

   volts-=204;
   volts/=820;
   volts*=(hi_rage-lo_rage)+lo_rage;

   if (ACTUAL_FLOW==1023)
   {
    volts=hi_rage;
//    volts=1500.0;
   }

   else if (ACTUAL_FLOW<=204)
   {
    volts=Lo_rage;
   }

   if ( sqrt_UNIT==2)
   {
    volts=hi_rage* (sqrt(volts/hi_rage));
   }
   else 
   {
   
   }
   actual_flow=volts;
//   actual_flow=1500.0;
//   volts=1500.000;
//   volts*=1.5;
//   KVALUE=10;
//   KVALUE_k=KVALUE/10.0;
   volts=actual_flow*KVALUE_k;
   actual_flow=volts;
   if (NUMBER_UNIT==3 || NUMBER_UNIT==2)
   {
     volts/=1000.0;
   }
   set_5x7();
  if (volts!=old_volts || OPEN==1)
  {
    if (NUMBER_UNIT==1)
    {
     someText = "kg/h";
    }
    else if (NUMBER_UNIT==2)
    {
     someText = "m3/h";
    }
    else  if (NUMBER_UNIT==3)
    {
     someText = "TPH";
//     volts/=1000.0;
    }
   Glcd_Write_Text(someText, 100, 4, xColorSet);
   Glcd_H_Line(0, 127, 40 , 1);
   OPEN=0;
   xGlcd_write_text(txt,5,8,xColorClear); // delete the written text
   if (NUMBER_UNIT==3 || NUMBER_UNIT==2)
   {
    sprintf(txt, "%.3f", volts);
   }
   else
   {
    sprintf(txt, "%.0f", volts);
   }
   xGlcd_write_text(txt,5,8,xColorSet);  // Write counter value
   old_volts=volts;
  }
  /*
   if (Total_flag==1)
   {
     Total_flag=0;
//     xGlcd_write_text(total_txt,5,8,xColorClear); // delete the written text
     TOTALLIZER+=actual_flow/3600.0;
     totalizer_save();
    set_8x7();
    if (NUMBER_UNIT==3)
    {
//     TOTALLIZER/=1000.0;
     sprintf(total_txt, "%.3f", TOTALLIZER/1000.0);
    }
    else 
    {
     sprintf(total_txt, "%.0f", TOTALLIZER);
    }
//     set_5x7();
     Glcd_write_text(total_txt,28,6,xColorSet);  // Write counter value
   }
  */
  
  if (set_but(0)==255)
   {
    if (scrl_but(0)==255)
    {
     if (one_sec>5)
    {
  //        Pass_word();
      if(Pass_word()==255)
     {
        set_5x7();
                slide_1 ();
        set_3x5();
        someText = "TOTAL";
        Glcd_Write_Text(someText, 4, 5, xColorSet);
        set_5x7();
        floattostr(volts,txt);
        INTCON.TMR0IF=0;
        TMR0H = 0xB;    // preset for Timer0 MSB register
        TMR0L = 0xDC;   // preset for Timer0 LSB register
        Total_flag=0;
        totalizer_save();
        if (NUMBER_UNIT==3 ||NUMBER_UNIT==2)
        {
         sprintf(total_txt, "%.3f", TOTALLIZER/1000.0);
        }
         else
         {
          sprintf(total_txt, "%.0f", TOTALLIZER);
         }
        set_8x7();
        Glcd_write_text(total_txt,28,6,xColorSet);  // Write counter value
        one_sec=0;
      }
      else
      {
        OPEN=1;
        cls();
        set_3x5();
        someText = "TOTAL";
        Glcd_Write_Text(someText, 4, 5, xColorSet);
        set_5x7();
        floattostr(volts,txt);
        INTCON.TMR0IF=0;
        TMR0H = 0xB;    // preset for Timer0 MSB register
        TMR0L = 0xDC;   // preset for Timer0 LSB register
        Total_flag=0;
        totalizer_save();
        if (NUMBER_UNIT==3 || NUMBER_UNIT==2)
        {
         sprintf(total_txt, "%.3f", TOTALLIZER/1000.0);
        }
         else
         {
          sprintf(total_txt, "%.0f", TOTALLIZER);
         }
        set_8x7();
        Glcd_write_text(total_txt,28,6,xColorSet);  // Write counter value
        one_sec=0;
      }
     }
    }
    else
    {
      one_sec=0;
    }
  }
 
  /*
   txt[0]=(digital_value/10000)%10;
   txt[1]=(digital_value/1000)%10;
   txt[2]='.';
   txt[3]=(digital_value/100)%10;
   txt[4]=(digital_value/10)%10;
   txt[5]=(digital_value/1)%10;

   Glcd_Write_Char(txt[0]+'0',1,6,1);
   Glcd_Write_Char(txt[1]+'0',9,6,1);
   Glcd_Write_Char(txt[2],18,6,1);
   Glcd_Write_Char(txt[3]+'0',27,6,1);
   Glcd_Write_Char(txt[4]+'0',36,6,1);
   Glcd_Write_Char(txt[5]+'0',45,6,1);
   */
 }
}

void interrupt()
{
 if (INTCON.TMR0IF)
 {
  INTCON.TMR0IF=0;
  TMR0H = 0xB;    // preset for Timer0 MSB register
  TMR0L = 0xDC;   // preset for Timer0 LSB register
  Total_flag=1;
  timer_back_light++;
  if (timer_back_light>=60)
  {
   timer_back_light=0;
   BACK_LIGHT=0;
  }
  if (PORTE.b0==0 && PORTE.b1==0)
  {
   one_sec++;
  }
  else
  {
   one_sec=0;
  }
/*if (one_sec==7)
  {
   one_sec=0;
  }*/
 }
}
/*
   txt[0]=(digital_value/10000)%10;
   txt[1]=(digital_value/1000)%10;
   txt[2]='.';
   txt[3]=(digital_value/100)%10;
   txt[4]=(digital_value/10)%10;
   txt[5]=(digital_value/1)%10;

   Glcd_Write_Char(txt[0]+'0',1,1,1);
   Glcd_Write_Char(txt[1]+'0',9,1,1);
   Glcd_Write_Char(txt[2],18,1,1);
   Glcd_Write_Char(txt[3]+'0',27,1,1);
   Glcd_Write_Char(txt[4]+'0',36,1,1);
   Glcd_Write_Char(txt[5]+'0',45,1,1);
  */
  
/*
  //   xGlcd_Write_Char(TXT[0],4,  5, xColorSet);
//   xGlcd_Write_Char(TXT[1],20, 5, xColorSet);
//   xGlcd_Write_Char(TXT[2],52, 5, xColorSet);
//   xGlcd_Write_Char(TXT[3],76, 5, xColorSet);
//   xGlcd_Write_Char(TXT[4],100,5, xColorSet);
//   xGlcd_Write_Char(TXT[5],124,5, xColorSet);
//   xGlcd_Write_Char(TXT[6],148,5, xColorSet);

//   sprintf(txt, "%.3f", volts/3600.0);
//   Glcd_Write_Text(txt, 20, 6, xColorSet);

*/