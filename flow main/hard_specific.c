
// flow meter connection
// Glcd module connections
char GLCD_DataPort at PORTD;
sbit GLCD_CS2 at RB3_bit;
sbit GLCD_CS1 at RB2_bit;
sbit GLCD_RS  at RB7_bit;
sbit GLCD_RW  at RB6_bit;
sbit GLCD_EN  at RB5_bit;
sbit GLCD_RST at RB4_bit;

sbit GLCD_CS2_Direction at TRISB3_bit;
sbit GLCD_CS1_Direction at TRISB2_bit;
sbit GLCD_RS_Direction  at TRISB7_bit;
sbit GLCD_RW_Direction  at TRISB6_bit;
sbit GLCD_EN_Direction  at TRISB5_bit;
sbit GLCD_RST_Direction at TRISB4_bit;
// End Glcd module connections

sbit BACK_LIGHT at RA4_bit;
sbit BACK_LIGHT_Direction at TRISA4_bit;

void Init_mcu()
{
  BACK_LIGHT_Direction=0;
  BACK_LIGHT=1;
  ADCON1 = 0x1E;
  I2C1_Init(100000);

}