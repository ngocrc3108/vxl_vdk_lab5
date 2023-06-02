
; YOU MAY CUSTOMIZE THIS AND OTHER START-UP TEMPLATES; 
; THE LOCATION OF THIS TEMPLATE IS C:\EMU8086\INC\0_COM_TEMPLATE.TXT

ORG 100H

;== NHAP VAO TOAN TU 1 DANG STRING
    MOV DX, OFFSET BUFFER
    MOV AH, 0AH
	INT 21H 

;====================================================	
;TOAN TU 1, CHUYEN STRING THANH SO   
    MOV BX, OFFSET BUFFER  
    MOV CL, [BX + 1] ;DO DAI CHUOI
    MOV CH, 0
    MOV BX, OFFSET BUFFER + 2 ;KI TU DAU TIEN DUOC NHAP
	MOV SI, CX ;DIA CHI CUA KI TU DANG XET(N-1 -> 0)  
	sub SI, 1	
	XULITOANTU1:       	
	;LOAD CHU SO DANG XET LEN AX
    MOV AL, [BX + SI] ;LUU KI TU VAO AL 
    AND AH, 0 ;DAM BAO AX = AL 
    SUB AX, '0' ;CHUYEN TU MA ASCII SANG DANG SO       
    
    ;NHAN SO DANG XET VOI WORD THAP CUA MUOIMU
    MUL WORD PTR [0 + OFFSET MUOIMU] 
    MOV [0 + OFFSET RESULT], AX ;LUU WORD THAP CUA PHEP NHAN VAO WORD THAP CUA RESULT  
    MOV [2 + OFFSET RESULT], DX ;LUU WORD CAO CUA PHEP NHAN VAO WORD CAO CUA RESULT
      
	;LOAD CHU SO DANG XET LEN AX
    MOV AL, [BX + SI] ;LUU KI TU VAO AL 
    AND AH, 0 ;DAM BAO AX = AL 
    SUB AX, '0' ;CHUYEN TU MA ASCII SANG DANG SO    
    
    ;NHAN CHU SO DANG XET VOI WORD CAO CUA MUOIMU 
    MUL WORD PTR [2 + OFFSET MUOIMU] 
    ADD [2 + OFFSET RESULT], AX ;CONG WORD THAP CUA PHEP NHAN VAO WORD CAO CUA RESULT
    ;BO QUA PHAN CAO CUA PHEP NHAN(DX), VI TA CHI XET KET QUA 32 BIT
    ;NEU DX KHAC 0 THI DA TRAN SO
        
    ;CONG DON RESULT VAO VAR1
    MOV AX, [0 + OFFSET RESULT]
    CLC
    ADD [0 + OFFSET VAR1], AX 
    mov AX, [2 + OFFSET RESULT]  
    ADC [2 + OFFSET VAR1], AX 
    
    ;MUOIMU = 10*MUOIMU
    MOV AX, 10
    MUL word ptr [0 + OFFSET MUOIMU] ;NHAN WORD THAP CUA MUOIMU VOI 10
    MOV [0 + OFFSET RESULT], AX 
    MOV [2 + OFFSET RESULT], DX 
    MOV AX, 10
    MUL word ptr [2 + OFFSET MUOIMU] ;NHAN WORD CAO CUA MUOIMU VOI 10
    ADD [2 + OFFSET RESULT], AX 
    ;BO QUA WORD CAO CUA PHEP NHAN(DX), DO TA CHI XET SO 32 BIT  
    ;NEU DX KHAC 0 THI DA TRAN SO
    
    ;GAN MUOIMU = RESULT
    MOV AX, [0 + OFFSET RESULT]
    MOV [0 + OFFSET MUOIMU], AX 
    MOV AX, [2 + OFFSET RESULT]
    MOV [2 + OFFSET MUOIMU], AX 
    
    DEC SI ; SI = SI - 1
    
    ;CX = CX - 1, NEU CX > 0 LAP LAI QUA TRINH TREN
    LOOP XULITOANTU1  
    
    ;IN RA KI TU XUONG DONG
    MOV AH, 2
    MOV DL, 0AH ;NEW LINE CHARATER
    INT 21H
    MOV DL, 13 ;DUA CON TRO VE DAU HANG
    INT 21H  
      
;== NHAP VAO TOAN TU 2 DANG STRING
    MOV DX, OFFSET BUFFER
    MOV AH, 0AH
	INT 21H 

