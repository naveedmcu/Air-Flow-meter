char position=1,tposition=1,position_c=1;
int fc1,fc2,fc3,fc4,FC5;
char  NUMBER_UNIT=1, sqrt_UNIT=1;
float KVALUE_k=1;
int  KVALUE;

void save_tag()
{
 set_3x5();
 someText ="SAVE";
 Glcd_Write_Text(someText, 5, 2, xColorSet);
// Glcd_Rectangle(3, 16, 21, 24, 1);
 Glcd_Box(3, 16, 21, 23, 2);
 delay_ms(500);
 set_5x7();
}

void selection(char POs)
{
 if (shift_BUT(0)==255)
 {
  while(shift_BUT(0)==255);
  position++;
  if (position==POs)
  {
   position=1;
  }
 }
}

void  set_up()
{
 cls();
 Glcd_Box(0, 0, 127, 8, 0);
 xGlcd_Set_Font(Arial10x11, 10, 11, 65);
// set_3x5();
 someText ="SETUP";
// Glcd_Write_Text(someText, 42, 0, xColorINVERT);
 XGlcd_Write_Text(someText, 42, 0, xColorSET);
// Glcd_H_Line(0, 127, 10 , 1);
 xGlcd_Set_Font(Tahoma15x24, 15,24,45);
 Glcd_Box(0, 0, 127, 9, 2);
// set_5x7();
}
void menu1()
{
 set_up();
 Glcd_Write_Text("1.RANGE", 12, 2, xColorSet);
 Glcd_Write_Text("2.UNIT", 12, 3, xColorSet);
 Glcd_Write_Text("3.SQRT", 12, 4, xColorSet);
 Glcd_Write_Text("4.K.FACTOR", 12, 5, xColorSet);
 Glcd_Write_Text("5.RESET_TOTALIZER", 12, 6, xColorSet);
}


void counter_cursor_pos(){
  if (scrl_but(0)==255 && tposition==0)
  {
     while(scrl_but(0)==255);
   Glcd_H_Line(70, 101, 40, 0);
   Glcd_H_Line(70, 70+5, 40, 1);

//   Glcd_Write_char(txt[1]+'0', 78, 4, 1);
//   Glcd_Write_char(txt[2]+'0', 86, 4, 1);
//   Glcd_Write_char(txt[3]+'0', 94, 4, 1);
//   Glcd_Write_char(txt[0]+'0', 70, 4, 0);
   position_c=0;
   tposition=1;
  }
  else if (scrl_but(0)==255 && tposition==1)
  {
     while(scrl_but(0)==255);
   Glcd_H_Line(70, 101, 40, 0);
   Glcd_H_Line(78, 78+5, 40, 1);

//   Glcd_Write_char(txt[0]+'0', 70, 4, 1);
//   Glcd_Write_char(txt[2]+'0', 86, 4, 1);
//   Glcd_Write_char(txt[3]+'0', 94, 4, 1);
//   Glcd_Write_char(txt[1]+'0', 78, 4, 0);
   position_c=1;
   tposition=2;
  }
  else if (scrl_but(0)==255 && tposition==2)
  {
     while(scrl_but(0)==255);
   Glcd_H_Line(70, 101, 40, 0);
   Glcd_H_Line(86, 86+5, 40, 1);

//   Glcd_Write_char(txt[0]+'0', 70, 4, 1);
//   Glcd_Write_char(txt[1]+'0', 72, 4, 1);
//   Glcd_Write_char(txt[3]+'0', 94, 4, 1);
//   Glcd_Write_char(txt[2]+'0', 86, 4, 0);
   position_c=2;
   tposition=3;
  }
  else if (scrl_but(0)==255 && tposition==3)
  {
     while(scrl_but(0)==255);
   Glcd_H_Line(70, 101, 40, 0);
   Glcd_H_Line(94, 94+5, 40, 1);

//   Glcd_Write_char(txt[0]+'0', 70, 4, 1);
//   Glcd_Write_char(txt[1]+'0', 78, 4, 1);
//   Glcd_Write_char(txt[2]+'0', 86, 4, 1);
//   Glcd_Write_char(txt[3]+'0', 94, 4, 0);
   position_c=3;
   tposition=0;
  }
}

