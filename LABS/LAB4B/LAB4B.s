/*
	This code was written to support the book, "ARM Assembly for Embedded Applications",
	by Daniel W. Lewis. Permission is granted to freely share this software provided
	that this notice is not removed. This software is intended to be used with a run-time
    library adapted by the author from the STM Cube Library for the 32F429IDISCOVERY
    board and available for download from http://www.engr.scu.edu/~dlewis/book3.
*/
         .syntax     unified
		 .cpu        cortex-m4
         .text

// ----------------------------------------------------------
// void OffBy0(void *dst, const void *src)
// ----------------------------------------------------------

        .global    OffBy0
        .thumb_func
        .align

// R0 = dst and R1 = src
OffBy0: .rept       250 // loop 100/4
        LDR         R2,[R1],4 //load *((uint32_t *) src) into temp register
        STR         R2,[R0],4 // store *((uint32_t *) src) into *((uint32_t *) dst)
        .endr

        BX          LR

// ----------------------------------------------------------
// void OffBy1(void *dst, const void *src)
// ----------------------------------------------------------

		.global	  OffBy1
        .thumb_func
        .align

OffBy1:	.rept       3 //loop 3
        LDRB        R2,[R1],1 // load *((uint8_t *) src) into temp register
        STRB        R2,[R0],1 // store *((uint8_t *) src) into *((uint8_t *) dst)
        .endr

        .rept       249 //loop 1000/4-1
        LDR         R2,[R1],4  //load *((uint32_t *) src) into temp register
        STR         R2,[R0],4 // store *((uint32_t *) src) into *((uint32_t *) dst)
        .endr

        .rept       1 //loop 1
        LDRB        R2,[R1],1 // load *((uint8_t *) src) into temp register
        STRB        R2,[R0],1 // store *((uint8_t *) src) into *((uint8_t *) dst)
        .endr

        BX          LR


// ----------------------------------------------------------
// void OffBy2(void *dst, const void *src)
// ----------------------------------------------------------

        .global    OffBy2
        .thumb_func
        .align

OffBy2:	.rept       2 //loop 2
        LDRB        R2,[R1],1 // load *((uint8_t *) src) into temp register
        STRB        R2,[R0],1 // store *((uint8_t *) src) into *((uint8_t *) dst)
        .endr

        .rept       249 //loop 100/4-1
        LDR         R2,[R1],4 //load *((uint32_t *) src) into temp register
        STR         R2,[R0],4 // store *((uint32_t *) src) into *((uint32_t *) dst)
        .endr

        .rept      2
        LDRB       R2,[R1],1 // load *((uint8_t *) src) into temp register
        STRB       R2,[R0],1 // store *((uint8_t *) src) into *((uint8_t *) dst)
        .endr

        BX        LR

// ----------------------------------------------------------
// void OffBy3(void *dst, const void *src)
// ----------------------------------------------------------

        .global		OffBy3
        .thumb_func
        .align

OffBy3:	.rept       1
        LDRB        R2,[R1],1 // load *((uint8_t *) src) into temp register
        STRB        R2,[R0],1 // store *((uint8_t *) src) into *((uint8_t *) dst)
        .endr

        .rept       249 //loop 1000/4-1
        LDR         R2,[R1],4
        STR         R2,[R0],4
        .endr

         .rept 		3 //loop 3
         LDRB       R2,[R1],1 // load *((uint8_t *) src) into temp register
         STRB       R2,[R0],1 // store *((uint8_t *) src) into *((uint8_t *) dst)
         .endr

         BX 		LR

		.end
