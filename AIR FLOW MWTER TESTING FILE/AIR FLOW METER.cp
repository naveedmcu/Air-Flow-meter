#line 1 "E:/Software and Electronic wilcom/PROGRAMS/AIR FLOW METER/AIR FLOW MWTER TESTING FILE/AIR FLOW METER.c"

const code char truck_bmp[1024];



char GLCD_DataPort at PORTD;

sbit GLCD_CS1 at RB7_bit;
sbit GLCD_CS2 at RB6_bit;
sbit GLCD_RS at RE2_bit;
sbit GLCD_RW at RE1_bit;
sbit GLCD_EN at RE0_bit;
sbit GLCD_RST at RB5_bit;

sbit GLCD_CS1_Direction at TRISB7_bit;
sbit GLCD_CS2_Direction at TRISB6_bit;
sbit GLCD_RS_Direction at TRISE2_bit;
sbit GLCD_RW_Direction at TRISE1_bit;
sbit GLCD_EN_Direction at TRISE0_bit;
sbit GLCD_RST_Direction at TRISB5_bit;


void delay2S(){
 Delay_ms(2000);
}

void main() {
 unsigned short ii;
 char *someText;


 ADCON1=6;

 Glcd_Init();
 Glcd_Fill(0x00);
 while(1)
 {
 Glcd_Fill(0xFF);

 Glcd_Set_Font(Font_Glcd_Character8x7, 8, 7, 32);
 someText = "AIR.FLOW.METER";
 Glcd_Write_Text(someText, 1, 0, 2);
 delay2S();

 Glcd_Set_Font(Font_Glcd_System3x5, 3, 5, 32);
 someText = "OMNI";
 Glcd_Write_Text(someText, 60, 2, 2);
 delay2S();

 Glcd_Set_Font(Font_Glcd_System5x7, 5, 7, 32);
 someText = "OMNI";
 Glcd_Write_Text(someText, 5, 4, 2);
 delay2S();

 Glcd_Set_Font(Font_Glcd_5x7, 5, 7, 32);
 someText = "AIR FLOW METER";
 Glcd_Write_Text(someText, 50, 6, 2);
 delay2S();
 }
 while(1) {
#line 66 "E:/Software and Electronic wilcom/PROGRAMS/AIR FLOW METER/AIR FLOW MWTER TESTING FILE/AIR FLOW METER.c"
 Glcd_Fill(0x00);

 Glcd_Box(62,40,124,56,1);
 Glcd_Rectangle(5,5,84,35,1);
 Glcd_Line(0, 0, 127, 63, 1);
 delay2S();

 for(ii = 5; ii < 60; ii+=5 ){
 Delay_ms(250);
 Glcd_V_Line(2, 54, ii, 1);
 Glcd_H_Line(2, 120, ii, 1);
 }

 delay2S();

 Glcd_Fill(0x00);
#line 85 "E:/Software and Electronic wilcom/PROGRAMS/AIR FLOW METER/AIR FLOW MWTER TESTING FILE/AIR FLOW METER.c"
 Glcd_Write_Text("mikroE", 1, 7, 2);

 for (ii = 1; ii <= 10; ii++)
 Glcd_Circle(63,32, 3*ii, 1);
 delay2S();

 Glcd_Box(12,20, 70,57, 2);
 delay2S();
#line 117 "E:/Software and Electronic wilcom/PROGRAMS/AIR FLOW METER/AIR FLOW MWTER TESTING FILE/AIR FLOW METER.c"
 }
}
