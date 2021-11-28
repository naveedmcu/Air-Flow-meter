
_Init_mcu:

;hard_specific.c,23 :: 		void Init_mcu()
;hard_specific.c,25 :: 		BACK_LIGHT_Direction=0;
	BCF         TRISA4_bit+0, 4 
;hard_specific.c,26 :: 		BACK_LIGHT=1;
	BSF         RA4_bit+0, 4 
;hard_specific.c,27 :: 		ADCON1 = 0x1E;
	MOVLW       30
	MOVWF       ADCON1+0 
;hard_specific.c,28 :: 		I2C1_Init(100000);
	MOVLW       80
	MOVWF       SSPADD+0 
	CALL        _I2C1_Init+0, 0
;hard_specific.c,30 :: 		}
L_end_Init_mcu:
	RETURN      0
; end of _Init_mcu

_delay2S:

;FLOW METER.c,25 :: 		void delay2S()
;FLOW METER.c,27 :: 		delay_ms(2000);
	MOVLW       82
	MOVWF       R11, 0
	MOVLW       43
	MOVWF       R12, 0
	MOVLW       0
	MOVWF       R13, 0
L_delay2S0:
	DECFSZ      R13, 1, 1
	BRA         L_delay2S0
	DECFSZ      R12, 1, 1
	BRA         L_delay2S0
	DECFSZ      R11, 1, 1
	BRA         L_delay2S0
	NOP
;FLOW METER.c,28 :: 		}
L_end_delay2S:
	RETURN      0
; end of _delay2S

_set_but:

;FLOW METER.c,31 :: 		char set_but(char active)
;FLOW METER.c,33 :: 		if  (Button(&PORTE, 0, 1, active)==255)
	MOVLW       PORTE+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTE+0)
	MOVWF       FARG_Button_port+1 
	CLRF        FARG_Button_pin+0 
	MOVLW       1
	MOVWF       FARG_Button_time_ms+0 
	MOVF        FARG_set_but_active+0, 0 
	MOVWF       FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_set_but1
;FLOW METER.c,35 :: 		timer_back_light=0;
	CLRF        _timer_back_light+0 
;FLOW METER.c,36 :: 		if (BACK_LIGHT==0)
	BTFSC       RA4_bit+0, 4 
	GOTO        L_set_but2
;FLOW METER.c,38 :: 		BACK_LIGHT=1;
	BSF         RA4_bit+0, 4 
;FLOW METER.c,39 :: 		return 0;
	CLRF        R0 
	GOTO        L_end_set_but
;FLOW METER.c,40 :: 		}
L_set_but2:
;FLOW METER.c,41 :: 		return 255;
	MOVLW       255
	MOVWF       R0 
	GOTO        L_end_set_but
;FLOW METER.c,42 :: 		}
L_set_but1:
;FLOW METER.c,44 :: 		return 0;
	CLRF        R0 
;FLOW METER.c,45 :: 		}
L_end_set_but:
	RETURN      0
; end of _set_but

_shift_but:

;FLOW METER.c,47 :: 		char shift_but(char active)
;FLOW METER.c,49 :: 		if  (Button(&PORTE, 2, 1, active)==255)
	MOVLW       PORTE+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTE+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       2
	MOVWF       FARG_Button_pin+0 
	MOVLW       1
	MOVWF       FARG_Button_time_ms+0 
	MOVF        FARG_shift_but_active+0, 0 
	MOVWF       FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_shift_but4
;FLOW METER.c,51 :: 		while(Button(&PORTE, 2, 1, active)==255);
L_shift_but5:
	MOVLW       PORTE+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTE+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       2
	MOVWF       FARG_Button_pin+0 
	MOVLW       1
	MOVWF       FARG_Button_time_ms+0 
	MOVF        FARG_shift_but_active+0, 0 
	MOVWF       FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_shift_but6
	GOTO        L_shift_but5
L_shift_but6:
;FLOW METER.c,52 :: 		timer_back_light=0;
	CLRF        _timer_back_light+0 
;FLOW METER.c,53 :: 		if (BACK_LIGHT==0)
	BTFSC       RA4_bit+0, 4 
	GOTO        L_shift_but7
;FLOW METER.c,55 :: 		BACK_LIGHT=1;
	BSF         RA4_bit+0, 4 
;FLOW METER.c,56 :: 		return 0;
	CLRF        R0 
	GOTO        L_end_shift_but
;FLOW METER.c,57 :: 		}
L_shift_but7:
;FLOW METER.c,58 :: 		return 255;
	MOVLW       255
	MOVWF       R0 
	GOTO        L_end_shift_but
;FLOW METER.c,59 :: 		}
L_shift_but4:
;FLOW METER.c,61 :: 		return 0;
	CLRF        R0 
;FLOW METER.c,62 :: 		}
L_end_shift_but:
	RETURN      0
; end of _shift_but

_scrl_but:

;FLOW METER.c,64 :: 		char scrl_but(char active)
;FLOW METER.c,66 :: 		if  (Button(&PORTE, 1, 1, active)==255)
	MOVLW       PORTE+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTE+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       1
	MOVWF       FARG_Button_pin+0 
	MOVLW       1
	MOVWF       FARG_Button_time_ms+0 
	MOVF        FARG_scrl_but_active+0, 0 
	MOVWF       FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_scrl_but9
;FLOW METER.c,68 :: 		timer_back_light=0;
	CLRF        _timer_back_light+0 
;FLOW METER.c,69 :: 		if (BACK_LIGHT==0)
	BTFSC       RA4_bit+0, 4 
	GOTO        L_scrl_but10
;FLOW METER.c,71 :: 		BACK_LIGHT=1;
	BSF         RA4_bit+0, 4 
;FLOW METER.c,72 :: 		return 0;
	CLRF        R0 
	GOTO        L_end_scrl_but
;FLOW METER.c,73 :: 		}
L_scrl_but10:
;FLOW METER.c,74 :: 		return 255;
	MOVLW       255
	MOVWF       R0 
	GOTO        L_end_scrl_but
;FLOW METER.c,75 :: 		}
L_scrl_but9:
;FLOW METER.c,77 :: 		return 0;
	CLRF        R0 
;FLOW METER.c,78 :: 		}
L_end_scrl_but:
	RETURN      0
; end of _scrl_but

_boder:

;FLOW METER.c,82 :: 		void boder()
;FLOW METER.c,84 :: 		Glcd_H_Line(0, 127, 0, 1);
	CLRF        FARG_Glcd_H_Line_x_start+0 
	MOVLW       127
	MOVWF       FARG_Glcd_H_Line_x_end+0 
	CLRF        FARG_Glcd_H_Line_y_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_H_Line_color+0 
	CALL        _Glcd_H_Line+0, 0
;FLOW METER.c,85 :: 		Glcd_H_Line(0, 127, 1, 1);
	CLRF        FARG_Glcd_H_Line_x_start+0 
	MOVLW       127
	MOVWF       FARG_Glcd_H_Line_x_end+0 
	MOVLW       1
	MOVWF       FARG_Glcd_H_Line_y_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_H_Line_color+0 
	CALL        _Glcd_H_Line+0, 0
;FLOW METER.c,86 :: 		Glcd_H_Line(0, 127, 62, 1);
	CLRF        FARG_Glcd_H_Line_x_start+0 
	MOVLW       127
	MOVWF       FARG_Glcd_H_Line_x_end+0 
	MOVLW       62
	MOVWF       FARG_Glcd_H_Line_y_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_H_Line_color+0 
	CALL        _Glcd_H_Line+0, 0
;FLOW METER.c,87 :: 		Glcd_H_Line(0, 127, 63, 1);
	CLRF        FARG_Glcd_H_Line_x_start+0 
	MOVLW       127
	MOVWF       FARG_Glcd_H_Line_x_end+0 
	MOVLW       63
	MOVWF       FARG_Glcd_H_Line_y_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_H_Line_color+0 
	CALL        _Glcd_H_Line+0, 0
;FLOW METER.c,92 :: 		}
L_end_boder:
	RETURN      0
; end of _boder

_cls:

;FLOW METER.c,94 :: 		void cls()
;FLOW METER.c,96 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;FLOW METER.c,97 :: 		boder();
	CALL        _boder+0, 0
;FLOW METER.c,98 :: 		OPEN=1;
	MOVLW       1
	MOVWF       _OPEN+0 
;FLOW METER.c,99 :: 		}
L_end_cls:
	RETURN      0
; end of _cls

_fill:

;FLOW METER.c,100 :: 		void fill()
;FLOW METER.c,102 :: 		Glcd_Fill(0xff);
	MOVLW       255
	MOVWF       FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;FLOW METER.c,103 :: 		}
L_end_fill:
	RETURN      0
; end of _fill

_set_3x5:

;FLOW METER.c,104 :: 		void set_3x5()
;FLOW METER.c,106 :: 		Glcd_Set_Font(Font_Glcd_System3x5 , 3, 5, 32);
	MOVLW       _Font_Glcd_System3x5+0
	MOVWF       FARG_Glcd_Set_Font_activeFont+0 
	MOVLW       hi_addr(_Font_Glcd_System3x5+0)
	MOVWF       FARG_Glcd_Set_Font_activeFont+1 
	MOVLW       higher_addr(_Font_Glcd_System3x5+0)
	MOVWF       FARG_Glcd_Set_Font_activeFont+2 
	MOVLW       3
	MOVWF       FARG_Glcd_Set_Font_aFontWidth+0 
	MOVLW       5
	MOVWF       FARG_Glcd_Set_Font_aFontHeight+0 
	MOVLW       32
	MOVWF       FARG_Glcd_Set_Font_aFontOffs+0 
	MOVLW       0
	MOVWF       FARG_Glcd_Set_Font_aFontOffs+1 
	CALL        _Glcd_Set_Font+0, 0
;FLOW METER.c,107 :: 		}
L_end_set_3x5:
	RETURN      0
; end of _set_3x5

_set_5x7:

;FLOW METER.c,108 :: 		void set_5x7()
;FLOW METER.c,110 :: 		Glcd_Set_Font(Font_Glcd_5x7, 5, 7, 32);
	MOVLW       _Font_Glcd_5x7+0
	MOVWF       FARG_Glcd_Set_Font_activeFont+0 
	MOVLW       hi_addr(_Font_Glcd_5x7+0)
	MOVWF       FARG_Glcd_Set_Font_activeFont+1 
	MOVLW       higher_addr(_Font_Glcd_5x7+0)
	MOVWF       FARG_Glcd_Set_Font_activeFont+2 
	MOVLW       5
	MOVWF       FARG_Glcd_Set_Font_aFontWidth+0 
	MOVLW       7
	MOVWF       FARG_Glcd_Set_Font_aFontHeight+0 
	MOVLW       32
	MOVWF       FARG_Glcd_Set_Font_aFontOffs+0 
	MOVLW       0
	MOVWF       FARG_Glcd_Set_Font_aFontOffs+1 
	CALL        _Glcd_Set_Font+0, 0
;FLOW METER.c,111 :: 		}
L_end_set_5x7:
	RETURN      0
; end of _set_5x7

_set_8x7:

;FLOW METER.c,113 :: 		void set_8x7()
;FLOW METER.c,115 :: 		Glcd_Set_Font(Font_Glcd_Character8x7, 8, 7, 32);
	MOVLW       _Font_Glcd_Character8x7+0
	MOVWF       FARG_Glcd_Set_Font_activeFont+0 
	MOVLW       hi_addr(_Font_Glcd_Character8x7+0)
	MOVWF       FARG_Glcd_Set_Font_activeFont+1 
	MOVLW       higher_addr(_Font_Glcd_Character8x7+0)
	MOVWF       FARG_Glcd_Set_Font_activeFont+2 
	MOVLW       8
	MOVWF       FARG_Glcd_Set_Font_aFontWidth+0 
	MOVLW       7
	MOVWF       FARG_Glcd_Set_Font_aFontHeight+0 
	MOVLW       32
	MOVWF       FARG_Glcd_Set_Font_aFontOffs+0 
	MOVLW       0
	MOVWF       FARG_Glcd_Set_Font_aFontOffs+1 
	CALL        _Glcd_Set_Font+0, 0
;FLOW METER.c,116 :: 		}
L_end_set_8x7:
	RETURN      0
; end of _set_8x7

_init_timer0:

;FLOW METER.c,120 :: 		void init_timer0()
;FLOW METER.c,123 :: 		T0CON.TMR0ON = 0;// Timer0 On/Off Control bit:1=Enables Timer0 / 0=Stops Timer0
	BCF         T0CON+0, 7 
;FLOW METER.c,124 :: 		T0CON.T08BIT = 0;// Timer0 8-bit/16-bit Control bit: 1=8-bit timer/counter / 0=16-bit timer/counter
	BCF         T0CON+0, 6 
;FLOW METER.c,125 :: 		T0CON.T0CS   = 0;// TMR0 Clock Source Select bit: 0=Internal Clock (CLKO) / 1=Transition on T0CKI pin
	BCF         T0CON+0, 5 
;FLOW METER.c,126 :: 		T0CON.T0SE   = 0;// TMR0 Source Edge Select bit: 0=low/high / 1=high/low
	BCF         T0CON+0, 4 
;FLOW METER.c,127 :: 		T0CON.PSA    = 0;// Prescaler Assignment bit: 0=Prescaler is assigned; 1=NOT assigned/bypassed
	BCF         T0CON+0, 3 
;FLOW METER.c,128 :: 		T0CON.T0PS2  = 1;// bits 2-0  PS2:PS0: Prescaler Select bits
	BSF         T0CON+0, 2 
;FLOW METER.c,129 :: 		T0CON.T0PS1  = 1;
	BSF         T0CON+0, 1 
;FLOW METER.c,130 :: 		T0CON.T0PS0  = 0;
	BCF         T0CON+0, 0 
;FLOW METER.c,131 :: 		TMR0H = 0xB;    // preset for Timer0 MSB register
	MOVLW       11
	MOVWF       TMR0H+0 
;FLOW METER.c,132 :: 		TMR0L = 0xDC;    // preset for Timer0 LSB register
	MOVLW       220
	MOVWF       TMR0L+0 
;FLOW METER.c,133 :: 		INTCON.TMR0IE=1;
	BSF         INTCON+0, 5 
;FLOW METER.c,134 :: 		INTCON.TMR0IF=0;
	BCF         INTCON+0, 2 
;FLOW METER.c,135 :: 		}
L_end_init_timer0:
	RETURN      0
; end of _init_timer0

_TIMER0_ON:

;FLOW METER.c,136 :: 		void TIMER0_ON()
;FLOW METER.c,138 :: 		T0CON.TMR0ON = 1;
	BSF         T0CON+0, 7 
;FLOW METER.c,139 :: 		}
L_end_TIMER0_ON:
	RETURN      0
; end of _TIMER0_ON

_TIMER0_Off:

;FLOW METER.c,140 :: 		void TIMER0_Off()
;FLOW METER.c,142 :: 		T0CON.TMR0ON = 0;
	BCF         T0CON+0, 7 
;FLOW METER.c,143 :: 		}
L_end_TIMER0_Off:
	RETURN      0
; end of _TIMER0_Off

_xGlcd_Set_Font:

;xglcd_lib.c,20 :: 		unsigned short font_height, unsigned int font_offset)
;xglcd_lib.c,22 :: 		xGlcdSelFont = ptrFontTbl;
	MOVF        FARG_xGlcd_Set_Font_ptrFontTbl+0, 0 
	MOVWF       _xGlcdSelFont+0 
	MOVF        FARG_xGlcd_Set_Font_ptrFontTbl+1, 0 
	MOVWF       _xGlcdSelFont+1 
	MOVF        FARG_xGlcd_Set_Font_ptrFontTbl+2, 0 
	MOVWF       _xGlcdSelFont+2 
;xglcd_lib.c,23 :: 		xGlcdSelFontWidth = font_width;
	MOVF        FARG_xGlcd_Set_Font_font_width+0, 0 
	MOVWF       _xGlcdSelFontWidth+0 
;xglcd_lib.c,24 :: 		xGlcdSelFontHeight = font_height;
	MOVF        FARG_xGlcd_Set_Font_font_height+0, 0 
	MOVWF       _xGlcdSelFontHeight+0 
;xglcd_lib.c,25 :: 		xGlcdSelFontOffset = font_offset;
	MOVF        FARG_xGlcd_Set_Font_font_offset+0, 0 
	MOVWF       _xGlcdSelFontOffset+0 
;xglcd_lib.c,26 :: 		xGLCD_Transparency  = FALSE;  //Transparency of Text is set to False !!!
	CLRF        _xGLCD_Transparency+0 
;xglcd_lib.c,27 :: 		xGlcdSelFontNbRows = xGlcdSelFontHeight / 8;
	MOVF        FARG_xGlcd_Set_Font_font_height+0, 0 
	MOVWF       _xGlcdSelFontNbRows+0 
	RRCF        _xGlcdSelFontNbRows+0, 1 
	BCF         _xGlcdSelFontNbRows+0, 7 
	RRCF        _xGlcdSelFontNbRows+0, 1 
	BCF         _xGlcdSelFontNbRows+0, 7 
	RRCF        _xGlcdSelFontNbRows+0, 1 
	BCF         _xGlcdSelFontNbRows+0, 7 
;xglcd_lib.c,28 :: 		if (xGlcdSelFontHeight  % 8) xGlcdSelFontNbRows++;
	MOVLW       7
	ANDWF       FARG_xGlcd_Set_Font_font_height+0, 0 
	MOVWF       R0 
	BTFSC       STATUS+0, 2 
	GOTO        L_xGlcd_Set_Font12
	INCF        _xGlcdSelFontNbRows+0, 1 
L_xGlcd_Set_Font12:
;xglcd_lib.c,29 :: 		}
L_end_xGlcd_Set_Font:
	RETURN      0
; end of _xGlcd_Set_Font

_xGLCD_Write_Data:

;xglcd_lib.c,32 :: 		void xGLCD_Write_Data(unsigned short pX, unsigned short pY, unsigned short pData)
;xglcd_lib.c,36 :: 		if ((pX>127) || (pY>63)) return;
	MOVF        FARG_xGLCD_Write_Data_pX+0, 0 
	SUBLW       127
	BTFSS       STATUS+0, 0 
	GOTO        L__xGLCD_Write_Data359
	MOVF        FARG_xGLCD_Write_Data_pY+0, 0 
	SUBLW       63
	BTFSS       STATUS+0, 0 
	GOTO        L__xGLCD_Write_Data359
	GOTO        L_xGLCD_Write_Data15
L__xGLCD_Write_Data359:
	GOTO        L_end_xGLCD_Write_Data
L_xGLCD_Write_Data15:
;xglcd_lib.c,37 :: 		xx = pX % 64;
	MOVLW       63
	ANDWF       FARG_xGLCD_Write_Data_pX+0, 0 
	MOVWF       xGLCD_Write_Data_xx_L0+0 
;xglcd_lib.c,38 :: 		tmp = pY / 8;
	MOVF        FARG_xGLCD_Write_Data_pY+0, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	BCF         R1, 7 
	RRCF        R1, 1 
	BCF         R1, 7 
	RRCF        R1, 1 
	BCF         R1, 7 
	MOVF        R1, 0 
	MOVWF       xGLCD_Write_Data_tmp_L0+0 
;xglcd_lib.c,39 :: 		if (tmp>7) return;
	MOVF        R1, 0 
	SUBLW       7
	BTFSC       STATUS+0, 0 
	GOTO        L_xGLCD_Write_Data16
	GOTO        L_end_xGLCD_Write_Data
L_xGLCD_Write_Data16:
;xglcd_lib.c,40 :: 		tmpY = pY % 8;
	MOVLW       7
	ANDWF       FARG_xGLCD_Write_Data_pY+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       xGLCD_Write_Data_tmpY_L0+0 
;xglcd_lib.c,41 :: 		if (tmpY) {
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_xGLCD_Write_Data17
;xglcd_lib.c,43 :: 		gData = pData << tmpY;
	MOVF        xGLCD_Write_Data_tmpY_L0+0, 0 
	MOVWF       R0 
	MOVF        FARG_xGLCD_Write_Data_pData+0, 0 
	MOVWF       xGLCD_Write_Data_gData_L0+0 
	MOVF        R0, 0 
L__xGLCD_Write_Data402:
	BZ          L__xGLCD_Write_Data403
	RLCF        xGLCD_Write_Data_gData_L0+0, 1 
	BCF         xGLCD_Write_Data_gData_L0+0, 0 
	ADDLW       255
	GOTO        L__xGLCD_Write_Data402
L__xGLCD_Write_Data403:
;xglcd_lib.c,44 :: 		Glcd_Set_Side(pX);
	MOVF        FARG_xGLCD_Write_Data_pX+0, 0 
	MOVWF       FARG_Glcd_Set_Side_x_pos+0 
	CALL        _Glcd_Set_Side+0, 0
;xglcd_lib.c,45 :: 		Glcd_Set_X(xx);
	MOVF        xGLCD_Write_Data_xx_L0+0, 0 
	MOVWF       FARG_Glcd_Set_X_x_pos+0 
	CALL        _Glcd_Set_X+0, 0
;xglcd_lib.c,46 :: 		Glcd_Set_Page(tmp);
	MOVF        xGLCD_Write_Data_tmp_L0+0, 0 
	MOVWF       FARG_Glcd_Set_Page_page+0 
	CALL        _Glcd_Set_Page+0, 0
;xglcd_lib.c,47 :: 		dataR = Glcd_Read_Data();
	CALL        _Glcd_Read_Data+0, 0
	MOVF        R0, 0 
	MOVWF       xGLCD_Write_Data_dataR_L0+0 
;xglcd_lib.c,48 :: 		dataR = Glcd_Read_Data();
	CALL        _Glcd_Read_Data+0, 0
	MOVF        R0, 0 
	MOVWF       xGLCD_Write_Data_dataR_L0+0 
;xglcd_lib.c,49 :: 		if (!xGLCD_Transparency)
	MOVF        _xGLCD_Transparency+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_xGLCD_Write_Data18
;xglcd_lib.c,50 :: 		dataR = dataR & (0xff >> (8-tmpY));
	MOVF        xGLCD_Write_Data_tmpY_L0+0, 0 
	SUBLW       8
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVF        R0, 0 
	MOVWF       R1 
	MOVLW       255
	MOVWF       R0 
	MOVF        R1, 0 
L__xGLCD_Write_Data404:
	BZ          L__xGLCD_Write_Data405
	RRCF        R0, 1 
	BCF         R0, 7 
	ADDLW       255
	GOTO        L__xGLCD_Write_Data404
L__xGLCD_Write_Data405:
	MOVF        R0, 0 
	ANDWF       xGLCD_Write_Data_dataR_L0+0, 1 
L_xGLCD_Write_Data18:
;xglcd_lib.c,51 :: 		dataR = gData | dataR;
	MOVF        xGLCD_Write_Data_gData_L0+0, 0 
	IORWF       xGLCD_Write_Data_dataR_L0+0, 1 
;xglcd_lib.c,52 :: 		Glcd_Set_X(xx);
	MOVF        xGLCD_Write_Data_xx_L0+0, 0 
	MOVWF       FARG_Glcd_Set_X_x_pos+0 
	CALL        _Glcd_Set_X+0, 0
;xglcd_lib.c,53 :: 		Glcd_Write_Data(dataR);
	MOVF        xGLCD_Write_Data_dataR_L0+0, 0 
	MOVWF       FARG_Glcd_Write_Data_ddata+0 
	CALL        _Glcd_Write_Data+0, 0
;xglcd_lib.c,55 :: 		tmp++;
	INCF        xGLCD_Write_Data_tmp_L0+0, 1 
;xglcd_lib.c,56 :: 		if (tmp>7) return;
	MOVF        xGLCD_Write_Data_tmp_L0+0, 0 
	SUBLW       7
	BTFSC       STATUS+0, 0 
	GOTO        L_xGLCD_Write_Data19
	GOTO        L_end_xGLCD_Write_Data
L_xGLCD_Write_Data19:
;xglcd_lib.c,57 :: 		Glcd_Set_X(xx);
	MOVF        xGLCD_Write_Data_xx_L0+0, 0 
	MOVWF       FARG_Glcd_Set_X_x_pos+0 
	CALL        _Glcd_Set_X+0, 0
;xglcd_lib.c,58 :: 		Glcd_Set_Page(tmp);
	MOVF        xGLCD_Write_Data_tmp_L0+0, 0 
	MOVWF       FARG_Glcd_Set_Page_page+0 
	CALL        _Glcd_Set_Page+0, 0
;xglcd_lib.c,59 :: 		gData = pData >> (8-tmpY);
	MOVF        xGLCD_Write_Data_tmpY_L0+0, 0 
	SUBLW       8
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVF        FARG_xGLCD_Write_Data_pData+0, 0 
	MOVWF       xGLCD_Write_Data_gData_L0+0 
	MOVF        R0, 0 
L__xGLCD_Write_Data406:
	BZ          L__xGLCD_Write_Data407
	RRCF        xGLCD_Write_Data_gData_L0+0, 1 
	BCF         xGLCD_Write_Data_gData_L0+0, 7 
	ADDLW       255
	GOTO        L__xGLCD_Write_Data406
L__xGLCD_Write_Data407:
;xglcd_lib.c,60 :: 		dataR = Glcd_Read_Data();
	CALL        _Glcd_Read_Data+0, 0
	MOVF        R0, 0 
	MOVWF       xGLCD_Write_Data_dataR_L0+0 
;xglcd_lib.c,61 :: 		dataR = Glcd_Read_Data();
	CALL        _Glcd_Read_Data+0, 0
	MOVF        R0, 0 
	MOVWF       xGLCD_Write_Data_dataR_L0+0 
;xglcd_lib.c,62 :: 		if (!xGLCD_Transparency)
	MOVF        _xGLCD_Transparency+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_xGLCD_Write_Data20
;xglcd_lib.c,63 :: 		dataR = dataR & (0xff << tmpY);
	MOVF        xGLCD_Write_Data_tmpY_L0+0, 0 
	MOVWF       R1 
	MOVLW       255
	MOVWF       R0 
	MOVF        R1, 0 
L__xGLCD_Write_Data408:
	BZ          L__xGLCD_Write_Data409
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__xGLCD_Write_Data408
L__xGLCD_Write_Data409:
	MOVF        R0, 0 
	ANDWF       xGLCD_Write_Data_dataR_L0+0, 1 
L_xGLCD_Write_Data20:
;xglcd_lib.c,64 :: 		dataR = gData | dataR;
	MOVF        xGLCD_Write_Data_gData_L0+0, 0 
	IORWF       xGLCD_Write_Data_dataR_L0+0, 1 
;xglcd_lib.c,65 :: 		Glcd_Set_X(xx);
	MOVF        xGLCD_Write_Data_xx_L0+0, 0 
	MOVWF       FARG_Glcd_Set_X_x_pos+0 
	CALL        _Glcd_Set_X+0, 0
;xglcd_lib.c,66 :: 		Glcd_Write_Data(dataR);
	MOVF        xGLCD_Write_Data_dataR_L0+0, 0 
	MOVWF       FARG_Glcd_Write_Data_ddata+0 
	CALL        _Glcd_Write_Data+0, 0
;xglcd_lib.c,67 :: 		}
	GOTO        L_xGLCD_Write_Data21
L_xGLCD_Write_Data17:
;xglcd_lib.c,69 :: 		Glcd_Set_Side(pX);
	MOVF        FARG_xGLCD_Write_Data_pX+0, 0 
	MOVWF       FARG_Glcd_Set_Side_x_pos+0 
	CALL        _Glcd_Set_Side+0, 0
;xglcd_lib.c,70 :: 		Glcd_Set_X(xx);
	MOVF        xGLCD_Write_Data_xx_L0+0, 0 
	MOVWF       FARG_Glcd_Set_X_x_pos+0 
	CALL        _Glcd_Set_X+0, 0
;xglcd_lib.c,71 :: 		Glcd_Set_Page(tmp);
	MOVF        xGLCD_Write_Data_tmp_L0+0, 0 
	MOVWF       FARG_Glcd_Set_Page_page+0 
	CALL        _Glcd_Set_Page+0, 0
;xglcd_lib.c,72 :: 		if (xGLCD_Transparency){
	MOVF        _xGLCD_Transparency+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_xGLCD_Write_Data22
;xglcd_lib.c,73 :: 		dataR = Glcd_Read_Data();
	CALL        _Glcd_Read_Data+0, 0
	MOVF        R0, 0 
	MOVWF       xGLCD_Write_Data_dataR_L0+0 
;xglcd_lib.c,74 :: 		dataR = Glcd_Read_Data();
	CALL        _Glcd_Read_Data+0, 0
	MOVF        R0, 0 
	MOVWF       xGLCD_Write_Data_dataR_L0+0 
;xglcd_lib.c,75 :: 		dataR = pData | dataR;
	MOVF        R0, 0 
	IORWF       FARG_xGLCD_Write_Data_pData+0, 0 
	MOVWF       xGLCD_Write_Data_dataR_L0+0 
;xglcd_lib.c,76 :: 		}
	GOTO        L_xGLCD_Write_Data23
L_xGLCD_Write_Data22:
;xglcd_lib.c,78 :: 		dataR = pData;
	MOVF        FARG_xGLCD_Write_Data_pData+0, 0 
	MOVWF       xGLCD_Write_Data_dataR_L0+0 
