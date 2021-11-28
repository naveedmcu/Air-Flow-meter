#line 1 "E:/Software and Electronic wilcom/PROGRAMS/FLOW METER/xGlcdTest.c"
#line 1 "e:/software and electronic wilcom/programs/flow meter/hard_specific.c"


char GLCD_DataPort at PORTD;

sbit GLCD_CS1 at RA5_bit;
sbit GLCD_CS2 at RA4_bit;
sbit GLCD_RS at RE2_bit;
sbit GLCD_RW at RE1_bit;
sbit GLCD_EN at RE0_bit;
sbit GLCD_RST at RA3_bit;

sbit GLCD_CS1_Direction at TRISA5_bit;
sbit GLCD_CS2_Direction at TRISA4_bit;
sbit GLCD_RS_Direction at TRISE2_bit;
sbit GLCD_RW_Direction at TRISE1_bit;
sbit GLCD_EN_Direction at TRISE0_bit;
sbit GLCD_RST_Direction at TRISA3_bit;


void Init_mcu()
{
 ADCON1 = 14;
}
#line 1 "e:/software and electronic wilcom/programs/flow meter/xglcd_lib.c"





const unsigned short xColorClear = 0;
const unsigned short xColorSet = 1;
const unsigned short xColorInvert= 2;


const char* xGlcdSelFont;

unsigned short xGlcdX, xGlcdY, xGlcdSelFontHeight,
 xGlcdSelFontWidth, xGlcdSelFontOffset,
 xGlcdSelFontNbRows;

char xGLCD_Transparency;

void xGlcd_Set_Font(const char* ptrFontTbl, unsigned short font_width,
 unsigned short font_height, unsigned int font_offset)
{
 xGlcdSelFont = ptrFontTbl;
 xGlcdSelFontWidth = font_width;
 xGlcdSelFontHeight = font_height;
 xGlcdSelFontOffset = font_offset;
 xGLCD_Transparency =  0 ;
 xGlcdSelFontNbRows = xGlcdSelFontHeight / 8;
 if (xGlcdSelFontHeight % 8) xGlcdSelFontNbRows++;
}


void xGLCD_Write_Data(unsigned short pX, unsigned short pY, unsigned short pData)
{
 unsigned short tmp, tmpY, gData, dataR, xx, yy;

 if ((pX>127) || (pY>63)) return;
 xx = pX % 64;
 tmp = pY / 8;
 if (tmp>7) return;
 tmpY = pY % 8;
 if (tmpY) {

 gData = pData << tmpY;
 Glcd_Set_Side(pX);
 Glcd_Set_X(xx);
 Glcd_Set_Page(tmp);
 dataR = Glcd_Read_Data();
 dataR = Glcd_Read_Data();
 if (!xGLCD_Transparency)
 dataR = dataR & (0xff >> (8-tmpY));
 dataR = gData | dataR;
 Glcd_Set_X(xx);
 Glcd_Write_Data(dataR);

 tmp++;
 if (tmp>7) return;
 Glcd_Set_X(xx);
 Glcd_Set_Page(tmp);
 gData = pData >> (8-tmpY);
 dataR = Glcd_Read_Data();
 dataR = Glcd_Read_Data();
 if (!xGLCD_Transparency)
 dataR = dataR & (0xff << tmpY);
 dataR = gData | dataR;
 Glcd_Set_X(xx);
 Glcd_Write_Data(dataR);
 }
 else {
 Glcd_Set_Side(pX);
 Glcd_Set_X(xx);
 Glcd_Set_Page(tmp);
 if (xGLCD_Transparency){
 dataR = Glcd_Read_Data();
 dataR = Glcd_Read_Data();
 dataR = pData | dataR;
 }
 else
 dataR = pData;
 Glcd_Set_X(xx);
 Glcd_Write_Data(dataR);
 }
}