void counter_cursor_pos_low(){
  if (scrl_but(0)==255 && tposition==0)
  {
   while(scrl_but(0)==255);
   Glcd_H_Line(70, 107, 56, 0);
   Glcd_H_Line(70, 70+5, 56, 1);
   position_c=0;
   tposition=1;
  }
  else if (scrl_but(0)==255 && tposition==1)
  {
     while(scrl_but(0)==255);
   Glcd_H_Line(70, 107, 56, 0);
   Glcd_H_Line(78, 78+5, 56, 1);
   position_c=1;
   tposition=2;
  }
  else if (scrl_but(0)==255 && tposition==2)
  {
     while(scrl_but(0)==255);
   Glcd_H_Line(70, 107, 56, 0);
   Glcd_H_Line(86, 86+5, 56, 1);
   position_c=2;
   tposition=3;
  }
  else if (scrl_but(0)==255 && tposition==3)
  {
   while(scrl_but(0)==255);
   Glcd_H_Line(70, 107, 56, 0);
   Glcd_H_Line(94, 94+5, 56, 1);
   position_c=3;
   tposition=4;
  }
  else if (scrl_but(0)==255 && tposition==4)
  {
   while(scrl_but(0)==255);
   Glcd_H_Line(70, 107, 56, 0);
   Glcd_H_Line(102, 102+5, 56, 1);
   position_c=4;
   tposition=0;
  }
}

/*
void counter_cursor_pos_2(){
  if (scrl_but(0)==255 && tposition==0)
  {
   while(scrl_but(0)==255);
//   Glcd_H_Line(65, 100, 40, 0);
//   Glcd_H_Line(69, 91, 40, 0);
   Glcd_H_Line(70, 101, 56, 0);
   Glcd_H_Line(70, 70+4, 40, 1);
   position_c=0;
   tposition=1;
  }
  
  else if (scrl_but(0)==255 && tposition==1)
  {
   while(scrl_but(0)==255);
//   Glcd_H_Line(65, 100, 40, 0);
//     Glcd_H_Line(69, 91, 40, 0);
   Glcd_H_Line(70, 101, 56, 0);
   Glcd_H_Line(86, 86+4, 40, 1);
   position_c=2;
   tposition=0;
  }
  
  if (scrl_but(0)==255 && tposition==2)
  {
   while(scrl_but(0)==255);
//   Glcd_H_Line(65, 100, 40, 0);
//   Glcd_H_Line(69, 91, 40, 0);
   Glcd_H_Line(70, 101, 56, 0);
   Glcd_H_Line(94, 94+5, 40, 1);
   position_c=3;
   tposition=0;
  }
}

*/

void counter_cursor_pos_REST(){
  if (scrl_but(0)==255 && tposition==0)
  {
   while(scrl_but(0)==255);
   Glcd_H_Line(65, 100, 40, 0);
   Glcd_H_Line(70, 70+5, 40, 1);
   position_c=0;
   tposition=1;
  }
  else if (scrl_but(0)==255 && tposition==1)
  {
   while(scrl_but(0)==255);
   Glcd_H_Line(65, 100, 40, 0);
   Glcd_H_Line(86, 86+5, 40, 1);
   position_c=2;
   tposition=0;
  }
}