L_xGLCD_Write_Data23:
;xglcd_lib.c,79 :: 		Glcd_Set_X(xx);
	MOVF        xGLCD_Write_Data_xx_L0+0, 0 
	MOVWF       FARG_Glcd_Set_X_x_pos+0 
	CALL        _Glcd_Set_X+0, 0
;xglcd_lib.c,80 :: 		Glcd_Write_Data(dataR);
	MOVF        xGLCD_Write_Data_dataR_L0+0, 0 
	MOVWF       FARG_Glcd_Write_Data_ddata+0 
	CALL        _Glcd_Write_Data+0, 0
;xglcd_lib.c,81 :: 		}
L_xGLCD_Write_Data21:
;xglcd_lib.c,82 :: 		}
L_end_xGLCD_Write_Data:
	RETURN      0
; end of _xGLCD_Write_Data

_xGlcd_Write_Char:

;xglcd_lib.c,84 :: 		unsigned short xGlcd_Write_Char(unsigned short  ch, unsigned short x, unsigned short y, unsigned short color)
;xglcd_lib.c,90 :: 		cOffset = xGlcdSelFontWidth * xGlcdSelFontNbRows+1;
	MOVF        _xGlcdSelFontWidth+0, 0 
	MULWF       _xGlcdSelFontNbRows+0 
	MOVF        PRODL+0, 0 
	MOVWF       xGlcd_Write_Char_cOffset_L0+0 
	MOVF        PRODH+0, 0 
	MOVWF       xGlcd_Write_Char_cOffset_L0+1 
	MOVLW       0
	BTFSC       xGlcd_Write_Char_cOffset_L0+1, 7 
	MOVLW       255
	MOVWF       xGlcd_Write_Char_cOffset_L0+2 
	MOVWF       xGlcd_Write_Char_cOffset_L0+3 
	INFSNZ      xGlcd_Write_Char_cOffset_L0+0, 1 
	INCF        xGlcd_Write_Char_cOffset_L0+1, 1 
	MOVLW       0
	BTFSC       xGlcd_Write_Char_cOffset_L0+1, 7 
	MOVLW       255
	MOVWF       xGlcd_Write_Char_cOffset_L0+2 
	MOVWF       xGlcd_Write_Char_cOffset_L0+3 
;xglcd_lib.c,91 :: 		cOffset = cOffset * (ch-xGlcdSelFontOffset);
	MOVF        _xGlcdSelFontOffset+0, 0 
	SUBWF       FARG_xGlcd_Write_Char_ch+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	MOVWF       R2 
	MOVWF       R3 
	MOVF        xGlcd_Write_Char_cOffset_L0+0, 0 
	MOVWF       R4 
	MOVF        xGlcd_Write_Char_cOffset_L0+1, 0 
	MOVWF       R5 
	MOVF        xGlcd_Write_Char_cOffset_L0+2, 0 
	MOVWF       R6 
	MOVF        xGlcd_Write_Char_cOffset_L0+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVF        R0, 0 
	MOVWF       xGlcd_Write_Char_cOffset_L0+0 
	MOVF        R1, 0 
	MOVWF       xGlcd_Write_Char_cOffset_L0+1 
	MOVF        R2, 0 
	MOVWF       xGlcd_Write_Char_cOffset_L0+2 
	MOVF        R3, 0 
	MOVWF       xGlcd_Write_Char_cOffset_L0+3 
;xglcd_lib.c,92 :: 		CurCharData = xGlcdSelFont+cOffset;
	MOVF        _xGlcdSelFont+0, 0 
	ADDWF       R0, 0 
	MOVWF       R4 
	MOVF        _xGlcdSelFont+1, 0 
	ADDWFC      R1, 0 
	MOVWF       R5 
	MOVF        _xGlcdSelFont+2, 0 
	ADDWFC      R2, 0 
	MOVWF       R6 
	MOVF        R4, 0 
	MOVWF       xGlcd_Write_Char_CurCharData_L0+0 
	MOVF        R5, 0 
	MOVWF       xGlcd_Write_Char_CurCharData_L0+1 
	MOVF        R6, 0 
	MOVWF       xGlcd_Write_Char_CurCharData_L0+2 
;xglcd_lib.c,93 :: 		CharWidth = *CurCharData;
	MOVF        R4, 0 
	MOVWF       TBLPTRL 
	MOVF        R5, 0 
	MOVWF       TBLPTRH 
	MOVF        R6, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, xGlcd_Write_Char_CharWidth_L0+0
;xglcd_lib.c,94 :: 		cOffset++;
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       xGlcd_Write_Char_cOffset_L0+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       xGlcd_Write_Char_cOffset_L0+1 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       xGlcd_Write_Char_cOffset_L0+2 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       xGlcd_Write_Char_cOffset_L0+3 
;xglcd_lib.c,95 :: 		for (i = 0; i< CharWidth; i++)
	CLRF        xGlcd_Write_Char_i_L0+0 
L_xGlcd_Write_Char24:
	MOVF        xGlcd_Write_Char_CharWidth_L0+0, 0 
	SUBWF       xGlcd_Write_Char_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_xGlcd_Write_Char25
;xglcd_lib.c,96 :: 		for (j = 0; j<xGlcdSelFontNbRows; j++)
	CLRF        xGlcd_Write_Char_j_L0+0 
L_xGlcd_Write_Char27:
	MOVF        _xGlcdSelFontNbRows+0, 0 
	SUBWF       xGlcd_Write_Char_j_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_xGlcd_Write_Char28
;xglcd_lib.c,98 :: 		CurCharData = xGlcdSelFont+(i*xGlcdSelFontNbRows)+j+cOffset;
	MOVF        xGlcd_Write_Char_i_L0+0, 0 
	MULWF       _xGlcdSelFontNbRows+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        PRODH+0, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	ADDWF       _xGlcdSelFont+0, 0 
	MOVWF       xGlcd_Write_Char_CurCharData_L0+0 
	MOVF        R1, 0 
	ADDWFC      _xGlcdSelFont+1, 0 
	MOVWF       xGlcd_Write_Char_CurCharData_L0+1 
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	ADDWFC      _xGlcdSelFont+2, 0 
	MOVWF       xGlcd_Write_Char_CurCharData_L0+2 
	MOVF        xGlcd_Write_Char_j_L0+0, 0 
	ADDWF       xGlcd_Write_Char_CurCharData_L0+0, 1 
	MOVLW       0
	ADDWFC      xGlcd_Write_Char_CurCharData_L0+1, 1 
	ADDWFC      xGlcd_Write_Char_CurCharData_L0+2, 1 
	MOVF        xGlcd_Write_Char_CurCharData_L0+0, 0 
	ADDWF       xGlcd_Write_Char_cOffset_L0+0, 0 
	MOVWF       xGlcd_Write_Char_CurCharData_L0+0 
	MOVF        xGlcd_Write_Char_CurCharData_L0+1, 0 
	ADDWFC      xGlcd_Write_Char_cOffset_L0+1, 0 
	MOVWF       xGlcd_Write_Char_CurCharData_L0+1 
	MOVF        xGlcd_Write_Char_CurCharData_L0+2, 0 
	ADDWFC      xGlcd_Write_Char_cOffset_L0+2, 0 
	MOVWF       xGlcd_Write_Char_CurCharData_L0+2 
;xglcd_lib.c,99 :: 		switch (color){
	GOTO        L_xGlcd_Write_Char30
;xglcd_lib.c,100 :: 		case 0 : CharData = 0; break;
L_xGlcd_Write_Char32:
	CLRF        xGlcd_Write_Char_CharData_L0+0 
	GOTO        L_xGlcd_Write_Char31
;xglcd_lib.c,101 :: 		case 1 : CharData = *CurCharData; break;
L_xGlcd_Write_Char33:
	MOVF        xGlcd_Write_Char_CurCharData_L0+0, 0 
	MOVWF       TBLPTRL 
	MOVF        xGlcd_Write_Char_CurCharData_L0+1, 0 
	MOVWF       TBLPTRH 
	MOVF        xGlcd_Write_Char_CurCharData_L0+2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, xGlcd_Write_Char_CharData_L0+0
	GOTO        L_xGlcd_Write_Char31
;xglcd_lib.c,102 :: 		case 2 : CharData =  ~(*CurCharData); break;
L_xGlcd_Write_Char34:
	MOVF        xGlcd_Write_Char_CurCharData_L0+0, 0 
	MOVWF       TBLPTRL 
	MOVF        xGlcd_Write_Char_CurCharData_L0+1, 0 
	MOVWF       TBLPTRH 
	MOVF        xGlcd_Write_Char_CurCharData_L0+2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	COMF        R0, 0 
	MOVWF       xGlcd_Write_Char_CharData_L0+0 
	GOTO        L_xGlcd_Write_Char31
;xglcd_lib.c,103 :: 		}
L_xGlcd_Write_Char30:
	MOVF        FARG_xGlcd_Write_Char_color+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_xGlcd_Write_Char32
	MOVF        FARG_xGlcd_Write_Char_color+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_xGlcd_Write_Char33
	MOVF        FARG_xGlcd_Write_Char_color+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_xGlcd_Write_Char34
L_xGlcd_Write_Char31:
;xglcd_lib.c,104 :: 		xGLCD_Write_Data(x+i,y+j*8,CharData);
	MOVF        xGlcd_Write_Char_i_L0+0, 0 
	ADDWF       FARG_xGlcd_Write_Char_x+0, 0 
	MOVWF       FARG_xGLCD_Write_Data_pX+0 
	MOVF        xGlcd_Write_Char_j_L0+0, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	ADDWF       FARG_xGlcd_Write_Char_y+0, 0 
	MOVWF       FARG_xGLCD_Write_Data_pY+0 
	MOVF        xGlcd_Write_Char_CharData_L0+0, 0 
	MOVWF       FARG_xGLCD_Write_Data_pData+0 
	CALL        _xGLCD_Write_Data+0, 0
;xglcd_lib.c,96 :: 		for (j = 0; j<xGlcdSelFontNbRows; j++)
	INCF        xGlcd_Write_Char_j_L0+0, 1 
;xglcd_lib.c,105 :: 		};
	GOTO        L_xGlcd_Write_Char27
L_xGlcd_Write_Char28:
;xglcd_lib.c,95 :: 		for (i = 0; i< CharWidth; i++)
	INCF        xGlcd_Write_Char_i_L0+0, 1 
;xglcd_lib.c,105 :: 		};
	GOTO        L_xGlcd_Write_Char24
L_xGlcd_Write_Char25:
;xglcd_lib.c,106 :: 		return CharWidth;
	MOVF        xGlcd_Write_Char_CharWidth_L0+0, 0 
	MOVWF       R0 
;xglcd_lib.c,107 :: 		}
L_end_xGlcd_Write_Char:
	RETURN      0
; end of _xGlcd_Write_Char

_xGlcd_Char_Width:

;xglcd_lib.c,109 :: 		unsigned short xGlcd_Char_Width(unsigned short ch)
;xglcd_lib.c,113 :: 		cOffset = xGlcdSelFontWidth * xGlcdSelFontNbRows+1;
	MOVF        _xGlcdSelFontWidth+0, 0 
	MULWF       _xGlcdSelFontNbRows+0 
	MOVF        PRODL+0, 0 
	MOVWF       xGlcd_Char_Width_cOffset_L0+0 
	MOVF        PRODH+0, 0 
	MOVWF       xGlcd_Char_Width_cOffset_L0+1 
	MOVLW       0
	BTFSC       xGlcd_Char_Width_cOffset_L0+1, 7 
	MOVLW       255
	MOVWF       xGlcd_Char_Width_cOffset_L0+2 
	MOVWF       xGlcd_Char_Width_cOffset_L0+3 
	INFSNZ      xGlcd_Char_Width_cOffset_L0+0, 1 
	INCF        xGlcd_Char_Width_cOffset_L0+1, 1 
	MOVLW       0
	BTFSC       xGlcd_Char_Width_cOffset_L0+1, 7 
	MOVLW       255
	MOVWF       xGlcd_Char_Width_cOffset_L0+2 
	MOVWF       xGlcd_Char_Width_cOffset_L0+3 
;xglcd_lib.c,114 :: 		cOffset = cOffset * (ch-xGlcdSelFontOffset);
	MOVF        _xGlcdSelFontOffset+0, 0 
	SUBWF       FARG_xGlcd_Char_Width_ch+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	MOVWF       R2 
	MOVWF       R3 
	MOVF        xGlcd_Char_Width_cOffset_L0+0, 0 
	MOVWF       R4 
	MOVF        xGlcd_Char_Width_cOffset_L0+1, 0 
	MOVWF       R5 
	MOVF        xGlcd_Char_Width_cOffset_L0+2, 0 
	MOVWF       R6 
	MOVF        xGlcd_Char_Width_cOffset_L0+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVF        R0, 0 
	MOVWF       xGlcd_Char_Width_cOffset_L0+0 
	MOVF        R1, 0 
	MOVWF       xGlcd_Char_Width_cOffset_L0+1 
	MOVF        R2, 0 
	MOVWF       xGlcd_Char_Width_cOffset_L0+2 
	MOVF        R3, 0 
	MOVWF       xGlcd_Char_Width_cOffset_L0+3 
;xglcd_lib.c,115 :: 		CurCharDt = xGlcdSelFont+cOffset;
	MOVF        _xGlcdSelFont+0, 0 
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVF        _xGlcdSelFont+1, 0 
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVF        _xGlcdSelFont+2, 0 
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
;xglcd_lib.c,116 :: 		return *CurCharDt;
	TBLRD*+
	MOVFF       TABLAT+0, R0
;xglcd_lib.c,117 :: 		}
L_end_xGlcd_Char_Width:
	RETURN      0
; end of _xGlcd_Char_Width

_xGlcd_Write_Text:

;xglcd_lib.c,119 :: 		void xGlcd_Write_Text(char* text, unsigned short x, unsigned short y, unsigned short color)
;xglcd_lib.c,123 :: 		l = strlen(text);
	MOVF        FARG_xGlcd_Write_Text_text+0, 0 
	MOVWF       FARG_strlen_s+0 
	MOVF        FARG_xGlcd_Write_Text_text+1, 0 
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVF        R0, 0 
	MOVWF       xGlcd_Write_Text_l_L0+0 
;xglcd_lib.c,124 :: 		posX = x;
	MOVF        FARG_xGlcd_Write_Text_x+0, 0 
	MOVWF       xGlcd_Write_Text_posX_L0+0 
;xglcd_lib.c,125 :: 		curChar = text;
	MOVF        FARG_xGlcd_Write_Text_text+0, 0 
	MOVWF       xGlcd_Write_Text_curChar_L0+0 
	MOVF        FARG_xGlcd_Write_Text_text+1, 0 
	MOVWF       xGlcd_Write_Text_curChar_L0+1 
;xglcd_lib.c,126 :: 		for (i=0; i<l; i++)
	CLRF        xGlcd_Write_Text_i_L0+0 
L_xGlcd_Write_Text35:
	MOVF        xGlcd_Write_Text_l_L0+0, 0 
	SUBWF       xGlcd_Write_Text_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_xGlcd_Write_Text36
;xglcd_lib.c,128 :: 		posX = posX + xGlcd_Write_Char(*curChar, posX,y, color) +  1; //add 1 blank column
	MOVFF       xGlcd_Write_Text_curChar_L0+0, FSR0
	MOVFF       xGlcd_Write_Text_curChar_L0+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_xGlcd_Write_Char_ch+0 
	MOVF        xGlcd_Write_Text_posX_L0+0, 0 
	MOVWF       FARG_xGlcd_Write_Char_x+0 
	MOVF        FARG_xGlcd_Write_Text_y+0, 0 
	MOVWF       FARG_xGlcd_Write_Char_y+0 
	MOVF        FARG_xGlcd_Write_Text_color+0, 0 
	MOVWF       FARG_xGlcd_Write_Char_color+0 
	CALL        _xGlcd_Write_Char+0, 0
	MOVF        R0, 0 
	ADDWF       xGlcd_Write_Text_posX_L0+0, 1 
	INCF        xGlcd_Write_Text_posX_L0+0, 1 
;xglcd_lib.c,129 :: 		curChar++;
	INFSNZ      xGlcd_Write_Text_curChar_L0+0, 1 
	INCF        xGlcd_Write_Text_curChar_L0+1, 1 
;xglcd_lib.c,126 :: 		for (i=0; i<l; i++)
	INCF        xGlcd_Write_Text_i_L0+0, 1 
;xglcd_lib.c,130 :: 		}
	GOTO        L_xGlcd_Write_Text35
L_xGlcd_Write_Text36:
;xglcd_lib.c,131 :: 		}
L_end_xGlcd_Write_Text:
	RETURN      0
; end of _xGlcd_Write_Text

_xGlcd_Text_Width:

;xglcd_lib.c,133 :: 		unsigned short xGlcd_Text_Width(char* text)
;xglcd_lib.c,136 :: 		l = strlen(text);
	MOVF        FARG_xGlcd_Text_Width_text+0, 0 
	MOVWF       FARG_strlen_s+0 
	MOVF        FARG_xGlcd_Text_Width_text+1, 0 
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVF        R0, 0 
	MOVWF       xGlcd_Text_Width_l_L0+0 
;xglcd_lib.c,137 :: 		w = 0;
	CLRF        xGlcd_Text_Width_w_L0+0 
;xglcd_lib.c,138 :: 		for (i = 0; i<l; i++)
	CLRF        xGlcd_Text_Width_i_L0+0 
L_xGlcd_Text_Width38:
	MOVF        xGlcd_Text_Width_l_L0+0, 0 
	SUBWF       xGlcd_Text_Width_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_xGlcd_Text_Width39
;xglcd_lib.c,139 :: 		w = w + xGlcd_Char_Width(text[i])+1; //add 1 blank column
	MOVF        xGlcd_Text_Width_i_L0+0, 0 
	ADDWF       FARG_xGlcd_Text_Width_text+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_xGlcd_Text_Width_text+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_xGlcd_Char_Width_ch+0 
	CALL        _xGlcd_Char_Width+0, 0
	MOVF        R0, 0 
	ADDWF       xGlcd_Text_Width_w_L0+0, 1 
	INCF        xGlcd_Text_Width_w_L0+0, 1 
;xglcd_lib.c,138 :: 		for (i = 0; i<l; i++)
	INCF        xGlcd_Text_Width_i_L0+0, 1 
;xglcd_lib.c,139 :: 		w = w + xGlcd_Char_Width(text[i])+1; //add 1 blank column
	GOTO        L_xGlcd_Text_Width38
L_xGlcd_Text_Width39:
;xglcd_lib.c,140 :: 		return w;
	MOVF        xGlcd_Text_Width_w_L0+0, 0 
	MOVWF       R0 
;xglcd_lib.c,141 :: 		}
L_end_xGlcd_Text_Width:
	RETURN      0
; end of _xGlcd_Text_Width

_xGLCD_Set_Transparency:

;xglcd_lib.c,143 :: 		void xGLCD_Set_Transparency(char active)
;xglcd_lib.c,145 :: 		xGLCD_Transparency = active;
	MOVF        FARG_xGLCD_Set_Transparency_active+0, 0 
	MOVWF       _xGLCD_Transparency+0 
;xglcd_lib.c,146 :: 		}
L_end_xGLCD_Set_Transparency:
	RETURN      0
; end of _xGLCD_Set_Transparency

_save_tag:

;slides.c,7 :: 		void save_tag()
;slides.c,9 :: 		set_3x5();
	CALL        _set_3x5+0, 0
;slides.c,10 :: 		someText ="SAVE";
	MOVLW       ?lstr1_FLOW_32METER+0
	MOVWF       _someText+0 
	MOVLW       hi_addr(?lstr1_FLOW_32METER+0)
	MOVWF       _someText+1 
;slides.c,11 :: 		Glcd_Write_Text(someText, 5, 2, xColorSet);
	MOVF        _someText+0, 0 
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVF        _someText+1, 0 
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       5
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;slides.c,13 :: 		Glcd_Box(3, 16, 21, 23, 2);
	MOVLW       3
	MOVWF       FARG_Glcd_Box_x_upper_left+0 
	MOVLW       16
	MOVWF       FARG_Glcd_Box_y_upper_left+0 
	MOVLW       21
	MOVWF       FARG_Glcd_Box_x_bottom_right+0 
	MOVLW       23
	MOVWF       FARG_Glcd_Box_y_bottom_right+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Box_color+0 
	CALL        _Glcd_Box+0, 0
;slides.c,14 :: 		delay_ms(500);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_save_tag41:
	DECFSZ      R13, 1, 1
	BRA         L_save_tag41
	DECFSZ      R12, 1, 1
	BRA         L_save_tag41
	DECFSZ      R11, 1, 1
	BRA         L_save_tag41
	NOP
;slides.c,15 :: 		set_5x7();
	CALL        _set_5x7+0, 0
;slides.c,16 :: 		}
L_end_save_tag:
	RETURN      0
; end of _save_tag

_selection:

;slides.c,18 :: 		void selection(char POs)
;slides.c,20 :: 		if (shift_BUT(0)==255)
	CLRF        FARG_shift_but_active+0 
	CALL        _shift_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_selection42
;slides.c,22 :: 		while(shift_BUT(0)==255);
L_selection43:
	CLRF        FARG_shift_but_active+0 
	CALL        _shift_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_selection44
	GOTO        L_selection43
L_selection44:
;slides.c,23 :: 		position++;
	INCF        _position+0, 1 
;slides.c,24 :: 		if (position==POs)
	MOVF        _position+0, 0 
	XORWF       FARG_selection_POs+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_selection45
;slides.c,26 :: 		position=1;
	MOVLW       1
	MOVWF       _position+0 
;slides.c,27 :: 		}
L_selection45:
;slides.c,28 :: 		}
L_selection42:
;slides.c,29 :: 		}
L_end_selection:
	RETURN      0
; end of _selection

_set_up:

;slides.c,31 :: 		void  set_up()
;slides.c,33 :: 		cls();
	CALL        _cls+0, 0
;slides.c,34 :: 		Glcd_Box(0, 0, 127, 8, 0);
	CLRF        FARG_Glcd_Box_x_upper_left+0 
	CLRF        FARG_Glcd_Box_y_upper_left+0 
	MOVLW       127
	MOVWF       FARG_Glcd_Box_x_bottom_right+0 
	MOVLW       8
	MOVWF       FARG_Glcd_Box_y_bottom_right+0 
	CLRF        FARG_Glcd_Box_color+0 
	CALL        _Glcd_Box+0, 0
;slides.c,35 :: 		xGlcd_Set_Font(Arial10x11, 10, 11, 65);
	MOVLW       _Arial10x11+0
	MOVWF       FARG_xGlcd_Set_Font_ptrFontTbl+0 
	MOVLW       hi_addr(_Arial10x11+0)
	MOVWF       FARG_xGlcd_Set_Font_ptrFontTbl+1 
	MOVLW       higher_addr(_Arial10x11+0)
	MOVWF       FARG_xGlcd_Set_Font_ptrFontTbl+2 
	MOVLW       10
	MOVWF       FARG_xGlcd_Set_Font_font_width+0 
	MOVLW       11
	MOVWF       FARG_xGlcd_Set_Font_font_height+0 
	MOVLW       65
	MOVWF       FARG_xGlcd_Set_Font_font_offset+0 
	MOVLW       0
	MOVWF       FARG_xGlcd_Set_Font_font_offset+1 
	CALL        _xGlcd_Set_Font+0, 0
;slides.c,37 :: 		someText ="SETUP";
	MOVLW       ?lstr2_FLOW_32METER+0
	MOVWF       _someText+0 
	MOVLW       hi_addr(?lstr2_FLOW_32METER+0)
	MOVWF       _someText+1 
;slides.c,39 :: 		XGlcd_Write_Text(someText, 42, 0, xColorSET);
	MOVF        _someText+0, 0 
	MOVWF       FARG_xGlcd_Write_Text_text+0 
	MOVF        _someText+1, 0 
	MOVWF       FARG_xGlcd_Write_Text_text+1 
	MOVLW       42
	MOVWF       FARG_xGlcd_Write_Text_x+0 
	CLRF        FARG_xGlcd_Write_Text_y+0 
	MOVLW       1
	MOVWF       FARG_xGlcd_Write_Text_color+0 
	CALL        _xGlcd_Write_Text+0, 0
;slides.c,41 :: 		xGlcd_Set_Font(Tahoma15x24, 15,24,45);
	MOVLW       _Tahoma15x24+0
	MOVWF       FARG_xGlcd_Set_Font_ptrFontTbl+0 
	MOVLW       hi_addr(_Tahoma15x24+0)
	MOVWF       FARG_xGlcd_Set_Font_ptrFontTbl+1 
	MOVLW       higher_addr(_Tahoma15x24+0)
	MOVWF       FARG_xGlcd_Set_Font_ptrFontTbl+2 
	MOVLW       15
	MOVWF       FARG_xGlcd_Set_Font_font_width+0 
	MOVLW       24
	MOVWF       FARG_xGlcd_Set_Font_font_height+0 
	MOVLW       45
	MOVWF       FARG_xGlcd_Set_Font_font_offset+0 
	MOVLW       0
	MOVWF       FARG_xGlcd_Set_Font_font_offset+1 
	CALL        _xGlcd_Set_Font+0, 0
;slides.c,42 :: 		Glcd_Box(0, 0, 127, 9, 2);
	CLRF        FARG_Glcd_Box_x_upper_left+0 
	CLRF        FARG_Glcd_Box_y_upper_left+0 
	MOVLW       127
	MOVWF       FARG_Glcd_Box_x_bottom_right+0 
	MOVLW       9
	MOVWF       FARG_Glcd_Box_y_bottom_right+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Box_color+0 
	CALL        _Glcd_Box+0, 0
;slides.c,44 :: 		}
L_end_set_up:
	RETURN      0
; end of _set_up

_menu1:

;slides.c,45 :: 		void menu1()
;slides.c,47 :: 		set_up();
	CALL        _set_up+0, 0
;slides.c,48 :: 		Glcd_Write_Text("1.RANGE", 12, 2, xColorSet);
	MOVLW       ?lstr3_FLOW_32METER+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr3_FLOW_32METER+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       12
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;slides.c,49 :: 		Glcd_Write_Text("2.UNIT", 12, 3, xColorSet);
	MOVLW       ?lstr4_FLOW_32METER+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr4_FLOW_32METER+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       12
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       3
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;slides.c,50 :: 		Glcd_Write_Text("3.SQRT", 12, 4, xColorSet);
	MOVLW       ?lstr5_FLOW_32METER+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr5_FLOW_32METER+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       12
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;slides.c,51 :: 		Glcd_Write_Text("4.K.FACTOR", 12, 5, xColorSet);
	MOVLW       ?lstr6_FLOW_32METER+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr6_FLOW_32METER+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       12
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       5
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;slides.c,52 :: 		Glcd_Write_Text("5.RESET_TOTALIZER", 12, 6, xColorSet);
	MOVLW       ?lstr7_FLOW_32METER+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr7_FLOW_32METER+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       12
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       6
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;slides.c,53 :: 		}
L_end_menu1:
	RETURN      0
; end of _menu1

_counter_cursor_pos:

;slides.c,56 :: 		void counter_cursor_pos(){
;slides.c,57 :: 		if (scrl_but(0)==255 && tposition==0)
	CLRF        FARG_scrl_but_active+0 
	CALL        _scrl_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_counter_cursor_pos48
	MOVF        _tposition+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_counter_cursor_pos48
L__counter_cursor_pos363:
;slides.c,59 :: 		while(scrl_but(0)==255);
L_counter_cursor_pos49:
	CLRF        FARG_scrl_but_active+0 
	CALL        _scrl_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_counter_cursor_pos50
	GOTO        L_counter_cursor_pos49
L_counter_cursor_pos50:
;slides.c,60 :: 		Glcd_H_Line(70, 101, 40, 0);
	MOVLW       70
	MOVWF       FARG_Glcd_H_Line_x_start+0 
	MOVLW       101
	MOVWF       FARG_Glcd_H_Line_x_end+0 
	MOVLW       40
	MOVWF       FARG_Glcd_H_Line_y_pos+0 
	CLRF        FARG_Glcd_H_Line_color+0 
	CALL        _Glcd_H_Line+0, 0
;slides.c,61 :: 		Glcd_H_Line(70, 70+5, 40, 1);
	MOVLW       70
	MOVWF       FARG_Glcd_H_Line_x_start+0 
	MOVLW       75
	MOVWF       FARG_Glcd_H_Line_x_end+0 
	MOVLW       40
	MOVWF       FARG_Glcd_H_Line_y_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_H_Line_color+0 
	CALL        _Glcd_H_Line+0, 0
;slides.c,67 :: 		position_c=0;
	CLRF        _position_c+0 
;slides.c,68 :: 		tposition=1;
	MOVLW       1
	MOVWF       _tposition+0 
;slides.c,69 :: 		}
	GOTO        L_counter_cursor_pos51
L_counter_cursor_pos48:
;slides.c,70 :: 		else if (scrl_but(0)==255 && tposition==1)
	CLRF        FARG_scrl_but_active+0 
	CALL        _scrl_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_counter_cursor_pos54
	MOVF        _tposition+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_counter_cursor_pos54
L__counter_cursor_pos362:
;slides.c,72 :: 		while(scrl_but(0)==255);
L_counter_cursor_pos55:
	CLRF        FARG_scrl_but_active+0 
	CALL        _scrl_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_counter_cursor_pos56
	GOTO        L_counter_cursor_pos55
