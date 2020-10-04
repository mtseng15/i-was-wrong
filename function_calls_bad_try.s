; Micah Tseng

		AREA FUNCTION_CALLS, CODE, READONLY
		ENTRY	
		
		LDR R4, index
		LDR R5, size
		ADR R6, num
		ADR R7, den
		ADR R8, q
		ADR R9, r
		
go		CMP R4, R5
		BGT done
		LDR R0, [R6, R4, LSL #2]
		LDR R1, [R7, R4, LSL #2]
		ADD R2, R8, R4, LSL #2
		ADD R3, R9, R4, LSL #2
		BL divide
		ADD R4, R4, #1
		B go	
done	B done				; the end
			
		; n = R0, d = R1, q = R2, r = R3		
divide	CMP R1, #0
		BXEQ LR 			; If d = 0, return
		RSBLT R1, R1, #0	; If d < 0, abs(d)
		CMP R0, #0			; compare n to 0
		RSBLT R0, R0, #0	; If, n < 0, abs(n)
		PUSH {R4, R5}
		; R4 = *q, R5 = *r
		MOV R4, #0		; *q = 0
		MOV R5, R0		; *r = n
while 	
		CMP R5, R1		; Compare *r and d
		BLT good
		ADD R4, R4, #1	; *q = *q + 1
		SUB R5, R5, R1	; *r = *r - d
		B while	
good
		STR R4, [R2]	; Store the value of *q at q
		STR R5, [R3]	; Store the value of *r at r
		POP {R4, R5}
		BX LR				; Go back to whence thee came
		
		; Data		
num		DCD 37, -25, -22
den		DCD 5, 0, -4	
index	DCD 0
size	DCD 3
q		SPACE 12
r		SPACE 12
		END