unsigned short xGlcd_Write_Char(unsigned short ch, unsigned short x, unsigned short y, unsigned short color)
{
 const char* CurCharData;
 unsigned short i, j, CharWidth, CharData;
 unsigned long cOffset;

 cOffset = xGlcdSelFontWidth * xGlcdSelFontNbRows+1;
 cOffset = cOffset * (ch-xGlcdSelFontOffset);
 CurCharData = xGlcdSelFont+cOffset;
 CharWidth = *CurCharData;
 cOffset++;
 for (i = 0; i< CharWidth; i++)
 for (j = 0; j<xGlcdSelFontNbRows; j++)
 {
 CurCharData = xGlcdSelFont+(i*xGlcdSelFontNbRows)+j+cOffset;
 switch (color){
 case 0 : CharData = 0; break;
 case 1 : CharData = *CurCharData; break;
 case 2 : CharData = ~(*CurCharData); break;
 }
 xGLCD_Write_Data(x+i,y+j*8,CharData);
 };
 return CharWidth;
}

unsigned short xGlcd_Char_Width(unsigned short ch)
{
 const char* CurCharDt;
 unsigned long cOffset;
 cOffset = xGlcdSelFontWidth * xGlcdSelFontNbRows+1;
 cOffset = cOffset * (ch-xGlcdSelFontOffset);
 CurCharDt = xGlcdSelFont+cOffset;
 return *CurCharDt;
}

void xGlcd_Write_Text(char* text, unsigned short x, unsigned short y, unsigned short color)
{
 unsigned short i, l, posX;
 char* curChar;
 l = strlen(text);
 posX = x;
 curChar = text;
 for (i=0; i<l; i++){
 posX = posX + xGlcd_Write_Char(*curChar, posX,y, color) + 1;
 curChar++;
 }
}

unsigned short xGlcd_Text_Width(char* text)
{
 unsigned short i, l, w;
 l = strlen(text);
 w = 0;
 for (i = 0; i<l; i++)
 w = w + xGlcd_Char_Width(text[i])+1;
 return w;
}