void unit_set()
{
 set_up();
 Glcd_Box(28,14 , 102, 24, 1);
 Glcd_Write_Text("UNIT SETTING", 30, 2, xColorinvert);
// NUMBER_UNIT=1;
 Glcd_Rectangle(8, 29, 35, 41, 1);
 NUMBER_UNIT  = EEPROM_Read(15);
 delay_ms(100);
 if (NUMBER_UNIT==1) Glcd_Write_Text("kg/h", 10, 4, xColorSet);
 if (NUMBER_UNIT==2) Glcd_Write_Text("m3/h", 10, 4, xColorSet);
 if (NUMBER_UNIT==3) Glcd_Write_Text("TPH", 10, 4, xColorSet);
 
 
 while(set_but(0)==0)
 {
   if (shift_but(0)==255)
   {
    while(shift_but(0)==255);
    NUMBER_UNIT++;
    if (NUMBER_UNIT>=4)
    {
     NUMBER_UNIT=1;
    }
    if (NUMBER_UNIT==1)
    {
     Glcd_Write_Text("TPH ", 10, 4, xColorclear);
     Glcd_Write_Text("kg/h", 10, 4, xColorSet);
    }
    else if (NUMBER_UNIT==2)
    {
     Glcd_Write_Text("kg/h", 10, 4, xColorclear);
     Glcd_Write_Text("m3/h", 10, 4, xColorSet);
    }
    else if (NUMBER_UNIT==3)
    {
     Glcd_Write_Text("m3/h", 10, 4, xColorclear);
     Glcd_Write_Text("TPH ", 10, 4, xColorSet);
    }
   }
 }
 EEPROM_Write(15,NUMBER_UNIT);
 delay_ms(10);
 save_tag();
 while(set_but(0)==255);
 menu1();
}



void sqrt_set()
{
 set_up();
 Glcd_Box(28,14 , 102, 24, 1);
 Glcd_Write_Text("SQRT SETTING", 30, 2, xColorinvert);
// sqrt_UNIT=1;
 Glcd_Rectangle(8, 29, 30, 41, 1);
 sqrt_UNIT  = EEPROM_Read(14);
 delay_ms(100);
 if (sqrt_UNIT==1) Glcd_Write_Text("NO ", 10, 4, xColorSet);
 if (sqrt_UNIT==2) Glcd_Write_Text("YES", 10, 4, xColorSet);
 while(set_but(0)==0)
 {
   if (shift_but(0)==255)
   {
     while(shift_but(0)==255);
     sqrt_UNIT++;
    if (sqrt_UNIT>=3)
    {
     sqrt_UNIT=1;
    }
    if (sqrt_UNIT==1)
    {
     Glcd_Write_Text("YES", 10, 4, xColorclear);
     Glcd_Write_Text("NO ", 10, 4, xColorSet);
    }
    else if (sqrt_UNIT==2)
    {
     Glcd_Write_Text("NO ", 10, 4, xColorclear);
     Glcd_Write_Text("YES", 10, 4, xColorSet);
    }
   }
  }
 EEPROM_Write(14,sqrt_UNIT);
 save_tag();
 while(set_but(0)==255);
 menu1();
}




void current_digit_change(char lcd_pos, char page_nu)
{
 if (shift_but(0)==255)
   {
//      Glcd_Write_char(txt[tposition]+'0', lcd_pos, 4, 1);
      txt[position_c]++;
      if (txt[position_c]>9)
      {
       txt[position_c]=0;
      }
      if (lcd_pos==70 && page_nu==6)
      {
       if (txt[position_c]>6) 
       {
        txt[position_c]=0;
        /*
        if (txt[1]>4)
        {
         txt[1]=4;
        }
        */
       }
       if (txt[position_c]==6)
       {

        if (txt[1]>4)
        {
         txt[1]=4;
        }

       }
      }
      if (txt[0]==6 && lcd_pos==78 && page_nu==6)
      {
       if (txt[position_c]>4) txt[position_c]=0;
      }
      ii=txt[position_c] + '0';
      Glcd_Write_char(ii, lcd_pos, page_nu, 1);
   }
}


void compress_data()
{
 FC1=(txt[0]*10000);
 FC2=(txt[1]*1000);
 FC3=(txt[2]*100);
 FC4=(txt[3]*10);
 FC5=(txt[4]*1);
}


