
_delay2S:

;AIR FLOW METER.c,23 :: 		void delay2S(){                                  // 2 seconds delay function
;AIR FLOW METER.c,24 :: 		Delay_ms(2000);
	MOVLW       51
	MOVWF       R11, 0
	MOVLW       187
	MOVWF       R12, 0
	MOVLW       223
	MOVWF       R13, 0
L_delay2S0:
	DECFSZ      R13, 1, 1
	BRA         L_delay2S0
	DECFSZ      R12, 1, 1
	BRA         L_delay2S0
	DECFSZ      R11, 1, 1
	BRA         L_delay2S0
	NOP
	NOP
;AIR FLOW METER.c,25 :: 		}
L_end_delay2S:
	RETURN      0
; end of _delay2S

_main:

;AIR FLOW METER.c,27 :: 		void main() {
;AIR FLOW METER.c,32 :: 		ADCON1=6;
	MOVLW       6
	MOVWF       ADCON1+0 
;AIR FLOW METER.c,34 :: 		Glcd_Init();                                   // Initialize GLCD
	CALL        _Glcd_Init+0, 0
;AIR FLOW METER.c,35 :: 		Glcd_Fill(0x00);                               // Clear GLCD
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;AIR FLOW METER.c,36 :: 		while(1)
L_main1:
;AIR FLOW METER.c,38 :: 		Glcd_Fill(0xFF);                                     // Fill GLCD
	MOVLW       255
	MOVWF       FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;AIR FLOW METER.c,40 :: 		Glcd_Set_Font(Font_Glcd_Character8x7, 8, 7, 32);     // Change font
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
;AIR FLOW METER.c,41 :: 		someText = "AIR.FLOW.METER";
	MOVLW       ?lstr1_AIR_32FLOW_32METER+0
	MOVWF       main_someText_L0+0 
	MOVLW       hi_addr(?lstr1_AIR_32FLOW_32METER+0)
	MOVWF       main_someText_L0+1 
;AIR FLOW METER.c,42 :: 		Glcd_Write_Text(someText, 1, 0, 2);                  // Write string
	MOVF        main_someText_L0+0, 0 
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVF        main_someText_L0+1, 0 
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	CLRF        FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;AIR FLOW METER.c,43 :: 		delay2S();
	CALL        _delay2S+0, 0
;AIR FLOW METER.c,45 :: 		Glcd_Set_Font(Font_Glcd_System3x5, 3, 5, 32);        // Change font
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
;AIR FLOW METER.c,46 :: 		someText = "OMNI";
	MOVLW       ?lstr2_AIR_32FLOW_32METER+0
	MOVWF       main_someText_L0+0 
	MOVLW       hi_addr(?lstr2_AIR_32FLOW_32METER+0)
	MOVWF       main_someText_L0+1 
;AIR FLOW METER.c,47 :: 		Glcd_Write_Text(someText, 60, 2, 2);                 // Write string
	MOVF        main_someText_L0+0, 0 
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVF        main_someText_L0+1, 0 
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       60
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;AIR FLOW METER.c,48 :: 		delay2S();
	CALL        _delay2S+0, 0
;AIR FLOW METER.c,50 :: 		Glcd_Set_Font(Font_Glcd_System5x7, 5, 7, 32);        // Change font
	MOVLW       _Font_Glcd_System5x7+0
	MOVWF       FARG_Glcd_Set_Font_activeFont+0 
	MOVLW       hi_addr(_Font_Glcd_System5x7+0)
	MOVWF       FARG_Glcd_Set_Font_activeFont+1 
	MOVLW       higher_addr(_Font_Glcd_System5x7+0)
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
;AIR FLOW METER.c,51 :: 		someText = "OMNI";
	MOVLW       ?lstr3_AIR_32FLOW_32METER+0
	MOVWF       main_someText_L0+0 
	MOVLW       hi_addr(?lstr3_AIR_32FLOW_32METER+0)
	MOVWF       main_someText_L0+1 
;AIR FLOW METER.c,52 :: 		Glcd_Write_Text(someText, 5, 4, 2);                  // Write string
	MOVF        main_someText_L0+0, 0 
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVF        main_someText_L0+1, 0 
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       5
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;AIR FLOW METER.c,53 :: 		delay2S();
	CALL        _delay2S+0, 0
;AIR FLOW METER.c,55 :: 		Glcd_Set_Font(Font_Glcd_5x7, 5, 7, 32);              // Change font
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
;AIR FLOW METER.c,56 :: 		someText = "AIR FLOW METER";
	MOVLW       ?lstr4_AIR_32FLOW_32METER+0
	MOVWF       main_someText_L0+0 
	MOVLW       hi_addr(?lstr4_AIR_32FLOW_32METER+0)
	MOVWF       main_someText_L0+1 
;AIR FLOW METER.c,57 :: 		Glcd_Write_Text(someText, 50, 6, 2);                 // Write string
	MOVF        main_someText_L0+0, 0 
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVF        main_someText_L0+1, 0 
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       50
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       6
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;AIR FLOW METER.c,58 :: 		delay2S();
	CALL        _delay2S+0, 0
;AIR FLOW METER.c,59 :: 		}
	GOTO        L_main1
