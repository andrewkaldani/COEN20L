/*
	This code was written to support the book, "ARM Assembly for Embedded Applications",
	by Daniel W. Lewis. Permission is granted to freely share this software provided
	that this notice is not removed. This software is intended to be used with a run-time
	library adapted by the author from the STM Cube Library for the 32F429IDISCOVERY
	board and available for download from http://www.engr.scu.edu/~dlewis/book3.
*/
		.syntax		unified
		.cpu		cortex-m4
		.text

		// int Sum(int Ai, int Bi, Cin) ;
		.global		Sum1
		.thumb_func
		.align
		// Sum = Ai ^ Bi ^ Cin
Sum1:	EOR		R2,R2,R1 //Bi^Cin
		EOR 		R0,R0,R2 //Ai^Bi^Cin
		BX			LR

		.global		Sum2
		.thumb_func
		.align
		// Sum = (Ai + Bi + Cin) & 1
Sum2:	ADD 		R2,R2,R1 //Bi+Cin
		ADD 		R0,R0,R2 //Ai+Bi+Cin
		AND 		R0,R0,1 //Ai+Bi+Cin & 1
		BX			LR

		.global		Sum3
		.thumb_func
		.align
		// Sum = ((0b10010110 >> ((Ai << 2) | (Bi << 1) | Ai)) & 1
Sum3:	ORR 		R1,R2,R1,LSL 1 //Bi<<1 |
		ORR 		R0,R1,R0,LSL 2 //Ai<<2 |Ai
		MOV 		R3,150 //R3 == 10010110
		LSR 		R0,R3,R0 // 0b10010110 >>
		AND 		R0,R0,1 //((0b10010110 >> ((Ai << 2) | (Bi << 1) | Ai)) & 1
		BX			LR

		.global		Sum4
		.thumb_func
		.align
		// Sum = sum[(Cin << 2) | (Bi << 1) | Ai)]
Sum4:	ORR 		R2,R2,R1,LSL 1 // cin<<2 |Ai
		ORR 		R0,R2,R0,LSL 2 //Bi << 1 |Ai
		LDR 		R3,=sum
		LDRB 		R0,[R3,R0] // R3[R0<<2|R1<<1|Ai]
		BX			LR
sum:	.byte		0,1,1,0,1,0,0,1

		// int Cout(int Ai, int Bi, Cin) ;
		.global		Cout1
		.thumb_func
		.align
		// Cout = Ai&Bi | Ai&Cin | Bi&Cin
Cout1:	ORR 		R3,R1,R2 // Bi|cin
		AND 		R0,R0,R3// Ai&bi|cin
		AND 		R2,R2,R1//cin&Bi
		ORR 		R0,R0,R2// Ai&bi|cin&Bi|Bi&Cin
		BX			LR

		.global		Cout2
		.thumb_func
		.align
		// Cout = (Ai + Bi + Cin) >> 1
Cout2:	ADD 		R2,R2,R1//Bi+Cin
		ADD 		R0,R0,R2//Ai+Bi+cin
		ASR 		R0,R0,1//(Ai + Bi + Cin) >> 1
		BX			LR

		.global		Cout3
		.thumb_func
		.align
		// Cout = ((0b11101000 >> ((Ai << 2) | (Bi << 1) | Ai)) & 1
Cout3:	ORR 		R1,R2,R1,LSL 1//(Bi << 1)
		ORR 		R0,R1,R0,LSL 2//((Ai << 2) | Ai
		MOV 		R3,232
		LSR 		R0,R3,R0 // ((0b11101000 >> ((Ai << 2) | (Bi << 1) | Ai))
		AND 		R0,R0,1//R3 >> ((R0 << 2) | (R1 << 1) | R0)) & 1
		BX			LR

		.global		Cout4
		.thumb_func
		.align
		// Cout = carry[(Ai << 2) | (Bi << 1) | Ai)]
Cout4:	ORR 		R2,R2,R1,LSL 1 // R2<<1 | Ai
		ORR 		R0,R2,R0,LSL 2 //R0<<2 |Ai
		LDR 		R3,=carry
		LDRB 		R0,[R3,R0] // R3[R0<<2|R1<<1|Ai]
		BX			LR


carry:	.byte		0,0,0,1,0,1,1,1

		.end