L_counter_cursor_pos56:
;slides.c,73 :: 		Glcd_H_Line(70, 101, 40, 0);
	MOVLW       70
	MOVWF       FARG_Glcd_H_Line_x_start+0 
	MOVLW       101
	MOVWF       FARG_Glcd_H_Line_x_end+0 
	MOVLW       40
	MOVWF       FARG_Glcd_H_Line_y_pos+0 
	CLRF        FARG_Glcd_H_Line_color+0 
	CALL        _Glcd_H_Line+0, 0
;slides.c,74 :: 		Glcd_H_Line(78, 78+5, 40, 1);
	MOVLW       78
	MOVWF       FARG_Glcd_H_Line_x_start+0 
	MOVLW       83
	MOVWF       FARG_Glcd_H_Line_x_end+0 
	MOVLW       40
	MOVWF       FARG_Glcd_H_Line_y_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_H_Line_color+0 
	CALL        _Glcd_H_Line+0, 0
;slides.c,80 :: 		position_c=1;
	MOVLW       1
	MOVWF       _position_c+0 
;slides.c,81 :: 		tposition=2;
	MOVLW       2
	MOVWF       _tposition+0 
;slides.c,82 :: 		}
	GOTO        L_counter_cursor_pos57
L_counter_cursor_pos54:
;slides.c,83 :: 		else if (scrl_but(0)==255 && tposition==2)
	CLRF        FARG_scrl_but_active+0 
	CALL        _scrl_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_counter_cursor_pos60
	MOVF        _tposition+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_counter_cursor_pos60
L__counter_cursor_pos361:
;slides.c,85 :: 		while(scrl_but(0)==255);
L_counter_cursor_pos61:
	CLRF        FARG_scrl_but_active+0 
	CALL        _scrl_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_counter_cursor_pos62
	GOTO        L_counter_cursor_pos61
L_counter_cursor_pos62:
;slides.c,86 :: 		Glcd_H_Line(70, 101, 40, 0);
	MOVLW       70
	MOVWF       FARG_Glcd_H_Line_x_start+0 
	MOVLW       101
	MOVWF       FARG_Glcd_H_Line_x_end+0 
	MOVLW       40
	MOVWF       FARG_Glcd_H_Line_y_pos+0 
	CLRF        FARG_Glcd_H_Line_color+0 
	CALL        _Glcd_H_Line+0, 0
;slides.c,87 :: 		Glcd_H_Line(86, 86+5, 40, 1);
	MOVLW       86
	MOVWF       FARG_Glcd_H_Line_x_start+0 
	MOVLW       91
	MOVWF       FARG_Glcd_H_Line_x_end+0 
	MOVLW       40
	MOVWF       FARG_Glcd_H_Line_y_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_H_Line_color+0 
	CALL        _Glcd_H_Line+0, 0
;slides.c,93 :: 		position_c=2;
	MOVLW       2
	MOVWF       _position_c+0 
;slides.c,94 :: 		tposition=3;
	MOVLW       3
	MOVWF       _tposition+0 
;slides.c,95 :: 		}
	GOTO        L_counter_cursor_pos63
L_counter_cursor_pos60:
;slides.c,96 :: 		else if (scrl_but(0)==255 && tposition==3)
	CLRF        FARG_scrl_but_active+0 
	CALL        _scrl_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_counter_cursor_pos66
	MOVF        _tposition+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_counter_cursor_pos66
L__counter_cursor_pos360:
;slides.c,98 :: 		while(scrl_but(0)==255);
L_counter_cursor_pos67:
	CLRF        FARG_scrl_but_active+0 
	CALL        _scrl_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_counter_cursor_pos68
	GOTO        L_counter_cursor_pos67
L_counter_cursor_pos68:
;slides.c,99 :: 		Glcd_H_Line(70, 101, 40, 0);
	MOVLW       70
	MOVWF       FARG_Glcd_H_Line_x_start+0 
	MOVLW       101
	MOVWF       FARG_Glcd_H_Line_x_end+0 
	MOVLW       40
	MOVWF       FARG_Glcd_H_Line_y_pos+0 
	CLRF        FARG_Glcd_H_Line_color+0 
	CALL        _Glcd_H_Line+0, 0
;slides.c,100 :: 		Glcd_H_Line(94, 94+5, 40, 1);
	MOVLW       94
	MOVWF       FARG_Glcd_H_Line_x_start+0 
	MOVLW       99
	MOVWF       FARG_Glcd_H_Line_x_end+0 
	MOVLW       40
	MOVWF       FARG_Glcd_H_Line_y_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_H_Line_color+0 
	CALL        _Glcd_H_Line+0, 0
;slides.c,106 :: 		position_c=3;
	MOVLW       3
	MOVWF       _position_c+0 
;slides.c,107 :: 		tposition=0;
	CLRF        _tposition+0 
;slides.c,108 :: 		}
L_counter_cursor_pos66:
L_counter_cursor_pos63:
L_counter_cursor_pos57:
L_counter_cursor_pos51:
;slides.c,109 :: 		}
L_end_counter_cursor_pos:
	RETURN      0
; end of _counter_cursor_pos

_counter_cursor_pos_low:

;slides.c,111 :: 		void counter_cursor_pos_low(){
;slides.c,112 :: 		if (scrl_but(0)==255 && tposition==0)
	CLRF        FARG_scrl_but_active+0 
	CALL        _scrl_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_counter_cursor_pos_low71
	MOVF        _tposition+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_counter_cursor_pos_low71
L__counter_cursor_pos_low368:
;slides.c,114 :: 		while(scrl_but(0)==255);
L_counter_cursor_pos_low72:
	CLRF        FARG_scrl_but_active+0 
	CALL        _scrl_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_counter_cursor_pos_low73
	GOTO        L_counter_cursor_pos_low72
L_counter_cursor_pos_low73:
;slides.c,115 :: 		Glcd_H_Line(70, 107, 56, 0);
	MOVLW       70
	MOVWF       FARG_Glcd_H_Line_x_start+0 
	MOVLW       107
	MOVWF       FARG_Glcd_H_Line_x_end+0 
	MOVLW       56
	MOVWF       FARG_Glcd_H_Line_y_pos+0 
	CLRF        FARG_Glcd_H_Line_color+0 
	CALL        _Glcd_H_Line+0, 0
;slides.c,116 :: 		Glcd_H_Line(70, 70+5, 56, 1);
	MOVLW       70
	MOVWF       FARG_Glcd_H_Line_x_start+0 
	MOVLW       75
	MOVWF       FARG_Glcd_H_Line_x_end+0 
	MOVLW       56
	MOVWF       FARG_Glcd_H_Line_y_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_H_Line_color+0 
	CALL        _Glcd_H_Line+0, 0
;slides.c,117 :: 		position_c=0;
	CLRF        _position_c+0 
;slides.c,118 :: 		tposition=1;
	MOVLW       1
	MOVWF       _tposition+0 
;slides.c,119 :: 		}
	GOTO        L_counter_cursor_pos_low74
L_counter_cursor_pos_low71:
;slides.c,120 :: 		else if (scrl_but(0)==255 && tposition==1)
	CLRF        FARG_scrl_but_active+0 
	CALL        _scrl_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_counter_cursor_pos_low77
	MOVF        _tposition+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_counter_cursor_pos_low77
L__counter_cursor_pos_low367:
;slides.c,122 :: 		while(scrl_but(0)==255);
L_counter_cursor_pos_low78:
	CLRF        FARG_scrl_but_active+0 
	CALL        _scrl_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_counter_cursor_pos_low79
	GOTO        L_counter_cursor_pos_low78
L_counter_cursor_pos_low79:
;slides.c,123 :: 		Glcd_H_Line(70, 107, 56, 0);
	MOVLW       70
	MOVWF       FARG_Glcd_H_Line_x_start+0 
	MOVLW       107
	MOVWF       FARG_Glcd_H_Line_x_end+0 
	MOVLW       56
	MOVWF       FARG_Glcd_H_Line_y_pos+0 
	CLRF        FARG_Glcd_H_Line_color+0 
	CALL        _Glcd_H_Line+0, 0
;slides.c,124 :: 		Glcd_H_Line(78, 78+5, 56, 1);
	MOVLW       78
	MOVWF       FARG_Glcd_H_Line_x_start+0 
	MOVLW       83
	MOVWF       FARG_Glcd_H_Line_x_end+0 
	MOVLW       56
	MOVWF       FARG_Glcd_H_Line_y_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_H_Line_color+0 
	CALL        _Glcd_H_Line+0, 0
;slides.c,125 :: 		position_c=1;
	MOVLW       1
	MOVWF       _position_c+0 
;slides.c,126 :: 		tposition=2;
	MOVLW       2
	MOVWF       _tposition+0 
;slides.c,127 :: 		}
	GOTO        L_counter_cursor_pos_low80
L_counter_cursor_pos_low77:
;slides.c,128 :: 		else if (scrl_but(0)==255 && tposition==2)
	CLRF        FARG_scrl_but_active+0 
	CALL        _scrl_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_counter_cursor_pos_low83
	MOVF        _tposition+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_counter_cursor_pos_low83
L__counter_cursor_pos_low366:
;slides.c,130 :: 		while(scrl_but(0)==255);
L_counter_cursor_pos_low84:
	CLRF        FARG_scrl_but_active+0 
	CALL        _scrl_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_counter_cursor_pos_low85
	GOTO        L_counter_cursor_pos_low84
L_counter_cursor_pos_low85:
;slides.c,131 :: 		Glcd_H_Line(70, 107, 56, 0);
	MOVLW       70
	MOVWF       FARG_Glcd_H_Line_x_start+0 
	MOVLW       107
	MOVWF       FARG_Glcd_H_Line_x_end+0 
	MOVLW       56
	MOVWF       FARG_Glcd_H_Line_y_pos+0 
	CLRF        FARG_Glcd_H_Line_color+0 
	CALL        _Glcd_H_Line+0, 0
;slides.c,132 :: 		Glcd_H_Line(86, 86+5, 56, 1);
	MOVLW       86
	MOVWF       FARG_Glcd_H_Line_x_start+0 
	MOVLW       91
	MOVWF       FARG_Glcd_H_Line_x_end+0 
	MOVLW       56
	MOVWF       FARG_Glcd_H_Line_y_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_H_Line_color+0 
	CALL        _Glcd_H_Line+0, 0
;slides.c,133 :: 		position_c=2;
	MOVLW       2
	MOVWF       _position_c+0 
;slides.c,134 :: 		tposition=3;
	MOVLW       3
	MOVWF       _tposition+0 
;slides.c,135 :: 		}
	GOTO        L_counter_cursor_pos_low86
L_counter_cursor_pos_low83:
;slides.c,136 :: 		else if (scrl_but(0)==255 && tposition==3)
	CLRF        FARG_scrl_but_active+0 
	CALL        _scrl_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_counter_cursor_pos_low89
	MOVF        _tposition+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_counter_cursor_pos_low89
L__counter_cursor_pos_low365:
;slides.c,138 :: 		while(scrl_but(0)==255);
L_counter_cursor_pos_low90:
	CLRF        FARG_scrl_but_active+0 
	CALL        _scrl_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_counter_cursor_pos_low91
	GOTO        L_counter_cursor_pos_low90
L_counter_cursor_pos_low91:
;slides.c,139 :: 		Glcd_H_Line(70, 107, 56, 0);
	MOVLW       70
	MOVWF       FARG_Glcd_H_Line_x_start+0 
	MOVLW       107
	MOVWF       FARG_Glcd_H_Line_x_end+0 
	MOVLW       56
	MOVWF       FARG_Glcd_H_Line_y_pos+0 
	CLRF        FARG_Glcd_H_Line_color+0 
	CALL        _Glcd_H_Line+0, 0
;slides.c,140 :: 		Glcd_H_Line(94, 94+5, 56, 1);
	MOVLW       94
	MOVWF       FARG_Glcd_H_Line_x_start+0 
	MOVLW       99
	MOVWF       FARG_Glcd_H_Line_x_end+0 
	MOVLW       56
	MOVWF       FARG_Glcd_H_Line_y_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_H_Line_color+0 
	CALL        _Glcd_H_Line+0, 0
;slides.c,141 :: 		position_c=3;
	MOVLW       3
	MOVWF       _position_c+0 
;slides.c,142 :: 		tposition=4;
	MOVLW       4
	MOVWF       _tposition+0 
;slides.c,143 :: 		}
	GOTO        L_counter_cursor_pos_low92
L_counter_cursor_pos_low89:
;slides.c,144 :: 		else if (scrl_but(0)==255 && tposition==4)
	CLRF        FARG_scrl_but_active+0 
	CALL        _scrl_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_counter_cursor_pos_low95
	MOVF        _tposition+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_counter_cursor_pos_low95
L__counter_cursor_pos_low364:
;slides.c,146 :: 		while(scrl_but(0)==255);
L_counter_cursor_pos_low96:
	CLRF        FARG_scrl_but_active+0 
	CALL        _scrl_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_counter_cursor_pos_low97
	GOTO        L_counter_cursor_pos_low96
L_counter_cursor_pos_low97:
;slides.c,147 :: 		Glcd_H_Line(70, 107, 56, 0);
	MOVLW       70
	MOVWF       FARG_Glcd_H_Line_x_start+0 
	MOVLW       107
	MOVWF       FARG_Glcd_H_Line_x_end+0 
	MOVLW       56
	MOVWF       FARG_Glcd_H_Line_y_pos+0 
	CLRF        FARG_Glcd_H_Line_color+0 
	CALL        _Glcd_H_Line+0, 0
;slides.c,148 :: 		Glcd_H_Line(102, 102+5, 56, 1);
	MOVLW       102
	MOVWF       FARG_Glcd_H_Line_x_start+0 
	MOVLW       107
	MOVWF       FARG_Glcd_H_Line_x_end+0 
	MOVLW       56
	MOVWF       FARG_Glcd_H_Line_y_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_H_Line_color+0 
	CALL        _Glcd_H_Line+0, 0
;slides.c,149 :: 		position_c=4;
	MOVLW       4
	MOVWF       _position_c+0 
;slides.c,150 :: 		tposition=0;
	CLRF        _tposition+0 
;slides.c,151 :: 		}
L_counter_cursor_pos_low95:
L_counter_cursor_pos_low92:
L_counter_cursor_pos_low86:
L_counter_cursor_pos_low80:
L_counter_cursor_pos_low74:
;slides.c,152 :: 		}
L_end_counter_cursor_pos_low:
	RETURN      0
; end of _counter_cursor_pos_low

_counter_cursor_pos_REST:

;slides.c,192 :: 		void counter_cursor_pos_REST(){
;slides.c,193 :: 		if (scrl_but(0)==255 && tposition==0)
	CLRF        FARG_scrl_but_active+0 
	CALL        _scrl_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_counter_cursor_pos_REST100
	MOVF        _tposition+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_counter_cursor_pos_REST100
L__counter_cursor_pos_REST370:
;slides.c,195 :: 		while(scrl_but(0)==255);
L_counter_cursor_pos_REST101:
	CLRF        FARG_scrl_but_active+0 
	CALL        _scrl_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_counter_cursor_pos_REST102
	GOTO        L_counter_cursor_pos_REST101
L_counter_cursor_pos_REST102:
;slides.c,196 :: 		Glcd_H_Line(65, 100, 40, 0);
	MOVLW       65
	MOVWF       FARG_Glcd_H_Line_x_start+0 
	MOVLW       100
	MOVWF       FARG_Glcd_H_Line_x_end+0 
	MOVLW       40
	MOVWF       FARG_Glcd_H_Line_y_pos+0 
	CLRF        FARG_Glcd_H_Line_color+0 
	CALL        _Glcd_H_Line+0, 0
;slides.c,197 :: 		Glcd_H_Line(70, 70+5, 40, 1);
	MOVLW       70
	MOVWF       FARG_Glcd_H_Line_x_start+0 
	MOVLW       75
	MOVWF       FARG_Glcd_H_Line_x_end+0 
	MOVLW       40
	MOVWF       FARG_Glcd_H_Line_y_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_H_Line_color+0 
	CALL        _Glcd_H_Line+0, 0
;slides.c,198 :: 		position_c=0;
	CLRF        _position_c+0 
;slides.c,199 :: 		tposition=1;
	MOVLW       1
	MOVWF       _tposition+0 
;slides.c,200 :: 		}
	GOTO        L_counter_cursor_pos_REST103
L_counter_cursor_pos_REST100:
;slides.c,201 :: 		else if (scrl_but(0)==255 && tposition==1)
	CLRF        FARG_scrl_but_active+0 
	CALL        _scrl_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_counter_cursor_pos_REST106
	MOVF        _tposition+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_counter_cursor_pos_REST106
L__counter_cursor_pos_REST369:
;slides.c,203 :: 		while(scrl_but(0)==255);
L_counter_cursor_pos_REST107:
	CLRF        FARG_scrl_but_active+0 
	CALL        _scrl_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_counter_cursor_pos_REST108
	GOTO        L_counter_cursor_pos_REST107
L_counter_cursor_pos_REST108:
;slides.c,204 :: 		Glcd_H_Line(65, 100, 40, 0);
	MOVLW       65
	MOVWF       FARG_Glcd_H_Line_x_start+0 
	MOVLW       100
	MOVWF       FARG_Glcd_H_Line_x_end+0 
	MOVLW       40
	MOVWF       FARG_Glcd_H_Line_y_pos+0 
	CLRF        FARG_Glcd_H_Line_color+0 
	CALL        _Glcd_H_Line+0, 0
;slides.c,205 :: 		Glcd_H_Line(86, 86+5, 40, 1);
	MOVLW       86
	MOVWF       FARG_Glcd_H_Line_x_start+0 
	MOVLW       91
	MOVWF       FARG_Glcd_H_Line_x_end+0 
	MOVLW       40
	MOVWF       FARG_Glcd_H_Line_y_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_H_Line_color+0 
	CALL        _Glcd_H_Line+0, 0
;slides.c,206 :: 		position_c=2;
	MOVLW       2
	MOVWF       _position_c+0 
;slides.c,207 :: 		tposition=0;
	CLRF        _tposition+0 
;slides.c,208 :: 		}
L_counter_cursor_pos_REST106:
L_counter_cursor_pos_REST103:
;slides.c,209 :: 		}
L_end_counter_cursor_pos_REST:
	RETURN      0
; end of _counter_cursor_pos_REST

_unit_set:

;slides.c,214 :: 		void unit_set()
;slides.c,216 :: 		set_up();
	CALL        _set_up+0, 0
;slides.c,217 :: 		Glcd_Box(28,14 , 102, 24, 1);
	MOVLW       28
	MOVWF       FARG_Glcd_Box_x_upper_left+0 
	MOVLW       14
	MOVWF       FARG_Glcd_Box_y_upper_left+0 
	MOVLW       102
	MOVWF       FARG_Glcd_Box_x_bottom_right+0 
	MOVLW       24
	MOVWF       FARG_Glcd_Box_y_bottom_right+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Box_color+0 
	CALL        _Glcd_Box+0, 0
;slides.c,218 :: 		Glcd_Write_Text("UNIT SETTING", 30, 2, xColorinvert);
	MOVLW       ?lstr8_FLOW_32METER+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr8_FLOW_32METER+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       30
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;slides.c,220 :: 		Glcd_Rectangle(8, 29, 35, 41, 1);
	MOVLW       8
	MOVWF       FARG_Glcd_Rectangle_x_upper_left+0 
	MOVLW       29
	MOVWF       FARG_Glcd_Rectangle_y_upper_left+0 
	MOVLW       35
	MOVWF       FARG_Glcd_Rectangle_x_bottom_right+0 
	MOVLW       41
	MOVWF       FARG_Glcd_Rectangle_y_bottom_right+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Rectangle_color+0 
	CALL        _Glcd_Rectangle+0, 0
;slides.c,221 :: 		NUMBER_UNIT  = EEPROM_Read(15);
	MOVLW       15
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _NUMBER_UNIT+0 
;slides.c,222 :: 		delay_ms(100);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_unit_set109:
	DECFSZ      R13, 1, 1
	BRA         L_unit_set109
	DECFSZ      R12, 1, 1
	BRA         L_unit_set109
	DECFSZ      R11, 1, 1
	BRA         L_unit_set109
;slides.c,223 :: 		if (NUMBER_UNIT==1) Glcd_Write_Text("kg/h", 10, 4, xColorSet);
	MOVF        _NUMBER_UNIT+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_unit_set110
	MOVLW       ?lstr9_FLOW_32METER+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr9_FLOW_32METER+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       10
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
L_unit_set110:
;slides.c,224 :: 		if (NUMBER_UNIT==2) Glcd_Write_Text("m3/h", 10, 4, xColorSet);
	MOVF        _NUMBER_UNIT+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_unit_set111
	MOVLW       ?lstr10_FLOW_32METER+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr10_FLOW_32METER+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       10
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
L_unit_set111:
;slides.c,225 :: 		if (NUMBER_UNIT==3) Glcd_Write_Text("TPH", 10, 4, xColorSet);
	MOVF        _NUMBER_UNIT+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_unit_set112
	MOVLW       ?lstr11_FLOW_32METER+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr11_FLOW_32METER+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       10
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
L_unit_set112:
;slides.c,228 :: 		while(set_but(0)==0)
L_unit_set113:
	CLRF        FARG_set_but_active+0 
	CALL        _set_but+0, 0
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_unit_set114
;slides.c,230 :: 		if (shift_but(0)==255)
	CLRF        FARG_shift_but_active+0 
	CALL        _shift_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_unit_set115
;slides.c,232 :: 		while(shift_but(0)==255);
L_unit_set116:
	CLRF        FARG_shift_but_active+0 
	CALL        _shift_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_unit_set117
	GOTO        L_unit_set116
L_unit_set117:
;slides.c,233 :: 		NUMBER_UNIT++;
	INCF        _NUMBER_UNIT+0, 1 
;slides.c,234 :: 		if (NUMBER_UNIT>=4)
	MOVLW       4
	SUBWF       _NUMBER_UNIT+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_unit_set118
;slides.c,236 :: 		NUMBER_UNIT=1;
	MOVLW       1
	MOVWF       _NUMBER_UNIT+0 
;slides.c,237 :: 		}
L_unit_set118:
;slides.c,238 :: 		if (NUMBER_UNIT==1)
	MOVF        _NUMBER_UNIT+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_unit_set119
;slides.c,240 :: 		Glcd_Write_Text("TPH ", 10, 4, xColorclear);
	MOVLW       ?lstr12_FLOW_32METER+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr12_FLOW_32METER+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       10
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	CLRF        FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;slides.c,241 :: 		Glcd_Write_Text("kg/h", 10, 4, xColorSet);
	MOVLW       ?lstr13_FLOW_32METER+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr13_FLOW_32METER+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       10
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;slides.c,242 :: 		}
	GOTO        L_unit_set120
L_unit_set119:
;slides.c,243 :: 		else if (NUMBER_UNIT==2)
	MOVF        _NUMBER_UNIT+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_unit_set121
;slides.c,245 :: 		Glcd_Write_Text("kg/h", 10, 4, xColorclear);
	MOVLW       ?lstr14_FLOW_32METER+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr14_FLOW_32METER+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       10
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	CLRF        FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;slides.c,246 :: 		Glcd_Write_Text("m3/h", 10, 4, xColorSet);
	MOVLW       ?lstr15_FLOW_32METER+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr15_FLOW_32METER+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       10
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;slides.c,247 :: 		}
	GOTO        L_unit_set122
L_unit_set121:
;slides.c,248 :: 		else if (NUMBER_UNIT==3)
	MOVF        _NUMBER_UNIT+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_unit_set123
;slides.c,250 :: 		Glcd_Write_Text("m3/h", 10, 4, xColorclear);
	MOVLW       ?lstr16_FLOW_32METER+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr16_FLOW_32METER+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       10
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	CLRF        FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;slides.c,251 :: 		Glcd_Write_Text("TPH ", 10, 4, xColorSet);
	MOVLW       ?lstr17_FLOW_32METER+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr17_FLOW_32METER+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       10
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;slides.c,252 :: 		}
L_unit_set123:
L_unit_set122:
L_unit_set120:
;slides.c,253 :: 		}
L_unit_set115:
;slides.c,254 :: 		}
	GOTO        L_unit_set113
L_unit_set114:
;slides.c,255 :: 		EEPROM_Write(15,NUMBER_UNIT);
	MOVLW       15
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _NUMBER_UNIT+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;slides.c,256 :: 		delay_ms(10);
	MOVLW       104
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_unit_set124:
	DECFSZ      R13, 1, 1
	BRA         L_unit_set124
	DECFSZ      R12, 1, 1
	BRA         L_unit_set124
	NOP
;slides.c,257 :: 		save_tag();
	CALL        _save_tag+0, 0
;slides.c,258 :: 		while(set_but(0)==255);
L_unit_set125:
	CLRF        FARG_set_but_active+0 
	CALL        _set_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_unit_set126
	GOTO        L_unit_set125
L_unit_set126:
;slides.c,259 :: 		menu1();
	CALL        _menu1+0, 0
;slides.c,260 :: 		}
L_end_unit_set:
	RETURN      0
; end of _unit_set

_sqrt_set:

;slides.c,264 :: 		void sqrt_set()
;slides.c,266 :: 		set_up();
	CALL        _set_up+0, 0
;slides.c,267 :: 		Glcd_Box(28,14 , 102, 24, 1);
	MOVLW       28
	MOVWF       FARG_Glcd_Box_x_upper_left+0 
	MOVLW       14
	MOVWF       FARG_Glcd_Box_y_upper_left+0 
	MOVLW       102
	MOVWF       FARG_Glcd_Box_x_bottom_right+0 
	MOVLW       24
	MOVWF       FARG_Glcd_Box_y_bottom_right+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Box_color+0 
	CALL        _Glcd_Box+0, 0
;slides.c,268 :: 		Glcd_Write_Text("SQRT SETTING", 30, 2, xColorinvert);
	MOVLW       ?lstr18_FLOW_32METER+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr18_FLOW_32METER+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       30
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;slides.c,270 :: 		Glcd_Rectangle(8, 29, 30, 41, 1);
	MOVLW       8
	MOVWF       FARG_Glcd_Rectangle_x_upper_left+0 
	MOVLW       29
	MOVWF       FARG_Glcd_Rectangle_y_upper_left+0 
	MOVLW       30
	MOVWF       FARG_Glcd_Rectangle_x_bottom_right+0 
	MOVLW       41
	MOVWF       FARG_Glcd_Rectangle_y_bottom_right+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Rectangle_color+0 
	CALL        _Glcd_Rectangle+0, 0
;slides.c,271 :: 		sqrt_UNIT  = EEPROM_Read(14);
	MOVLW       14
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sqrt_UNIT+0 
;slides.c,272 :: 		delay_ms(100);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_sqrt_set127:
	DECFSZ      R13, 1, 1
	BRA         L_sqrt_set127
	DECFSZ      R12, 1, 1
	BRA         L_sqrt_set127
	DECFSZ      R11, 1, 1
	BRA         L_sqrt_set127
;slides.c,273 :: 		if (sqrt_UNIT==1) Glcd_Write_Text("NO ", 10, 4, xColorSet);
	MOVF        _sqrt_UNIT+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_sqrt_set128
	MOVLW       ?lstr19_FLOW_32METER+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr19_FLOW_32METER+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       10
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
L_sqrt_set128:
;slides.c,274 :: 		if (sqrt_UNIT==2) Glcd_Write_Text("YES", 10, 4, xColorSet);
	MOVF        _sqrt_UNIT+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_sqrt_set129
	MOVLW       ?lstr20_FLOW_32METER+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr20_FLOW_32METER+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       10
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
L_sqrt_set129:
;slides.c,275 :: 		while(set_but(0)==0)
L_sqrt_set130:
	CLRF        FARG_set_but_active+0 
	CALL        _set_but+0, 0
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_sqrt_set131
;slides.c,277 :: 		if (shift_but(0)==255)
	CLRF        FARG_shift_but_active+0 
	CALL        _shift_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_sqrt_set132
;slides.c,279 :: 		while(shift_but(0)==255);
L_sqrt_set133:
	CLRF        FARG_shift_but_active+0 
	CALL        _shift_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_sqrt_set134
	GOTO        L_sqrt_set133
L_sqrt_set134:
;slides.c,280 :: 		sqrt_UNIT++;
	INCF        _sqrt_UNIT+0, 1 
;slides.c,281 :: 		if (sqrt_UNIT>=3)
	MOVLW       3
	SUBWF       _sqrt_UNIT+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_sqrt_set135
;slides.c,283 :: 		sqrt_UNIT=1;
	MOVLW       1
	MOVWF       _sqrt_UNIT+0 
;slides.c,284 :: 		}
L_sqrt_set135:
;slides.c,285 :: 		if (sqrt_UNIT==1)
	MOVF        _sqrt_UNIT+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_sqrt_set136
;slides.c,287 :: 		Glcd_Write_Text("YES", 10, 4, xColorclear);
	MOVLW       ?lstr21_FLOW_32METER+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr21_FLOW_32METER+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       10
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	CLRF        FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;slides.c,288 :: 		Glcd_Write_Text("NO ", 10, 4, xColorSet);
	MOVLW       ?lstr22_FLOW_32METER+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr22_FLOW_32METER+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       10
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;slides.c,289 :: 		}
	GOTO        L_sqrt_set137