void counter_cursor_pos_2(){
  if (scrl_but(0)==255 && tposition==0)
  {
   while(scrl_but(0)==255);
//   Glcd_H_Line(65, 100, 40, 0);
//   Glcd_H_Line(69, 91, 40, 0);
   Glcd_H_Line(70, 100, 40, 0);
   Glcd_H_Line(70, 70+4, 40, 1);
   position_c=0;
   tposition=1;
  }

  else if (scrl_but(0)==255 && tposition==1)
  {
   while(scrl_but(0)==255);
//   Glcd_H_Line(65, 100, 40, 0);
//     Glcd_H_Line(69, 91, 40, 0);
   Glcd_H_Line(70, 100, 40, 0);
   Glcd_H_Line(86, 86+4, 40, 1);
   position_c=2;
   tposition=2;
  }

  if (scrl_but(0)==255 && tposition==2)
  {
   while(scrl_but(0)==255);
//   Glcd_H_Line(65, 100, 40, 0);
//   Glcd_H_Line(69, 91, 40, 0);
   Glcd_H_Line(70, 100, 40, 0);
   Glcd_H_Line(94, 94+5, 40, 1);
   position_c=3;
   tposition=0;
  }
}




void K_settong()
{
 set_up();
 Glcd_Box(23,14 , 122, 24, 1);
 Glcd_Write_Text("K.FACTOR SETTING", 25, 2, xColorinvert);
 Glcd_Write_Text("K.FACTOR", 5, 4, xColorSet);
 Glcd_Write_Text("min 0.01 and max 1.99", 1, 6, xColorSet);

 KVALUE=EEPROM_Read(16);

 txt[0]=(KVALUE/100)%10;
 txt[2]=(KVALUE/10)%10;
 txt[3]=(KVALUE/1)%10;
 
  Glcd_Write_char(txt[0]+'0', 70, 4, xColorSet);
  Glcd_Write_char('.', 78, 4, xColorSet);
  Glcd_Write_char(txt[2]+'0', 86, 4, xColorSet);
  Glcd_Write_char(txt[3]+'0', 94, 4, xColorSet);

  Glcd_Rectangle(68, 30, 101, 42, 1);

 tposition=1,position_c=0;
// Glcd_H_Line(65, 100, 40, 0);
 Glcd_H_Line(70, 70+4, 40, 1);

 
 while(1)
 {
  if      (position_c==0)  current_digit_change(70,4);
  else if (position_c==2)  current_digit_change(86,4);
  else if (position_c==3)  current_digit_change(94,4);

//  Glcd_Write_char(txt[0]+'0', 70, 6, xColorSet);
//  Glcd_Write_char(txt[1]+'0', 78, 6, xColorSet);

  counter_cursor_pos_2();

  if (set_but(0)==255)
  {
     KVALUE=(txt[0]*100);
     KVALUE+=(txt[2]*10);
     KVALUE+=(txt[3]*1);
//    ByteToStr(KVALUE,temp_str);
//    Glcd_write_text(temp_str,5,5,xColorSet);  // Write counter value
    KVALUE_k=KVALUE/100.0;
//    floattostr(KVALUE_k,txt);
//    Glcd_Write_Text(txt, 5, 5, xColorSet);
//    delay_ms(1000);
    EEPROM_Write(16,KVALUE);
    delay_ms(100);
   if (KVALUE>199 || KVALUE==0)
   {
   
   }
   else  break;
  }
 }
 save_tag();
 while(set_but(0)==255);
 menu1();
}





