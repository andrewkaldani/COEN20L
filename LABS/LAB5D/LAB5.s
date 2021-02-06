/*
	This code was written to support the book, "ARM Assembly for Embedded Applications",
	by Daniel W. Lewis. Permission is granted to freely share this software provided
	that this notice is not removed. This software is intended to be used with a run-time
    library adapted by the author from the STM Cube Library for the 32F429IDISCOVERY
    board and available for download from http://www.engr.scu.edu/~dlewis/book3.
*/
            .syntax         unified
            .cpu            cortex-m4
            .text



            .global         TireDiam
            .thumb_func
            .align

//R0 = W, R1 = A, R2 = R
TireDiam:
            PUSH        {R4,LR}
            LDR         R3,=1270
            MUL         R4,R0,R1//r4= a*w
            UDIV        R0,R4,R3//r0 = a*w/1270
            ADDS        R1,R0,R2//  r1= r + a*w/1270
            MLS         R0,R3,R0,R4 // r0 = a*w - 1270(a*w/1270)
            POP         {R4,LR}
            BX          LR


            .global		TireCirc
    		.thumb_func
    		.align

TireCirc:
            PUSH        {R4,R5,R6,LR}
            BL          TireDiam // call function TireDiam
            LDR         R2,=1587500
            LDR         R3,=4987290
            LDR         R4,=3927
            MUL         R5,R4,R0 //R5 = R3*R0(diam * 3927)
            MLA         R6,R3,R1,R5 // R6 = R5+R2*R1(r5+diam*4987290)
            UDIV        R1,R6,R2//R1 = R6/1587500
            MLS         R0,R2,R1,R6 // remainder = R6-R4(R1)
            POP         {R4,R5,R6,LR}
            BX          LR
            .end