L_sqrt_set136:
;slides.c,290 :: 		else if (sqrt_UNIT==2)
	MOVF        _sqrt_UNIT+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_sqrt_set138
;slides.c,292 :: 		Glcd_Write_Text("NO ", 10, 4, xColorclear);
	MOVLW       ?lstr23_FLOW_32METER+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr23_FLOW_32METER+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       10
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	CLRF        FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;slides.c,293 :: 		Glcd_Write_Text("YES", 10, 4, xColorSet);
	MOVLW       ?lstr24_FLOW_32METER+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr24_FLOW_32METER+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       10
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;slides.c,294 :: 		}
L_sqrt_set138:
L_sqrt_set137:
;slides.c,295 :: 		}
L_sqrt_set132:
;slides.c,296 :: 		}
	GOTO        L_sqrt_set130
L_sqrt_set131:
;slides.c,297 :: 		EEPROM_Write(14,sqrt_UNIT);
	MOVLW       14
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _sqrt_UNIT+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;slides.c,298 :: 		save_tag();
	CALL        _save_tag+0, 0
;slides.c,299 :: 		while(set_but(0)==255);
L_sqrt_set139:
	CLRF        FARG_set_but_active+0 
	CALL        _set_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_sqrt_set140
	GOTO        L_sqrt_set139
L_sqrt_set140:
;slides.c,300 :: 		menu1();
	CALL        _menu1+0, 0
;slides.c,301 :: 		}
L_end_sqrt_set:
	RETURN      0
; end of _sqrt_set

_current_digit_change:

;slides.c,306 :: 		void current_digit_change(char lcd_pos, char page_nu)
;slides.c,308 :: 		if (shift_but(0)==255)
	CLRF        FARG_shift_but_active+0 
	CALL        _shift_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_current_digit_change141
;slides.c,311 :: 		txt[position_c]++;
	MOVLW       _txt+0
	MOVWF       R1 
	MOVLW       hi_addr(_txt+0)
	MOVWF       R2 
	MOVF        _position_c+0, 0 
	ADDWF       R1, 1 
	BTFSC       STATUS+0, 0 
	INCF        R2, 1 
	MOVFF       R1, FSR0
	MOVFF       R2, FSR0H
	MOVF        POSTINC0+0, 0 
	ADDLW       1
	MOVWF       R0 
	MOVFF       R1, FSR1
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;slides.c,312 :: 		if (txt[position_c]>9)
	MOVLW       _txt+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FSR0H 
	MOVF        _position_c+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	SUBLW       9
	BTFSC       STATUS+0, 0 
	GOTO        L_current_digit_change142
;slides.c,314 :: 		txt[position_c]=0;
	MOVLW       _txt+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FSR1H 
	MOVF        _position_c+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
;slides.c,315 :: 		}
L_current_digit_change142:
;slides.c,316 :: 		if (lcd_pos==70 && page_nu==6)
	MOVF        FARG_current_digit_change_lcd_pos+0, 0 
	XORLW       70
	BTFSS       STATUS+0, 2 
	GOTO        L_current_digit_change145
	MOVF        FARG_current_digit_change_page_nu+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_current_digit_change145
L__current_digit_change372:
;slides.c,318 :: 		if (txt[position_c]>6)
	MOVLW       _txt+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FSR0H 
	MOVF        _position_c+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	SUBLW       6
	BTFSC       STATUS+0, 0 
	GOTO        L_current_digit_change146
;slides.c,320 :: 		txt[position_c]=0;
	MOVLW       _txt+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FSR1H 
	MOVF        _position_c+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
;slides.c,327 :: 		}
L_current_digit_change146:
;slides.c,328 :: 		if (txt[position_c]==6)
	MOVLW       _txt+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FSR0H 
	MOVF        _position_c+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_current_digit_change147
;slides.c,331 :: 		if (txt[1]>4)
	MOVF        _txt+1, 0 
	SUBLW       4
	BTFSC       STATUS+0, 0 
	GOTO        L_current_digit_change148
;slides.c,333 :: 		txt[1]=4;
	MOVLW       4
	MOVWF       _txt+1 
;slides.c,334 :: 		}
L_current_digit_change148:
;slides.c,336 :: 		}
L_current_digit_change147:
;slides.c,337 :: 		}
L_current_digit_change145:
;slides.c,338 :: 		if (txt[0]==6 && lcd_pos==78 && page_nu==6)
	MOVF        _txt+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_current_digit_change151
	MOVF        FARG_current_digit_change_lcd_pos+0, 0 
	XORLW       78
	BTFSS       STATUS+0, 2 
	GOTO        L_current_digit_change151
	MOVF        FARG_current_digit_change_page_nu+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_current_digit_change151
L__current_digit_change371:
;slides.c,340 :: 		if (txt[position_c]>4) txt[position_c]=0;
	MOVLW       _txt+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FSR0H 
	MOVF        _position_c+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	SUBLW       4
	BTFSC       STATUS+0, 0 
	GOTO        L_current_digit_change152
	MOVLW       _txt+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FSR1H 
	MOVF        _position_c+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
L_current_digit_change152:
;slides.c,341 :: 		}
L_current_digit_change151:
;slides.c,342 :: 		ii=txt[position_c] + '0';
	MOVLW       _txt+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FSR0H 
	MOVF        _position_c+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVLW       48
	ADDWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _ii+0 
;slides.c,343 :: 		Glcd_Write_char(ii, lcd_pos, page_nu, 1);
	MOVF        R0, 0 
	MOVWF       FARG_Glcd_Write_Char_chr+0 
	MOVF        FARG_current_digit_change_lcd_pos+0, 0 
	MOVWF       FARG_Glcd_Write_Char_x_pos+0 
	MOVF        FARG_current_digit_change_page_nu+0, 0 
	MOVWF       FARG_Glcd_Write_Char_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Char_color+0 
	CALL        _Glcd_Write_Char+0, 0
;slides.c,344 :: 		}
L_current_digit_change141:
;slides.c,345 :: 		}
L_end_current_digit_change:
	RETURN      0
; end of _current_digit_change

_compress_data:

;slides.c,348 :: 		void compress_data()
;slides.c,350 :: 		FC1=(txt[0]*10000);
	MOVF        _txt+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       16
	MOVWF       R4 
	MOVLW       39
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _fc1+0 
	MOVF        R1, 0 
	MOVWF       _fc1+1 
;slides.c,351 :: 		FC2=(txt[1]*1000);
	MOVF        _txt+1, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _fc2+0 
	MOVF        R1, 0 
	MOVWF       _fc2+1 
;slides.c,352 :: 		FC3=(txt[2]*100);
	MOVLW       100
	MULWF       _txt+2 
	MOVF        PRODL+0, 0 
	MOVWF       _fc3+0 
	MOVF        PRODH+0, 0 
	MOVWF       _fc3+1 
;slides.c,353 :: 		FC4=(txt[3]*10);
	MOVLW       10
	MULWF       _txt+3 
	MOVF        PRODL+0, 0 
	MOVWF       _fc4+0 
	MOVF        PRODH+0, 0 
	MOVWF       _fc4+1 
;slides.c,354 :: 		FC5=(txt[4]*1);
	MOVF        _txt+4, 0 
	MOVWF       _FC5+0 
	MOVLW       0
	MOVWF       _FC5+1 
;slides.c,355 :: 		}
L_end_compress_data:
	RETURN      0
; end of _compress_data

_counter_cursor_pos_2:

;slides.c,358 :: 		void counter_cursor_pos_2(){
;slides.c,359 :: 		if (scrl_but(0)==255 && tposition==0)
	CLRF        FARG_scrl_but_active+0 
	CALL        _scrl_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_counter_cursor_pos_2155
	MOVF        _tposition+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_counter_cursor_pos_2155
L__counter_cursor_pos_2375:
;slides.c,361 :: 		while(scrl_but(0)==255);
L_counter_cursor_pos_2156:
	CLRF        FARG_scrl_but_active+0 
	CALL        _scrl_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_counter_cursor_pos_2157
	GOTO        L_counter_cursor_pos_2156
L_counter_cursor_pos_2157:
;slides.c,364 :: 		Glcd_H_Line(70, 100, 40, 0);
	MOVLW       70
	MOVWF       FARG_Glcd_H_Line_x_start+0 
	MOVLW       100
	MOVWF       FARG_Glcd_H_Line_x_end+0 
	MOVLW       40
	MOVWF       FARG_Glcd_H_Line_y_pos+0 
	CLRF        FARG_Glcd_H_Line_color+0 
	CALL        _Glcd_H_Line+0, 0
;slides.c,365 :: 		Glcd_H_Line(70, 70+4, 40, 1);
	MOVLW       70
	MOVWF       FARG_Glcd_H_Line_x_start+0 
	MOVLW       74
	MOVWF       FARG_Glcd_H_Line_x_end+0 
	MOVLW       40
	MOVWF       FARG_Glcd_H_Line_y_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_H_Line_color+0 
	CALL        _Glcd_H_Line+0, 0
;slides.c,366 :: 		position_c=0;
	CLRF        _position_c+0 
;slides.c,367 :: 		tposition=1;
	MOVLW       1
	MOVWF       _tposition+0 
;slides.c,368 :: 		}
	GOTO        L_counter_cursor_pos_2158
L_counter_cursor_pos_2155:
;slides.c,370 :: 		else if (scrl_but(0)==255 && tposition==1)
	CLRF        FARG_scrl_but_active+0 
	CALL        _scrl_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_counter_cursor_pos_2161
	MOVF        _tposition+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_counter_cursor_pos_2161
L__counter_cursor_pos_2374:
;slides.c,372 :: 		while(scrl_but(0)==255);
L_counter_cursor_pos_2162:
	CLRF        FARG_scrl_but_active+0 
	CALL        _scrl_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_counter_cursor_pos_2163
	GOTO        L_counter_cursor_pos_2162
L_counter_cursor_pos_2163:
;slides.c,375 :: 		Glcd_H_Line(70, 100, 40, 0);
	MOVLW       70
	MOVWF       FARG_Glcd_H_Line_x_start+0 
	MOVLW       100
	MOVWF       FARG_Glcd_H_Line_x_end+0 
	MOVLW       40
	MOVWF       FARG_Glcd_H_Line_y_pos+0 
	CLRF        FARG_Glcd_H_Line_color+0 
	CALL        _Glcd_H_Line+0, 0
;slides.c,376 :: 		Glcd_H_Line(86, 86+4, 40, 1);
	MOVLW       86
	MOVWF       FARG_Glcd_H_Line_x_start+0 
	MOVLW       90
	MOVWF       FARG_Glcd_H_Line_x_end+0 
	MOVLW       40
	MOVWF       FARG_Glcd_H_Line_y_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_H_Line_color+0 
	CALL        _Glcd_H_Line+0, 0
;slides.c,377 :: 		position_c=2;
	MOVLW       2
	MOVWF       _position_c+0 
;slides.c,378 :: 		tposition=2;
	MOVLW       2
	MOVWF       _tposition+0 
;slides.c,379 :: 		}
L_counter_cursor_pos_2161:
L_counter_cursor_pos_2158:
;slides.c,381 :: 		if (scrl_but(0)==255 && tposition==2)
	CLRF        FARG_scrl_but_active+0 
	CALL        _scrl_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_counter_cursor_pos_2166
	MOVF        _tposition+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_counter_cursor_pos_2166
L__counter_cursor_pos_2373:
;slides.c,383 :: 		while(scrl_but(0)==255);
L_counter_cursor_pos_2167:
	CLRF        FARG_scrl_but_active+0 
	CALL        _scrl_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_counter_cursor_pos_2168
	GOTO        L_counter_cursor_pos_2167
L_counter_cursor_pos_2168:
;slides.c,386 :: 		Glcd_H_Line(70, 100, 40, 0);
	MOVLW       70
	MOVWF       FARG_Glcd_H_Line_x_start+0 
	MOVLW       100
	MOVWF       FARG_Glcd_H_Line_x_end+0 
	MOVLW       40
	MOVWF       FARG_Glcd_H_Line_y_pos+0 
	CLRF        FARG_Glcd_H_Line_color+0 
	CALL        _Glcd_H_Line+0, 0
;slides.c,387 :: 		Glcd_H_Line(94, 94+5, 40, 1);
	MOVLW       94
	MOVWF       FARG_Glcd_H_Line_x_start+0 
	MOVLW       99
	MOVWF       FARG_Glcd_H_Line_x_end+0 
	MOVLW       40
	MOVWF       FARG_Glcd_H_Line_y_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_H_Line_color+0 
	CALL        _Glcd_H_Line+0, 0
;slides.c,388 :: 		position_c=3;
	MOVLW       3
	MOVWF       _position_c+0 
;slides.c,389 :: 		tposition=0;
	CLRF        _tposition+0 
;slides.c,390 :: 		}
L_counter_cursor_pos_2166:
;slides.c,391 :: 		}
L_end_counter_cursor_pos_2:
	RETURN      0
; end of _counter_cursor_pos_2

_K_settong:

;slides.c,396 :: 		void K_settong()
;slides.c,398 :: 		set_up();
	CALL        _set_up+0, 0
;slides.c,399 :: 		Glcd_Box(23,14 , 122, 24, 1);
	MOVLW       23
	MOVWF       FARG_Glcd_Box_x_upper_left+0 
	MOVLW       14
	MOVWF       FARG_Glcd_Box_y_upper_left+0 
	MOVLW       122
	MOVWF       FARG_Glcd_Box_x_bottom_right+0 
	MOVLW       24
	MOVWF       FARG_Glcd_Box_y_bottom_right+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Box_color+0 
	CALL        _Glcd_Box+0, 0
;slides.c,400 :: 		Glcd_Write_Text("K.FACTOR SETTING", 25, 2, xColorinvert);
	MOVLW       ?lstr25_FLOW_32METER+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr25_FLOW_32METER+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       25
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;slides.c,401 :: 		Glcd_Write_Text("K.FACTOR", 5, 4, xColorSet);
	MOVLW       ?lstr26_FLOW_32METER+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr26_FLOW_32METER+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       5
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;slides.c,402 :: 		Glcd_Write_Text("min 0.01 and max 1.99", 1, 6, xColorSet);
	MOVLW       ?lstr27_FLOW_32METER+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr27_FLOW_32METER+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       6
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;slides.c,404 :: 		KVALUE=EEPROM_Read(16);
	MOVLW       16
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _KVALUE+0 
	MOVLW       0
	MOVWF       _KVALUE+1 
;slides.c,406 :: 		txt[0]=(KVALUE/100)%10;
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _KVALUE+0, 0 
	MOVWF       R0 
	MOVF        _KVALUE+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _txt+0 
;slides.c,407 :: 		txt[2]=(KVALUE/10)%10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _KVALUE+0, 0 
	MOVWF       R0 
	MOVF        _KVALUE+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _txt+2 
;slides.c,408 :: 		txt[3]=(KVALUE/1)%10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _KVALUE+0, 0 
	MOVWF       R0 
	MOVF        _KVALUE+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _txt+3 
;slides.c,410 :: 		Glcd_Write_char(txt[0]+'0', 70, 4, xColorSet);
	MOVLW       48
	ADDWF       _txt+0, 0 
	MOVWF       FARG_Glcd_Write_Char_chr+0 
	MOVLW       70
	MOVWF       FARG_Glcd_Write_Char_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Char_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Char_color+0 
	CALL        _Glcd_Write_Char+0, 0
;slides.c,411 :: 		Glcd_Write_char('.', 78, 4, xColorSet);
	MOVLW       46
	MOVWF       FARG_Glcd_Write_Char_chr+0 
	MOVLW       78
	MOVWF       FARG_Glcd_Write_Char_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Char_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Char_color+0 
	CALL        _Glcd_Write_Char+0, 0
;slides.c,412 :: 		Glcd_Write_char(txt[2]+'0', 86, 4, xColorSet);
	MOVLW       48
	ADDWF       _txt+2, 0 
	MOVWF       FARG_Glcd_Write_Char_chr+0 
	MOVLW       86
	MOVWF       FARG_Glcd_Write_Char_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Char_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Char_color+0 
	CALL        _Glcd_Write_Char+0, 0
;slides.c,413 :: 		Glcd_Write_char(txt[3]+'0', 94, 4, xColorSet);
	MOVLW       48
	ADDWF       _txt+3, 0 
	MOVWF       FARG_Glcd_Write_Char_chr+0 
	MOVLW       94
	MOVWF       FARG_Glcd_Write_Char_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Char_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Char_color+0 
	CALL        _Glcd_Write_Char+0, 0
;slides.c,415 :: 		Glcd_Rectangle(68, 30, 101, 42, 1);
	MOVLW       68
	MOVWF       FARG_Glcd_Rectangle_x_upper_left+0 
	MOVLW       30
	MOVWF       FARG_Glcd_Rectangle_y_upper_left+0 
	MOVLW       101
	MOVWF       FARG_Glcd_Rectangle_x_bottom_right+0 
	MOVLW       42
	MOVWF       FARG_Glcd_Rectangle_y_bottom_right+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Rectangle_color+0 
	CALL        _Glcd_Rectangle+0, 0
;slides.c,417 :: 		tposition=1,position_c=0;
	MOVLW       1
	MOVWF       _tposition+0 
	CLRF        _position_c+0 
;slides.c,419 :: 		Glcd_H_Line(70, 70+4, 40, 1);
	MOVLW       70
	MOVWF       FARG_Glcd_H_Line_x_start+0 
	MOVLW       74
	MOVWF       FARG_Glcd_H_Line_x_end+0 
	MOVLW       40
	MOVWF       FARG_Glcd_H_Line_y_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_H_Line_color+0 
	CALL        _Glcd_H_Line+0, 0
;slides.c,422 :: 		while(1)
L_K_settong169:
;slides.c,424 :: 		if      (position_c==0)  current_digit_change(70,4);
	MOVF        _position_c+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_K_settong171
	MOVLW       70
	MOVWF       FARG_current_digit_change_lcd_pos+0 
	MOVLW       4
	MOVWF       FARG_current_digit_change_page_nu+0 
	CALL        _current_digit_change+0, 0
	GOTO        L_K_settong172
L_K_settong171:
;slides.c,425 :: 		else if (position_c==2)  current_digit_change(86,4);
	MOVF        _position_c+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_K_settong173
	MOVLW       86
	MOVWF       FARG_current_digit_change_lcd_pos+0 
	MOVLW       4
	MOVWF       FARG_current_digit_change_page_nu+0 
	CALL        _current_digit_change+0, 0
	GOTO        L_K_settong174
L_K_settong173:
;slides.c,426 :: 		else if (position_c==3)  current_digit_change(94,4);
	MOVF        _position_c+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_K_settong175
	MOVLW       94
	MOVWF       FARG_current_digit_change_lcd_pos+0 
	MOVLW       4
	MOVWF       FARG_current_digit_change_page_nu+0 
	CALL        _current_digit_change+0, 0
L_K_settong175:
L_K_settong174:
L_K_settong172:
;slides.c,431 :: 		counter_cursor_pos_2();
	CALL        _counter_cursor_pos_2+0, 0
;slides.c,433 :: 		if (set_but(0)==255)
	CLRF        FARG_set_but_active+0 
	CALL        _set_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_K_settong176
;slides.c,435 :: 		KVALUE=(txt[0]*100);
	MOVLW       100
	MULWF       _txt+0 
	MOVF        PRODL+0, 0 
	MOVWF       _KVALUE+0 
	MOVF        PRODH+0, 0 
	MOVWF       _KVALUE+1 
;slides.c,436 :: 		KVALUE+=(txt[2]*10);
	MOVLW       10
	MULWF       _txt+2 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        PRODH+0, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	ADDWF       _KVALUE+0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	ADDWFC      _KVALUE+1, 0 
	MOVWF       R3 
	MOVF        R2, 0 
	MOVWF       _KVALUE+0 
	MOVF        R3, 0 
	MOVWF       _KVALUE+1 
;slides.c,437 :: 		KVALUE+=(txt[3]*1);
	MOVF        _txt+3, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        R2, 0 
	ADDWF       R0, 1 
	MOVF        R3, 0 
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       _KVALUE+0 
	MOVF        R1, 0 
	MOVWF       _KVALUE+1 
;slides.c,440 :: 		KVALUE_k=KVALUE/100.0;
	CALL        _Int2Double+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       72
	MOVWF       R6 
	MOVLW       133
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _KVALUE_k+0 
	MOVF        R1, 0 
	MOVWF       _KVALUE_k+1 
	MOVF        R2, 0 
	MOVWF       _KVALUE_k+2 
	MOVF        R3, 0 
	MOVWF       _KVALUE_k+3 
;slides.c,444 :: 		EEPROM_Write(16,KVALUE);
	MOVLW       16
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _KVALUE+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;slides.c,445 :: 		delay_ms(100);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_K_settong177:
	DECFSZ      R13, 1, 1
	BRA         L_K_settong177
	DECFSZ      R12, 1, 1
	BRA         L_K_settong177
	DECFSZ      R11, 1, 1
	BRA         L_K_settong177
;slides.c,446 :: 		if (KVALUE>199 || KVALUE==0)
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _KVALUE+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__K_settong428
	MOVF        _KVALUE+0, 0 
	SUBLW       199
L__K_settong428:
	BTFSS       STATUS+0, 0 
	GOTO        L__K_settong376
	MOVLW       0
	XORWF       _KVALUE+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__K_settong429
	MOVLW       0
	XORWF       _KVALUE+0, 0 
L__K_settong429:
	BTFSC       STATUS+0, 2 
	GOTO        L__K_settong376
	GOTO        L_K_settong180
L__K_settong376:
;slides.c,449 :: 		}
	GOTO        L_K_settong181
L_K_settong180:
;slides.c,450 :: 		else  break;
	GOTO        L_K_settong170
L_K_settong181:
;slides.c,451 :: 		}
L_K_settong176:
;slides.c,452 :: 		}
	GOTO        L_K_settong169
L_K_settong170:
;slides.c,453 :: 		save_tag();
	CALL        _save_tag+0, 0
;slides.c,454 :: 		while(set_but(0)==255);
L_K_settong182:
	CLRF        FARG_set_but_active+0 
	CALL        _set_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_K_settong183
	GOTO        L_K_settong182
L_K_settong183:
;slides.c,455 :: 		menu1();
	CALL        _menu1+0, 0
;slides.c,456 :: 		}
L_end_K_settong:
	RETURN      0
; end of _K_settong

_range_set:

;slides.c,462 :: 		void range_set()
;slides.c,464 :: 		set_up();
	CALL        _set_up+0, 0
;slides.c,465 :: 		Glcd_Box(28,14 , 108, 24, 1);
	MOVLW       28
	MOVWF       FARG_Glcd_Box_x_upper_left+0 
	MOVLW       14
	MOVWF       FARG_Glcd_Box_y_upper_left+0 
	MOVLW       108
	MOVWF       FARG_Glcd_Box_x_bottom_right+0 
	MOVLW       24
	MOVWF       FARG_Glcd_Box_y_bottom_right+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Box_color+0 
	CALL        _Glcd_Box+0, 0
;slides.c,466 :: 		Glcd_Write_Text("RANGE SETTING", 30, 2, xColorinvert);
	MOVLW       ?lstr28_FLOW_32METER+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr28_FLOW_32METER+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       30
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;slides.c,467 :: 		Glcd_Write_Text("LOW RANGE", 5, 4, xColorSet);
	MOVLW       ?lstr29_FLOW_32METER+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr29_FLOW_32METER+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       5
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;slides.c,468 :: 		Glcd_Write_Text("HI RANGE", 5, 6, xColorSet);
	MOVLW       ?lstr30_FLOW_32METER+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr30_FLOW_32METER+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       5
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       6
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;slides.c,472 :: 		Lo(lo_RAGE)=EEPROM_Read(10);
	MOVLW       10
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _lo_RAGE+0 
;slides.c,473 :: 		delay_ms(10);
	MOVLW       104
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_range_set184:
	DECFSZ      R13, 1, 1
	BRA         L_range_set184
	DECFSZ      R12, 1, 1
	BRA         L_range_set184
	NOP
;slides.c,474 :: 		Hi(lo_RAGE)=EEPROM_Read(11);
	MOVLW       11
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _lo_RAGE+1 
;slides.c,475 :: 		delay_ms(10);
	MOVLW       104
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_range_set185:
	DECFSZ      R13, 1, 1
	BRA         L_range_set185
	DECFSZ      R12, 1, 1
	BRA         L_range_set185
	NOP
;slides.c,476 :: 		Lo(hi_RAGE)=EEPROM_Read(12);
	MOVLW       12
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _hi_RAGE+0 
;slides.c,477 :: 		delay_ms(10);
	MOVLW       104
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_range_set186:
	DECFSZ      R13, 1, 1
	BRA         L_range_set186
	DECFSZ      R12, 1, 1
	BRA         L_range_set186
	NOP
;slides.c,478 :: 		Hi(hi_RAGE)=EEPROM_Read(13);
	MOVLW       13
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _hi_RAGE+1 
;slides.c,479 :: 		delay_ms(10);
	MOVLW       104
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_range_set187:
	DECFSZ      R13, 1, 1
	BRA         L_range_set187
	DECFSZ      R12, 1, 1
	BRA         L_range_set187
	NOP
;slides.c,481 :: 		txt[0]=(hi_RAGE/10000)%10;
	MOVLW       16
	MOVWF       R4 
	MOVLW       39
	MOVWF       R5 
	MOVF        _hi_RAGE+0, 0 
	MOVWF       R0 
	MOVF        _hi_RAGE+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _txt+0 
;slides.c,482 :: 		txt[1]=(hi_RAGE/1000)%10;
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	MOVF        _hi_RAGE+0, 0 
	MOVWF       R0 
	MOVF        _hi_RAGE+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _txt+1 
;slides.c,483 :: 		txt[2]=(hi_RAGE/100)%10;
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _hi_RAGE+0, 0 
	MOVWF       R0 
	MOVF        _hi_RAGE+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _txt+2 
;slides.c,484 :: 		txt[3]=(hi_RAGE/10)%10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _hi_RAGE+0, 0 
	MOVWF       R0 
	MOVF        _hi_RAGE+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _txt+3 
;slides.c,485 :: 		txt[4]=(hi_RAGE/1)%10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _hi_RAGE+0, 0 
	MOVWF       R0 
	MOVF        _hi_RAGE+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _txt+4 
;slides.c,487 :: 		Glcd_Write_char(txt[0]+'0', 70, 6, xColorSet);
	MOVLW       48
	ADDWF       _txt+0, 0 
	MOVWF       FARG_Glcd_Write_Char_chr+0 
	MOVLW       70
	MOVWF       FARG_Glcd_Write_Char_x_pos+0 
	MOVLW       6
	MOVWF       FARG_Glcd_Write_Char_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Char_color+0 
	CALL        _Glcd_Write_Char+0, 0
;slides.c,488 :: 		Glcd_Write_char(txt[1]+'0', 78, 6, xColorSet);
	MOVLW       48
	ADDWF       _txt+1, 0 
	MOVWF       FARG_Glcd_Write_Char_chr+0 
	MOVLW       78
	MOVWF       FARG_Glcd_Write_Char_x_pos+0 
	MOVLW       6
	MOVWF       FARG_Glcd_Write_Char_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Char_color+0 
	CALL        _Glcd_Write_Char+0, 0
;slides.c,489 :: 		Glcd_Write_char(txt[2]+'0', 86, 6, xColorSet);
	MOVLW       48
	ADDWF       _txt+2, 0 
	MOVWF       FARG_Glcd_Write_Char_chr+0 
	MOVLW       86
	MOVWF       FARG_Glcd_Write_Char_x_pos+0 
	MOVLW       6
	MOVWF       FARG_Glcd_Write_Char_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Char_color+0 
	CALL        _Glcd_Write_Char+0, 0
;slides.c,490 :: 		Glcd_Write_char(txt[3]+'0', 94, 6, xColorSet);
	MOVLW       48
	ADDWF       _txt+3, 0 
	MOVWF       FARG_Glcd_Write_Char_chr+0 
	MOVLW       94
	MOVWF       FARG_Glcd_Write_Char_x_pos+0 
	MOVLW       6
	MOVWF       FARG_Glcd_Write_Char_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Char_color+0 
	CALL        _Glcd_Write_Char+0, 0
;slides.c,491 :: 		Glcd_Write_char(txt[4]+'0', 102, 6, xColorSet);
	MOVLW       48
	ADDWF       _txt+4, 0 
	MOVWF       FARG_Glcd_Write_Char_chr+0 
	MOVLW       102
	MOVWF       FARG_Glcd_Write_Char_x_pos+0 
	MOVLW       6
	MOVWF       FARG_Glcd_Write_Char_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Char_color+0 
	CALL        _Glcd_Write_Char+0, 0
;slides.c,493 :: 		Glcd_Rectangle(67, 45, 110, 58, 1);
	MOVLW       67
	MOVWF       FARG_Glcd_Rectangle_x_upper_left+0 
	MOVLW       45
	MOVWF       FARG_Glcd_Rectangle_y_upper_left+0 
	MOVLW       110
	MOVWF       FARG_Glcd_Rectangle_x_bottom_right+0 
	MOVLW       58
	MOVWF       FARG_Glcd_Rectangle_y_bottom_right+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Rectangle_color+0 
	CALL        _Glcd_Rectangle+0, 0
;slides.c,496 :: 		txt[0]=(Lo_RAGE/1000)%10;
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	MOVF        _lo_RAGE+0, 0 
	MOVWF       R0 
	MOVF        _lo_RAGE+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _txt+0 