;AIR FLOW METER.c,66 :: 		Glcd_Fill(0x00);                             // Clear GLCD
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;AIR FLOW METER.c,68 :: 		Glcd_Box(62,40,124,56,1);                    // Draw box
	MOVLW       62
	MOVWF       FARG_Glcd_Box_x_upper_left+0 
	MOVLW       40
	MOVWF       FARG_Glcd_Box_y_upper_left+0 
	MOVLW       124
	MOVWF       FARG_Glcd_Box_x_bottom_right+0 
	MOVLW       56
	MOVWF       FARG_Glcd_Box_y_bottom_right+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Box_color+0 
	CALL        _Glcd_Box+0, 0
;AIR FLOW METER.c,69 :: 		Glcd_Rectangle(5,5,84,35,1);                 // Draw rectangle
	MOVLW       5
	MOVWF       FARG_Glcd_Rectangle_x_upper_left+0 
	MOVLW       5
	MOVWF       FARG_Glcd_Rectangle_y_upper_left+0 
	MOVLW       84
	MOVWF       FARG_Glcd_Rectangle_x_bottom_right+0 
	MOVLW       35
	MOVWF       FARG_Glcd_Rectangle_y_bottom_right+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Rectangle_color+0 
	CALL        _Glcd_Rectangle+0, 0
;AIR FLOW METER.c,70 :: 		Glcd_Line(0, 0, 127, 63, 1);                 // Draw line
	CLRF        FARG_Glcd_Line_x_start+0 
	CLRF        FARG_Glcd_Line_x_start+1 
	CLRF        FARG_Glcd_Line_y_start+0 
	CLRF        FARG_Glcd_Line_y_start+1 
	MOVLW       127
	MOVWF       FARG_Glcd_Line_x_end+0 
	MOVLW       0
	MOVWF       FARG_Glcd_Line_x_end+1 
	MOVLW       63
	MOVWF       FARG_Glcd_Line_y_end+0 
	MOVLW       0
	MOVWF       FARG_Glcd_Line_y_end+1 
	MOVLW       1
	MOVWF       FARG_Glcd_Line_color+0 
	CALL        _Glcd_Line+0, 0
;AIR FLOW METER.c,71 :: 		delay2S();
	CALL        _delay2S+0, 0
