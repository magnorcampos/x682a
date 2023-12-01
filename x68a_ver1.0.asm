; Hardware X628A
; magnorcampos
; For practice assebly language
; microcontroller

 #include <p16f628a.inc>
 
 ; Configurando os Fuses
 __config _XT_OSC & _WDT_OFF & _PWRTE_ON & _CP_OFF 	
 
 ; Declarando a variavel
 COUNT equ 0x20 ; Substitua 0x20 pelo endere�o de mem�ria desejado para COUNT

 
 ; Criando o Mapa de mem�ria
 #define    bank0   bcf STATUS,RP0          ; Seleciono o Banco_0
 #define    bank1   bsf STATUS,RP0			; Seleciono o Banco_1
 
 
 ; Configurando as Entradas
 #define botao_1   PORTB,RB0                ; Bot�o_1 esta no PORT_B e no bit RB0
 
 
 ; Configurando as Saidas
 #define led       PORTA,RA0				; Led esta no PORT_A e no bit RA0
 
 ; Configurando o vetor de Reset
 		org		   H'0000'					; Origem de endere�o da mem�ria, pois este end H'0000' � o endere�o de Reset
 		goto       inicio					; Desvia o vetor de interrup��o
 		
 ; Configurando o vetor de Interrup��o
 		org		   H'0004'					; Todas as interrup��es apontam para este endere�o 
 		retfie     							; Retorno da interrup��o		
 
 ; Programa Principal
 inicio:
 
 		bank1								; Seleciona o banco 1 de mem�ria
 		movlw	B'00000011'					; Configura o Literal
 		movwf	TRISA						; Move o literal para o reg TRISA, setando RA0 como entrada
 		
 		movlw	B'00000000'					; Configura o Literal e move para o reg WORK na ULA
 		movwf   TRISB						; Aloca este valor literal no end do ref TRISB, setando todo o PORT_B como saida
 
 		bank0								; Seleciona o banco 0
 		
 		movlw	B'00000011'					; Configura o Literal e move para o registrador Work
 		movwf   PORTB						; Carrega o Literal no PortB
 		
 		goto looping
 
 ;Inicio do Looping do programa
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
; Bloco do comando de Delay	
delay_1: 	
 	movlw D'255'           ; Valor inicial do contador
    movwf COUNT            ; Move para um registrador de contagem
    
delay_1_loop:
    decfsz COUNT, F        ; Decrementa o contador e salta se zero
    goto delay_1_loop      ; Repete o loop se o contador n�o atingiu zero
    return                 ; Retorna ao c�digo principal
;---------------------------------------------------------------------------
 
 
 end