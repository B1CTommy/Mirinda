.model small
.stack 100h

.data
    s1 db 'nhap so luong phan tu trong day: $'
	s2 db 10, 13, 'nhap gia tri cho cac phan tu: $'
	s3 db 10, 13, 'cac so le trong mang: $'
	s4 db 10, 13, 'tong so le: $'
	s db 5 dup(?) ;khai bao mang 100 ki tu co gia tri ?
	len db ?
	tongchan db 0
.code
	main proc
    mov ax, @data
    mov ds, ax
	
	mov ah, 9
	lea dx, s1
	int 21h
	
	;nhap so luong phan tu
	mov ah, 0
	mov ah, 1
	int 21h
	sub al, 48
	mov len, al
	
	;nhap gia tri cho cac phan tu
	mov ah, 9
	lea dx, s2
	int 21h
	
	mov cx, 0
	mov cl, len
	mov bx, 0
nhapmang:
	mov ah, 1
	int 21h
	sub al, 48
	mov s[bx], al
	
	inc bx
	loop nhapmang
	
;in ra so chan
	mov cx, 0
	mov cl, len
	mov bx, 0
	
	mov ah, 9
	lea dx, s3
	int 21h
inmang:
	mov dl, s[bx]
	mov ax, 0
	mov al, dl
	mov dl, 2
	div dl
	cmp ah, 1
	je skipin
	
	mov dl, s[bx]
	add tongchan, dl
	add dl, 48
	
	mov ah, 2
	int 21h
skipin:
	inc bx
	loop inmang

	;in loi dan
	mov ah, 9
	lea dx, s4
	int 21h
	
	mov ax, 0
	mov al, tongchan
	mov dl, 10
	div dl
	
	mov bl, al
	mov bh, ah
	
	;in chu so hang chuc
	mov dl, bl
	add dl, 48
	mov ah, 2
	int 21h
	
	;in chu so hang don vi
	mov dl, bh
	add dl, 48
	mov ah, 2
	int 21h
		
	 mov ah, 4Ch
    int 21h
end main