;slides.c,497 :: 		txt[1]=(Lo_RAGE/100)%10;
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _lo_RAGE+0, 0 
	MOVWF       R0 
	MOVF        _lo_RAGE+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _txt+1 
;slides.c,498 :: 		txt[2]=(Lo_RAGE/10)%10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _lo_RAGE+0, 0 
	MOVWF       R0 
	MOVF        _lo_RAGE+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _txt+2 
;slides.c,499 :: 		txt[3]=(Lo_RAGE/1)%10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _lo_RAGE+0, 0 
	MOVWF       R0 
	MOVF        _lo_RAGE+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _txt+3 
;slides.c,500 :: 		Glcd_Write_char(txt[0]+'0', 70, 4, xColorSet);
	MOVLW       48
	ADDWF       _txt+0, 0 
	MOVWF       FARG_Glcd_Write_Char_chr+0 
	MOVLW       70
	MOVWF       FARG_Glcd_Write_Char_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Char_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Char_color+0 
	CALL        _Glcd_Write_Char+0, 0
;slides.c,501 :: 		Glcd_Write_char(txt[1]+'0', 78, 4, xColorSet);
	MOVLW       48
	ADDWF       _txt+1, 0 
	MOVWF       FARG_Glcd_Write_Char_chr+0 
	MOVLW       78
	MOVWF       FARG_Glcd_Write_Char_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Char_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Char_color+0 
	CALL        _Glcd_Write_Char+0, 0
;slides.c,502 :: 		Glcd_Write_char(txt[2]+'0', 86, 4, xColorSet);
	MOVLW       48
	ADDWF       _txt+2, 0 
	MOVWF       FARG_Glcd_Write_Char_chr+0 
	MOVLW       86
	MOVWF       FARG_Glcd_Write_Char_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Char_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Char_color+0 
	CALL        _Glcd_Write_Char+0, 0
;slides.c,503 :: 		Glcd_Write_char(txt[3]+'0', 94, 4, xColorSet);
	MOVLW       48
	ADDWF       _txt+3, 0 
	MOVWF       FARG_Glcd_Write_Char_chr+0 
	MOVLW       94
	MOVWF       FARG_Glcd_Write_Char_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Char_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Char_color+0 
	CALL        _Glcd_Write_Char+0, 0
;slides.c,504 :: 		Glcd_Rectangle(67, 29, 102, 42, 1);
	MOVLW       67
	MOVWF       FARG_Glcd_Rectangle_x_upper_left+0 
	MOVLW       29
	MOVWF       FARG_Glcd_Rectangle_y_upper_left+0 
	MOVLW       102
	MOVWF       FARG_Glcd_Rectangle_x_bottom_right+0 
	MOVLW       42
	MOVWF       FARG_Glcd_Rectangle_y_bottom_right+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Rectangle_color+0 
	CALL        _Glcd_Rectangle+0, 0
;slides.c,506 :: 		tposition=1,position_c=0;
	MOVLW       1
	MOVWF       _tposition+0 
	CLRF        _position_c+0 
;slides.c,508 :: 		Glcd_H_Line(70, 70+5, 40, 1);
	MOVLW       70
	MOVWF       FARG_Glcd_H_Line_x_start+0 
	MOVLW       75
	MOVWF       FARG_Glcd_H_Line_x_end+0 
	MOVLW       40
	MOVWF       FARG_Glcd_H_Line_y_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_H_Line_color+0 
	CALL        _Glcd_H_Line+0, 0
;slides.c,511 :: 		while(1)
L_range_set188:
;slides.c,513 :: 		if      (position_c==0)  current_digit_change(70,4);
	MOVF        _position_c+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_range_set190
	MOVLW       70
	MOVWF       FARG_current_digit_change_lcd_pos+0 
	MOVLW       4
	MOVWF       FARG_current_digit_change_page_nu+0 
	CALL        _current_digit_change+0, 0
	GOTO        L_range_set191
L_range_set190:
;slides.c,514 :: 		else if (position_c==1)  current_digit_change(78,4);
	MOVF        _position_c+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_range_set192
	MOVLW       78
	MOVWF       FARG_current_digit_change_lcd_pos+0 
	MOVLW       4
	MOVWF       FARG_current_digit_change_page_nu+0 
	CALL        _current_digit_change+0, 0
	GOTO        L_range_set193
L_range_set192:
;slides.c,515 :: 		else if (position_c==2)  current_digit_change(86,4);
	MOVF        _position_c+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_range_set194
	MOVLW       86
	MOVWF       FARG_current_digit_change_lcd_pos+0 
	MOVLW       4
	MOVWF       FARG_current_digit_change_page_nu+0 
	CALL        _current_digit_change+0, 0
	GOTO        L_range_set195
L_range_set194:
;slides.c,516 :: 		else if (position_c==3)  current_digit_change(94,4);
	MOVF        _position_c+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_range_set196
	MOVLW       94
	MOVWF       FARG_current_digit_change_lcd_pos+0 
	MOVLW       4
	MOVWF       FARG_current_digit_change_page_nu+0 
	CALL        _current_digit_change+0, 0
L_range_set196:
L_range_set195:
L_range_set193:
L_range_set191:
;slides.c,526 :: 		counter_cursor_pos();
	CALL        _counter_cursor_pos+0, 0
;slides.c,528 :: 		if (set_but(0)==255)
	CLRF        FARG_set_but_active+0 
	CALL        _set_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_range_set197
;slides.c,530 :: 		while(set_but(0)==255);
L_range_set198:
	CLRF        FARG_set_but_active+0 
	CALL        _set_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_range_set199
	GOTO        L_range_set198
L_range_set199:
;slides.c,532 :: 		FC1=(txt[0]*1000);
	MOVF        _txt+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _fc1+0 
	MOVF        R1, 0 
	MOVWF       _fc1+1 
;slides.c,533 :: 		FC2=(txt[1]*100);
	MOVLW       100
	MULWF       _txt+1 
	MOVF        PRODL+0, 0 
	MOVWF       _fc2+0 
	MOVF        PRODH+0, 0 
	MOVWF       _fc2+1 
;slides.c,534 :: 		FC3=(txt[2]*10);
	MOVLW       10
	MULWF       _txt+2 
	MOVF        PRODL+0, 0 
	MOVWF       R2 
	MOVF        PRODH+0, 0 
	MOVWF       R3 
	MOVF        R2, 0 
	MOVWF       _fc3+0 
	MOVF        R3, 0 
	MOVWF       _fc3+1 
;slides.c,535 :: 		FC4=(txt[3]*1);
	MOVF        _txt+3, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _fc4+0 
	MOVF        R1, 0 
	MOVWF       _fc4+1 
;slides.c,538 :: 		lo_RAGE=fc1+fc2+fc3+fc4;
	MOVF        _fc2+0, 0 
	ADDWF       _fc1+0, 0 
	MOVWF       _lo_RAGE+0 
	MOVF        _fc2+1, 0 
	ADDWFC      _fc1+1, 0 
	MOVWF       _lo_RAGE+1 
	MOVF        R2, 0 
	ADDWF       _lo_RAGE+0, 1 
	MOVF        R3, 0 
	ADDWFC      _lo_RAGE+1, 1 
	MOVF        R0, 0 
	ADDWF       _lo_RAGE+0, 1 
	MOVF        R1, 0 
	ADDWFC      _lo_RAGE+1, 1 
;slides.c,539 :: 		EEPROM_Write(10, Lo(lo_RAGE));
	MOVLW       10
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _lo_RAGE+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;slides.c,540 :: 		delay_ms(100);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_range_set200:
	DECFSZ      R13, 1, 1
	BRA         L_range_set200
	DECFSZ      R12, 1, 1
	BRA         L_range_set200
	DECFSZ      R11, 1, 1
	BRA         L_range_set200
;slides.c,541 :: 		EEPROM_Write(11, Hi(lo_RAGE));
	MOVLW       11
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _lo_RAGE+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;slides.c,542 :: 		delay_ms(100);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_range_set201:
	DECFSZ      R13, 1, 1
	BRA         L_range_set201
	DECFSZ      R12, 1, 1
	BRA         L_range_set201
	DECFSZ      R11, 1, 1
	BRA         L_range_set201
;slides.c,543 :: 		break;
	GOTO        L_range_set189
;slides.c,544 :: 		}
L_range_set197:
;slides.c,545 :: 		}
	GOTO        L_range_set188
L_range_set189:
;slides.c,547 :: 		Glcd_H_Line(70, 101, 40, 0);
	MOVLW       70
	MOVWF       FARG_Glcd_H_Line_x_start+0 
	MOVLW       101
	MOVWF       FARG_Glcd_H_Line_x_end+0 
	MOVLW       40
	MOVWF       FARG_Glcd_H_Line_y_pos+0 
	CLRF        FARG_Glcd_H_Line_color+0 
	CALL        _Glcd_H_Line+0, 0
;slides.c,548 :: 		tposition=1,position_c=0;
	MOVLW       1
	MOVWF       _tposition+0 
	CLRF        _position_c+0 
;slides.c,549 :: 		Glcd_H_Line(70, 70+5, 56, 1);
	MOVLW       70
	MOVWF       FARG_Glcd_H_Line_x_start+0 
	MOVLW       75
	MOVWF       FARG_Glcd_H_Line_x_end+0 
	MOVLW       56
	MOVWF       FARG_Glcd_H_Line_y_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_H_Line_color+0 
	CALL        _Glcd_H_Line+0, 0
;slides.c,551 :: 		txt[0]=(hi_RAGE/10000)%10;
	MOVLW       16
	MOVWF       R4 
	MOVLW       39
	MOVWF       R5 
	MOVF        _hi_RAGE+0, 0 
	MOVWF       R0 
	MOVF        _hi_RAGE+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _txt+0 
;slides.c,552 :: 		txt[1]=(hi_RAGE/1000)%10;
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	MOVF        _hi_RAGE+0, 0 
	MOVWF       R0 
	MOVF        _hi_RAGE+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _txt+1 
;slides.c,553 :: 		txt[2]=(hi_RAGE/100)%10;
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _hi_RAGE+0, 0 
	MOVWF       R0 
	MOVF        _hi_RAGE+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _txt+2 
;slides.c,554 :: 		txt[3]=(hi_RAGE/10)%10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _hi_RAGE+0, 0 
	MOVWF       R0 
	MOVF        _hi_RAGE+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _txt+3 
;slides.c,555 :: 		txt[4]=(hi_RAGE/1)%10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _hi_RAGE+0, 0 
	MOVWF       R0 
	MOVF        _hi_RAGE+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _txt+4 
;slides.c,557 :: 		Glcd_Write_char(txt[0]+'0', 70, 6, xColorSet);
	MOVLW       48
	ADDWF       _txt+0, 0 
	MOVWF       FARG_Glcd_Write_Char_chr+0 
	MOVLW       70
	MOVWF       FARG_Glcd_Write_Char_x_pos+0 
	MOVLW       6
	MOVWF       FARG_Glcd_Write_Char_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Char_color+0 
	CALL        _Glcd_Write_Char+0, 0
;slides.c,558 :: 		Glcd_Write_char(txt[1]+'0', 78, 6, xColorSet);
	MOVLW       48
	ADDWF       _txt+1, 0 
	MOVWF       FARG_Glcd_Write_Char_chr+0 
	MOVLW       78
	MOVWF       FARG_Glcd_Write_Char_x_pos+0 
	MOVLW       6
	MOVWF       FARG_Glcd_Write_Char_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Char_color+0 
	CALL        _Glcd_Write_Char+0, 0
;slides.c,559 :: 		Glcd_Write_char(txt[2]+'0', 86, 6, xColorSet);
	MOVLW       48
	ADDWF       _txt+2, 0 
	MOVWF       FARG_Glcd_Write_Char_chr+0 
	MOVLW       86
	MOVWF       FARG_Glcd_Write_Char_x_pos+0 
	MOVLW       6
	MOVWF       FARG_Glcd_Write_Char_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Char_color+0 
	CALL        _Glcd_Write_Char+0, 0
;slides.c,560 :: 		Glcd_Write_char(txt[3]+'0', 94, 6, xColorSet);
	MOVLW       48
	ADDWF       _txt+3, 0 
	MOVWF       FARG_Glcd_Write_Char_chr+0 
	MOVLW       94
	MOVWF       FARG_Glcd_Write_Char_x_pos+0 
	MOVLW       6
	MOVWF       FARG_Glcd_Write_Char_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Char_color+0 
	CALL        _Glcd_Write_Char+0, 0
;slides.c,561 :: 		Glcd_Write_char(txt[4]+'0', 102, 6, xColorSet);
	MOVLW       48
	ADDWF       _txt+4, 0 
	MOVWF       FARG_Glcd_Write_Char_chr+0 
	MOVLW       102
	MOVWF       FARG_Glcd_Write_Char_x_pos+0 
	MOVLW       6
	MOVWF       FARG_Glcd_Write_Char_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Char_color+0 
	CALL        _Glcd_Write_Char+0, 0
;slides.c,562 :: 		while(1)
L_range_set202:
;slides.c,564 :: 		if      (position_c==0)  current_digit_change(70,6);
	MOVF        _position_c+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_range_set204
	MOVLW       70
	MOVWF       FARG_current_digit_change_lcd_pos+0 
	MOVLW       6
	MOVWF       FARG_current_digit_change_page_nu+0 
	CALL        _current_digit_change+0, 0
	GOTO        L_range_set205
L_range_set204:
;slides.c,565 :: 		else if (position_c==1)  current_digit_change(78,6);
	MOVF        _position_c+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_range_set206
	MOVLW       78
	MOVWF       FARG_current_digit_change_lcd_pos+0 
	MOVLW       6
	MOVWF       FARG_current_digit_change_page_nu+0 
	CALL        _current_digit_change+0, 0
	GOTO        L_range_set207
L_range_set206:
;slides.c,566 :: 		else if (position_c==2)  current_digit_change(86,6);
	MOVF        _position_c+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_range_set208
	MOVLW       86
	MOVWF       FARG_current_digit_change_lcd_pos+0 
	MOVLW       6
	MOVWF       FARG_current_digit_change_page_nu+0 
	CALL        _current_digit_change+0, 0
	GOTO        L_range_set209
L_range_set208:
;slides.c,567 :: 		else if (position_c==3)  current_digit_change(94,6);
	MOVF        _position_c+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_range_set210
	MOVLW       94
	MOVWF       FARG_current_digit_change_lcd_pos+0 
	MOVLW       6
	MOVWF       FARG_current_digit_change_page_nu+0 
	CALL        _current_digit_change+0, 0
	GOTO        L_range_set211
L_range_set210:
;slides.c,568 :: 		else if (position_c==4)  current_digit_change(102,6);
	MOVF        _position_c+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_range_set212
	MOVLW       102
	MOVWF       FARG_current_digit_change_lcd_pos+0 
	MOVLW       6
	MOVWF       FARG_current_digit_change_page_nu+0 
	CALL        _current_digit_change+0, 0
L_range_set212:
L_range_set211:
L_range_set209:
L_range_set207:
L_range_set205:
;slides.c,578 :: 		counter_cursor_pos_low();
	CALL        _counter_cursor_pos_low+0, 0
;slides.c,579 :: 		if (set_but(0)==255)
	CLRF        FARG_set_but_active+0 
	CALL        _set_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_range_set213
;slides.c,581 :: 		compress_data();
	CALL        _compress_data+0, 0
;slides.c,582 :: 		hi_RAGE=fc1+fc2+fc3+fc4+fc5;
	MOVF        _fc2+0, 0 
	ADDWF       _fc1+0, 0 
	MOVWF       _hi_RAGE+0 
	MOVF        _fc2+1, 0 
	ADDWFC      _fc1+1, 0 
	MOVWF       _hi_RAGE+1 
	MOVF        _fc3+0, 0 
	ADDWF       _hi_RAGE+0, 1 
	MOVF        _fc3+1, 0 
	ADDWFC      _hi_RAGE+1, 1 
	MOVF        _fc4+0, 0 
	ADDWF       _hi_RAGE+0, 1 
	MOVF        _fc4+1, 0 
	ADDWFC      _hi_RAGE+1, 1 
	MOVF        _FC5+0, 0 
	ADDWF       _hi_RAGE+0, 1 
	MOVF        _FC5+1, 0 
	ADDWFC      _hi_RAGE+1, 1 
;slides.c,583 :: 		EEPROM_Write(12, Lo(hi_RAGE));
	MOVLW       12
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _hi_RAGE+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;slides.c,584 :: 		delay_ms(100);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_range_set214:
	DECFSZ      R13, 1, 1
	BRA         L_range_set214
	DECFSZ      R12, 1, 1
	BRA         L_range_set214
	DECFSZ      R11, 1, 1
	BRA         L_range_set214
;slides.c,585 :: 		EEPROM_Write(13, Hi(hi_RAGE));
	MOVLW       13
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _hi_RAGE+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;slides.c,586 :: 		delay_ms(100);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_range_set215:
	DECFSZ      R13, 1, 1
	BRA         L_range_set215
	DECFSZ      R12, 1, 1
	BRA         L_range_set215
	DECFSZ      R11, 1, 1
	BRA         L_range_set215
;slides.c,587 :: 		break;
	GOTO        L_range_set203
;slides.c,588 :: 		}
L_range_set213:
;slides.c,589 :: 		}
	GOTO        L_range_set202
L_range_set203:
;slides.c,590 :: 		save_tag();
	CALL        _save_tag+0, 0
;slides.c,591 :: 		while(set_but(0)==255);
L_range_set216:
	CLRF        FARG_set_but_active+0 
	CALL        _set_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_range_set217
	GOTO        L_range_set216
L_range_set217:
;slides.c,592 :: 		menu1();
	CALL        _menu1+0, 0
;slides.c,593 :: 		}
L_end_range_set:
	RETURN      0
; end of _range_set

_Reset:

;slides.c,596 :: 		void Reset()
;slides.c,598 :: 		char Reset_postion=2;
	MOVLW       2
	MOVWF       Reset_Reset_postion_L0+0 
;slides.c,599 :: 		set_up();
	CALL        _set_up+0, 0
;slides.c,600 :: 		Glcd_Box(28,14 , 102, 24, 1);
	MOVLW       28
	MOVWF       FARG_Glcd_Box_x_upper_left+0 
	MOVLW       14
	MOVWF       FARG_Glcd_Box_y_upper_left+0 
	MOVLW       102
	MOVWF       FARG_Glcd_Box_x_bottom_right+0 
	MOVLW       24
	MOVWF       FARG_Glcd_Box_y_bottom_right+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Box_color+0 
	CALL        _Glcd_Box+0, 0
;slides.c,601 :: 		Glcd_Write_Text("ARE YOU SURE", 30, 2, xColorinvert);
	MOVLW       ?lstr31_FLOW_32METER+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr31_FLOW_32METER+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       30
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;slides.c,603 :: 		Glcd_Write_Text("YES", 20, 5, xColorSet);
	MOVLW       ?lstr32_FLOW_32METER+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr32_FLOW_32METER+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       20
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       5
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;slides.c,604 :: 		Glcd_Write_Text("NO", 86, 5, xColorSet);
	MOVLW       ?lstr33_FLOW_32METER+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr33_FLOW_32METER+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       86
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       5
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;slides.c,606 :: 		Glcd_Rectangle(84, 38, 98, 48, 1);
	MOVLW       84
	MOVWF       FARG_Glcd_Rectangle_x_upper_left+0 
	MOVLW       38
	MOVWF       FARG_Glcd_Rectangle_y_upper_left+0 
	MOVLW       98
	MOVWF       FARG_Glcd_Rectangle_x_bottom_right+0 
	MOVLW       48
	MOVWF       FARG_Glcd_Rectangle_y_bottom_right+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Rectangle_color+0 
	CALL        _Glcd_Rectangle+0, 0
;slides.c,610 :: 		while(set_but(0)==0)
L_Reset218:
	CLRF        FARG_set_but_active+0 
	CALL        _set_but+0, 0
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Reset219
;slides.c,612 :: 		if (SCRL_but(0)==255)
	CLRF        FARG_scrl_but_active+0 
	CALL        _scrl_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_Reset220
;slides.c,614 :: 		while(SCRL_but(0)==255);
L_Reset221:
	CLRF        FARG_scrl_but_active+0 
	CALL        _scrl_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_Reset222
	GOTO        L_Reset221
L_Reset222:
;slides.c,615 :: 		Reset_postion++;
	INCF        Reset_Reset_postion_L0+0, 1 
;slides.c,616 :: 		if (Reset_postion>=3)
	MOVLW       3
	SUBWF       Reset_Reset_postion_L0+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_Reset223
;slides.c,618 :: 		Reset_postion=1;
	MOVLW       1
	MOVWF       Reset_Reset_postion_L0+0 
;slides.c,619 :: 		}
L_Reset223:
;slides.c,620 :: 		if (Reset_postion==1)
	MOVF        Reset_Reset_postion_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Reset224
;slides.c,622 :: 		Glcd_Rectangle(18, 38, 38, 48, 1);
	MOVLW       18
	MOVWF       FARG_Glcd_Rectangle_x_upper_left+0 
	MOVLW       38
	MOVWF       FARG_Glcd_Rectangle_y_upper_left+0 
	MOVLW       38
	MOVWF       FARG_Glcd_Rectangle_x_bottom_right+0 
	MOVLW       48
	MOVWF       FARG_Glcd_Rectangle_y_bottom_right+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Rectangle_color+0 
	CALL        _Glcd_Rectangle+0, 0
;slides.c,623 :: 		Glcd_Rectangle(84, 38, 98, 48, 0);
	MOVLW       84
	MOVWF       FARG_Glcd_Rectangle_x_upper_left+0 
	MOVLW       38
	MOVWF       FARG_Glcd_Rectangle_y_upper_left+0 
	MOVLW       98
	MOVWF       FARG_Glcd_Rectangle_x_bottom_right+0 
	MOVLW       48
	MOVWF       FARG_Glcd_Rectangle_y_bottom_right+0 
	CLRF        FARG_Glcd_Rectangle_color+0 
	CALL        _Glcd_Rectangle+0, 0
;slides.c,624 :: 		}
	GOTO        L_Reset225
L_Reset224:
;slides.c,625 :: 		else if (Reset_postion==2)
	MOVF        Reset_Reset_postion_L0+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_Reset226
;slides.c,627 :: 		Glcd_Rectangle(84, 38, 98, 48, 1);
	MOVLW       84
	MOVWF       FARG_Glcd_Rectangle_x_upper_left+0 
	MOVLW       38
	MOVWF       FARG_Glcd_Rectangle_y_upper_left+0 
	MOVLW       98
	MOVWF       FARG_Glcd_Rectangle_x_bottom_right+0 
	MOVLW       48
	MOVWF       FARG_Glcd_Rectangle_y_bottom_right+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Rectangle_color+0 
	CALL        _Glcd_Rectangle+0, 0
;slides.c,628 :: 		Glcd_Rectangle(18, 38, 38, 48, 0);
	MOVLW       18
	MOVWF       FARG_Glcd_Rectangle_x_upper_left+0 
	MOVLW       38
	MOVWF       FARG_Glcd_Rectangle_y_upper_left+0 
	MOVLW       38
	MOVWF       FARG_Glcd_Rectangle_x_bottom_right+0 
	MOVLW       48
	MOVWF       FARG_Glcd_Rectangle_y_bottom_right+0 
	CLRF        FARG_Glcd_Rectangle_color+0 
	CALL        _Glcd_Rectangle+0, 0
;slides.c,629 :: 		}
L_Reset226:
L_Reset225:
;slides.c,630 :: 		}
L_Reset220:
;slides.c,631 :: 		}
	GOTO        L_Reset218
L_Reset219:
;slides.c,632 :: 		if (Reset_postion==1)
	MOVF        Reset_Reset_postion_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Reset227
;slides.c,634 :: 		TOTALLIZER=0.0;
	CLRF        _TOTALLIZER+0 
	CLRF        _TOTALLIZER+1 
	CLRF        _TOTALLIZER+2 
	CLRF        _TOTALLIZER+3 
;slides.c,635 :: 		}
L_Reset227:
;slides.c,660 :: 		save_tag();
	CALL        _save_tag+0, 0
;slides.c,661 :: 		while(set_but(0)==255);
L_Reset228:
	CLRF        FARG_set_but_active+0 
	CALL        _set_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_Reset229
	GOTO        L_Reset228
L_Reset229:
;slides.c,662 :: 		menu1();
	CALL        _menu1+0, 0
;slides.c,663 :: 		}
L_end_Reset:
	RETURN      0
; end of _Reset

_clear_errow:

;slides.c,665 :: 		void clear_errow(char errow)
;slides.c,668 :: 		Glcd_Write_Text("  ", 3, errow, 1);
	MOVLW       ?lstr34_FLOW_32METER+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr34_FLOW_32METER+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       3
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVF        FARG_clear_errow_errow+0, 0 
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;slides.c,671 :: 		}
L_end_clear_errow:
	RETURN      0
; end of _clear_errow

_Pass_word:

;slides.c,753 :: 		char  Pass_word()
;slides.c,755 :: 		char T_pass=0;
;slides.c,756 :: 		cls();
	CALL        _cls+0, 0
;slides.c,757 :: 		SET_5X7();
	CALL        _set_5x7+0, 0
;slides.c,758 :: 		Glcd_Box(18, 6, 104, 16, 1);
	MOVLW       18
	MOVWF       FARG_Glcd_Box_x_upper_left+0 
	MOVLW       6
	MOVWF       FARG_Glcd_Box_y_upper_left+0 
	MOVLW       104
	MOVWF       FARG_Glcd_Box_x_bottom_right+0 
	MOVLW       16
	MOVWF       FARG_Glcd_Box_y_bottom_right+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Box_color+0 
	CALL        _Glcd_Box+0, 0
;slides.c,759 :: 		Glcd_Write_Text("ENTER PASSWORD", 20, 1, xColorINVERT);
	MOVLW       ?lstr35_FLOW_32METER+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr35_FLOW_32METER+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       20
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;slides.c,761 :: 		SET_8X7();
	CALL        _set_8x7+0, 0
;slides.c,762 :: 		Glcd_Write_Text("OMNI", 10, 5, xColorSET);
	MOVLW       ?lstr36_FLOW_32METER+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr36_FLOW_32METER+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       10
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       5
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;slides.c,763 :: 		Glcd_Write_Text("TELEMETRY", 1, 6, xColorINVERT);
	MOVLW       ?lstr37_FLOW_32METER+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr37_FLOW_32METER+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       6
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;slides.c,764 :: 		SET_5X7();
	CALL        _set_5x7+0, 0
;slides.c,765 :: 		Glcd_Write_Text("FLOW", 10, 3, xColorINVERT);
	MOVLW       ?lstr38_FLOW_32METER+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr38_FLOW_32METER+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       10
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       3
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;slides.c,766 :: 		Glcd_Write_Text("METERING", 5, 4, xColorINVERT);
	MOVLW       ?lstr39_FLOW_32METER+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr39_FLOW_32METER+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       5
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;slides.c,767 :: 		SET_5X7();
	CALL        _set_5x7+0, 0
;slides.c,768 :: 		txt[0]=0;
	CLRF        _txt+0 
;slides.c,769 :: 		txt[1]=0;
	CLRF        _txt+1 
;slides.c,770 :: 		txt[2]=0;
	CLRF        _txt+2 
;slides.c,771 :: 		txt[3]=0;
	CLRF        _txt+3 
;slides.c,772 :: 		Glcd_Write_char('0', 70, 4, xColorSet);
	MOVLW       48
	MOVWF       FARG_Glcd_Write_Char_chr+0 
	MOVLW       70
	MOVWF       FARG_Glcd_Write_Char_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Char_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Char_color+0 
	CALL        _Glcd_Write_Char+0, 0
;slides.c,773 :: 		Glcd_Write_char('0', 78, 4, xColorSet);
	MOVLW       48
	MOVWF       FARG_Glcd_Write_Char_chr+0 
	MOVLW       78
	MOVWF       FARG_Glcd_Write_Char_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Char_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Char_color+0 
	CALL        _Glcd_Write_Char+0, 0
;slides.c,774 :: 		Glcd_Write_char('0', 86, 4, xColorSet);
	MOVLW       48
	MOVWF       FARG_Glcd_Write_Char_chr+0 
	MOVLW       86
	MOVWF       FARG_Glcd_Write_Char_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Char_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Char_color+0 
	CALL        _Glcd_Write_Char+0, 0
;slides.c,775 :: 		Glcd_Write_char('0', 94, 4, xColorSet);
	MOVLW       48
	MOVWF       FARG_Glcd_Write_Char_chr+0 
	MOVLW       94
	MOVWF       FARG_Glcd_Write_Char_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Char_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Char_color+0 
	CALL        _Glcd_Write_Char+0, 0
;slides.c,776 :: 		Glcd_Rectangle(67, 29, 102, 42, 1);
	MOVLW       67
	MOVWF       FARG_Glcd_Rectangle_x_upper_left+0 
	MOVLW       29
	MOVWF       FARG_Glcd_Rectangle_y_upper_left+0 
	MOVLW       102
	MOVWF       FARG_Glcd_Rectangle_x_bottom_right+0 
	MOVLW       42
	MOVWF       FARG_Glcd_Rectangle_y_bottom_right+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Rectangle_color+0 
	CALL        _Glcd_Rectangle+0, 0
