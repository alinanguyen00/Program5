; Main.asm
; Name:
; UTEid: 
; Continuously reads from x4600 making sure its not reading duplicate
; symbols. Processes the symbol based on the program description
; of mRNA processing.
               .ORIG x4000
; initialize the stack pointer
		LD R6, ADDRESS

; set up the keyboard interrupt vector table entry
		LD R1, ISR1
		STI R1, Int


; enable keyboard interrupts
		LD R1, ADDRESS
		STI R1, KBSR


; start of actual program
loop
LDI R0, Buffer
BRz loop
TRAP x21
AND R1, R1, #0
STI R1, Buffer

;checking the letter in R0 for start codon
;checking if an Acharacter
LD R3, Acharacter
ADD R3, R3, R0
BRnp loop

loop1
LDI R0, Buffer
BRz loop1
TRAP x21
AND R1, R1, #0
STI R1, Buffer

LD R3, Ucharacter
ADD R3, R3, R0
BRnp #-11

loop2
LDI R0, Buffer
BRz loop2
TRAP x21
AND R1, R1, #0
STI R1, Buffer
LD R3, Gcharacter
ADD R3, R3, R0
BRnp loop
;created a start codon, print pipe
LD R0, pipe
TRAP x21

;start of looking for end codon
loop3
LDI R0, Buffer
BRz loop3
TRAP x21
AND R1, R1, #0
STI R1, Buffer

LD R3, Ucharacter
ADD R3, R3, R0
BRnp loop3

loop4
LDI R0, Buffer
BRz loop4
TRAP x21
AND R1, R1, #0
STI R1, Buffer
LD R3, Acharacter
ADD R3, R3, R0
BRz loop5
LD R3, Gcharacter
ADD R3, R3, R0
BRz loop6
BRnp #-15

loop5	;loop for UAA or UAG
LDI R0, Buffer
BRz loop5
TRAP x21
AND R1, R1, #0
STI R1, Buffer
LD R3, Acharacter
ADD R3, R3, R0
BRz endcodon
LD R3, Gcharacter
ADD R3, R3, R0
BRz endcodon
BRnp #-27

loop6
LDI R0, Buffer
BRz loop6
TRAP x21
AND R1, R1, #0
STI R1, Buffer
LD R3, Acharacter
ADD R3, R3, R0
BRnp #-35

endcodon
TRAP x25

ADDRESS		.FILL x4000
Int		.FILL x0180
ISR1		.FILL x2600
KBSR		.FILL xFE00
KBDR		.FILL xFE02
Buffer		.FILL x4600
pipe		.FILL #124
Acharacter	.FILL x-41
Ucharacter	.FILL x-55
Gcharacter	.FILL x-47
		.END
