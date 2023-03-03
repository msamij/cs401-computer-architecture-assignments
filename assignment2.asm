[org 0x0100]
jmp start

name db'Muhammad Sami' ,"$"
vuid db'bc210200046' , "$"

keyboardisr:
	push ax
	push es
	mov ax, 0xb800
	mov es, ax
 	in al, 0x60
 	cmp al, 0x2a
 	jne nextcmp
	
	call clrscr
 	
 	mov ah, 0x13
 	mov al, 1
 	mov bh, 0
 	mov bl, 7
 	mov dx, 0000 ; prints at top left
 	mov cx, 11
 	push cs
 	pop es
 	mov bp, vuid
 	int 0x10
	jmp nomatch

nextcmp:
	cmp al, 0x36
	jne nomatch

	call clrscr
	
	mov ah, 0x13
 	mov al, 1
	mov bh, 0
	mov bl, 7
	mov dx, 0000 ; prints at top left
	mov cx, 13
 	push cs
	pop es
	mov bp, name
	int 0x10

nomatch:
 	mov al, 0x20
	out 0x20, al
	pop es
 	pop ax
 	iret

start:
	xor ax, ax
	mov es, ax
	cli
	mov word [es:9*4], keyboardisr
 	mov [es:9*4+2], cs
 	sti

li:
	jmp 11

clrscr:
	pusha
	mov ah, 0x00
	mov al, 0x03
	int 0x10
	popa
	ret 
