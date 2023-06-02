org 100h  
    ;nhap vao toan tu 1 dang string
    mov dx, offset buffer
    mov ah, 0ah
	int 21h 
	
	;toan tu 1, chuyen string thanh so 
    mov BX, offset buffer + 1   
    mov CL, [BX] ;do dai chuoi
    mov CH, 0	
	xuLiToanTu1:       
	mov SI, CX
    mov AX, [BX + SI] 
    and AX, 0FFh 
    sub AX, '0'
    
    ;thuc hien phep nhan 32b*16b -> 32b
    ;vi phep toan lon nhat hop le la 4*10^9 (2^32
    ; = 4 294 967 296)
    ;van co the bieu dien bang 32b.    
    mul muoiMu_l 
    mov result_l, AX
    mov result_h, DX
    mov AX, [BX + SI] 
    and AX, 0FFh
    sub AX, '0'
    mul muoiMu_h     
    clc ;clear carry flag
    add result_h, AX  
    ;cong don ket qua vao bien var1      
    mov AX, result_l 
    add var1_l, AX
    mov AX, result_h  
    adc var1_h, AX    
    
    ;x10 bien muoiMu bang phep toan 32b*16b->32b
    ;gia tri lon nhat la 10^9 co the 
    ;bieu dien bang 32 bit
    mov AX, 10
    mul muoiMu_l 
    mov result_l, AX
    mov result_h, DX
    mov AX, 10
    mul muoiMu_h
    add result_h, AX 
    ;luu ket qua vao bien muoiMu
    mov AX, result_l 
    mov muoiMu_l, AX
    mov AX, result_h
    mov muoiMu_h, AX 
    Loop xuLiToanTu1 
    
    ;dat lai gia tri ban dau cho bien muoiMu
    mov muoiMu_l, 1
    mov muoiMu_h, 0  
    
    ;nhap vao toan tu 2 dang string
    mov dx, offset buffer
    mov ah, 0ah
	int 21h 
	
	;toan tu 1, chuyen string thanh so 
    mov BX, offset buffer + 1   
    mov CL, [BX] ;do dai chuoi	
    mov CH, 0
	xuLiToanTu2:       
	mov SI, CX
    mov AX, [BX + SI] 
    and AX, 0FFh 
    sub AX, '0'
    
    ;thuc hien phep nhan 32b*16b -> 32b
    ;vi phep toan lon nhat hop le la 4*10^9 (2^32
    ; = 4 294 967 296)
    ;van co the bieu dien bang 32b.    
    mul muoiMu_l 
    mov result_l, AX
    mov result_h, DX
    mov AX, [BX + SI] 
    and AX, 0FFh
    sub AX, '0'
    mul muoiMu_h 
    clc ;clear carry flag
    add result_h, AX  
    ;cong don ket qua vao bien var2      
    mov AX, result_l 
    add var2_l, AX
    mov AX, result_h  
    adc var2_h, AX    
    
    ;x10 bien muoiMu bang phep toan 32b*16b->32b
    ;gia tri lon nhat la 10^9 co the 
    ;bieu dien bang 32 bit
    mov AX, 10
    mul muoiMu_l 
    mov result_l, AX
    mov result_h, DX
    mov AX, 10
    mul muoiMu_h
    add result_h, AX 
    ;luu ket qua vao bien muoiMu
    mov AX, result_l 
    mov muoiMu_l, AX
    mov AX, result_h
    mov muoiMu_h, AX 
    Loop xuLiToanTu2   
    
    ;cong 2 so vua nhap 
    clc ;clear carry flag
    mov AX, var1_l
    add AX, var2_l
    mov result_l, AX
    mov AX, var1_h
    adc AX, var2_h
    mov result_h, AX
    
    ;hien thi ket qua
    
ret
muoiMu_l  dw  1 
muoiMu_h  dw  0 
var1_l  dw  ?
var1_h  dw  ?
var2_l  dw  ?
var2_h  dw  ?  
result_l    dw  ?
result_h    dw  ? 
buffer db 10,?, 10 dup(' ')