void xGLCD_Set_Transparency(char active)
{
 xGLCD_Transparency = active;
}
#line 1 "e:/software and electronic wilcom/programs/flow meter/propfont.h"
#line 12 "e:/software and electronic wilcom/programs/flow meter/propfont.h"
const unsigned short Arial14x16[] = {
 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x03, 0x00, 0x00, 0xFE, 0x0D, 0xFE, 0x0D, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x07, 0x00, 0x00, 0x1E, 0x00, 0x1E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1E, 0x00, 0x1E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x07, 0x30, 0x0F, 0xF0, 0x0F, 0xFE, 0x03, 0x3E, 0x0F, 0xF0, 0x0F, 0xFE, 0x03, 0x3E, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x07, 0x38, 0x03, 0x7C, 0x07, 0x66, 0x0C, 0xFF, 0x1F, 0xC6, 0x0C, 0xCC, 0x07, 0x88, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x0C, 0x1C, 0x00, 0x3E, 0x00, 0x22, 0x00, 0x3E, 0x0C, 0x1C, 0x0F, 0xC0, 0x03, 0xF0, 0x00, 0x3C, 0x07, 0x8E, 0x0F, 0x82, 0x08, 0x80, 0x0F, 0x00, 0x07, 0x00, 0x00, 0x00, 0x00,
 0x0B, 0x00, 0x00, 0x80, 0x07, 0xDC, 0x0F, 0x7E, 0x0C, 0x66, 0x0C, 0xE6, 0x0D, 0xBE, 0x0F, 0x1C, 0x07, 0x80, 0x07, 0x80, 0x0F, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x03, 0x00, 0x00, 0x1E, 0x00, 0x1E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x05, 0x00, 0x00, 0xF0, 0x07, 0xFC, 0x3F, 0x1E, 0x78, 0x02, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x04, 0x02, 0x40, 0x0E, 0x78, 0xFC, 0x3F, 0xE0, 0x07, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x05, 0x14, 0x00, 0x14, 0x00, 0x0E, 0x00, 0x14, 0x00, 0x14, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x08, 0x60, 0x00, 0x60, 0x00, 0x60, 0x00, 0xFC, 0x03, 0xFC, 0x03, 0x60, 0x00, 0x60, 0x00, 0x60, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x03, 0x00, 0x00, 0x00, 0x2C, 0x00, 0x1C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x05, 0x00, 0x00, 0x80, 0x01, 0x80, 0x01, 0x80, 0x01, 0x80, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x03, 0x00, 0x00, 0x00, 0x0C, 0x00, 0x0C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x04, 0x00, 0x0E, 0xF0, 0x0F, 0xFE, 0x01, 0x0E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x07, 0xF8, 0x03, 0xFC, 0x07, 0x0E, 0x0E, 0x06, 0x0C, 0x0E, 0x0E, 0xFC, 0x07, 0xF8, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x06, 0x00, 0x00, 0x30, 0x00, 0x18, 0x00, 0x0C, 0x00, 0xFE, 0x0F, 0xFE, 0x0F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x07, 0x18, 0x0C, 0x1C, 0x0E, 0x06, 0x0F, 0x86, 0x0D, 0xC6, 0x0C, 0x7E, 0x0C, 0x3C, 0x0C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x07, 0x0C, 0x03, 0x0E, 0x07, 0x06, 0x0E, 0x66, 0x0C, 0x66, 0x0C, 0xFE, 0x07, 0x9C, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x07, 0x80, 0x03, 0xC0, 0x03, 0x70, 0x03, 0x1C, 0x03, 0xFE, 0x0F, 0xFE, 0x0F, 0x00, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x07, 0x70, 0x03, 0x7E, 0x07, 0x3E, 0x0E, 0x36, 0x0C, 0x36, 0x0C, 0xE6, 0x07, 0xC6, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x07, 0xF8, 0x03, 0xFC, 0x07, 0x6E, 0x0C, 0x66, 0x0C, 0x66, 0x0C, 0xEE, 0x07, 0xCC, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x07, 0x06, 0x00, 0x06, 0x0E, 0xC6, 0x0F, 0xF6, 0x01, 0x3E, 0x00, 0x0E, 0x00, 0x06, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x07, 0x98, 0x03, 0xFC, 0x07, 0x66, 0x0C, 0x66, 0x0C, 0x66, 0x0C, 0xFC, 0x07, 0x98, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x07, 0x78, 0x06, 0xFC, 0x0E, 0xC6, 0x0C, 0xC6, 0x0C, 0xC6, 0x0E, 0xFC, 0x07, 0xF8, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x03, 0x00, 0x00, 0x30, 0x0C, 0x30, 0x0C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x03, 0x00, 0x00, 0x30, 0x2C, 0x30, 0x1C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x07, 0xC0, 0x00, 0xC0, 0x00, 0xE0, 0x01, 0xE0, 0x01, 0x30, 0x03, 0x30, 0x03, 0x18, 0x06, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x08, 0xB0, 0x01, 0xB0, 0x01, 0xB0, 0x01, 0xB0, 0x01, 0xB0, 0x01, 0xB0, 0x01, 0xB0, 0x01, 0xB0, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x07, 0x18, 0x06, 0x30, 0x03, 0x30, 0x03, 0xE0, 0x01, 0xE0, 0x01, 0xC0, 0x00, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x08, 0x08, 0x00, 0x0C, 0x00, 0x06, 0x00, 0x86, 0x0D, 0xC6, 0x0D, 0xE6, 0x00, 0x7C, 0x00, 0x38, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x0E, 0xC0, 0x0F, 0xF0, 0x3F, 0x38, 0x78, 0x9C, 0x67, 0xEC, 0xEF, 0x76, 0xCC, 0x36, 0xCC, 0x36, 0xC6, 0xE6, 0xCF, 0xF6, 0xCF, 0x3E, 0x6C, 0x1C, 0x66, 0xF8, 0x33, 0xF0, 0x11,
 0x09, 0x00, 0x0E, 0xC0, 0x0F, 0xF8, 0x01, 0xBE, 0x01, 0x86, 0x01, 0xBE, 0x01, 0xF8, 0x01, 0xC0, 0x0F, 0x00, 0x0E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x0A, 0x00, 0x00, 0xFE, 0x0F, 0xFE, 0x0F, 0x66, 0x0C, 0x66, 0x0C, 0x66, 0x0C, 0x66, 0x0C, 0x66, 0x0C, 0xFE, 0x0F, 0xDC, 0x07, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x0A, 0x00, 0x00, 0xF0, 0x01, 0xFC, 0x07, 0x0C, 0x06, 0x06, 0x0C, 0x06, 0x0C, 0x06, 0x0C, 0x0E, 0x0E, 0x1C, 0x07, 0x08, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x0A, 0x00, 0x00, 0xFE, 0x0F, 0xFE, 0x0F, 0x06, 0x0C, 0x06, 0x0C, 0x06, 0x0C, 0x06, 0x0C, 0x0C, 0x06, 0xFC, 0x07, 0xF0, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x09, 0x00, 0x00, 0xFE, 0x0F, 0xFE, 0x0F, 0x66, 0x0C, 0x66, 0x0C, 0x66, 0x0C, 0x66, 0x0C, 0x66, 0x0C, 0x66, 0x0C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x08, 0x00, 0x00, 0xFE, 0x0F, 0xFE, 0x0F, 0x66, 0x00, 0x66, 0x00, 0x66, 0x00, 0x66, 0x00, 0x06, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x0B, 0x00, 0x00, 0xF0, 0x01, 0xFC, 0x07, 0x0C, 0x06, 0x06, 0x0C, 0x06, 0x0C, 0xC6, 0x0C, 0xC6, 0x0C, 0xCE, 0x0E, 0xDC, 0x07, 0xC8, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x0A, 0x00, 0x00, 0xFE, 0x0F, 0xFE, 0x0F, 0x60, 0x00, 0x60, 0x00, 0x60, 0x00, 0x60, 0x00, 0x60, 0x00, 0xFE, 0x0F, 0xFE, 0x0F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x03, 0x00, 0x00, 0xFE, 0x0F, 0xFE, 0x0F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x07, 0x00, 0x03, 0x00, 0x07, 0x00, 0x0E, 0x00, 0x0C, 0x00, 0x0C, 0xFE, 0x07, 0xFE, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x0A, 0x00, 0x00, 0xFE, 0x0F, 0xFE, 0x0F, 0xC0, 0x00, 0x60, 0x00, 0x70, 0x00, 0xF8, 0x01, 0x8C, 0x07, 0x06, 0x0E, 0x02, 0x0C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x08, 0x00, 0x00, 0xFE, 0x0F, 0xFE, 0x0F, 0x00, 0x0C, 0x00, 0x0C, 0x00, 0x0C, 0x00, 0x0C, 0x00, 0x0C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x0C, 0x00, 0x00, 0xFE, 0x0F, 0xFE, 0x0F, 0x1E, 0x00, 0xF8, 0x00, 0xC0, 0x07, 0x00, 0x0F, 0xC0, 0x07, 0xF8, 0x00, 0x1E, 0x00, 0xFE, 0x0F, 0xFE, 0x0F, 0x00, 0x00, 0x00, 0x00,
 0x0A, 0x00, 0x00, 0xFE, 0x0F, 0xFE, 0x0F, 0x1C, 0x00, 0x78, 0x00, 0xE0, 0x00, 0x80, 0x03, 0x00, 0x07, 0xFE, 0x0F, 0xFE, 0x0F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x0B, 0x00, 0x00, 0xF0, 0x01, 0xFC, 0x07, 0x0C, 0x06, 0x06, 0x0C, 0x06, 0x0C, 0x06, 0x0C, 0x06, 0x0C, 0x0C, 0x06, 0xFC, 0x07, 0xF0, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x09, 0x00, 0x00, 0xFE, 0x0F, 0xFE, 0x0F, 0xC6, 0x00, 0xC6, 0x00, 0xC6, 0x00, 0xC6, 0x00, 0x7E, 0x00, 0x3C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x0B, 0x00, 0x00, 0xF0, 0x01, 0xFC, 0x07, 0x0C, 0x06, 0x06, 0x0C, 0x06, 0x0D, 0x06, 0x0F, 0x06, 0x06, 0x0C, 0x0E, 0xFC, 0x1F, 0xF0, 0x11, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x0B, 0x00, 0x00, 0xFE, 0x0F, 0xFE, 0x0F, 0xC6, 0x00, 0xC6, 0x00, 0xC6, 0x00, 0xC6, 0x01, 0xC6, 0x03, 0x7E, 0x0F, 0x3C, 0x0E, 0x00, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x09, 0x00, 0x00, 0x38, 0x06, 0x7C, 0x06, 0x66, 0x0C, 0x66, 0x0C, 0xE6, 0x0C, 0xC6, 0x0C, 0xCC, 0x07, 0x8C, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x09, 0x00, 0x00, 0x06, 0x00, 0x06, 0x00, 0x06, 0x00, 0xFE, 0x0F, 0xFE, 0x0F, 0x06, 0x00, 0x06, 0x00, 0x06, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x0A, 0x00, 0x00, 0xFE, 0x03, 0xFE, 0x07, 0x00, 0x0E, 0x00, 0x0C, 0x00, 0x0C, 0x00, 0x0C, 0x00, 0x0E, 0xFE, 0x07, 0xFE, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x09, 0x06, 0x00, 0x3E, 0x00, 0xF8, 0x01, 0xC0, 0x0F, 0x00, 0x0E, 0xC0, 0x0F, 0xF8, 0x01, 0x3E, 0x00, 0x06, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x0D, 0x0E, 0x00, 0xFE, 0x01, 0xF8, 0x0F, 0x00, 0x0E, 0xF0, 0x0F, 0xFE, 0x00, 0x0E, 0x00, 0xFE, 0x00, 0xF0, 0x0F, 0x00, 0x0E, 0xF8, 0x0F, 0xFE, 0x01, 0x0E, 0x00, 0x00, 0x00,
 0x09, 0x00, 0x00, 0x06, 0x0C, 0x0E, 0x0E, 0xBC, 0x07, 0xF0, 0x01, 0xF0, 0x01, 0xBC, 0x07, 0x0E, 0x0E, 0x06, 0x0C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x09, 0x00, 0x00, 0x06, 0x00, 0x1E, 0x00, 0x38, 0x00, 0xF0, 0x0F, 0xF0, 0x0F, 0x38, 0x00, 0x1E, 0x00, 0x06, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x08, 0x06, 0x0C, 0x06, 0x0F, 0x86, 0x0F, 0xE6, 0x0D, 0x76, 0x0C, 0x3E, 0x0C, 0x0E, 0x0C, 0x06, 0x0C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x05, 0x00, 0x00, 0xFE, 0x7F, 0xFE, 0x7F, 0x06, 0x60, 0x06, 0x60, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x04, 0x0E, 0x00, 0xFE, 0x01, 0xF0, 0x0F, 0x00, 0x0E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x04, 0x06, 0x60, 0x06, 0x60, 0xFE, 0x7F, 0xFE, 0x7F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x08, 0x40, 0x00, 0x70, 0x00, 0x3C, 0x00, 0x0E, 0x00, 0x0E, 0x00, 0x3C, 0x00, 0x70, 0x00, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x08, 0x00, 0x60, 0x00, 0x60, 0x00, 0x60, 0x00, 0x60, 0x00, 0x60, 0x00, 0x60, 0x00, 0x60, 0x00, 0x60, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x03, 0x02, 0x00, 0x06, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x08, 0x00, 0x00, 0x20, 0x06, 0x30, 0x0F, 0xB0, 0x0D, 0xB0, 0x0C, 0xF0, 0x07, 0xE0, 0x0F, 0x00, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x08, 0x00, 0x00, 0xFE, 0x0F, 0xFE, 0x0F, 0x60, 0x04, 0x30, 0x0C, 0x70, 0x0E, 0xE0, 0x07, 0xC0, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x07, 0x00, 0x00, 0xC0, 0x03, 0xE0, 0x07, 0x30, 0x0C, 0x30, 0x0C, 0x70, 0x0E, 0x60, 0x06, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x08, 0x00, 0x00, 0xC0, 0x03, 0xE0, 0x07, 0x70, 0x0E, 0x30, 0x0C, 0x60, 0x06, 0xFE, 0x0F, 0xFE, 0x0F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x08, 0x00, 0x00, 0xC0, 0x03, 0xE0, 0x07, 0xB0, 0x0D, 0xB0, 0x0D, 0xB0, 0x0D, 0xE0, 0x0D, 0xC0, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x06, 0x30, 0x00, 0xFC, 0x0F, 0xFE, 0x0F, 0x36, 0x00, 0x36, 0x00, 0x06, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x08, 0x00, 0x00, 0xC0, 0x33, 0xE0, 0x77, 0x70, 0x6E, 0x30, 0x6C, 0x60, 0x66, 0xF0, 0x7F, 0xF0, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x08, 0x00, 0x00, 0xFE, 0x0F, 0xFE, 0x0F, 0x60, 0x00, 0x30, 0x00, 0x30, 0x00, 0xF0, 0x0F, 0xE0, 0x0F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x03, 0x00, 0x00, 0xF6, 0x0F, 0xF6, 0x0F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x03, 0x00, 0x60, 0xF6, 0x7F, 0xF6, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x07, 0x00, 0x00, 0xFE, 0x0F, 0xFE, 0x0F, 0xC0, 0x01, 0xE0, 0x03, 0x30, 0x0F, 0x10, 0x0C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x03, 0x00, 0x00, 0xFE, 0x0F, 0xFE, 0x0F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x0B, 0x00, 0x00, 0xF0, 0x0F, 0xF0, 0x0F, 0x20, 0x00, 0x30, 0x00, 0xF0, 0x0F, 0xE0, 0x0F, 0x20, 0x00, 0x30, 0x00, 0xF0, 0x0F, 0xE0, 0x0F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x08, 0x00, 0x00, 0xF0, 0x0F, 0xF0, 0x0F, 0x60, 0x00, 0x30, 0x00, 0x30, 0x00, 0xF0, 0x0F, 0xE0, 0x0F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x08, 0x00, 0x00, 0xC0, 0x03, 0xE0, 0x07, 0x70, 0x0E, 0x30, 0x0C, 0x70, 0x0E, 0xE0, 0x07, 0xC0, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x08, 0x00, 0x00, 0xF0, 0x7F, 0xF0, 0x7F, 0x60, 0x06, 0x30, 0x0C, 0x70, 0x0E, 0xE0, 0x07, 0xC0, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x08, 0x00, 0x00, 0xC0, 0x03, 0xE0, 0x07, 0x70, 0x0E, 0x30, 0x0C, 0x60, 0x06, 0xF0, 0x7F, 0xF0, 0x7F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x06, 0x00, 0x00, 0xF0, 0x0F, 0xF0, 0x0F, 0x60, 0x00, 0x30, 0x00, 0x30, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x07, 0x00, 0x00, 0xE0, 0x04, 0xF0, 0x0D, 0xB0, 0x0D, 0xB0, 0x0D, 0xB0, 0x0F, 0x20, 0x07, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x05, 0x30, 0x00, 0xF8, 0x07, 0xFC, 0x0F, 0x30, 0x0C, 0x30, 0x0C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x08, 0x00, 0x00, 0xF0, 0x07, 0xF0, 0x0F, 0x00, 0x0C, 0x00, 0x0C, 0x00, 0x06, 0xF0, 0x0F, 0xF0, 0x0F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x08, 0x00, 0x00, 0x70, 0x00, 0xF0, 0x01, 0x80, 0x0F, 0x00, 0x0E, 0x80, 0x0F, 0xF0, 0x01, 0x70, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x0B, 0x30, 0x00, 0xF0, 0x01, 0xC0, 0x0F, 0x00, 0x0E, 0xE0, 0x07, 0x70, 0x00, 0xE0, 0x07, 0x00, 0x0E, 0xC0, 0x0F, 0xF0, 0x01, 0x30, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x07, 0x00, 0x00, 0x30, 0x0C, 0x70, 0x0E, 0xC0, 0x03, 0xC0, 0x03, 0x70, 0x0E, 0x30, 0x0C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x07, 0x30, 0x00, 0xF0, 0x43, 0xC0, 0x7F, 0x00, 0x7C, 0xC0, 0x1F, 0xF0, 0x03, 0x30, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x07, 0x00, 0x00, 0x30, 0x0C, 0x30, 0x0E, 0x30, 0x0F, 0xB0, 0x0D, 0xF0, 0x0C, 0x70, 0x0C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x06, 0x00, 0x00, 0x80, 0x01, 0xFC, 0x3F, 0x7E, 0x7E, 0x06, 0x60, 0x06, 0x60, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x03, 0x00, 0x00, 0xFE, 0x7F, 0xFE, 0x7F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x05, 0x06, 0x60, 0x06, 0x60, 0x7E, 0x7E, 0xFC, 0x3F, 0x80, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x08, 0xC0, 0x00, 0x60, 0x00, 0x60, 0x00, 0x60, 0x00, 0xC0, 0x00, 0xC0, 0x00, 0xC0, 0x00, 0x60, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x09, 0x00, 0x00, 0x00, 0x00, 0xFC, 0x0F, 0x04, 0x08, 0x04, 0x08, 0x04, 0x08, 0x04, 0x08, 0x04, 0x08, 0xFC, 0x0F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
 };
