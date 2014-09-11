;**** A P P L I C A T I O N   N O T E   A V R 3 0 5 ************************
;*
;* Title		: Half Duplex Interrupt Driven Software UART
;* Version		: rev. 1.2 (24-04-2002), reset vector added
;*			: rev. 1.1 (27.08.1997)
;* Last updated		: 24-04-2002
;* Target		: AT90Sxxxx (All AVR Device)
;*
;* Support email	: avr@atmel.com
;*
;* Code Size		: 32 Words
;* Low Register Usage	: 0
;* High Register Usage	: 4
;* Interrupt Usage	: None
;*
;* DESCRIPTION
;* This Application note contains a very code efficient software UART.
;* The example program receives one character and echoes it back.
;***************************************************************************

;;;#include "candle.h"
;;;#include "iodefs.h"

;***** Pin definitions

#define DDR(port) (port-1)
#define PINS(port) (port-2)
#define PORT(port) (port)

#define	RxD	4			/* Receive pin is PB4 */
#define	RxPort	PORTB
#define	TxD	4			/* Transmit pin is PB4 */
#define	TxPort	PORTB

/* ***** Global register variables */

#define	bitcnt	r25			/* bit counter */
#define	temp	r23			/* temporary storage register */

#define	Txbyte	r24			/* Data to be transmitted */
#define	Rxbyte	r24			/* Received data */

#define CLOCK 1600000
#define BAUD_RATE 19200
#define BAUD_RATE 38400

#define BIT_COUNT (((CLOCK + (BAUD_RATE/2))/BAUD_RATE - 8 + 1) / 3)

.cseg
;***************************************************************************
;*
;* "putchar"
;*
;* This subroutine transmits the byte stored in the "Txbyte" register
;* The number of stop bits used is set with the sb constant
;*
;* Number of words	:14 including return
;* Number of cycles	:Depens on bit rate
;* Low registers used	:None
;* High registers used	:2 (bitcnt,Txbyte)
;* Pointers used	:None
;*
;***************************************************************************
.equ		sb	=2		;Number of stop bits (1, 2, ...)

		.global putchar