;====================================================	
;TOAN TU 2, CHUYEN STRING THANH SO   
    MOV BX, OFFSET BUFFER   
    MOV CL, [BX + 1] ;DO DAI CHUOI
    MOV CH, 0	 
    MOV WORD PTR [0 + OFFSET MUOIMU], 1H ;MUOIMU = 1
    MOV WORD PTR [2 + OFFSET MUOIMU], 0H  
	MOV SI, CX 
	SUB SI, 1  ;DIA CHI CUA KI TU DANG XET(N-1 -> 0)  
    MOV BX, OFFSET BUFFER + 2 ;KI TU DAU TIEN DUOC NHAP
	XULITOANTU2:       	
	;LOAD CHU SO DANG XET LEN AX
    MOV AL, [BX + SI] ;LUU KI TU VAO AL 
    AND AH, 0 ;DAM BAO AX = AL 
    SUB AX, '0' ;CHUYEN TU MA ASCII SANG DANG SO       
    
    ;NHAN SO DANG XET VOI WORD THAP CUA MUOIMU
    MUL WORD PTR [0 + OFFSET MUOIMU] 
    MOV [0 + OFFSET RESULT], AX ;LUU WORD THAP CUA PHEP NHAN VAO WORD THAP CUA RESULT  
    MOV [2 + OFFSET RESULT], DX ;LUU WORD CAO CUA PHEP NHAN VAO WORD CAO CUA RESULT
      
	;LOAD CHU SO DANG XET LEN AX
    MOV AL, [BX + SI] ;LUU KI TU VAO AL 
    AND AH, 0 ;DAM BAO AX = AL 
    SUB AX, '0' ;CHUYEN TU MA ASCII SANG DANG SO    
    
    ;NHAN CHU SO DANG XET VOI WORD CAO CUA MUOIMU
    MUL WORD PTR [2 + OFFSET MUOIMU] 
    ADD [2 + OFFSET RESULT], AX ;CONG WORD THAP CUA PHEP NHAN VAO WORD CAO CUA RESULT
    ;BO QUA PHAN CAO CUA PHEP NHAN(DX), VI TA CHI XET KET QUA 32 BIT
    ;NEU DX KHAC 0 THI DA TRAN SO
        
    ;CONG DON RESULT VAO VAR2
    MOV AX, [0 + OFFSET RESULT]
    CLC
    ADD [0 + OFFSET VAR2], AX
    MOV AX, [2 + OFFSET RESULT]  
    ADC [2 + OFFSET VAR2], AX 
    
    ;MUOIMU = 10*MUOIMU
    MOV AX, 10
    MUL word ptr [0 + OFFSET MUOIMU] ;NHAN WORD THAP CUA MUOIMU VOI 10
    MOV [0 + OFFSET RESULT], AX 
    MOV [2 + OFFSET RESULT], DX 
    MOV AX, 10
    MUL word ptr [2 + OFFSET MUOIMU] ;NHAN WORD CAO CUA MUOIMU VOI 10
    ADD [2 + OFFSET RESULT], AX 
    ;BO QUA WORD CAO CUA PHEP NHAN(DX), DO TA CHI XET SO 32 BIT  
    ;NEU DX KHAC 0 THI DA TRAN SO
    
    ;GAN MUOIMU = RESULT
    MOV AX, [0 + OFFSET RESULT]
    MOV [0 + OFFSET MUOIMU], AX 
    MOV AX, [2 + OFFSET RESULT]
    MOV [2 + OFFSET MUOIMU], AX
    
    DEC SI
    ;CX = CX - 1, NEU CX > 0 LAP LAI QUA TRINH TREN
    LOOP XULITOANTU2  
    
    ;tinh toan var1 = var1 + var2
    clc 
    mov AX, [0 + offset var2]
    add [0 + offset VAR1], AX 
    mov AX, [2 + offset var2]
    adc [2 + offset VAR1], AX  
    
;======================================================== 
    ;IN RA KI TU XUONG DONG
    MOV AH, 2
    MOV DL, 0AH ;NEW LINE CHARATER
    INT 21H
    MOV DL, 13 ;DUA CON TRO VE DAU HANG
    INT 21H                               
    
;CHUYEN DOI SO NHI PHAN SANG STRING
MOV CX, 11  
MOV SI, 10
CONVERT:
MOV BX, 10
mov DX, 0
mov AX, [2+OFFSET VAR1]
DIV BX
MOV [2+OFFSET VAR1], AX ;WORD CAO CUA PHAN NGUYEN
MOV AX, [0 + OFFSET VAR1]
DIV BX
MOV [0+OFFSET VAR1], AX ;WORD THAP CUA PHAN NGUYEN  
;DX CHUA PHAN DU 
ADD DX, '0' 
MOV BYTE PTR [SI + OFFSET STRING], DL
DEC SI
LOOPNE CONVERT  
 

;TIM SO DAU TIEN KHAC 0
MOV CX, 11 
MOV AX, 0
MOV SI, AX
FIND:
MOV AL, [SI + OFFSET STRING] 
INC SI                      
CMP AX, '0'
LOOPE FIND      
DEC SI

MOV CX, 10
SUB CX, SI  
MOV AH, 2
PRINTRESULT:
MOV DL, BYTE PTR [SI + OFFSET STRING]
INT 21H    
NOTPRINT: 
INC SI
lOOP PRINTRESULT
RET
BUFFER DB 11,?, 11 DUP(' ') 
VAR1    DD  0
VAR2    DD  0 
RESULT  DD  ?
MUOIMU  DD  1  
STRING dB 11 dup('0')



