
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h
mov i, 0
mov j, 0

mov cx, 5
convert:
mov BX, offset string   
mov si, i
mov ax, [BX + SI]
sub al, '0'
sub ah, '0'
sal al, 4 
or ah, al

mov bx, offset num
mov si, j
mov byte ptr [bx + si], ah
add i, 2
add j, 1
Loop convert
  

mov cx, 5
ReverseDoubleDabble: 

pusha
;ShiftRightAll
clc 
mov cx, 15 
mov bx, offset num   
mov ax, 0
mov si, ax
loop2:
rcr byte ptr [bx + si], 1  
inc si
Loop loop2     
popa
 
pusha 
;CheckBCD:
mov cx, 5 
mov bx, offset num   
mov ax, 0
mov si, ax
CheckBCD:
mov al, [bx + si]
mov ah, al 
shr ah, 4
and al, 0fh
cmp al, 8
jl  notSub3_1
sub al, 3
notSub3_1: 
cmp ah, 8
jl  notSub3_2
sub ah, 3
notSub3_2:
sal al, 4 
or ah, al 
mov [bx + si], ah 
inc si
Loop CheckBCD
popa
    
Loop ReverseDoubleDabble    
ret 
string db 6 dup('0'), '5', '4', '3', '1'
num     db 10  dup(0)
i   dw ?
j   dw  ?




