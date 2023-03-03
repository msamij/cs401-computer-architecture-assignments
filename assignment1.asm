[ORG 0x100]

	mov ax, 0
	mov bx, id	; point bx to first no of id
	mov bp, 0
	
l1:	add ax, [bx]	; ax will have current id no
	add bx, 2	; point bx to next id
	add ax, [bx]	; sum up id no's
	add bx, 2	; point bx to next id
	add ax, [bx]
	mov [sum+bp], ax	; save three no's sum in [sum] 
	add byte[counter], 1	; counter will be incremented we're doing this sum 3 times since there are 3 pairs of 3 					  no's
	cmp byte[counter], 3	; once counter is 3 that means we've added up 3 pairs of 3 no's, now we compare them.
	je l2
	
	add bp, 2	; otherwise point bp to sum in memory where we'll save next three no's sum.
	mov ax, 0	; now that the three nums have been added and saved into memory, we now add next three no's and 				  initialize ax back 0.
	
	add bx, 2	; point bx to next id
	cmp byte[counter], 3
	jne l1
l2:
	mov ax, [sum]		; move first sum into ax
	cmp ax, [sum+2]	; compare first two sums
	jae l3			; if ax > sum + 2 then compare ax with sum + 4

	mov ax, [sum + 2]	; if ax < [sum + 2] compare sum + 2 with sum + 4
	cmp ax, [sum + 4]	; if [sum + 2] > [sum + 4] then [sum + 2 ] is largest save into result.
	jmp l4
	
	mov ax, [sum + 4]	; this means that [sum + 4] is the largest (since we've compared all previous).
	jmp l4			; save [sum + 4] in result.
	
l3:	cmp ax, [sum+4]	; compare ax with sum + 4
	jae l4			; if ax > sum + 4 then ax is largest
	mov ax, [sum+4]
	jmp l4	
		
l4:	mov [result], ax	

	mov ax, 0x4C00
	int 0x21

id: dw		2, 1, 0, 2, 0, 0, 0, 4, 6
counter: db	0
sum:	dw	0, 0, 0
result: dw	0