;slides.c,777 :: 		tposition=1,position_c=0;
	MOVLW       1
	MOVWF       _tposition+0 
	CLRF        _position_c+0 
;slides.c,778 :: 		Glcd_H_Line(70, 70+5, 40, 1);
	MOVLW       70
	MOVWF       FARG_Glcd_H_Line_x_start+0 
	MOVLW       75
	MOVWF       FARG_Glcd_H_Line_x_end+0 
	MOVLW       40
	MOVWF       FARG_Glcd_H_Line_y_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_H_Line_color+0 
	CALL        _Glcd_H_Line+0, 0
;slides.c,780 :: 		while(set_but(0)==255);
L_Pass_word230:
	CLRF        FARG_set_but_active+0 
	CALL        _set_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_Pass_word231
	GOTO        L_Pass_word230
L_Pass_word231:
;slides.c,781 :: 		while(scrl_but(0)==255);
L_Pass_word232:
	CLRF        FARG_scrl_but_active+0 
	CALL        _scrl_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_Pass_word233
	GOTO        L_Pass_word232
L_Pass_word233:
;slides.c,782 :: 		while(1)
L_Pass_word234:
;slides.c,784 :: 		if      (position_c==0)  current_digit_change(70,4);
	MOVF        _position_c+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Pass_word236
	MOVLW       70
	MOVWF       FARG_current_digit_change_lcd_pos+0 
	MOVLW       4
	MOVWF       FARG_current_digit_change_page_nu+0 
	CALL        _current_digit_change+0, 0
	GOTO        L_Pass_word237
L_Pass_word236:
;slides.c,785 :: 		else if (position_c==1)  current_digit_change(78,4);
	MOVF        _position_c+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Pass_word238
	MOVLW       78
	MOVWF       FARG_current_digit_change_lcd_pos+0 
	MOVLW       4
	MOVWF       FARG_current_digit_change_page_nu+0 
	CALL        _current_digit_change+0, 0
	GOTO        L_Pass_word239
L_Pass_word238:
;slides.c,786 :: 		else if (position_c==2)  current_digit_change(86,4);
	MOVF        _position_c+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_Pass_word240
	MOVLW       86
	MOVWF       FARG_current_digit_change_lcd_pos+0 
	MOVLW       4
	MOVWF       FARG_current_digit_change_page_nu+0 
	CALL        _current_digit_change+0, 0
	GOTO        L_Pass_word241
L_Pass_word240:
;slides.c,787 :: 		else if (position_c==3)  current_digit_change(94,4);
	MOVF        _position_c+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_Pass_word242
	MOVLW       94
	MOVWF       FARG_current_digit_change_lcd_pos+0 
	MOVLW       4
	MOVWF       FARG_current_digit_change_page_nu+0 
	CALL        _current_digit_change+0, 0
L_Pass_word242:
L_Pass_word241:
L_Pass_word239:
L_Pass_word237:
;slides.c,795 :: 		counter_cursor_pos();
	CALL        _counter_cursor_pos+0, 0
;slides.c,797 :: 		if (set_but(0)==255)
	CLRF        FARG_set_but_active+0 
	CALL        _set_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_Pass_word243
;slides.c,799 :: 		if (txt[0]==7 && txt[1]==4 && txt[2]==7 && txt[3]==8) // this is password
	MOVF        _txt+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_Pass_word246
	MOVF        _txt+1, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_Pass_word246
	MOVF        _txt+2, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_Pass_word246
	MOVF        _txt+3, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L_Pass_word246
L__Pass_word378:
;slides.c,801 :: 		return 255;
	MOVLW       255
	MOVWF       R0 
	GOTO        L_end_Pass_word
;slides.c,802 :: 		}
L_Pass_word246:
;slides.c,803 :: 		else if (txt[0]==0 && txt[1]==0 && txt[2]==0 && txt[3]==0)
	MOVF        _txt+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Pass_word250
	MOVF        _txt+1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Pass_word250
	MOVF        _txt+2, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Pass_word250
	MOVF        _txt+3, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Pass_word250
L__Pass_word377:
;slides.c,806 :: 		return 0;
	CLRF        R0 
	GOTO        L_end_Pass_word
;slides.c,807 :: 		}
L_Pass_word250:
;slides.c,810 :: 		txt[0]=0;
	CLRF        _txt+0 
;slides.c,811 :: 		txt[1]=0;
	CLRF        _txt+1 
;slides.c,812 :: 		txt[2]=0;
	CLRF        _txt+2 
;slides.c,813 :: 		txt[3]=0;
	CLRF        _txt+3 
;slides.c,814 :: 		Glcd_Write_char('0', 70, 4, xColorSet);
	MOVLW       48
	MOVWF       FARG_Glcd_Write_Char_chr+0 
	MOVLW       70
	MOVWF       FARG_Glcd_Write_Char_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Char_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Char_color+0 
	CALL        _Glcd_Write_Char+0, 0
;slides.c,815 :: 		Glcd_Write_char('0', 78, 4, xColorSet);
	MOVLW       48
	MOVWF       FARG_Glcd_Write_Char_chr+0 
	MOVLW       78
	MOVWF       FARG_Glcd_Write_Char_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Char_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Char_color+0 
	CALL        _Glcd_Write_Char+0, 0
;slides.c,816 :: 		Glcd_Write_char('0', 86, 4, xColorSet);
	MOVLW       48
	MOVWF       FARG_Glcd_Write_Char_chr+0 
	MOVLW       86
	MOVWF       FARG_Glcd_Write_Char_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Char_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Char_color+0 
	CALL        _Glcd_Write_Char+0, 0
;slides.c,817 :: 		Glcd_Write_char('0', 94, 4, xColorSet);
	MOVLW       48
	MOVWF       FARG_Glcd_Write_Char_chr+0 
	MOVLW       94
	MOVWF       FARG_Glcd_Write_Char_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Char_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Char_color+0 
	CALL        _Glcd_Write_Char+0, 0
;slides.c,818 :: 		Glcd_Rectangle(67, 29, 102, 42, 1);
	MOVLW       67
	MOVWF       FARG_Glcd_Rectangle_x_upper_left+0 
	MOVLW       29
	MOVWF       FARG_Glcd_Rectangle_y_upper_left+0 
	MOVLW       102
	MOVWF       FARG_Glcd_Rectangle_x_bottom_right+0 
	MOVLW       42
	MOVWF       FARG_Glcd_Rectangle_y_bottom_right+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Rectangle_color+0 
	CALL        _Glcd_Rectangle+0, 0
;slides.c,819 :: 		Glcd_H_Line(70, 101, 40, 0);
	MOVLW       70
	MOVWF       FARG_Glcd_H_Line_x_start+0 
	MOVLW       101
	MOVWF       FARG_Glcd_H_Line_x_end+0 
	MOVLW       40
	MOVWF       FARG_Glcd_H_Line_y_pos+0 
	CLRF        FARG_Glcd_H_Line_color+0 
	CALL        _Glcd_H_Line+0, 0
;slides.c,820 :: 		tposition=1,position_c=0;
	MOVLW       1
	MOVWF       _tposition+0 
	CLRF        _position_c+0 
;slides.c,821 :: 		Glcd_H_Line(70, 70+5, 40, 1);
	MOVLW       70
	MOVWF       FARG_Glcd_H_Line_x_start+0 
	MOVLW       75
	MOVWF       FARG_Glcd_H_Line_x_end+0 
	MOVLW       40
	MOVWF       FARG_Glcd_H_Line_y_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_H_Line_color+0 
	CALL        _Glcd_H_Line+0, 0
;slides.c,822 :: 		while(set_but(0)==255);
L_Pass_word252:
	CLRF        FARG_set_but_active+0 
	CALL        _set_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_Pass_word253
	GOTO        L_Pass_word252
L_Pass_word253:
;slides.c,824 :: 		}
L_Pass_word243:
;slides.c,825 :: 		}
	GOTO        L_Pass_word234
;slides.c,827 :: 		}
L_end_Pass_word:
	RETURN      0
; end of _Pass_word

_slide_1:

;slides.c,831 :: 		void slide_1 ()
;slides.c,833 :: 		menu1();
	CALL        _menu1+0, 0
;slides.c,834 :: 		set_3x5();
	CALL        _set_3x5+0, 0
;slides.c,835 :: 		Glcd_Write_Text("=>", 3, 2, xColorSet);
	MOVLW       ?lstr40_FLOW_32METER+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr40_FLOW_32METER+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       3
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;slides.c,836 :: 		set_5x7();
	CALL        _set_5x7+0, 0
;slides.c,838 :: 		while(scrl_but(0)==0)
L_slide_1254:
	CLRF        FARG_scrl_but_active+0 
	CALL        _scrl_but+0, 0
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_slide_1255
;slides.c,840 :: 		selection(6);
	MOVLW       6
	MOVWF       FARG_selection_POs+0 
	CALL        _selection+0, 0
;slides.c,841 :: 		if (position==1)
	MOVF        _position+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_slide_1256
;slides.c,843 :: 		set_3x5();
	CALL        _set_3x5+0, 0
;slides.c,844 :: 		clear_errow(3);
	MOVLW       3
	MOVWF       FARG_clear_errow_errow+0 
	CALL        _clear_errow+0, 0
;slides.c,845 :: 		clear_errow(4);
	MOVLW       4
	MOVWF       FARG_clear_errow_errow+0 
	CALL        _clear_errow+0, 0
;slides.c,846 :: 		clear_errow(5);
	MOVLW       5
	MOVWF       FARG_clear_errow_errow+0 
	CALL        _clear_errow+0, 0
;slides.c,847 :: 		clear_errow(6);
	MOVLW       6
	MOVWF       FARG_clear_errow_errow+0 
	CALL        _clear_errow+0, 0
;slides.c,849 :: 		Glcd_Write_Text("=>", 3, 2, xColorSet);
	MOVLW       ?lstr41_FLOW_32METER+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr41_FLOW_32METER+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       3
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;slides.c,850 :: 		set_5x7();
	CALL        _set_5x7+0, 0
;slides.c,851 :: 		}
L_slide_1256:
;slides.c,852 :: 		if (position==2)
	MOVF        _position+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_slide_1257
;slides.c,854 :: 		set_3x5();
	CALL        _set_3x5+0, 0
;slides.c,855 :: 		clear_errow(2);
	MOVLW       2
	MOVWF       FARG_clear_errow_errow+0 
	CALL        _clear_errow+0, 0
;slides.c,856 :: 		clear_errow(4);
	MOVLW       4
	MOVWF       FARG_clear_errow_errow+0 
	CALL        _clear_errow+0, 0
;slides.c,857 :: 		clear_errow(5);
	MOVLW       5
	MOVWF       FARG_clear_errow_errow+0 
	CALL        _clear_errow+0, 0
;slides.c,858 :: 		clear_errow(6);
	MOVLW       6
	MOVWF       FARG_clear_errow_errow+0 
	CALL        _clear_errow+0, 0
;slides.c,859 :: 		Glcd_Write_Text("=>", 3, 3, xColorSet);
	MOVLW       ?lstr42_FLOW_32METER+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr42_FLOW_32METER+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       3
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       3
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;slides.c,860 :: 		set_5x7();
	CALL        _set_5x7+0, 0
;slides.c,861 :: 		}
L_slide_1257:
;slides.c,862 :: 		if (position==3)
	MOVF        _position+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_slide_1258
;slides.c,864 :: 		set_3x5();
	CALL        _set_3x5+0, 0
;slides.c,865 :: 		clear_errow(2);
	MOVLW       2
	MOVWF       FARG_clear_errow_errow+0 
	CALL        _clear_errow+0, 0
;slides.c,866 :: 		clear_errow(3);
	MOVLW       3
	MOVWF       FARG_clear_errow_errow+0 
	CALL        _clear_errow+0, 0
;slides.c,867 :: 		clear_errow(5);
	MOVLW       5
	MOVWF       FARG_clear_errow_errow+0 
	CALL        _clear_errow+0, 0
;slides.c,868 :: 		clear_errow(6);
	MOVLW       6
	MOVWF       FARG_clear_errow_errow+0 
	CALL        _clear_errow+0, 0
;slides.c,869 :: 		Glcd_Write_Text("=>", 3, 4, xColorSet);
	MOVLW       ?lstr43_FLOW_32METER+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr43_FLOW_32METER+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       3
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;slides.c,870 :: 		set_5x7();
	CALL        _set_5x7+0, 0
;slides.c,871 :: 		}
L_slide_1258:
;slides.c,872 :: 		if (position==4)
	MOVF        _position+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_slide_1259
;slides.c,874 :: 		set_3x5();
	CALL        _set_3x5+0, 0
;slides.c,875 :: 		clear_errow(2);
	MOVLW       2
	MOVWF       FARG_clear_errow_errow+0 
	CALL        _clear_errow+0, 0
;slides.c,876 :: 		clear_errow(3);
	MOVLW       3
	MOVWF       FARG_clear_errow_errow+0 
	CALL        _clear_errow+0, 0
;slides.c,877 :: 		clear_errow(4);
	MOVLW       4
	MOVWF       FARG_clear_errow_errow+0 
	CALL        _clear_errow+0, 0
;slides.c,878 :: 		clear_errow(6);
	MOVLW       6
	MOVWF       FARG_clear_errow_errow+0 
	CALL        _clear_errow+0, 0
;slides.c,879 :: 		Glcd_Write_Text("=>", 3, 5, xColorSet);
	MOVLW       ?lstr44_FLOW_32METER+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr44_FLOW_32METER+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       3
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       5
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;slides.c,880 :: 		set_5x7();
	CALL        _set_5x7+0, 0
;slides.c,881 :: 		}
L_slide_1259:
;slides.c,882 :: 		if (position==5)
	MOVF        _position+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_slide_1260
;slides.c,884 :: 		set_3x5();
	CALL        _set_3x5+0, 0
;slides.c,885 :: 		clear_errow(2);
	MOVLW       2
	MOVWF       FARG_clear_errow_errow+0 
	CALL        _clear_errow+0, 0
;slides.c,886 :: 		clear_errow(3);
	MOVLW       3
	MOVWF       FARG_clear_errow_errow+0 
	CALL        _clear_errow+0, 0
;slides.c,887 :: 		clear_errow(4);
	MOVLW       4
	MOVWF       FARG_clear_errow_errow+0 
	CALL        _clear_errow+0, 0
;slides.c,888 :: 		clear_errow(5);
	MOVLW       5
	MOVWF       FARG_clear_errow_errow+0 
	CALL        _clear_errow+0, 0
;slides.c,889 :: 		Glcd_Write_Text("=>", 3, 6, xColorSet);
	MOVLW       ?lstr45_FLOW_32METER+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr45_FLOW_32METER+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       3
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       6
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;slides.c,890 :: 		set_5x7();
	CALL        _set_5x7+0, 0
;slides.c,891 :: 		}
L_slide_1260:
;slides.c,895 :: 		if (set_but(0)==255)
	CLRF        FARG_set_but_active+0 
	CALL        _set_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_slide_1261
;slides.c,898 :: 		if (position==1)
	MOVF        _position+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_slide_1262
;slides.c,900 :: 		while(set_but(0)==255);
L_slide_1263:
	CLRF        FARG_set_but_active+0 
	CALL        _set_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_slide_1264
	GOTO        L_slide_1263
L_slide_1264:
;slides.c,901 :: 		range_set();
	CALL        _range_set+0, 0
;slides.c,902 :: 		}
L_slide_1262:
;slides.c,903 :: 		}
L_slide_1261:
;slides.c,904 :: 		if (set_but(0)==255)
	CLRF        FARG_set_but_active+0 
	CALL        _set_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_slide_1265
;slides.c,906 :: 		if (position==2)
	MOVF        _position+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_slide_1266
;slides.c,908 :: 		while(set_but(0)==255);
L_slide_1267:
	CLRF        FARG_set_but_active+0 
	CALL        _set_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_slide_1268
	GOTO        L_slide_1267
L_slide_1268:
;slides.c,909 :: 		unit_set();
	CALL        _unit_set+0, 0
;slides.c,910 :: 		}
L_slide_1266:
;slides.c,911 :: 		}
L_slide_1265:
;slides.c,912 :: 		if (set_but(0)==255)
	CLRF        FARG_set_but_active+0 
	CALL        _set_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_slide_1269
;slides.c,914 :: 		if (position==3)
	MOVF        _position+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_slide_1270
;slides.c,916 :: 		while(set_but(0)==255)
L_slide_1271:
	CLRF        FARG_set_but_active+0 
	CALL        _set_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_slide_1272
;slides.c,918 :: 		while(set_but(0)==255);
L_slide_1273:
	CLRF        FARG_set_but_active+0 
	CALL        _set_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_slide_1274
	GOTO        L_slide_1273
L_slide_1274:
;slides.c,919 :: 		sqrt_set();
	CALL        _sqrt_set+0, 0
;slides.c,920 :: 		}
	GOTO        L_slide_1271
L_slide_1272:
;slides.c,921 :: 		}
L_slide_1270:
;slides.c,922 :: 		}
L_slide_1269:
;slides.c,923 :: 		if (set_but(0)==255)
	CLRF        FARG_set_but_active+0 
	CALL        _set_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_slide_1275
;slides.c,925 :: 		if (position==4)
	MOVF        _position+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_slide_1276
;slides.c,927 :: 		while(set_but(0)==255)
L_slide_1277:
	CLRF        FARG_set_but_active+0 
	CALL        _set_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_slide_1278
;slides.c,929 :: 		while(set_but(0)==255);
L_slide_1279:
	CLRF        FARG_set_but_active+0 
	CALL        _set_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_slide_1280
	GOTO        L_slide_1279
L_slide_1280:
;slides.c,930 :: 		K_settong();
	CALL        _K_settong+0, 0
;slides.c,931 :: 		}
	GOTO        L_slide_1277
L_slide_1278:
;slides.c,932 :: 		}
L_slide_1276:
;slides.c,933 :: 		}
L_slide_1275:
;slides.c,934 :: 		if (set_but(0)==255)
	CLRF        FARG_set_but_active+0 
	CALL        _set_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_slide_1281
;slides.c,936 :: 		if (position==5)
	MOVF        _position+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_slide_1282
;slides.c,938 :: 		while(set_but(0)==255)
L_slide_1283:
	CLRF        FARG_set_but_active+0 
	CALL        _set_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_slide_1284
;slides.c,940 :: 		while(set_but(0)==255);
L_slide_1285:
	CLRF        FARG_set_but_active+0 
	CALL        _set_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_slide_1286
	GOTO        L_slide_1285
L_slide_1286:
;slides.c,941 :: 		Reset();
	CALL        _Reset+0, 0
;slides.c,942 :: 		}
	GOTO        L_slide_1283
L_slide_1284:
;slides.c,943 :: 		}
L_slide_1282:
;slides.c,944 :: 		}
L_slide_1281:
;slides.c,945 :: 		}
	GOTO        L_slide_1254
L_slide_1255:
;slides.c,946 :: 		OPEN=1;
	MOVLW       1
	MOVWF       _OPEN+0 
;slides.c,947 :: 		cls();
	CALL        _cls+0, 0
;slides.c,948 :: 		}
L_end_slide_1:
	RETURN      0
; end of _slide_1

_read_ds1307:

;flow_meter_i2c.c,1 :: 		unsigned short read_ds1307(unsigned short address)
;flow_meter_i2c.c,4 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;flow_meter_i2c.c,5 :: 		I2C1_Wr(0xd0); //address 0x68 followed by direction bit (0 for write, 1 for read) 0x68 followed by 0 --> 0xD0
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;flow_meter_i2c.c,6 :: 		I2C1_Wr(address);
	MOVF        FARG_read_ds1307_address+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;flow_meter_i2c.c,7 :: 		I2C1_Repeated_Start();
	CALL        _I2C1_Repeated_Start+0, 0
;flow_meter_i2c.c,8 :: 		I2C1_Wr(0xd1); //0x68 followed by 1 --> 0xD1
	MOVLW       209
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;flow_meter_i2c.c,9 :: 		dataa=I2C1_Rd(0);
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       read_ds1307_dataa_L0+0 
;flow_meter_i2c.c,10 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;flow_meter_i2c.c,11 :: 		return(dataa);
	MOVF        read_ds1307_dataa_L0+0, 0 
	MOVWF       R0 
;flow_meter_i2c.c,12 :: 		}
L_end_read_ds1307:
	RETURN      0
; end of _read_ds1307

_write_ds1307:

;flow_meter_i2c.c,14 :: 		void write_ds1307(unsigned short address,unsigned short w_data)
;flow_meter_i2c.c,16 :: 		I2C1_Start(); // issue I2C start signal
	CALL        _I2C1_Start+0, 0
;flow_meter_i2c.c,18 :: 		I2C1_Wr(0xD0); // send byte via I2C (device address + W)
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;flow_meter_i2c.c,19 :: 		I2C1_Wr(address); // send byte (address of DS1307 location)
	MOVF        FARG_write_ds1307_address+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;flow_meter_i2c.c,20 :: 		I2C1_Wr(w_data); // send data (data to be written)
	MOVF        FARG_write_ds1307_w_data+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;flow_meter_i2c.c,21 :: 		I2C1_Stop(); // issue I2C stop signal
	CALL        _I2C1_Stop+0, 0
;flow_meter_i2c.c,22 :: 		}
L_end_write_ds1307:
	RETURN      0
; end of _write_ds1307

_dafualt_timer:

;flow_meter_i2c.c,25 :: 		void dafualt_timer()
;flow_meter_i2c.c,28 :: 		Glcd_write_text("Dafult time",28,6,xColorSet);  // Write counter value
	MOVLW       ?lstr46_FLOW_32METER+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr46_FLOW_32METER+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       28
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       6
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;flow_meter_i2c.c,29 :: 		write_ds1307(0,0x80); //Reset second to 0 sec. and stop Oscillator
	CLRF        FARG_write_ds1307_address+0 
	MOVLW       128
	MOVWF       FARG_write_ds1307_w_data+0 
	CALL        _write_ds1307+0, 0
;flow_meter_i2c.c,30 :: 		write_ds1307(1,0x25); //write min 25
	MOVLW       1
	MOVWF       FARG_write_ds1307_address+0 
	MOVLW       37
	MOVWF       FARG_write_ds1307_w_data+0 
	CALL        _write_ds1307+0, 0
;flow_meter_i2c.c,31 :: 		write_ds1307(2,0x69); //write hour 8 PM
	MOVLW       2
	MOVWF       FARG_write_ds1307_address+0 
	MOVLW       105
	MOVWF       FARG_write_ds1307_w_data+0 
	CALL        _write_ds1307+0, 0
;flow_meter_i2c.c,32 :: 		write_ds1307(3,0x07); //write day of week 2:Saturday
	MOVLW       3
	MOVWF       FARG_write_ds1307_address+0 
	MOVLW       7
	MOVWF       FARG_write_ds1307_w_data+0 
	CALL        _write_ds1307+0, 0
;flow_meter_i2c.c,33 :: 		write_ds1307(4,0x22); // write date 22
	MOVLW       4
	MOVWF       FARG_write_ds1307_address+0 
	MOVLW       34
	MOVWF       FARG_write_ds1307_w_data+0 
	CALL        _write_ds1307+0, 0
;flow_meter_i2c.c,34 :: 		write_ds1307(5,0x05); // write month May
	MOVLW       5
	MOVWF       FARG_write_ds1307_address+0 
	MOVLW       5
	MOVWF       FARG_write_ds1307_w_data+0 
	CALL        _write_ds1307+0, 0
;flow_meter_i2c.c,35 :: 		write_ds1307(6,0x10); // write year 10 --> 2010
	MOVLW       6
	MOVWF       FARG_write_ds1307_address+0 
	MOVLW       16
	MOVWF       FARG_write_ds1307_w_data+0 
	CALL        _write_ds1307+0, 0
;flow_meter_i2c.c,36 :: 		write_ds1307(7,0x10); //SQWE output at 1 Hz
	MOVLW       7
	MOVWF       FARG_write_ds1307_address+0 
	MOVLW       16
	MOVWF       FARG_write_ds1307_w_data+0 
	CALL        _write_ds1307+0, 0
;flow_meter_i2c.c,37 :: 		write_ds1307(0,0x00); //Reset second to 0 sec. and start Oscillator
	CLRF        FARG_write_ds1307_address+0 
	CLRF        FARG_write_ds1307_w_data+0 
	CALL        _write_ds1307+0, 0
;flow_meter_i2c.c,38 :: 		write_ds1307(0x2F,0xAA);
	MOVLW       47
	MOVWF       FARG_write_ds1307_address+0 
	MOVLW       170
	MOVWF       FARG_write_ds1307_w_data+0 
	CALL        _write_ds1307+0, 0
;flow_meter_i2c.c,39 :: 		delay_ms(500);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_dafualt_timer287:
	DECFSZ      R13, 1, 1
	BRA         L_dafualt_timer287
	DECFSZ      R12, 1, 1
	BRA         L_dafualt_timer287
	DECFSZ      R11, 1, 1
	BRA         L_dafualt_timer287
	NOP
;flow_meter_i2c.c,40 :: 		Glcd_write_text("Dafult time set",0,0,xColorSet);  // Write counter value
	MOVLW       ?lstr47_FLOW_32METER+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr47_FLOW_32METER+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	CLRF        FARG_Glcd_Write_Text_x_pos+0 
	CLRF        FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;flow_meter_i2c.c,42 :: 		}
L_end_dafualt_timer:
	RETURN      0
; end of _dafualt_timer

_totalizer_save:

;FLOW METER.c,161 :: 		void totalizer_save()
;FLOW METER.c,164 :: 		TOTALLIZER_saved=TOTALLIZER*10000.0;
	MOVF        _TOTALLIZER+0, 0 
	MOVWF       R0 
	MOVF        _TOTALLIZER+1, 0 
	MOVWF       R1 
	MOVF        _TOTALLIZER+2, 0 
	MOVWF       R2 
	MOVF        _TOTALLIZER+3, 0 
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
	MOVLW       64
	MOVWF       R5 
	MOVLW       28
	MOVWF       R6 
	MOVLW       140
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       totalizer_save_TOTALLIZER_saved_L0+0 
	MOVF        R1, 0 
	MOVWF       totalizer_save_TOTALLIZER_saved_L0+1 
	MOVF        R2, 0 
	MOVWF       totalizer_save_TOTALLIZER_saved_L0+2 
	MOVF        R3, 0 
	MOVWF       totalizer_save_TOTALLIZER_saved_L0+3 
;FLOW METER.c,167 :: 		write_ds1307(50,Lo(TOTALLIZER_saved));
	MOVLW       50
	MOVWF       FARG_write_ds1307_address+0 
	MOVF        totalizer_save_TOTALLIZER_saved_L0+0, 0 
	MOVWF       FARG_write_ds1307_w_data+0 
	CALL        _write_ds1307+0, 0
;FLOW METER.c,169 :: 		write_ds1307(51,Hi(TOTALLIZER_saved));
	MOVLW       51
	MOVWF       FARG_write_ds1307_address+0 
	MOVF        totalizer_save_TOTALLIZER_saved_L0+1, 0 
	MOVWF       FARG_write_ds1307_w_data+0 
	CALL        _write_ds1307+0, 0
;FLOW METER.c,171 :: 		write_ds1307(52,Higher(TOTALLIZER_saved));
	MOVLW       52
	MOVWF       FARG_write_ds1307_address+0 
	MOVF        totalizer_save_TOTALLIZER_saved_L0+2, 0 
	MOVWF       FARG_write_ds1307_w_data+0 
	CALL        _write_ds1307+0, 0
;FLOW METER.c,173 :: 		write_ds1307(53,Highest(TOTALLIZER_saved));
	MOVLW       53
	MOVWF       FARG_write_ds1307_address+0 
	MOVF        totalizer_save_TOTALLIZER_saved_L0+3, 0 
	MOVWF       FARG_write_ds1307_w_data+0 
	CALL        _write_ds1307+0, 0
;FLOW METER.c,187 :: 		}
L_end_totalizer_save:
	RETURN      0
; end of _totalizer_save

_totalizer_read:

;FLOW METER.c,189 :: 		void totalizer_read()
;FLOW METER.c,192 :: 		Lo(TOTALLIZER) = read_ds1307(50);
	MOVLW       50
	MOVWF       FARG_read_ds1307_address+0 
	CALL        _read_ds1307+0, 0
	MOVF        R0, 0 
	MOVWF       _TOTALLIZER+0 
;FLOW METER.c,194 :: 		Hi(TOTALLIZER) = read_ds1307(51);
	MOVLW       51
	MOVWF       FARG_read_ds1307_address+0 
	CALL        _read_ds1307+0, 0
	MOVF        R0, 0 
	MOVWF       _TOTALLIZER+1 
;FLOW METER.c,196 :: 		Higher(TOTALLIZER) = read_ds1307(52);
	MOVLW       52
	MOVWF       FARG_read_ds1307_address+0 
	CALL        _read_ds1307+0, 0
	MOVF        R0, 0 
	MOVWF       _TOTALLIZER+2 
;FLOW METER.c,198 :: 		Highest(TOTALLIZER) = read_ds1307(53);
	MOVLW       53
	MOVWF       FARG_read_ds1307_address+0 
	CALL        _read_ds1307+0, 0
	MOVF        R0, 0 
	MOVWF       _TOTALLIZER+3 