void range_set()
{
 set_up();
 Glcd_Box(28,14 , 108, 24, 1);
 Glcd_Write_Text("RANGE SETTING", 30, 2, xColorinvert);
 Glcd_Write_Text("LOW RANGE", 5, 4, xColorSet);
 Glcd_Write_Text("HI RANGE", 5, 6, xColorSet);
 


 Lo(lo_RAGE)=EEPROM_Read(10);
 delay_ms(10);
 Hi(lo_RAGE)=EEPROM_Read(11);
 delay_ms(10);
 Lo(hi_RAGE)=EEPROM_Read(12);
 delay_ms(10);
 Hi(hi_RAGE)=EEPROM_Read(13);
 delay_ms(10);

 txt[0]=(hi_RAGE/10000)%10;
 txt[1]=(hi_RAGE/1000)%10;
 txt[2]=(hi_RAGE/100)%10;
 txt[3]=(hi_RAGE/10)%10;
 txt[4]=(hi_RAGE/1)%10;

 Glcd_Write_char(txt[0]+'0', 70, 6, xColorSet);
 Glcd_Write_char(txt[1]+'0', 78, 6, xColorSet);
 Glcd_Write_char(txt[2]+'0', 86, 6, xColorSet);
 Glcd_Write_char(txt[3]+'0', 94, 6, xColorSet);
 Glcd_Write_char(txt[4]+'0', 102, 6, xColorSet);

 Glcd_Rectangle(67, 45, 110, 58, 1);
 
 
 txt[0]=(Lo_RAGE/1000)%10;
 txt[1]=(Lo_RAGE/100)%10;
 txt[2]=(Lo_RAGE/10)%10;
 txt[3]=(Lo_RAGE/1)%10;
  Glcd_Write_char(txt[0]+'0', 70, 4, xColorSet);
  Glcd_Write_char(txt[1]+'0', 78, 4, xColorSet);
  Glcd_Write_char(txt[2]+'0', 86, 4, xColorSet);
  Glcd_Write_char(txt[3]+'0', 94, 4, xColorSet);
  Glcd_Rectangle(67, 29, 102, 42, 1);

  tposition=1,position_c=0;
//  Glcd_H_Line(70, 101, 40, 0);
  Glcd_H_Line(70, 70+5, 40, 1);
  

 while(1)
 {
  if      (position_c==0)  current_digit_change(70,4);
  else if (position_c==1)  current_digit_change(78,4);
  else if (position_c==2)  current_digit_change(86,4);
  else if (position_c==3)  current_digit_change(94,4);

  /*
  Glcd_Write_char(txt[0]+'0', 70, 5, xColorSet);
  Glcd_Write_char(txt[1]+'0', 78, 5, xColorSet);
  Glcd_Write_char(txt[2]+'0', 86, 5, xColorSet);
  Glcd_Write_char(txt[3]+'0', 94, 5, xColorSet);
  */

  
  counter_cursor_pos();

  if (set_but(0)==255)
  {
    while(set_but(0)==255);
//    compress_data();
     FC1=(txt[0]*1000);
     FC2=(txt[1]*100);
     FC3=(txt[2]*10);
     FC4=(txt[3]*1);
    
//    lo_RAGE=1234;
    lo_RAGE=fc1+fc2+fc3+fc4;
    EEPROM_Write(10, Lo(lo_RAGE));
    delay_ms(100);
    EEPROM_Write(11, Hi(lo_RAGE));
    delay_ms(100);
    break;
  }
 }

 Glcd_H_Line(70, 101, 40, 0);
 tposition=1,position_c=0;
 Glcd_H_Line(70, 70+5, 56, 1);
 
 txt[0]=(hi_RAGE/10000)%10;
 txt[1]=(hi_RAGE/1000)%10;
 txt[2]=(hi_RAGE/100)%10;
 txt[3]=(hi_RAGE/10)%10;
 txt[4]=(hi_RAGE/1)%10;
 
 Glcd_Write_char(txt[0]+'0', 70, 6, xColorSet);
 Glcd_Write_char(txt[1]+'0', 78, 6, xColorSet);
 Glcd_Write_char(txt[2]+'0', 86, 6, xColorSet);
 Glcd_Write_char(txt[3]+'0', 94, 6, xColorSet);
 Glcd_Write_char(txt[4]+'0', 102, 6, xColorSet);
 while(1)
 {
  if      (position_c==0)  current_digit_change(70,6);
  else if (position_c==1)  current_digit_change(78,6);
  else if (position_c==2)  current_digit_change(86,6);
  else if (position_c==3)  current_digit_change(94,6);
  else if (position_c==4)  current_digit_change(102,6);

  /*
  Glcd_Write_char(txt[0]+'0', 70, 7, xColorSet);
  Glcd_Write_char(txt[1]+'0', 78, 7, xColorSet);
  Glcd_Write_char(txt[2]+'0', 86, 7, xColorSet);
  Glcd_Write_char(txt[3]+'0', 94, 7, xColorSet);
  */


  counter_cursor_pos_low();
  if (set_but(0)==255)
  {
    compress_data();
    hi_RAGE=fc1+fc2+fc3+fc4+fc5;
    EEPROM_Write(12, Lo(hi_RAGE));
    delay_ms(100);
    EEPROM_Write(13, Hi(hi_RAGE));
    delay_ms(100);
    break;
  }
 }
 save_tag();
 while(set_but(0)==255);
 menu1();
}


