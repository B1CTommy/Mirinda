.model small
.stack 100h

.data
    s1 db 'nhap day ki tu: $'
    s2 db 10, 13, 'ho ten ban khi dao nguoc: $'
	chaoban db 10, 13, 'chao ban: $'
	s db 100 dup(?) ;khai bao mang 100 ki tu co gia tri ?
.code
	main proc
    mov ax, @data
    mov ds, ax
	
	mov ah, 9
	lea dx, s1
	int 21h
	
	mov bx, 0 ; tao gia tri ban dau
nhaptiep:
	;nhap tung ki tu
	mov ah, 1
	int 21h
	cmp al, 13 ;so sanh co phai la enter khong
	je hienday1 ; neu la enter thi break
	mov s[bx], al ;gan gia tri cho mang thu bx
	inc bx;tang bx len
	jmp nhaptiep
	
;in mang ki tu (string)
hienday1:
	mov ah, 9
	lea dx, chaoban
	int 21h
	
	mov cx, bx
	mov bx, 0
intiep1:	
	mov ah, 2
	mov dl, s[bx]
	inc bx
	int 21h
	loop intiep1
	
;in mang ki tu toan hoa
hienday2:
	mov ah, 9
	lea dx, chaoban
	int 21h
	
	mov cx, bx
	mov bx, 0

intiep2:
	mov dl, s[bx]
	
	cmp dl, 'a'
	jl skipcong2
	cmp dl, 'z'
	jg skipcong2
	sub dl, 32
skipcong2:
	inc bx
	mov ah, 2
	int 21h
	loop intiep2
	
;string bi dao nguoc
hienday3:
	mov cx, bx
	
	mov ah, 9
	lea dx, chaoban
	int 21h
intiep3:
	dec bx
	mov dl, s[bx]
	mov ah, 2
	int 21h
	loop intiep3
	
    mov ah, 4Ch
    int 21h

end main