;AIR FLOW METER.c,73 :: 		for(ii = 5; ii < 60; ii+=5 ){                // Draw horizontal and vertical lines
	MOVLW       5
	MOVWF       main_ii_L0+0 
	MOVLW       60
	SUBWF       main_ii_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main6
;AIR FLOW METER.c,74 :: 		Delay_ms(250);
	MOVLW       7
	MOVWF       R11, 0
	MOVLW       88
	MOVWF       R12, 0
	MOVLW       89
	MOVWF       R13, 0
L_main8:
	DECFSZ      R13, 1, 1
	BRA         L_main8
	DECFSZ      R12, 1, 1
	BRA         L_main8
	DECFSZ      R11, 1, 1
	BRA         L_main8
	NOP
	NOP
;AIR FLOW METER.c,75 :: 		Glcd_V_Line(2, 54, ii, 1);
	MOVLW       2
	MOVWF       FARG_Glcd_V_Line_y_start+0 
	MOVLW       54
	MOVWF       FARG_Glcd_V_Line_y_end+0 
	MOVF        main_ii_L0+0, 0 
	MOVWF       FARG_Glcd_V_Line_x_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_V_Line_color+0 
	CALL        _Glcd_V_Line+0, 0
;AIR FLOW METER.c,76 :: 		Glcd_H_Line(2, 120, ii, 1);
	MOVLW       2
	MOVWF       FARG_Glcd_H_Line_x_start+0 
	MOVLW       120
	MOVWF       FARG_Glcd_H_Line_x_end+0 
	MOVF        main_ii_L0+0, 0 
	MOVWF       FARG_Glcd_H_Line_y_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_H_Line_color+0 
	CALL        _Glcd_H_Line+0, 0
;AIR FLOW METER.c,73 :: 		for(ii = 5; ii < 60; ii+=5 ){                // Draw horizontal and vertical lines
	MOVLW       5
	ADDWF       main_ii_L0+0, 1 
;AIR FLOW METER.c,77 :: 		}
	GOTO        L_main5
L_main6:
;AIR FLOW METER.c,79 :: 		delay2S();
	CALL        _delay2S+0, 0
;AIR FLOW METER.c,81 :: 		Glcd_Fill(0x00);                                       // Clear GLCD
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;AIR FLOW METER.c,85 :: 		Glcd_Write_Text("mikroE", 1, 7, 2);                    // Write string
	MOVLW       ?lstr5_AIR_32FLOW_32METER+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr5_AIR_32FLOW_32METER+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       7
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;AIR FLOW METER.c,87 :: 		for (ii = 1; ii <= 10; ii++)                           // Draw circles
	MOVLW       1
	MOVWF       main_ii_L0+0 
L_main9:
	MOVF        main_ii_L0+0, 0 
	SUBLW       10
	BTFSS       STATUS+0, 0 
	GOTO        L_main10
;AIR FLOW METER.c,88 :: 		Glcd_Circle(63,32, 3*ii, 1);
	MOVLW       63
	MOVWF       FARG_Glcd_Circle_x_center+0 
	MOVLW       0
	MOVWF       FARG_Glcd_Circle_x_center+1 
	MOVLW       32
	MOVWF       FARG_Glcd_Circle_y_center+0 
	MOVLW       0
	MOVWF       FARG_Glcd_Circle_y_center+1 
	MOVLW       3
	MULWF       main_ii_L0+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_Glcd_Circle_radius+0 
	MOVF        PRODH+0, 0 
	MOVWF       FARG_Glcd_Circle_radius+1 
	MOVLW       1
	MOVWF       FARG_Glcd_Circle_color+0 
	CALL        _Glcd_Circle+0, 0
;AIR FLOW METER.c,87 :: 		for (ii = 1; ii <= 10; ii++)                           // Draw circles
	INCF        main_ii_L0+0, 1 
;AIR FLOW METER.c,88 :: 		Glcd_Circle(63,32, 3*ii, 1);
	GOTO        L_main9
L_main10:
;AIR FLOW METER.c,89 :: 		delay2S();
	CALL        _delay2S+0, 0
;AIR FLOW METER.c,91 :: 		Glcd_Box(12,20, 70,57, 2);                             // Draw box
	MOVLW       12
	MOVWF       FARG_Glcd_Box_x_upper_left+0 
	MOVLW       20
	MOVWF       FARG_Glcd_Box_y_upper_left+0 
	MOVLW       70
	MOVWF       FARG_Glcd_Box_x_bottom_right+0 
	MOVLW       57
	MOVWF       FARG_Glcd_Box_y_bottom_right+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Box_color+0 
	CALL        _Glcd_Box+0, 0
;AIR FLOW METER.c,92 :: 		delay2S();
	CALL        _delay2S+0, 0
;AIR FLOW METER.c,117 :: 		}
	GOTO        L_main3
;AIR FLOW METER.c,118 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