;FLOW METER.c,211 :: 		TOTALLIZER/=10000.0;
	MOVLW       0
	MOVWF       R4 
	MOVLW       64
	MOVWF       R5 
	MOVLW       28
	MOVWF       R6 
	MOVLW       140
	MOVWF       R7 
	MOVF        _TOTALLIZER+0, 0 
	MOVWF       R0 
	MOVF        _TOTALLIZER+1, 0 
	MOVWF       R1 
	MOVF        _TOTALLIZER+2, 0 
	MOVWF       R2 
	MOVF        _TOTALLIZER+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _TOTALLIZER+0 
	MOVF        R1, 0 
	MOVWF       _TOTALLIZER+1 
	MOVF        R2, 0 
	MOVWF       _TOTALLIZER+2 
	MOVF        R3, 0 
	MOVWF       _TOTALLIZER+3 
;FLOW METER.c,212 :: 		}
L_end_totalizer_read:
	RETURN      0
; end of _totalizer_read

_total_rizer_cal:

;FLOW METER.c,215 :: 		void total_rizer_cal()
;FLOW METER.c,217 :: 		if (Total_flag==1)
	MOVF        _Total_flag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_total_rizer_cal288
;FLOW METER.c,219 :: 		Total_flag=0;
	CLRF        _Total_flag+0 
;FLOW METER.c,221 :: 		TOTALLIZER+=actual_flow/3600.0;
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       97
	MOVWF       R6 
	MOVLW       138
	MOVWF       R7 
	MOVF        _actual_flow+0, 0 
	MOVWF       R0 
	MOVF        _actual_flow+1, 0 
	MOVWF       R1 
	MOVF        _actual_flow+2, 0 
	MOVWF       R2 
	MOVF        _actual_flow+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	MOVF        _TOTALLIZER+0, 0 
	MOVWF       R4 
	MOVF        _TOTALLIZER+1, 0 
	MOVWF       R5 
	MOVF        _TOTALLIZER+2, 0 
	MOVWF       R6 
	MOVF        _TOTALLIZER+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _TOTALLIZER+0 
	MOVF        R1, 0 
	MOVWF       _TOTALLIZER+1 
	MOVF        R2, 0 
	MOVWF       _TOTALLIZER+2 
	MOVF        R3, 0 
	MOVWF       _TOTALLIZER+3 
;FLOW METER.c,222 :: 		totalizer_save();
	CALL        _totalizer_save+0, 0
;FLOW METER.c,223 :: 		set_8x7();
	CALL        _set_8x7+0, 0
;FLOW METER.c,224 :: 		if (NUMBER_UNIT==3 || NUMBER_UNIT==2)
	MOVF        _NUMBER_UNIT+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L__total_rizer_cal379
	MOVF        _NUMBER_UNIT+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L__total_rizer_cal379
	GOTO        L_total_rizer_cal291
L__total_rizer_cal379:
;FLOW METER.c,227 :: 		sprintf(total_txt, "%.3f", TOTALLIZER/1000.0);
	MOVLW       _total_txt+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_total_txt+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_48_FLOW_32METER+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_48_FLOW_32METER+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_48_FLOW_32METER+0)
	MOVWF       FARG_sprintf_f+2 
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       122
	MOVWF       R6 
	MOVLW       136
	MOVWF       R7 
	MOVF        _TOTALLIZER+0, 0 
	MOVWF       R0 
	MOVF        _TOTALLIZER+1, 0 
	MOVWF       R1 
	MOVF        _TOTALLIZER+2, 0 
	MOVWF       R2 
	MOVF        _TOTALLIZER+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        R1, 0 
	MOVWF       FARG_sprintf_wh+6 
	MOVF        R2, 0 
	MOVWF       FARG_sprintf_wh+7 
	MOVF        R3, 0 
	MOVWF       FARG_sprintf_wh+8 
	CALL        _sprintf+0, 0
;FLOW METER.c,228 :: 		}
	GOTO        L_total_rizer_cal292
L_total_rizer_cal291:
;FLOW METER.c,231 :: 		sprintf(total_txt, "%.0f", TOTALLIZER);
	MOVLW       _total_txt+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_total_txt+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_49_FLOW_32METER+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_49_FLOW_32METER+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_49_FLOW_32METER+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        _TOTALLIZER+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _TOTALLIZER+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	MOVF        _TOTALLIZER+2, 0 
	MOVWF       FARG_sprintf_wh+7 
	MOVF        _TOTALLIZER+3, 0 
	MOVWF       FARG_sprintf_wh+8 
	CALL        _sprintf+0, 0
;FLOW METER.c,232 :: 		}
L_total_rizer_cal292:
;FLOW METER.c,234 :: 		Glcd_write_text(total_txt,28,6,xColorSet);  // Write counter value
	MOVLW       _total_txt+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(_total_txt+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       28
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       6
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;FLOW METER.c,235 :: 		}
L_total_rizer_cal288:
;FLOW METER.c,236 :: 		}
L_end_total_rizer_cal:
	RETURN      0
; end of _total_rizer_cal

_main:

;FLOW METER.c,239 :: 		void main()
;FLOW METER.c,241 :: 		OSCCON.IRCF0=1;
	BSF         OSCCON+0, 4 
;FLOW METER.c,242 :: 		OSCCON.IRCF1=1;
	BSF         OSCCON+0, 5 
;FLOW METER.c,243 :: 		OSCCON.IRCF2=1;
	BSF         OSCCON+0, 6 
;FLOW METER.c,244 :: 		OSCCON.SCS1=1;
	BSF         OSCCON+0, 1 
;FLOW METER.c,245 :: 		OSCCON.SCS1=0;
	BCF         OSCCON+0, 1 
;FLOW METER.c,246 :: 		OSCTUNE.PLLEN=1;
	BSF         OSCTUNE+0, 6 
;FLOW METER.c,247 :: 		OSCTUNE.TUN0=0;
	BCF         OSCTUNE+0, 0 
;FLOW METER.c,248 :: 		OSCTUNE.TUN1=0;
	BCF         OSCTUNE+0, 1 
;FLOW METER.c,249 :: 		OSCTUNE.TUN2=0;
	BCF         OSCTUNE+0, 2 
;FLOW METER.c,250 :: 		OSCTUNE.TUN3=0;
	BCF         OSCTUNE+0, 3 
;FLOW METER.c,251 :: 		OSCTUNE.TUN4=0;
	BCF         OSCTUNE+0, 4 
;FLOW METER.c,253 :: 		trise=0;
	CLRF        TRISE+0 
;FLOW METER.c,254 :: 		trise.b0=1;
	BSF         TRISE+0, 0 
;FLOW METER.c,255 :: 		trise.b1=1;
	BSF         TRISE+0, 1 
;FLOW METER.c,256 :: 		trise.b2=1;
	BSF         TRISE+0, 2 
;FLOW METER.c,257 :: 		ADC_Init();
	CALL        _ADC_Init+0, 0
;FLOW METER.c,258 :: 		Init_mcu();
	CALL        _Init_mcu+0, 0
;FLOW METER.c,259 :: 		Glcd_Init();       // Init for EasyPIC3 board
	CALL        _Glcd_Init+0, 0
;FLOW METER.c,260 :: 		CLS();
	CALL        _cls+0, 0
;FLOW METER.c,261 :: 		xGlcd_Set_Font(Tahoma14x15 , 14,15,46);
	MOVLW       _Tahoma14x15+0
	MOVWF       FARG_xGlcd_Set_Font_ptrFontTbl+0 
	MOVLW       hi_addr(_Tahoma14x15+0)
	MOVWF       FARG_xGlcd_Set_Font_ptrFontTbl+1 
	MOVLW       higher_addr(_Tahoma14x15+0)
	MOVWF       FARG_xGlcd_Set_Font_ptrFontTbl+2 
	MOVLW       14
	MOVWF       FARG_xGlcd_Set_Font_font_width+0 
	MOVLW       15
	MOVWF       FARG_xGlcd_Set_Font_font_height+0 
	MOVLW       46
	MOVWF       FARG_xGlcd_Set_Font_font_offset+0 
	MOVLW       0
	MOVWF       FARG_xGlcd_Set_Font_font_offset+1 
	CALL        _xGlcd_Set_Font+0, 0
;FLOW METER.c,262 :: 		set_8x7();
	CALL        _set_8x7+0, 0
;FLOW METER.c,269 :: 		fill();
	CALL        _fill+0, 0
;FLOW METER.c,270 :: 		someText = "Omni_Telemetry";
	MOVLW       ?lstr50_FLOW_32METER+0
	MOVWF       _someText+0 
	MOVLW       hi_addr(?lstr50_FLOW_32METER+0)
	MOVWF       _someText+1 
;FLOW METER.c,271 :: 		ii = (128-xGlcd_Text_Width(someText)) / 2;  // 128  is the width of the GLCD
	MOVF        _someText+0, 0 
	MOVWF       FARG_xGlcd_Text_Width_text+0 
	MOVF        _someText+1, 0 
	MOVWF       FARG_xGlcd_Text_Width_text+1 
	CALL        _xGlcd_Text_Width+0, 0
	MOVF        R0, 0 
	SUBLW       128
	MOVWF       R3 
	CLRF        R4 
	MOVLW       0
	SUBWFB      R4, 1 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	BTFSC       R1, 6 
	BSF         R1, 7 
	MOVF        R0, 0 
	MOVWF       _ii+0 
;FLOW METER.c,272 :: 		xGlcd_Write_Text(someText,ii,16,xColorINVERT);
	MOVF        _someText+0, 0 
	MOVWF       FARG_xGlcd_Write_Text_text+0 
	MOVF        _someText+1, 0 
	MOVWF       FARG_xGlcd_Write_Text_text+1 
	MOVF        R0, 0 
	MOVWF       FARG_xGlcd_Write_Text_x+0 
	MOVLW       16
	MOVWF       FARG_xGlcd_Write_Text_y+0 
	MOVLW       2
	MOVWF       FARG_xGlcd_Write_Text_color+0 
	CALL        _xGlcd_Write_Text+0, 0
;FLOW METER.c,274 :: 		someText = "www.Omnitm.ca";
	MOVLW       ?lstr51_FLOW_32METER+0
	MOVWF       _someText+0 
	MOVLW       hi_addr(?lstr51_FLOW_32METER+0)
	MOVWF       _someText+1 
;FLOW METER.c,275 :: 		ii = (128-xGlcd_Text_Width(someText)) / 2;  // 128  is the width of the GLCD
	MOVF        _someText+0, 0 
	MOVWF       FARG_xGlcd_Text_Width_text+0 
	MOVF        _someText+1, 0 
	MOVWF       FARG_xGlcd_Text_Width_text+1 
	CALL        _xGlcd_Text_Width+0, 0
	MOVF        R0, 0 
	SUBLW       128
	MOVWF       R3 
	CLRF        R4 
	MOVLW       0
	SUBWFB      R4, 1 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	BTFSC       R1, 6 
	BSF         R1, 7 
	MOVF        R0, 0 
	MOVWF       _ii+0 
;FLOW METER.c,276 :: 		xGlcd_Write_Text(someText,ii,32,xColorINVERT);
	MOVF        _someText+0, 0 
	MOVWF       FARG_xGlcd_Write_Text_text+0 
	MOVF        _someText+1, 0 
	MOVWF       FARG_xGlcd_Write_Text_text+1 
	MOVF        R0, 0 
	MOVWF       FARG_xGlcd_Write_Text_x+0 
	MOVLW       32
	MOVWF       FARG_xGlcd_Write_Text_y+0 
	MOVLW       2
	MOVWF       FARG_xGlcd_Write_Text_color+0 
	CALL        _xGlcd_Write_Text+0, 0
;FLOW METER.c,277 :: 		delay_ms(5000);
	MOVLW       203
	MOVWF       R11, 0
	MOVLW       236
	MOVWF       R12, 0
	MOVLW       132
	MOVWF       R13, 0
L_main293:
	DECFSZ      R13, 1, 1
	BRA         L_main293
	DECFSZ      R12, 1, 1
	BRA         L_main293
	DECFSZ      R11, 1, 1
	BRA         L_main293
	NOP
;FLOW METER.c,278 :: 		CLS();
	CALL        _cls+0, 0
;FLOW METER.c,279 :: 		fill();
	CALL        _fill+0, 0
;FLOW METER.c,280 :: 		someText = "Flow_Computer";
	MOVLW       ?lstr52_FLOW_32METER+0
	MOVWF       _someText+0 
	MOVLW       hi_addr(?lstr52_FLOW_32METER+0)
	MOVWF       _someText+1 
;FLOW METER.c,281 :: 		ii = (128-xGlcd_Text_Width(someText)) / 2;  // 128  is the width of the GLCD
	MOVF        _someText+0, 0 
	MOVWF       FARG_xGlcd_Text_Width_text+0 
	MOVF        _someText+1, 0 
	MOVWF       FARG_xGlcd_Text_Width_text+1 
	CALL        _xGlcd_Text_Width+0, 0
	MOVF        R0, 0 
	SUBLW       128
	MOVWF       R3 
	CLRF        R4 
	MOVLW       0
	SUBWFB      R4, 1 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	BTFSC       R1, 6 
	BSF         R1, 7 
	MOVF        R0, 0 
	MOVWF       _ii+0 
;FLOW METER.c,282 :: 		xGlcd_Write_Text(someText,ii,5,xColorinvert);
	MOVF        _someText+0, 0 
	MOVWF       FARG_xGlcd_Write_Text_text+0 
	MOVF        _someText+1, 0 
	MOVWF       FARG_xGlcd_Write_Text_text+1 
	MOVF        R0, 0 
	MOVWF       FARG_xGlcd_Write_Text_x+0 
	MOVLW       5
	MOVWF       FARG_xGlcd_Write_Text_y+0 
	MOVLW       2
	MOVWF       FARG_xGlcd_Write_Text_color+0 
	CALL        _xGlcd_Write_Text+0, 0
;FLOW METER.c,285 :: 		someText = "FCU_5400";
	MOVLW       ?lstr53_FLOW_32METER+0
	MOVWF       _someText+0 
	MOVLW       hi_addr(?lstr53_FLOW_32METER+0)
	MOVWF       _someText+1 
;FLOW METER.c,286 :: 		ii = (128-xGlcd_Text_Width(someText)) / 2;  // 128  is the width of the GLCD
	MOVF        _someText+0, 0 
	MOVWF       FARG_xGlcd_Text_Width_text+0 
	MOVF        _someText+1, 0 
	MOVWF       FARG_xGlcd_Text_Width_text+1 
	CALL        _xGlcd_Text_Width+0, 0
	MOVF        R0, 0 
	SUBLW       128
	MOVWF       R3 
	CLRF        R4 
	MOVLW       0
	SUBWFB      R4, 1 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	BTFSC       R1, 6 
	BSF         R1, 7 
	MOVF        R0, 0 
	MOVWF       _ii+0 
;FLOW METER.c,287 :: 		xGlcd_Write_Text(someText,ii,21,xColorinvert);
	MOVF        _someText+0, 0 
	MOVWF       FARG_xGlcd_Write_Text_text+0 
	MOVF        _someText+1, 0 
	MOVWF       FARG_xGlcd_Write_Text_text+1 
	MOVF        R0, 0 
	MOVWF       FARG_xGlcd_Write_Text_x+0 
	MOVLW       21
	MOVWF       FARG_xGlcd_Write_Text_y+0 
	MOVLW       2
	MOVWF       FARG_xGlcd_Write_Text_color+0 
	CALL        _xGlcd_Write_Text+0, 0
;FLOW METER.c,292 :: 		someText = "Intellengent";
	MOVLW       ?lstr54_FLOW_32METER+0
	MOVWF       _someText+0 
	MOVLW       hi_addr(?lstr54_FLOW_32METER+0)
	MOVWF       _someText+1 
;FLOW METER.c,293 :: 		Glcd_Write_Text(someText, 4, 5, xColorinvert);
	MOVF        _someText+0, 0 
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVF        _someText+1, 0 
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       5
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;FLOW METER.c,298 :: 		someText = "Flow_Metering";
	MOVLW       ?lstr55_FLOW_32METER+0
	MOVWF       _someText+0 
	MOVLW       hi_addr(?lstr55_FLOW_32METER+0)
	MOVWF       _someText+1 
;FLOW METER.c,299 :: 		Glcd_Write_Text(someText, 4, 6, xColorinvert);
	MOVF        _someText+0, 0 
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVF        _someText+1, 0 
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       6
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;FLOW METER.c,302 :: 		delay_ms(5000);
	MOVLW       203
	MOVWF       R11, 0
	MOVLW       236
	MOVWF       R12, 0
	MOVLW       132
	MOVWF       R13, 0
L_main294:
	DECFSZ      R13, 1, 1
	BRA         L_main294
	DECFSZ      R12, 1, 1
	BRA         L_main294
	DECFSZ      R11, 1, 1
	BRA         L_main294
	NOP
;FLOW METER.c,304 :: 		CLS();
	CALL        _cls+0, 0
;FLOW METER.c,305 :: 		if (set_but(0)==255)
	CLRF        FARG_set_but_active+0 
	CALL        _set_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_main295
;FLOW METER.c,307 :: 		set_5x7();
	CALL        _set_5x7+0, 0
;FLOW METER.c,308 :: 		someText = "ADC SETTING MODE";
	MOVLW       ?lstr56_FLOW_32METER+0
	MOVWF       _someText+0 
	MOVLW       hi_addr(?lstr56_FLOW_32METER+0)
	MOVWF       _someText+1 
;FLOW METER.c,309 :: 		Glcd_Write_Text(someText, 4, 4, xColorinvert);
	MOVF        _someText+0, 0 
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVF        _someText+1, 0 
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;FLOW METER.c,310 :: 		Setting_Mode_Enter=1;
	MOVLW       1
	MOVWF       _Setting_Mode_Enter+0 
;FLOW METER.c,311 :: 		delay_ms(3000);
	MOVLW       122
	MOVWF       R11, 0
	MOVLW       193
	MOVWF       R12, 0
	MOVLW       129
	MOVWF       R13, 0
L_main296:
	DECFSZ      R13, 1, 1
	BRA         L_main296
	DECFSZ      R12, 1, 1
	BRA         L_main296
	DECFSZ      R11, 1, 1
	BRA         L_main296
	NOP
	NOP
;FLOW METER.c,312 :: 		}
L_main295:
;FLOW METER.c,315 :: 		CLS();
	CALL        _cls+0, 0
;FLOW METER.c,316 :: 		volts=00000000;
	CLRF        _volts+0 
	CLRF        _volts+1 
	CLRF        _volts+2 
	CLRF        _volts+3 
;FLOW METER.c,317 :: 		xGlcd_Set_Font(Tahoma15x24, 15,24,45);
	MOVLW       _Tahoma15x24+0
	MOVWF       FARG_xGlcd_Set_Font_ptrFontTbl+0 
	MOVLW       hi_addr(_Tahoma15x24+0)
	MOVWF       FARG_xGlcd_Set_Font_ptrFontTbl+1 
	MOVLW       higher_addr(_Tahoma15x24+0)
	MOVWF       FARG_xGlcd_Set_Font_ptrFontTbl+2 
	MOVLW       15
	MOVWF       FARG_xGlcd_Set_Font_font_width+0 
	MOVLW       24
	MOVWF       FARG_xGlcd_Set_Font_font_height+0 
	MOVLW       45
	MOVWF       FARG_xGlcd_Set_Font_font_offset+0 
	MOVLW       0
	MOVWF       FARG_xGlcd_Set_Font_font_offset+1 
	CALL        _xGlcd_Set_Font+0, 0
;FLOW METER.c,318 :: 		set_5x7();
	CALL        _set_5x7+0, 0
;FLOW METER.c,319 :: 		set_3x5();
	CALL        _set_3x5+0, 0
;FLOW METER.c,320 :: 		sqrt_UNIT  = EEPROM_Read(14);
	MOVLW       14
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sqrt_UNIT+0 
;FLOW METER.c,321 :: 		delay_ms(10);
	MOVLW       104
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_main297:
	DECFSZ      R13, 1, 1
	BRA         L_main297
	DECFSZ      R12, 1, 1
	BRA         L_main297
	NOP
;FLOW METER.c,322 :: 		NUMBER_UNIT  = EEPROM_Read(15);
	MOVLW       15
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _NUMBER_UNIT+0 
;FLOW METER.c,323 :: 		delay_ms(10);
	MOVLW       104
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_main298:
	DECFSZ      R13, 1, 1
	BRA         L_main298
	DECFSZ      R12, 1, 1
	BRA         L_main298
	NOP
;FLOW METER.c,324 :: 		KVALUE=EEPROM_Read(16);
	MOVLW       16
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _KVALUE+0 
	MOVLW       0
	MOVWF       _KVALUE+1 
;FLOW METER.c,325 :: 		KVALUE_k=KVALUE/100.0;
	MOVF        _KVALUE+0, 0 
	MOVWF       R0 
	MOVF        _KVALUE+1, 0 
	MOVWF       R1 
	CALL        _Int2Double+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       72
	MOVWF       R6 
	MOVLW       133
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _KVALUE_k+0 
	MOVF        R1, 0 
	MOVWF       _KVALUE_k+1 
	MOVF        R2, 0 
	MOVWF       _KVALUE_k+2 
	MOVF        R3, 0 
	MOVWF       _KVALUE_k+3 
;FLOW METER.c,326 :: 		delay_ms(10);
	MOVLW       104
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_main299:
	DECFSZ      R13, 1, 1
	BRA         L_main299
	DECFSZ      R12, 1, 1
	BRA         L_main299
	NOP
;FLOW METER.c,327 :: 		Lo(lo_RAGE)=EEPROM_Read(10);
	MOVLW       10
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _lo_RAGE+0 
;FLOW METER.c,328 :: 		delay_ms(10);
	MOVLW       104
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_main300:
	DECFSZ      R13, 1, 1
	BRA         L_main300
	DECFSZ      R12, 1, 1
	BRA         L_main300
	NOP
;FLOW METER.c,329 :: 		Hi(lo_RAGE)=EEPROM_Read(11);
	MOVLW       11
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _lo_RAGE+1 
;FLOW METER.c,330 :: 		delay_ms(10);
	MOVLW       104
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_main301:
	DECFSZ      R13, 1, 1
	BRA         L_main301
	DECFSZ      R12, 1, 1
	BRA         L_main301
	NOP
;FLOW METER.c,331 :: 		Lo(hi_RAGE)=EEPROM_Read(12);
	MOVLW       12
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _hi_RAGE+0 
;FLOW METER.c,332 :: 		delay_ms(10);
	MOVLW       104
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_main302:
	DECFSZ      R13, 1, 1
	BRA         L_main302
	DECFSZ      R12, 1, 1
	BRA         L_main302
	NOP
;FLOW METER.c,333 :: 		Hi(hi_RAGE)=EEPROM_Read(13);
	MOVLW       13
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _hi_RAGE+1 
;FLOW METER.c,334 :: 		delay_ms(10);
	MOVLW       104
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_main303:
	DECFSZ      R13, 1, 1
	BRA         L_main303
	DECFSZ      R12, 1, 1
	BRA         L_main303
	NOP
;FLOW METER.c,335 :: 		set_5x7();
	CALL        _set_5x7+0, 0
;FLOW METER.c,338 :: 		if (NUMBER_UNIT==1)
	MOVF        _NUMBER_UNIT+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main304
;FLOW METER.c,340 :: 		someText = "kg/h";
	MOVLW       ?lstr57_FLOW_32METER+0
	MOVWF       _someText+0 
	MOVLW       hi_addr(?lstr57_FLOW_32METER+0)
	MOVWF       _someText+1 
;FLOW METER.c,341 :: 		}
	GOTO        L_main305
L_main304:
;FLOW METER.c,342 :: 		else if (NUMBER_UNIT==2)
	MOVF        _NUMBER_UNIT+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_main306
;FLOW METER.c,344 :: 		someText = "m3/h";
	MOVLW       ?lstr58_FLOW_32METER+0
	MOVWF       _someText+0 
	MOVLW       hi_addr(?lstr58_FLOW_32METER+0)
	MOVWF       _someText+1 
;FLOW METER.c,345 :: 		}
	GOTO        L_main307
L_main306:
;FLOW METER.c,346 :: 		else  if (NUMBER_UNIT==3)
	MOVF        _NUMBER_UNIT+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_main308
;FLOW METER.c,348 :: 		someText = "TPH";
	MOVLW       ?lstr59_FLOW_32METER+0
	MOVWF       _someText+0 
	MOVLW       hi_addr(?lstr59_FLOW_32METER+0)
	MOVWF       _someText+1 
;FLOW METER.c,349 :: 		}
L_main308:
L_main307:
L_main305:
;FLOW METER.c,350 :: 		Glcd_Write_Text(someText, 100, 4, xColorSet);
	MOVF        _someText+0, 0 
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVF        _someText+1, 0 
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       100
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;FLOW METER.c,351 :: 		Glcd_H_Line(0, 127, 40 , 1);
	CLRF        FARG_Glcd_H_Line_x_start+0 
	MOVLW       127
	MOVWF       FARG_Glcd_H_Line_x_end+0 
	MOVLW       40
	MOVWF       FARG_Glcd_H_Line_y_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_H_Line_color+0 
	CALL        _Glcd_H_Line+0, 0
;FLOW METER.c,352 :: 		set_3x5();
	CALL        _set_3x5+0, 0
;FLOW METER.c,353 :: 		someText = "TOTAL";
	MOVLW       ?lstr60_FLOW_32METER+0
	MOVWF       _someText+0 
	MOVLW       hi_addr(?lstr60_FLOW_32METER+0)
	MOVWF       _someText+1 
;FLOW METER.c,354 :: 		Glcd_Write_Text(someText, 4, 5, xColorSet);
	MOVF        _someText+0, 0 
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVF        _someText+1, 0 
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       5
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;FLOW METER.c,355 :: 		set_5x7();
	CALL        _set_5x7+0, 0
;FLOW METER.c,356 :: 		volts=0.0;
	CLRF        _volts+0 
	CLRF        _volts+1 
	CLRF        _volts+2 
	CLRF        _volts+3 
;FLOW METER.c,357 :: 		sprintf(txt, "%.3f", volts);
	MOVLW       _txt+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_61_FLOW_32METER+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_61_FLOW_32METER+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_61_FLOW_32METER+0)
	MOVWF       FARG_sprintf_f+2 
	CLRF        FARG_sprintf_wh+5 
	CLRF        FARG_sprintf_wh+6 
	CLRF        FARG_sprintf_wh+7 
	CLRF        FARG_sprintf_wh+8 
	CALL        _sprintf+0, 0
;FLOW METER.c,358 :: 		xGlcd_write_text(txt,5,8,xColorSet);  // Write counter value
	MOVLW       _txt+0
	MOVWF       FARG_xGlcd_Write_Text_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_xGlcd_Write_Text_text+1 
	MOVLW       5
	MOVWF       FARG_xGlcd_Write_Text_x+0 
	MOVLW       8
	MOVWF       FARG_xGlcd_Write_Text_y+0 
	MOVLW       1
	MOVWF       FARG_xGlcd_Write_Text_color+0 
	CALL        _xGlcd_Write_Text+0, 0
;FLOW METER.c,359 :: 		xGlcd_write_text(txt,5,8,xColorClear); // delete the written text
	MOVLW       _txt+0
	MOVWF       FARG_xGlcd_Write_Text_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_xGlcd_Write_Text_text+1 
	MOVLW       5
	MOVWF       FARG_xGlcd_Write_Text_x+0 
	MOVLW       8
	MOVWF       FARG_xGlcd_Write_Text_y+0 
	CLRF        FARG_xGlcd_Write_Text_color+0 
	CALL        _xGlcd_Write_Text+0, 0
;FLOW METER.c,363 :: 		totalizer_read();
	CALL        _totalizer_read+0, 0
;FLOW METER.c,364 :: 		if (NUMBER_UNIT==3)
	MOVF        _NUMBER_UNIT+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_main309
;FLOW METER.c,366 :: 		sprintf(total_txt, "%.3f", TOTALLIZER/1000.0);
	MOVLW       _total_txt+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_total_txt+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_62_FLOW_32METER+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_62_FLOW_32METER+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_62_FLOW_32METER+0)
	MOVWF       FARG_sprintf_f+2 
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       122
	MOVWF       R6 
	MOVLW       136
	MOVWF       R7 
	MOVF        _TOTALLIZER+0, 0 
	MOVWF       R0 
	MOVF        _TOTALLIZER+1, 0 
	MOVWF       R1 
	MOVF        _TOTALLIZER+2, 0 
	MOVWF       R2 
	MOVF        _TOTALLIZER+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        R1, 0 
	MOVWF       FARG_sprintf_wh+6 
	MOVF        R2, 0 
	MOVWF       FARG_sprintf_wh+7 
	MOVF        R3, 0 
	MOVWF       FARG_sprintf_wh+8 
	CALL        _sprintf+0, 0
;FLOW METER.c,367 :: 		}
	GOTO        L_main310
L_main309:
;FLOW METER.c,370 :: 		sprintf(total_txt, "%.0f", TOTALLIZER);
	MOVLW       _total_txt+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_total_txt+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_63_FLOW_32METER+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_63_FLOW_32METER+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_63_FLOW_32METER+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        _TOTALLIZER+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _TOTALLIZER+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	MOVF        _TOTALLIZER+2, 0 
	MOVWF       FARG_sprintf_wh+7 
	MOVF        _TOTALLIZER+3, 0 
	MOVWF       FARG_sprintf_wh+8 
	CALL        _sprintf+0, 0
