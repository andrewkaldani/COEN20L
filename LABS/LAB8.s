/*
	This code was written to support the Friday book, "ARM Assembly for Embedded Applications",
	by Daniel W. Lewis. Permission is granted to freely share this software provided
	that this notice is not removed. This software is intended to be used with a run-time
	library adapted by the author from the STM Cube Library for the 32F429IDISCOVERY
	board and available for download from http://www.engr.scu.edu/~dlewis/book3.
*/
			.syntax     unified
			.cpu        cortex-m4
			.text

			// uint32_t Mul32X10(uint32_t multiplicand) ;
			.global		Mul32X10
			.thumb_func
			.align
Mul32X10:			// R0 = multiplicand
			ADD 		R0,R0,R0,LSL 2 //5*R0
			LSL 		R0,R0,1 //5*R0*2=10*R0
			BX			LR

			// uint32_t Mul64X10(uint32_t multiplicand) ;
			.global		Mul64X10
			.thumb_func
			.align
Mul64X10:	// R1.R0 = multiplicand
			ADDS		R0,R0,R0//R0 = 2*R0(least sig half)
			ADC 		R1,R1,R1//R1 = 2*R1(Most sig half)
			LSL 		R2,R1,2//R2 = 2^2*2*R0=8*R1
			ADD 		R2,R2,R0,LSR 30// fix bits of least sig half
			LSL 		R3,R0,2//R3 = 2^2*2*R0=8*R0
			ADDS 		R0,R0,R3 // R0=2*R0+8*R0 = 10*R0 (least sig half)
			ADC 		R1,R1,R2 //R1 = 2*R1+8*R1=R1*10(most sig half)
			BX			LR

			// uint32_t Div32X10(uint32_t dividend) ;
			.global		Div32X10
			.thumb_func
			.align
Div32X10:	// R0 = dividend
			LDR 		R1,=3435973837 // (2^5+2)/10 contsant needed using recpriocal mult
			UMULL 		R2,R1,R1,R0 // 64-bit mult R1.R0
			LSRS 		R0,R1,3 // R0 = R1*2^3= 10*R0(divide by 10)
			BX			LR

			.end
