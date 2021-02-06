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

			// int32_t Add(int32_t a, int32_t b) ;
			.global		Add
			.thumb_func
			.align

Add:	ADD R0,R0,R1 /* this will add a and b */
			BX			LR /*return the function */

			/* int32_t Less1(int32_t a)*/ ;
			.global		Less1
			.thumb_func
			.align
Less1: SUB R0,R0,1 /*will subtract a-1*/
			 BX			LR

			/* int32_t Square2x(int32_t x) ;*/
			.global		Square2x
			.thumb_func
			.align
Square2x: ADD R0,R0,R0  /*this adds x+X */
        	B Square  /*call function square*/


			/* int32_t Last(int32_t x) ; */
			.global		Last
			.thumb_func
			.align

Last:		PUSH {R4,LR} /*use register R4 perserve x*/
						MOV R4,R0 /* perserves x in R4*/
						BL SquareRoot /* call the function squareroot*/
						ADD R0,R0,R4 /* add x with the function*/
						POP {R4,PC} /* restoring R4*/


			.end