;FLOW METER.c,371 :: 		}
L_main310:
;FLOW METER.c,372 :: 		set_8x7();
	CALL        _set_8x7+0, 0
;FLOW METER.c,373 :: 		Glcd_write_text(total_txt,28,6,xColorSet);  // Write counter value
	MOVLW       _total_txt+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(_total_txt+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       28
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       6
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;FLOW METER.c,377 :: 		init_timer0();
	CALL        _init_timer0+0, 0
;FLOW METER.c,378 :: 		TIMER0_ON();
	CALL        _TIMER0_ON+0, 0
;FLOW METER.c,379 :: 		INTCON.GIE=1;
	BSF         INTCON+0, 7 
;FLOW METER.c,380 :: 		INTCON.GIEL=1;
	BSF         INTCON+0, 6 
;FLOW METER.c,384 :: 		for(;;)
L_main311:
;FLOW METER.c,386 :: 		digital_value=0;
	CLRF        _digital_value+0 
	CLRF        _digital_value+1 
;FLOW METER.c,387 :: 		for (psx=0;psx<50;psx++)
	CLRF        _PSX+0 
L_main314:
	MOVLW       50
	SUBWF       _PSX+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main315
;FLOW METER.c,389 :: 		digital_value+=ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	ADDWF       _digital_value+0, 1 
	MOVF        R1, 0 
	ADDWFC      _digital_value+1, 1 
;FLOW METER.c,390 :: 		delay_ms(10);
	MOVLW       104
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_main317:
	DECFSZ      R13, 1, 1
	BRA         L_main317
	DECFSZ      R12, 1, 1
	BRA         L_main317
	NOP
;FLOW METER.c,391 :: 		total_rizer_cal();
	CALL        _total_rizer_cal+0, 0
;FLOW METER.c,387 :: 		for (psx=0;psx<50;psx++)
	INCF        _PSX+0, 1 
;FLOW METER.c,392 :: 		}
	GOTO        L_main314
L_main315:
;FLOW METER.c,394 :: 		digital_value=digital_value/50;
	MOVLW       50
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _digital_value+0, 0 
	MOVWF       R0 
	MOVF        _digital_value+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _digital_value+0 
	MOVF        R1, 0 
	MOVWF       _digital_value+1 
;FLOW METER.c,396 :: 		if (Setting_Mode_Enter==1)
	MOVF        _Setting_Mode_Enter+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main318
;FLOW METER.c,398 :: 		inttostr(digital_value,txt);
	MOVF        _digital_value+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _digital_value+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _txt+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;FLOW METER.c,399 :: 		set_5x7();
	CALL        _set_5x7+0, 0
;FLOW METER.c,400 :: 		Glcd_Write_Text(txt, 90, 6, xColorSet);
	MOVLW       _txt+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       90
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       6
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;FLOW METER.c,401 :: 		}
L_main318:
;FLOW METER.c,403 :: 		volts=digital_value;
	MOVF        _digital_value+0, 0 
	MOVWF       R0 
	MOVF        _digital_value+1, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        R0, 0 
	MOVWF       _volts+0 
	MOVF        R1, 0 
	MOVWF       _volts+1 
	MOVF        R2, 0 
	MOVWF       _volts+2 
	MOVF        R3, 0 
	MOVWF       _volts+3 
;FLOW METER.c,404 :: 		ACTUAL_FLOW=volts;
	MOVF        R0, 0 
	MOVWF       _actual_flow+0 
	MOVF        R1, 0 
	MOVWF       _actual_flow+1 
	MOVF        R2, 0 
	MOVWF       _actual_flow+2 
	MOVF        R3, 0 
	MOVWF       _actual_flow+3 
;FLOW METER.c,410 :: 		volts-=204;
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       76
	MOVWF       R6 
	MOVLW       134
	MOVWF       R7 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _volts+0 
	MOVF        R1, 0 
	MOVWF       _volts+1 
	MOVF        R2, 0 
	MOVWF       _volts+2 
	MOVF        R3, 0 
	MOVWF       _volts+3 
;FLOW METER.c,411 :: 		volts/=820;
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       77
	MOVWF       R6 
	MOVLW       136
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__main+0 
	MOVF        R1, 0 
	MOVWF       FLOC__main+1 
	MOVF        R2, 0 
	MOVWF       FLOC__main+2 
	MOVF        R3, 0 
	MOVWF       FLOC__main+3 
	MOVF        FLOC__main+0, 0 
	MOVWF       _volts+0 
	MOVF        FLOC__main+1, 0 
	MOVWF       _volts+1 
	MOVF        FLOC__main+2, 0 
	MOVWF       _volts+2 
	MOVF        FLOC__main+3, 0 
	MOVWF       _volts+3 
;FLOW METER.c,412 :: 		volts*=(hi_rage-lo_rage)+lo_rage;
	MOVF        _lo_RAGE+0, 0 
	SUBWF       _hi_RAGE+0, 0 
	MOVWF       R0 
	MOVF        _lo_RAGE+1, 0 
	SUBWFB      _hi_RAGE+1, 0 
	MOVWF       R1 
	MOVF        _lo_RAGE+0, 0 
	ADDWF       R0, 1 
	MOVF        _lo_RAGE+1, 0 
	ADDWFC      R1, 1 
	CALL        _Word2Double+0, 0
	MOVF        FLOC__main+0, 0 
	MOVWF       R4 
	MOVF        FLOC__main+1, 0 
	MOVWF       R5 
	MOVF        FLOC__main+2, 0 
	MOVWF       R6 
	MOVF        FLOC__main+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _volts+0 
	MOVF        R1, 0 
	MOVWF       _volts+1 
	MOVF        R2, 0 
	MOVWF       _volts+2 
	MOVF        R3, 0 
	MOVWF       _volts+3 
;FLOW METER.c,414 :: 		if (ACTUAL_FLOW==1023)
	MOVLW       0
	MOVWF       R4 
	MOVLW       192
	MOVWF       R5 
	MOVLW       127
	MOVWF       R6 
	MOVLW       136
	MOVWF       R7 
	MOVF        _actual_flow+0, 0 
	MOVWF       R0 
	MOVF        _actual_flow+1, 0 
	MOVWF       R1 
	MOVF        _actual_flow+2, 0 
	MOVWF       R2 
	MOVF        _actual_flow+3, 0 
	MOVWF       R3 
	CALL        _Equals_Double+0, 0
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main319
;FLOW METER.c,416 :: 		volts=hi_rage;
	MOVF        _hi_RAGE+0, 0 
	MOVWF       R0 
	MOVF        _hi_RAGE+1, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        R0, 0 
	MOVWF       _volts+0 
	MOVF        R1, 0 
	MOVWF       _volts+1 
	MOVF        R2, 0 
	MOVWF       _volts+2 
	MOVF        R3, 0 
	MOVWF       _volts+3 
;FLOW METER.c,418 :: 		}
	GOTO        L_main320
L_main319:
;FLOW METER.c,420 :: 		else if (ACTUAL_FLOW<=204)
	MOVF        _actual_flow+0, 0 
	MOVWF       R4 
	MOVF        _actual_flow+1, 0 
	MOVWF       R5 
	MOVF        _actual_flow+2, 0 
	MOVWF       R6 
	MOVF        _actual_flow+3, 0 
	MOVWF       R7 
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       76
	MOVWF       R2 
	MOVLW       134
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       0
	BTFSC       STATUS+0, 0 
	MOVLW       1
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main321
;FLOW METER.c,422 :: 		volts=Lo_rage;
	MOVF        _lo_RAGE+0, 0 
	MOVWF       R0 
	MOVF        _lo_RAGE+1, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        R0, 0 
	MOVWF       _volts+0 
	MOVF        R1, 0 
	MOVWF       _volts+1 
	MOVF        R2, 0 
	MOVWF       _volts+2 
	MOVF        R3, 0 
	MOVWF       _volts+3 
;FLOW METER.c,423 :: 		}
L_main321:
L_main320:
;FLOW METER.c,425 :: 		if ( sqrt_UNIT==2)
	MOVF        _sqrt_UNIT+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_main322
;FLOW METER.c,427 :: 		volts=hi_rage* (sqrt(volts/hi_rage));
	MOVF        _hi_RAGE+0, 0 
	MOVWF       R0 
	MOVF        _hi_RAGE+1, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        _volts+0, 0 
	MOVWF       R0 
	MOVF        _volts+1, 0 
	MOVWF       R1 
	MOVF        _volts+2, 0 
	MOVWF       R2 
	MOVF        _volts+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_sqrt_x+0 
	MOVF        R1, 0 
	MOVWF       FARG_sqrt_x+1 
	MOVF        R2, 0 
	MOVWF       FARG_sqrt_x+2 
	MOVF        R3, 0 
	MOVWF       FARG_sqrt_x+3 
	CALL        _sqrt+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__main+0 
	MOVF        R1, 0 
	MOVWF       FLOC__main+1 
	MOVF        R2, 0 
	MOVWF       FLOC__main+2 
	MOVF        R3, 0 
	MOVWF       FLOC__main+3 
	MOVF        _hi_RAGE+0, 0 
	MOVWF       R0 
	MOVF        _hi_RAGE+1, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        FLOC__main+0, 0 
	MOVWF       R4 
	MOVF        FLOC__main+1, 0 
	MOVWF       R5 
	MOVF        FLOC__main+2, 0 
	MOVWF       R6 
	MOVF        FLOC__main+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _volts+0 
	MOVF        R1, 0 
	MOVWF       _volts+1 
	MOVF        R2, 0 
	MOVWF       _volts+2 
	MOVF        R3, 0 
	MOVWF       _volts+3 
;FLOW METER.c,428 :: 		}
	GOTO        L_main323
L_main322:
;FLOW METER.c,432 :: 		}
L_main323:
;FLOW METER.c,433 :: 		actual_flow=volts;
	MOVF        _volts+0, 0 
	MOVWF       _actual_flow+0 
	MOVF        _volts+1, 0 
	MOVWF       _actual_flow+1 
	MOVF        _volts+2, 0 
	MOVWF       _actual_flow+2 
	MOVF        _volts+3, 0 
	MOVWF       _actual_flow+3 
;FLOW METER.c,439 :: 		volts=actual_flow*KVALUE_k;
	MOVF        _volts+0, 0 
	MOVWF       R0 
	MOVF        _volts+1, 0 
	MOVWF       R1 
	MOVF        _volts+2, 0 
	MOVWF       R2 
	MOVF        _volts+3, 0 
	MOVWF       R3 
	MOVF        _KVALUE_k+0, 0 
	MOVWF       R4 
	MOVF        _KVALUE_k+1, 0 
	MOVWF       R5 
	MOVF        _KVALUE_k+2, 0 
	MOVWF       R6 
	MOVF        _KVALUE_k+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _volts+0 
	MOVF        R1, 0 
	MOVWF       _volts+1 
	MOVF        R2, 0 
	MOVWF       _volts+2 
	MOVF        R3, 0 
	MOVWF       _volts+3 
;FLOW METER.c,440 :: 		actual_flow=volts;
	MOVF        R0, 0 
	MOVWF       _actual_flow+0 
	MOVF        R1, 0 
	MOVWF       _actual_flow+1 
	MOVF        R2, 0 
	MOVWF       _actual_flow+2 
	MOVF        R3, 0 
	MOVWF       _actual_flow+3 
;FLOW METER.c,441 :: 		if (NUMBER_UNIT==3 || NUMBER_UNIT==2)
	MOVF        _NUMBER_UNIT+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L__main384
	MOVF        _NUMBER_UNIT+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L__main384
	GOTO        L_main326
L__main384:
;FLOW METER.c,443 :: 		volts/=1000.0;
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       122
	MOVWF       R6 
	MOVLW       136
	MOVWF       R7 
	MOVF        _volts+0, 0 
	MOVWF       R0 
	MOVF        _volts+1, 0 
	MOVWF       R1 
	MOVF        _volts+2, 0 
	MOVWF       R2 
	MOVF        _volts+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _volts+0 
	MOVF        R1, 0 
	MOVWF       _volts+1 
	MOVF        R2, 0 
	MOVWF       _volts+2 
	MOVF        R3, 0 
	MOVWF       _volts+3 
;FLOW METER.c,444 :: 		}
L_main326:
;FLOW METER.c,445 :: 		set_5x7();
	CALL        _set_5x7+0, 0
;FLOW METER.c,446 :: 		if (volts!=old_volts || OPEN==1)
	MOVF        _volts+0, 0 
	MOVWF       R0 
	MOVF        _volts+1, 0 
	MOVWF       R1 
	MOVF        _volts+2, 0 
	MOVWF       R2 
	MOVF        _volts+3, 0 
	MOVWF       R3 
	MOVF        _old_volts+0, 0 
	MOVWF       R4 
	MOVF        _old_volts+1, 0 
	MOVWF       R5 
	MOVF        _old_volts+2, 0 
	MOVWF       R6 
	MOVF        _old_volts+3, 0 
	MOVWF       R7 
	CALL        _Equals_Double+0, 0
	MOVLW       0
	BTFSS       STATUS+0, 2 
	MOVLW       1
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__main383
	MOVF        _OPEN+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__main383
	GOTO        L_main329
L__main383:
;FLOW METER.c,448 :: 		if (NUMBER_UNIT==1)
	MOVF        _NUMBER_UNIT+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main330
;FLOW METER.c,450 :: 		someText = "kg/h";
	MOVLW       ?lstr64_FLOW_32METER+0
	MOVWF       _someText+0 
	MOVLW       hi_addr(?lstr64_FLOW_32METER+0)
	MOVWF       _someText+1 
;FLOW METER.c,451 :: 		}
	GOTO        L_main331
L_main330:
;FLOW METER.c,452 :: 		else if (NUMBER_UNIT==2)
	MOVF        _NUMBER_UNIT+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_main332
;FLOW METER.c,454 :: 		someText = "m3/h";
	MOVLW       ?lstr65_FLOW_32METER+0
	MOVWF       _someText+0 
	MOVLW       hi_addr(?lstr65_FLOW_32METER+0)
	MOVWF       _someText+1 
;FLOW METER.c,455 :: 		}
	GOTO        L_main333
L_main332:
;FLOW METER.c,456 :: 		else  if (NUMBER_UNIT==3)
	MOVF        _NUMBER_UNIT+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_main334
;FLOW METER.c,458 :: 		someText = "TPH";
	MOVLW       ?lstr66_FLOW_32METER+0
	MOVWF       _someText+0 
	MOVLW       hi_addr(?lstr66_FLOW_32METER+0)
	MOVWF       _someText+1 
;FLOW METER.c,460 :: 		}
L_main334:
L_main333:
L_main331:
;FLOW METER.c,461 :: 		Glcd_Write_Text(someText, 100, 4, xColorSet);
	MOVF        _someText+0, 0 
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVF        _someText+1, 0 
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       100
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;FLOW METER.c,462 :: 		Glcd_H_Line(0, 127, 40 , 1);
	CLRF        FARG_Glcd_H_Line_x_start+0 
	MOVLW       127
	MOVWF       FARG_Glcd_H_Line_x_end+0 
	MOVLW       40
	MOVWF       FARG_Glcd_H_Line_y_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_H_Line_color+0 
	CALL        _Glcd_H_Line+0, 0
;FLOW METER.c,463 :: 		OPEN=0;
	CLRF        _OPEN+0 
;FLOW METER.c,464 :: 		xGlcd_write_text(txt,5,8,xColorClear); // delete the written text
	MOVLW       _txt+0
	MOVWF       FARG_xGlcd_Write_Text_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_xGlcd_Write_Text_text+1 
	MOVLW       5
	MOVWF       FARG_xGlcd_Write_Text_x+0 
	MOVLW       8
	MOVWF       FARG_xGlcd_Write_Text_y+0 
	CLRF        FARG_xGlcd_Write_Text_color+0 
	CALL        _xGlcd_Write_Text+0, 0
;FLOW METER.c,465 :: 		if (NUMBER_UNIT==3 || NUMBER_UNIT==2)
	MOVF        _NUMBER_UNIT+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L__main382
	MOVF        _NUMBER_UNIT+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L__main382
	GOTO        L_main337
L__main382:
;FLOW METER.c,467 :: 		sprintf(txt, "%.3f", volts);
	MOVLW       _txt+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_67_FLOW_32METER+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_67_FLOW_32METER+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_67_FLOW_32METER+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        _volts+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _volts+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	MOVF        _volts+2, 0 
	MOVWF       FARG_sprintf_wh+7 
	MOVF        _volts+3, 0 
	MOVWF       FARG_sprintf_wh+8 
	CALL        _sprintf+0, 0
;FLOW METER.c,468 :: 		}
	GOTO        L_main338
L_main337:
;FLOW METER.c,471 :: 		sprintf(txt, "%.0f", volts);
	MOVLW       _txt+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_68_FLOW_32METER+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_68_FLOW_32METER+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_68_FLOW_32METER+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        _volts+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _volts+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	MOVF        _volts+2, 0 
	MOVWF       FARG_sprintf_wh+7 
	MOVF        _volts+3, 0 
	MOVWF       FARG_sprintf_wh+8 
	CALL        _sprintf+0, 0
;FLOW METER.c,472 :: 		}
L_main338:
;FLOW METER.c,473 :: 		xGlcd_write_text(txt,5,8,xColorSet);  // Write counter value
	MOVLW       _txt+0
	MOVWF       FARG_xGlcd_Write_Text_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_xGlcd_Write_Text_text+1 
	MOVLW       5
	MOVWF       FARG_xGlcd_Write_Text_x+0 
	MOVLW       8
	MOVWF       FARG_xGlcd_Write_Text_y+0 
	MOVLW       1
	MOVWF       FARG_xGlcd_Write_Text_color+0 
	CALL        _xGlcd_Write_Text+0, 0
;FLOW METER.c,474 :: 		old_volts=volts;
	MOVF        _volts+0, 0 
	MOVWF       _old_volts+0 
	MOVF        _volts+1, 0 
	MOVWF       _old_volts+1 
	MOVF        _volts+2, 0 
	MOVWF       _old_volts+2 
	MOVF        _volts+3, 0 
	MOVWF       _old_volts+3 
;FLOW METER.c,475 :: 		}
L_main329:
;FLOW METER.c,498 :: 		if (set_but(0)==255)
	CLRF        FARG_set_but_active+0 
	CALL        _set_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_main339
;FLOW METER.c,500 :: 		if (scrl_but(0)==255)
	CLRF        FARG_scrl_but_active+0 
	CALL        _scrl_but+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_main340
;FLOW METER.c,502 :: 		if (one_sec>5)
	MOVF        _one_sec+0, 0 
	SUBLW       5
	BTFSC       STATUS+0, 0 
	GOTO        L_main341
;FLOW METER.c,505 :: 		if(Pass_word()==255)
	CALL        _Pass_word+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_main342
;FLOW METER.c,507 :: 		set_5x7();
	CALL        _set_5x7+0, 0
;FLOW METER.c,508 :: 		slide_1 ();
	CALL        _slide_1+0, 0
;FLOW METER.c,509 :: 		set_3x5();
	CALL        _set_3x5+0, 0
;FLOW METER.c,510 :: 		someText = "TOTAL";
	MOVLW       ?lstr69_FLOW_32METER+0
	MOVWF       _someText+0 
	MOVLW       hi_addr(?lstr69_FLOW_32METER+0)
	MOVWF       _someText+1 
;FLOW METER.c,511 :: 		Glcd_Write_Text(someText, 4, 5, xColorSet);
	MOVF        _someText+0, 0 
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVF        _someText+1, 0 
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       5
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;FLOW METER.c,512 :: 		set_5x7();
	CALL        _set_5x7+0, 0
;FLOW METER.c,513 :: 		floattostr(volts,txt);
	MOVF        _volts+0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        _volts+1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        _volts+2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        _volts+3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       _txt+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;FLOW METER.c,514 :: 		INTCON.TMR0IF=0;
	BCF         INTCON+0, 2 
;FLOW METER.c,515 :: 		TMR0H = 0xB;    // preset for Timer0 MSB register
	MOVLW       11
	MOVWF       TMR0H+0 
;FLOW METER.c,516 :: 		TMR0L = 0xDC;   // preset for Timer0 LSB register
	MOVLW       220
	MOVWF       TMR0L+0 
;FLOW METER.c,517 :: 		Total_flag=0;
	CLRF        _Total_flag+0 
;FLOW METER.c,518 :: 		totalizer_save();
	CALL        _totalizer_save+0, 0
;FLOW METER.c,519 :: 		if (NUMBER_UNIT==3 ||NUMBER_UNIT==2)
	MOVF        _NUMBER_UNIT+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L__main381
	MOVF        _NUMBER_UNIT+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L__main381
	GOTO        L_main345
L__main381:
;FLOW METER.c,521 :: 		sprintf(total_txt, "%.3f", TOTALLIZER/1000.0);
	MOVLW       _total_txt+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_total_txt+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_70_FLOW_32METER+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_70_FLOW_32METER+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_70_FLOW_32METER+0)
	MOVWF       FARG_sprintf_f+2 
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       122
	MOVWF       R6 
	MOVLW       136
	MOVWF       R7 
	MOVF        _TOTALLIZER+0, 0 
	MOVWF       R0 
	MOVF        _TOTALLIZER+1, 0 
	MOVWF       R1 
	MOVF        _TOTALLIZER+2, 0 
	MOVWF       R2 
	MOVF        _TOTALLIZER+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        R1, 0 
	MOVWF       FARG_sprintf_wh+6 
	MOVF        R2, 0 
	MOVWF       FARG_sprintf_wh+7 
	MOVF        R3, 0 
	MOVWF       FARG_sprintf_wh+8 
	CALL        _sprintf+0, 0
;FLOW METER.c,522 :: 		}
	GOTO        L_main346
L_main345:
;FLOW METER.c,525 :: 		sprintf(total_txt, "%.0f", TOTALLIZER);
	MOVLW       _total_txt+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_total_txt+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_71_FLOW_32METER+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_71_FLOW_32METER+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_71_FLOW_32METER+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        _TOTALLIZER+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _TOTALLIZER+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	MOVF        _TOTALLIZER+2, 0 
	MOVWF       FARG_sprintf_wh+7 
	MOVF        _TOTALLIZER+3, 0 
	MOVWF       FARG_sprintf_wh+8 
	CALL        _sprintf+0, 0
;FLOW METER.c,526 :: 		}
L_main346:
;FLOW METER.c,527 :: 		set_8x7();
	CALL        _set_8x7+0, 0
;FLOW METER.c,528 :: 		Glcd_write_text(total_txt,28,6,xColorSet);  // Write counter value
	MOVLW       _total_txt+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(_total_txt+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       28
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       6
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;FLOW METER.c,529 :: 		one_sec=0;
	CLRF        _one_sec+0 
;FLOW METER.c,530 :: 		}
	GOTO        L_main347
L_main342:
;FLOW METER.c,533 :: 		OPEN=1;
	MOVLW       1
	MOVWF       _OPEN+0 
;FLOW METER.c,534 :: 		cls();
	CALL        _cls+0, 0
;FLOW METER.c,535 :: 		set_3x5();
	CALL        _set_3x5+0, 0
;FLOW METER.c,536 :: 		someText = "TOTAL";
	MOVLW       ?lstr72_FLOW_32METER+0
	MOVWF       _someText+0 
	MOVLW       hi_addr(?lstr72_FLOW_32METER+0)
	MOVWF       _someText+1 
;FLOW METER.c,537 :: 		Glcd_Write_Text(someText, 4, 5, xColorSet);
	MOVF        _someText+0, 0 
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVF        _someText+1, 0 
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       5
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;FLOW METER.c,538 :: 		set_5x7();
	CALL        _set_5x7+0, 0
;FLOW METER.c,539 :: 		floattostr(volts,txt);
	MOVF        _volts+0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        _volts+1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        _volts+2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        _volts+3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       _txt+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;FLOW METER.c,540 :: 		INTCON.TMR0IF=0;
	BCF         INTCON+0, 2 
;FLOW METER.c,541 :: 		TMR0H = 0xB;    // preset for Timer0 MSB register
	MOVLW       11
	MOVWF       TMR0H+0 
;FLOW METER.c,542 :: 		TMR0L = 0xDC;   // preset for Timer0 LSB register
	MOVLW       220
	MOVWF       TMR0L+0 
;FLOW METER.c,543 :: 		Total_flag=0;
	CLRF        _Total_flag+0 
;FLOW METER.c,544 :: 		totalizer_save();
	CALL        _totalizer_save+0, 0
;FLOW METER.c,545 :: 		if (NUMBER_UNIT==3 || NUMBER_UNIT==2)
	MOVF        _NUMBER_UNIT+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L__main380
	MOVF        _NUMBER_UNIT+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L__main380
	GOTO        L_main350
L__main380:
;FLOW METER.c,547 :: 		sprintf(total_txt, "%.3f", TOTALLIZER/1000.0);
	MOVLW       _total_txt+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_total_txt+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_73_FLOW_32METER+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_73_FLOW_32METER+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_73_FLOW_32METER+0)
	MOVWF       FARG_sprintf_f+2 
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       122
	MOVWF       R6 
	MOVLW       136
	MOVWF       R7 
	MOVF        _TOTALLIZER+0, 0 
	MOVWF       R0 
	MOVF        _TOTALLIZER+1, 0 
	MOVWF       R1 
	MOVF        _TOTALLIZER+2, 0 
	MOVWF       R2 
	MOVF        _TOTALLIZER+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        R1, 0 
	MOVWF       FARG_sprintf_wh+6 
	MOVF        R2, 0 
	MOVWF       FARG_sprintf_wh+7 
	MOVF        R3, 0 
	MOVWF       FARG_sprintf_wh+8 
	CALL        _sprintf+0, 0
;FLOW METER.c,548 :: 		}
	GOTO        L_main351
L_main350:
;FLOW METER.c,551 :: 		sprintf(total_txt, "%.0f", TOTALLIZER);
	MOVLW       _total_txt+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_total_txt+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_74_FLOW_32METER+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_74_FLOW_32METER+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_74_FLOW_32METER+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        _TOTALLIZER+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _TOTALLIZER+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	MOVF        _TOTALLIZER+2, 0 
	MOVWF       FARG_sprintf_wh+7 
	MOVF        _TOTALLIZER+3, 0 
	MOVWF       FARG_sprintf_wh+8 
	CALL        _sprintf+0, 0
;FLOW METER.c,552 :: 		}
L_main351:
;FLOW METER.c,553 :: 		set_8x7();
	CALL        _set_8x7+0, 0
;FLOW METER.c,554 :: 		Glcd_write_text(total_txt,28,6,xColorSet);  // Write counter value
	MOVLW       _total_txt+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(_total_txt+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       28
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       6
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;FLOW METER.c,555 :: 		one_sec=0;
	CLRF        _one_sec+0 
;FLOW METER.c,556 :: 		}
L_main347:
;FLOW METER.c,557 :: 		}
L_main341:
;FLOW METER.c,558 :: 		}
	GOTO        L_main352
L_main340:
;FLOW METER.c,561 :: 		one_sec=0;
	CLRF        _one_sec+0 
;FLOW METER.c,562 :: 		}
L_main352:
;FLOW METER.c,563 :: 		}
L_main339:
;FLOW METER.c,580 :: 		}
	GOTO        L_main311
;FLOW METER.c,581 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_interrupt:

;FLOW METER.c,583 :: 		void interrupt()
;FLOW METER.c,585 :: 		if (INTCON.TMR0IF)
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt353
;FLOW METER.c,587 :: 		INTCON.TMR0IF=0;
	BCF         INTCON+0, 2 
;FLOW METER.c,588 :: 		TMR0H = 0xB;    // preset for Timer0 MSB register
	MOVLW       11
	MOVWF       TMR0H+0 
;FLOW METER.c,589 :: 		TMR0L = 0xDC;   // preset for Timer0 LSB register
	MOVLW       220
	MOVWF       TMR0L+0 
;FLOW METER.c,590 :: 		Total_flag=1;
	MOVLW       1
	MOVWF       _Total_flag+0 
;FLOW METER.c,591 :: 		timer_back_light++;
	INCF        _timer_back_light+0, 1 
;FLOW METER.c,592 :: 		if (timer_back_light>=60)
	MOVLW       60
	SUBWF       _timer_back_light+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt354
;FLOW METER.c,594 :: 		timer_back_light=0;
	CLRF        _timer_back_light+0 
;FLOW METER.c,595 :: 		BACK_LIGHT=0;
	BCF         RA4_bit+0, 4 
;FLOW METER.c,596 :: 		}
L_interrupt354:
;FLOW METER.c,597 :: 		if (PORTE.b0==0 && PORTE.b1==0)
	BTFSC       PORTE+0, 0 
	GOTO        L_interrupt357
	BTFSC       PORTE+0, 1 
	GOTO        L_interrupt357
L__interrupt385:
;FLOW METER.c,599 :: 		one_sec++;
	INCF        _one_sec+0, 1 
;FLOW METER.c,600 :: 		}
	GOTO        L_interrupt358
L_interrupt357:
;FLOW METER.c,603 :: 		one_sec=0;
	CLRF        _one_sec+0 
;FLOW METER.c,604 :: 		}
L_interrupt358:
;FLOW METER.c,609 :: 		}
L_interrupt353:
;FLOW METER.c,610 :: 		}
L_end_interrupt:
L__interrupt443:
	RETFIE      1
; end of _interrupt
