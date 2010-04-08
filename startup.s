.section INTERRUPT_VECTOR, "x"
.global _Reset
_Reset:
	B Reset_Handler /* Reset */
	B . /* Undefined */
	B Data_Abort /* SWI */
	B . /* Prefetch Abort */
	B . /* Data Abort */
	B . /* reserved */
	B . /* IRQ */
	B . /* FIQ */

Reset_Handler:
	LDR sp, =stack_top
	BL c_entry
        ldr r0, instruction
        mov r2, #0x08
        str r0, [r2]
	swi 0x0
	B .

Data_Abort:
	LDR sp, =stack_top
	BL data_entry
	B .


instruction:
	.word 0xea00402b
