; ISR.asm
; Name:
; UTEid: 
; Keyboard ISR runs when a key is struck
; Checks for a valid RNA symbol and places it at x4600
               .ORIG x2600
		AND R0, R0, #0
		LDI R1, KBDR
		LD R0, A
		ADD R0, R1, R0
		BRnp NextL
		STI R1, CharAdd
		BRnzp DONE
NextL		LD R0, U
		ADD R0, R1, R0
		BRnp NextL1
		STI R1, CharAdd
		BRnzp DONE
NextL1		LD R0, C
		ADD R0, R1, R0
		BRnp NextL2
		STI R1, CharAdd
		BRnzp DONE
NextL2		LD R0, G
		ADD R0, R1, R0
		BRnp DONE
		STI R1, CharAdd
DONE		RTI

	


KBSR		.FILL xFE00
KBDR		.FILL xFE02
A		.FILL x-41
U		.FILL x-55
G		.FILL x-47
C		.FILL x-43
CharAdd		.FILL x4600

		.END
