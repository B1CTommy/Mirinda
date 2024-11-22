.model small
.stack 100h

.data
    prompt db 'Nhap so thap phan: $'
    bin_msg db 'So nhi phan la: $'
    new_line db 0Dh, 0Ah, '$'
    input db 5  ; Dung lượng bộ nhớ nhập (5 ký tự tối đa)
    num db 0    ; Số thập phân sẽ nhập vào đây

.code
main:
    ; Khởi tạo DS
    mov ax, @data
    mov ds, ax

    ; In thông báo yêu cầu nhập số
    mov ah, 09h
    lea dx, prompt
    int 21h

    ; Nhập số thập phân từ bàn phím
    lea dx, num
    mov ah, 0Ah
    int 21h

    ; Chuyển đổi từ ASCII sang giá trị thập phân
    lea si, num + 2  ; Bắt đầu từ vị trí đầu tiên của chuỗi nhập
    xor ax, ax       ; Ax = 0 (để lưu kết quả thập phân)

convert_loop:
    mov bl, [si]     ; Lấy một ký tự
    sub bl, 30h      ; Chuyển từ ASCII sang giá trị thập phân
    cmp bl, 0        ; Nếu là ký tự null (kết thúc chuỗi)
    je  done_convert
    ; Cập nhật giá trị thập phân
    mov ah, al       ; Dịch các chữ số hiện tại sang trái
    shl ax, 1
    add ax, bx       ; Cộng giá trị vào ax
    inc si           ; Đi tiếp tới ký tự kế tiếp
    jmp convert_loop

done_convert:
    ; In ra thông báo "So nhi phan la:"
    mov ah, 09h
    lea dx, bin_msg
    int 21h

    ; Chuyển đổi từ số thập phân sang nhị phân và in ra
    mov bx, ax       ; Lưu giá trị thập phân vào bx

    ; Duyệt từng bit và in ra
    mov cx, 16       ; Số bit tối đa (16 bit)
print_binary:
    shl bx, 1        ; Dịch trái 1 bit
    jnc no_print_bit ; Nếu bit là 0 thì không in
    mov dl, '1'      ; Nếu bit là 1
    int 21h
    jmp continue_print
no_print_bit:
    mov dl, '0'      ; Nếu bit là 0
    int 21h
continue_print:
    loop print_binary

    ; In dòng mới
    mov ah, 09h
    lea dx, new_line
    int 21h

    ; Kết thúc chương trình
    mov ah, 4Ch
    int 21h

end main