void Reset()
{
 char Reset_postion=2;
 set_up();
 Glcd_Box(28,14 , 102, 24, 1);
 Glcd_Write_Text("ARE YOU SURE", 30, 2, xColorinvert);

 Glcd_Write_Text("YES", 20, 5, xColorSet);
 Glcd_Write_Text("NO", 86, 5, xColorSet);

 Glcd_Rectangle(84, 38, 98, 48, 1);

//   Glcd_Rectangle(18, 38, 38, 48, 1);
//   Glcd_Rectangle(84, 38, 98, 48, 1);
  while(set_but(0)==0)
  {
   if (SCRL_but(0)==255)
   {
     while(SCRL_but(0)==255);
     Reset_postion++;
    if (Reset_postion>=3)
    {
     Reset_postion=1;
    }
    if (Reset_postion==1)
    {
     Glcd_Rectangle(18, 38, 38, 48, 1);
     Glcd_Rectangle(84, 38, 98, 48, 0);
    }
    else if (Reset_postion==2)
    {
     Glcd_Rectangle(84, 38, 98, 48, 1);
     Glcd_Rectangle(18, 38, 38, 48, 0);
    }
   }
  }
  if (Reset_postion==1)
  {
   TOTALLIZER=0.0;
  }
 /*
  while(set_but(0)==0)
 {
   if (shift_but(0)==255)
   {
     while(shift_but(0)==255);
     sqrt_UNIT++;
    if (sqrt_UNIT>=3)
    {
     sqrt_UNIT=1;
    }
    if (sqrt_UNIT==1)
    {
     Glcd_Write_Text("YES", 5, 4, xColorclear);
     Glcd_Write_Text("NO ", 5, 4, xColorSet);
    }
    else if (sqrt_UNIT==2)
    {
     Glcd_Write_Text("NO ", 5, 4, xColorclear);
     Glcd_Write_Text("YES", 5, 4, xColorSet);
    }
   }
  }
  */
  save_tag();
  while(set_but(0)==255);
  menu1();
}

void clear_errow(char errow)
{
// set_3x5();
 Glcd_Write_Text("  ", 3, errow, 1);
// Glcd_Box(0, 16, 11, 60, 0);
// set_5x7();
}

