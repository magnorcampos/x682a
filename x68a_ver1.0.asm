; Hardware X628A
; magnorcampos
; For practice assebly language
; microcontroller

 #include <p16f628a.inc>                                         ;add the lib of microcontroller
 
 ; Config Fuses
 __config _XT_OSC & _WDT_OFF & _PWRTE_ON & _CP_OFF 	           
 
 ; Declaring variables
 COUNT equ 0x20                                                  ; Create variable COUNT in address of memory 0x20  

 
 ; Memory MAP
 #define    bank0   bcf STATUS,RP0                                ; clear bit RP0, select BANK0
 #define    bank1   bsf STATUS,RP0			                             ; set bit RP0, select BANK1
 
 
 ; Inputs config
 #define button_1   PORTB,RB0                                     ; button_1, PORT_B and bit 0
 #define button_2   PORTB,RB1                                     ; button_2, PORT_B and bit 1
 
 
 ; Outputs config
 #define led       PORTA,RA0			                                  	; led, PORT_A and bit 0
 #defien buzzer    PORTA,RA1                                      ; buzzer, PORT_A and bit 1
 
 ; Reset config
 		org		   H'0000'					                                           ; Reset Address H'0000' 
 		goto       inicio					                                         ; Vector Interruption
 		
 ; Interruption config
 		org		   H'0004'					                                           ; Interruption Address H'0004' 
 		retfie     							                                             ; Return of interruption		
 
 ; Main
 inicio:
 
 		bank1								                                                   ; Select Bank1
 		movlw	B'00000011'					                                          ; Literal config and set Work register
 		movwf	TRISA						                                               ; Address Literal TRISA and set bit _A0 and _A1
 		
 		movlw	B'00000000'					
 		movwf   TRISB						
 
 		bank0								                                                   ; Select Bank0

 		movlw	B'00000011'					                                          ; Config Literal and set register W
 		movwf   PORTB					                                             	; Move literal to PORTB and set bit _RB0 and _RB1
 		
 		goto looping                                                    ; goto to looping
 
 ;Looping
 looping:
 
 	   movlw	B'00000001'
 	   movwf    PORTB
 	   
       call delay_1
 	   
 	   movlw	B'00000000'
 	   movwf    PORTB
 	 	
  	   call delay_1
  	   
  	   movlw	B'00000010'
 	   movwf    PORTB
 	   
 	   call delay_1
  	   
  	   movlw	B'00000000'
 	   movwf    PORTB
 	   
 	   call delay_1
  	   
  	   movlw	B'00000011'
 	   movwf    PORTB
 	   
 	   call delay_1
 	   
 	   	
 	goto looping
 	
;--------------------------------------------------------------------------- 
; Delay	
delay_1: 	
 	movlw D'255'             ; Confi literal 
    movwf COUNT            ; Move litral to Count register
    
delay_1_loop:              ; Create looping
    decfsz COUNT, F        ; Decrease COUNT and skip if result is zero
    goto delay_1_loop      ; If resulto isn't zero. So go to "delay_1_loop"
    return                 ; Return to code
;---------------------------------------------------------------------------
 
 
 end
