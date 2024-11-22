.model small
.stack 100h

.data
    s1 db 'Nhap mot day ki tu: $'
    s2 db 10, 13, 'So nhi phan la: $'
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
	je hienday ; neu la enter thi break
	mov s[bx], al ;gan gia tri cho mang thu bx
	inc bx;tang bx len
	jmp nhaptiep
	
;in mang ki tu (string)
hienday:
	mov ah, 9
	lea dx, s2
	int 21h
	
	mov cx, bx
	mov bx, 0
intiep:	
	cmp s[bx], 'a'
	jl skipcong
	cmp s[bx], 'z'
	jg skipcong
	
	sub s[bx], 32
skipcong:
	mov ah, 2
	mov dl, s[bx]
	inc bx
	int 21h
	
	
	
	loop intiep:

	
    mov ah, 4Ch
    int 21h

end main