/*
void counter_cursor_pos(){
  if (scrl_but(0)==255 && tposition==0)
  {
     while(scrl_but(0)==255);
   Glcd_H_Line(70, 101, 40, 0);
   Glcd_H_Line(70, 70+5, 40, 1);

//   Glcd_Write_char(txt[1]+'0', 78, 4, 1);
//   Glcd_Write_char(txt[2]+'0', 86, 4, 1);
//   Glcd_Write_char(txt[3]+'0', 94, 4, 1);
//   Glcd_Write_char(txt[0]+'0', 70, 4, 0);
   position_c=0;
   tposition=1;
  }
  else if (scrl_but(0)==255 && tposition==1)
  {
     while(scrl_but(0)==255);
   Glcd_H_Line(70, 101, 40, 0);
   Glcd_H_Line(78, 78+5, 40, 1);

//   Glcd_Write_char(txt[0]+'0', 70, 4, 1);
//   Glcd_Write_char(txt[2]+'0', 86, 4, 1);
//   Glcd_Write_char(txt[3]+'0', 94, 4, 1);
//   Glcd_Write_char(txt[1]+'0', 78, 4, 0);
   position_c=1;
   tposition=2;
  }
  else if (scrl_but(0)==255 && tposition==2)
  {
     while(scrl_but(0)==255);
   Glcd_H_Line(70, 101, 40, 0);
   Glcd_H_Line(86, 86+5, 40, 1);

//   Glcd_Write_char(txt[0]+'0', 70, 4, 1);
//   Glcd_Write_char(txt[1]+'0', 72, 4, 1);
//   Glcd_Write_char(txt[3]+'0', 94, 4, 1);
//   Glcd_Write_char(txt[2]+'0', 86, 4, 0);
   position_c=2;
   tposition=3;
  }
  else if (scrl_but(0)==255 && tposition==3)
  {
     while(scrl_but(0)==255);
   Glcd_H_Line(70, 101, 40, 0);
   Glcd_H_Line(94, 94+5, 40, 1);

//   Glcd_Write_char(txt[0]+'0', 70, 4, 1);
//   Glcd_Write_char(txt[1]+'0', 78, 4, 1);
//   Glcd_Write_char(txt[2]+'0', 86, 4, 1);
//   Glcd_Write_char(txt[3]+'0', 94, 4, 0);
   position_c=3;
   tposition=0;
  }
}

*/
/*
void LOCK_OPEN(char l_o)
{
 if (l_o==0)
 {
   someText ="LOCK";
   Glcd_Write_Text(someText, 5, 2, xColorSet);
  // Glcd_Rectangle(3, 16, 21, 24, 1);
   Glcd_Box(3, 16, 21, 23, 2);
   delay_ms(500);
   set_5x7();
 }
  if (l_o==1)
 {
   someText ="OPEN";
   Glcd_Write_Text(someText, 5, 2, xColorSet);
  // Glcd_Rectangle(3, 16, 21, 24, 1);
   Glcd_Box(3, 16, 21, 23, 2);
   delay_ms(500);
 }
}
*/

char  Pass_word()
{
 char T_pass=0;
 cls();
 SET_5X7();
 Glcd_Box(18, 6, 104, 16, 1);
 Glcd_Write_Text("ENTER PASSWORD", 20, 1, xColorINVERT);
 
 SET_8X7();
 Glcd_Write_Text("OMNI", 10, 5, xColorSET);
 Glcd_Write_Text("TELEMETRY", 1, 6, xColorINVERT);
 SET_5X7();
 Glcd_Write_Text("FLOW", 10, 3, xColorINVERT);
 Glcd_Write_Text("METERING", 5, 4, xColorINVERT);
 SET_5X7();
  txt[0]=0;
  txt[1]=0;
  txt[2]=0;
  txt[3]=0;
  Glcd_Write_char('0', 70, 4, xColorSet);
  Glcd_Write_char('0', 78, 4, xColorSet);
  Glcd_Write_char('0', 86, 4, xColorSet);
  Glcd_Write_char('0', 94, 4, xColorSet);
  Glcd_Rectangle(67, 29, 102, 42, 1);
  tposition=1,position_c=0;
  Glcd_H_Line(70, 70+5, 40, 1);

 while(set_but(0)==255);
 while(scrl_but(0)==255);
  while(1)
 {
  if      (position_c==0)  current_digit_change(70,4);
  else if (position_c==1)  current_digit_change(78,4);
  else if (position_c==2)  current_digit_change(86,4);
  else if (position_c==3)  current_digit_change(94,4);

  /*
  Glcd_Write_char(txt[0]+'0', 70, 5, xColorSet);
  Glcd_Write_char(txt[1]+'0', 78, 5, xColorSet);
  Glcd_Write_char(txt[2]+'0', 86, 5, xColorSet);
  Glcd_Write_char(txt[3]+'0', 94, 5, xColorSet);
  */
  counter_cursor_pos();

  if (set_but(0)==255)
  {
    if (txt[0]==7 && txt[1]==4 && txt[2]==7 && txt[3]==8) // this is password
    {
     return 255;
    }
    else if (txt[0]==0 && txt[1]==0 && txt[2]==0 && txt[3]==0)
    {
     
     return 0;
    }
    else
    {
      txt[0]=0;
      txt[1]=0;
      txt[2]=0;
      txt[3]=0;
     Glcd_Write_char('0', 70, 4, xColorSet);
     Glcd_Write_char('0', 78, 4, xColorSet);
     Glcd_Write_char('0', 86, 4, xColorSet);
     Glcd_Write_char('0', 94, 4, xColorSet);
     Glcd_Rectangle(67, 29, 102, 42, 1);
     Glcd_H_Line(70, 101, 40, 0);
     tposition=1,position_c=0;
     Glcd_H_Line(70, 70+5, 40, 1);
     while(set_but(0)==255);
    }
  }
 }
 Glcd_H_Line(70, 101, 40, 0);
}