putchar:	ldi	bitcnt,9+sb	;1+8+sb (sb is # of stop bits)
		sbi	DDR(TxPort),TxD	;TxD is output
		com	Txbyte		;Inverte everything
		sec			;Start bit

putchar0:	brcc	putchar1	;If carry set
		sbi	TxPort,TxD	;    send a '0'
		rjmp	putchar2	;else	

putchar1:	cbi	TxPort,TxD	;    send a '1'
		nop

putchar2:	
#if 0
		rcall UART_delay	;One bit delay
		rcall UART_delay
#else
		ldi	temp,BIT_COUNT
1:		dec	temp
		brne	1b
#endif

		lsr	Txbyte		;Get next bit
		dec	bitcnt		;If not all bit sent
		brne	putchar0	;   send next
					;else
		ret			;   return


;***************************************************************************
;*
;* "getchar"
;*
;* This subroutine receives one byte and returns it in the "Rxbyte" register
;*
;* Number of words	:14 including return
;* Number of cycles	:Depens on when data arrives
;* Low registers used	:None
;* High registers used	:2 (bitcnt,Rxbyte)
;* Pointers used	:None
;*
;***************************************************************************

		.global getchar
getchar:	ldi 	bitcnt,9	;8 data bit + 1 stop bit
		cbi	DDR(RxPort),RxD	;RxD is input

getchar1:	sbis 	PINS(RxPort),RxD	;Wait for start bit (high)
		rjmp 	getchar1
#if 0
		rcall UART_delay	;0.5 bit delay

getchar2:	rcall UART_delay	;1 bit delay
		rcall UART_delay		
#else
		ldi	temp,BIT_COUNT/2
1:		dec	temp
		brne	1b

getchar2:				;1 bit delay
		ldi	temp,BIT_COUNT
1:		dec	temp
		brne	1b
#endif

		clc			;clear carry
		sbis 	PINS(RxPort),RxD	;if RX pin low
		sec			;

		dec 	bitcnt		;If bit is stop bit
		breq 	getchar3	;   return
					;else
		ror 	Rxbyte		;   shift bit into Rxbyte
		rjmp 	getchar2	;   go get next

getchar3:	ret


;***************************************************************************
;*
;* "UART_delay"
;*
;* This delay subroutine generates the required delay between the bits when
;* transmitting and receiving bytes. The total execution time is set by the
;* constant "b":
;*
;*	3·b + 7 cycles (including rcall and ret)
;*
;* Number of words	:4 including return
;* Low registers used	:None
;* High registers used	:1 (temp)
;* Pointers used	:None
;*
;***************************************************************************
; Some b values: 	(See also table in Appnote documentation)
;
; 1 MHz crystal:
;   9600 bps - b=14
;  19200 bps - b=5
;  28800 bps - b=2
;
; 2 MHz crystal:
;  19200 bps - b=14
;  28800 bps - b=8
;  57600 bps - b=2

; 4 MHz crystal:
;  19200 bps - b=31
;  28800 bps - b=19
;  57600 bps - b=8
; 115200 bps - b=2

//.equ	b	=31	;19200 bps @ 4 MHz crystal
//.equ	b	=14	;9600 bps @ 1 MHz crystal (3% error!)
//.equ	b	=69	;2400 bps @ 1 MHz crystal (66 nominal)
.equ	b	=32	;4800 bps @ 1 MHz crystal (31 nominal)
.equ	b	=50	;4800 bps @ 1.6 MHz crystal (49.6 nominal)

		.global UART_delay
UART_delay:	ldi	temp,b
UART_delay1:	dec	temp
		brne	UART_delay1

		ret

;***** Program Execution Starts Here

;***** Test program

		.global uart_reset
uart_reset:	cbi	TxPort,TxD	;Init port pins
		cbi	DDR(RxPort),RxD	;RxD is input

                cbi PORTB, 1    ; LED on
#ifdef CALIBRATE_OSC
1:
                cbi PORTB, 1    ; LED on
                sbi PORTB, 1    ; LED on
                cbi PORTB, 1    ; LED on
                sbi PORTB, 1    ; LED on
                cbi PORTB, 1    ; LED on
                sbi PORTB, 1    ; LED on
                cbi PORTB, 1    ; LED on
                sbi PORTB, 1    ; LED on
                cbi PORTB, 1    ; LED on
                sbi PORTB, 1    ; LED on
                cbi PORTB, 1    ; LED on
                sbi PORTB, 1    ; LED on
                cbi PORTB, 1    ; LED on
                sbi PORTB, 1    ; LED on
                cbi PORTB, 1    ; LED on
                sbi PORTB, 1    ; LED on
                cbi PORTB, 1    ; LED on
                sbi PORTB, 1    ; LED on
                cbi PORTB, 1    ; LED on
                sbi PORTB, 1    ; LED on
                cbi PORTB, 1    ; LED on
                sbi PORTB, 1    ; LED on
                cbi PORTB, 1    ; LED on
                sbi PORTB, 1    ; LED on
                cbi PORTB, 1    ; LED on
                sbi PORTB, 1    ; LED on
                cbi PORTB, 1    ; LED on
                sbi PORTB, 1    ; LED on
                cbi PORTB, 1    ; LED on
                sbi PORTB, 1    ; LED on
                cbi PORTB, 1    ; LED on
                sbi PORTB, 1    ; LED on
                cbi PORTB, 1    ; LED on
                sbi PORTB, 1    ; LED on
                cbi PORTB, 1    ; LED on
                sbi PORTB, 1    ; LED on
                cbi PORTB, 1    ; LED on
                sbi PORTB, 1    ; LED on
                cbi PORTB, 1    ; LED on
                sbi PORTB, 1    ; LED on
                cbi PORTB, 1    ; LED on
                sbi PORTB, 1    ; LED on
                cbi PORTB, 1    ; LED on
                sbi PORTB, 1    ; LED on
                cbi PORTB, 1    ; LED on
                sbi PORTB, 1    ; LED on
                cbi PORTB, 1    ; LED on
                sbi PORTB, 1    ; LED on
                cbi PORTB, 1    ; LED on
                sbi PORTB, 1    ; LED on
                cbi PORTB, 1    ; LED on
                sbi PORTB, 1    ; LED on
                cbi PORTB, 1    ; LED on
                sbi PORTB, 1    ; LED on
                cbi PORTB, 1    ; LED on
                sbi PORTB, 1    ; LED on
                cbi PORTB, 1    ; LED on
                sbi PORTB, 1    ; LED on
                cbi PORTB, 1    ; LED on
                sbi PORTB, 1    ; LED on
                cbi PORTB, 1    ; LED on
                sbi PORTB, 1    ; LED on
                cbi PORTB, 1    ; LED on
                sbi PORTB, 1    ; LED on
                rjmp 1b
#endif
#if 0
2:
		ldi	Txbyte,'5'
		rcall	putchar
		rcall UART_delay
		ldi	Txbyte,' '
		rcall	putchar
		rcall UART_delay
		rcall UART_delay
		rcall UART_delay
		rcall UART_delay
		rcall UART_delay
		rcall UART_delay
		rcall UART_delay
		rcall UART_delay
		rcall UART_delay
		rcall UART_delay
		rcall UART_delay
		rcall UART_delay
		rcall UART_delay
		rjmp 2b
#endif

		ldi	Txbyte,'X'
		rcall	putchar

		ldi	Txbyte,'\r'
		rcall	putchar

		ldi	Txbyte,'\n'
		rcall	putchar

forever:	rcall	getchar
		mov	Txbyte,Rxbyte
		rcall UART_delay
		rcall UART_delay
		rcall	putchar		;Echo received char
		rjmp	forever

