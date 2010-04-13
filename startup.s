.text
#define IRQ_OFFSET 24

.section INTERRUPT_VECTOR, "x"
.global _Reset
_Reset:
	B Reset_Handler /* Reset */
	B . /* Undefined */
	B . /* SWI */
	B . /* Prefetch Abort */
	B . /* Data Abort */
	B . /* reserved */
	B . /* IRQ */
	B . /* FIQ */

Reset_Handler:
	LDR sp, =stack_top
	BL c_entry

        adr r0, SWI_Handler
	mov r1, #24
	sub r0, r0, r1
	mov r0, r0, asr #2	/* r0 = (SWI_Handler-8)/4 = offset */
	sub r1, r0, #2		/* r1 = offset - 2 */
	mov r2, #0x0ea00	/* r2 = 0xea00 */
	mov r2, r2, lsl #16	/* r2 = 0xea000000 */
	orr r1, r1, r2		/* r1 = 0xea00r1, assume lsl lower 16 bits will be zero */
        mov r3, #24
        str r1, [r3]

	bl setup_timer
	mrs r1, cpsr
	bic r1, r1, #0x80
	msr cpsr_c, r1
	B .

SWI_Handler:
	LDR sp, =stack_top
	adr r0, text
	BL print_uart0
	B .


instruction:
	.word 0xea00402b

text:
	.byte 'I',' ','a','m',' ','S','W','I','\n',0