void slide_1 ()
{
 menu1();
 set_3x5();
 Glcd_Write_Text("=>", 3, 2, xColorSet);
 set_5x7();
// Glcd_Circle_Fill(5, 18, 2, 1);
 while(scrl_but(0)==0)
 {
  selection(6);
  if (position==1)
  {
   set_3x5();
   clear_errow(3);
   clear_errow(4);
   clear_errow(5);
   clear_errow(6);
//   Glcd_Circle_Fill(18, 5, 2, 1);
   Glcd_Write_Text("=>", 3, 2, xColorSet);
   set_5x7();
  }
  if (position==2)
  {
   set_3x5();
   clear_errow(2);
   clear_errow(4);
   clear_errow(5);
   clear_errow(6);
   Glcd_Write_Text("=>", 3, 3, xColorSet);
   set_5x7();
  }
  if (position==3)
  {
   set_3x5();
   clear_errow(2);
   clear_errow(3);
   clear_errow(5);
   clear_errow(6);
   Glcd_Write_Text("=>", 3, 4, xColorSet);
   set_5x7();
  }
  if (position==4)
  {
   set_3x5();
   clear_errow(2);
   clear_errow(3);
   clear_errow(4);
   clear_errow(6);
   Glcd_Write_Text("=>", 3, 5, xColorSet);
   set_5x7();
  }
  if (position==5)
  {
   set_3x5();
   clear_errow(2);
   clear_errow(3);
   clear_errow(4);
   clear_errow(5);
   Glcd_Write_Text("=>", 3, 6, xColorSet);
   set_5x7();
  }
//----------------------------
//  if (set_button(0)==255)
//----------------------------
  if (set_but(0)==255)
  {
//   while(set_but(0)==255);
   if (position==1)
   {
    while(set_but(0)==255);
    range_set();
   }
  }
  if (set_but(0)==255)
  {
   if (position==2)
   {
    while(set_but(0)==255);
    unit_set();
   }
  }
  if (set_but(0)==255)
  {
   if (position==3)
   {
    while(set_but(0)==255)
    {
     while(set_but(0)==255);
     sqrt_set();
    }
   }
  }
  if (set_but(0)==255)
  {
   if (position==4)
   {
    while(set_but(0)==255)
    {
     while(set_but(0)==255);
     K_settong();
    }
   }
  }
  if (set_but(0)==255)
  {
   if (position==5)
   {
    while(set_but(0)==255)
    {
     while(set_but(0)==255);
     Reset();
    }
   }
  }
 }
 OPEN=1;
 cls();
}