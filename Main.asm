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
		ST R1, Int


; enable keyboard interrupts
		LD R1, ADDRESS
		ST R1, KBSR


; start of actual program
loop
LDI R0, Buffer
BRz loop
TRAP x21
AND R1, R1, #0
STI R1, Buffer

;checking the letter in R0 for start codon




TRAP x25

ADDRESS		.FILL x4000
Int		.FILL x0180
ISR1		.FILL x2600
KBSR		.FILL xFE00
KBDR		.FILL xFE02
Buffer		.FILL x4600
		.END