#line 32 "E:/Software and Electronic wilcom/PROGRAMS/FLOW METER/xGlcdTest.c"
void delay2S(){
 delay_ms(2000);
}

void main() {
 unsigned short ii;
 unsigned int jj;
 char *someText;
 char temp_str[4];

 Init_mcu();




 Glcd_Init();
 Glcd_Fill(0x00);



 xGlcd_Set_Font(Broadway17x15, 17,15,32);






 someText = "Time 23:59";
 xGlcd_Write_Text(someText,17,1,xColorSet);
 delay2S();





 Glcd_Set_Font(System3x5, 3, 5, 32);
 someText = "GLCD OLD SMALL FONT";
 Glcd_Write_Text(someText, 3, 2, xColorSet);



 someText = "Cool Big Font";
 xGlcd_Write_Text(someText,1,24,xColorSet);



 xGlcd_Set_Font(Comic_Sans_MS19x23, 19,23,32);




 someText = "Octal 2007";
 ii = (128-xGlcd_Text_Width(someText)) / 2;

 xGlcd_Write_Text(someText,ii,42,xColorSet);
 delay2S();

 xGlcd_Set_Font(Broadway17x15, 17,15,32);


 someText = "Time 23:59";
 xGlcd_Write_Text(someText,17,1,xColorClear);
 delay2S();


 someText = "Count:";
 xGlcd_Write_Text(someText,1,1,xColorSet);








 ii=200;
 while (1==1){
 ii++;
 ByteToStr(ii,temp_str);
 xGlcd_write_text(temp_str,69,0,xColorSet);
 delay_ms(1000);
 xGlcd_write_text(temp_str,69,0,xColorClear);
 }

 lMainLoop:
 goto lMainLoop;

}