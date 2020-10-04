; Micah Tseng

		AREA FUNCTION_CALLS, CODE, READWRITE
		ENTRY	
		
		; Set the arguments for devide
		LDR R0, num0
		LDR R1, num1
		ADR R2, q_0			; Load the address of q
		ADR R3, r_0			; Load the address of r
		BL divide
		; Set the second set of arguments for devide
		LDR R0, num2
		LDR R1, num3
		ADR R2, q_1			; Load the address of q
		ADR R3, r_1			; Load the address of r
		BL divide
		; Set the second set of arguments for devide
		LDR R0, num4
		LDR R1, num5
		ADR R2, q_2			; Load the address of q
		ADR R3, r_2			; Load the address of r
		
		BL divide		
done	B done				; the end
			
		; n = R0, d = R1, q = R2, r = R3		
divide	CMP R1, #0
		BXEQ LR 			; If d = 0, return
		RSBLT R1, R1, #0	; If d < 0, abs(d)
		CMP R0, #0			; compare n to 0
		RSBLT R0, R0, #0	; If, n < 0, abs(n)
		; Should I push here?
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
		
		BX LR				; Go back to whence thee came
		
		; Data
num0	DCD 37
num1	DCD 5
num2	DCD -25
num3	DCD	0
num4	DCD -22
num5	DCD -4
q_0		SPACE 4
r_0		SPACE 4
q_1		SPACE 4
r_1		SPACE 4
q_2		SPACE 4
r_2		SPACE 4
