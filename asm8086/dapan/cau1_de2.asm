.model small
.stack 100h

.data
    s1 db 'nhap day ki tu: $'
	s2 db 10, 13, 'nhap day ki tu 2: $'
	s3 db 10, 13, 'day nguoc: $'
	chaoban db 10, 13, 'Ban: $'
	chaoque db ' Chao mung que ban: $'
	s db 100 dup(?) ;khai bao mang 100 ki tu co gia tri ?
	sq db 100 dup(?) ;khai bao mang 100 ki tu co gia tri ?
	size1 db 0
	size2 db 0
.code
	main proc
    mov ax, @data
    mov ds, ax
	
	mov ah, 9
	lea dx, s1
	int 21h
	
	mov bl, 0 ; tao gia tri ban dau
	
	;nhap chuoi thu nhat
nhaptiep1:
	;nhap tung ki tu
	mov ah, 1
	int 21h
	cmp al, 13 ;so sanh co phai la enter khong
	je nhap2 ; neu la enter thi break
	mov s[bx], al ;gan gia tri cho mang thu bx
	inc bx;tang bx len
	jmp nhaptiep1
	
	
	
	;nhap 2
nhap2:
	mov s[bx], '$'
	mov bx, 0 ;reset lai bx
	mov ah, 9
	lea dx, s2
	int 21h
nhaptiep2:
	mov ah, 1
	int 21h
	cmp al, 13 ;so sanh co phai la enter khong
	je stopnhap ; neu la enter thi break
	mov sq[bx], al ;gan gia tri cho mang thu bx
	inc bx;tang bx len
	mov size2, bl ;luu do dai cua chuoi 2
	jmp nhaptiep2

stopnhap:
	mov sq[bx], '$'
;in mang ki tu (string)
hienday1:
	mov ah, 9
	lea dx, chaoban
	int 21h
	
	mov ah, 9
	lea dx, s
	int 21h
	
hienday2:

	mov ah, 9
	lea dx, chaoque
	int 21h
	mov cx, 0
	mov cl, size2
	mov bx, 0
	
intiep2:
	
	mov dl, sq[bx]
	inc bx
	
	cmp dl, 'a'
	jl skipcong2
	cmp dl, 'z'
	jg skipcong2
	sub dl, 32
skipcong2:
	
	mov ah, 2
	int 21h
	loop intiep2

	mov cx, 0
	mov cl, size2
	mov ah, 9
	lea dx, s3
	int 21h
hienday3:

	dec bx
	mov dl, sq[bx]
	mov ah, 2
	int 21h
	loop hienday3
	
	 mov ah, 4Ch
    int 21h
end main
