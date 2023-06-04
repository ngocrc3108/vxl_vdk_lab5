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
    
    ;dx chua phan bit 32-47, neu dx > 0 thi overflow vi ta chi tinh toan tren 32 bit
    and dx, dx
    jnz overflow
            
    ;CONG DON RESULT VAO VAR1
    MOV AX, [0 + OFFSET RESULT]
    CLC
    ADD [0 + OFFSET VAR1], AX 
    mov AX, [2 + OFFSET RESULT]  
    ADC [2 + OFFSET VAR1], AX 
    JC overflow ;neu CF = 1, thi overflow 
    
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
    
    ;dx chua phan bit 32-47, neu dx > 0 thi overflow vi ta chi tinh toan tren 32 bit
    and dx, dx
    jnz overflow
        
    ;CONG DON RESULT VAO VAR2
    MOV AX, [0 + OFFSET RESULT]
    CLC
    ADD [0 + OFFSET VAR2], AX
    MOV AX, [2 + OFFSET RESULT]  
    ADC [2 + OFFSET VAR2], AX 
    JC overflow ;neu CF = 1, thi overflow  
    
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
    
   ;tinh toan var1 = var1 - var2
    clc 
    mov AX, [0 + offset var2]
    sub [0 + offset VAR1], AX 
    mov AX, [2 + offset var2]
    sbb [2 + offset VAR1], AX  
    
;======================================================== 
    ;IN RA KI TU XUONG DONG
    MOV AH, 2
    MOV DL, 0AH ;NEW LINE CHARATER
    INT 21H
    MOV DL, 13 ;DUA CON TRO VE DAU HANG
    INT 21H 
    ;in ra dau tru neu kq am
    JNC KhongInDauTru     
    MOV DL, '-'
    INT 21H                                
    
    ;var1 < 0, lay 0 - var1 de lay gia tri tuyet doi
    CLC
    mov AX, 0                 
    MOV BX, OFFSET VAR1
    sub AX, [BX + 0] 
    mov DX, 0
    sbb DX, [BX + 2]
    MOV [0 + offset VAR1], AX 
    MOV [2 + offset VAR1], DX 
    KhongInDauTru: 
       
;========================================================    
    ;CHUYEN DOI SO NHI PHAN SANG STRING  
    MOV CX, 10  
    MOV SI, 9
    CONVERT: 
    ;chia word cao cua var1 cho 10
    MOV BX, 10
    mov DX, 0 ;phep chia 32b/16b, nen phai dat dx = 0
    mov AX, [2+OFFSET VAR1] ;word cao cua var1
    DIV BX
    MOV [2+OFFSET VAR1], AX ;WORD CAO CUA PHAN NGUYEN 
    
    ;chia word thap cua var1 cho 10
    ;dx = phan du < 10. vi vay phep chia sau se khong bi tran
    MOV AX, [0 + OFFSET VAR1] ;word thap cua var1
    DIV BX
    MOV [0+OFFSET VAR1], AX ;WORD THAP CUA PHAN NGUYEN  
    ;DX CHUA PHAN DU 
    ADD DX, '0' 
    MOV BYTE PTR [SI + OFFSET STRING], DL
    DEC SI
    
    ;ax chua word thap cua var1, thuc hien or word  
    ;thap va word cao de kiem tra xem var1 co bang 0 hay khong 
    ;neu bang 0 thi thoat khoi vong lap  
    mov bx, offset var1
    or ax, [bx + 2] ;neu var1 = 0, ZF = 1 
    ;if (CX <> 0) and (ZF = 0) then jump
    LOOPNE CONVERT  
    
    
;========================================================         
;in ra ket qua
    ;sau khi thoat khoi vong lap tren, si + 1 la 
    ;dia chi cua chu so dau tien
    inc si
    
    mov dx, offset STRING  
    add dx, si ;tro dx den chu so dau tien khac 0 
    ;in ra chuoi, ki tu ket thuc la '$' da duoc khai bao cuoi chuoi
	mov ah, 9
	int 21h 
	jmp exit
;========================================================
    ;in ra dong chu overflow 
    overflow:
    mov dx, offset s_overflow
    mov ah, 9
	int 21h
exit:   
    RET
    BUFFER DB 11,?, 11 DUP(' ') 
    VAR1    DD  0
    VAR2    DD  0 
    RESULT  DD  ?
    MUOIMU  DD  1  
    STRING dB 10 dup('0'), '$'
    s_overflow db 0ah, 13, "overflow $"


