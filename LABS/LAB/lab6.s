/*
	This code was written to support the book, "ARM Assembly for Embedded Applications",
	by Daniel W. Lewis. Permission is granted to freely share this software provided
	that this notice is not removed. This software is intended to be used with a run-time
    library adapted by the author from the STM Cube Library for the 32F429IDISCOVERY
    board and available for download from http://www.engr.scu.edu/~dlewis/book3.
*/
            .syntax     unified
            .cpu cortex-m4
            .text



            .global     Between
            .thumb_func
            .align


Between:    //R0 = min, R1 = value, R2 = max
            SUB         R1,R1,R0//R1=value-min
            SUB         R0,R2,R0//R0=max-min
            CMP         R0,R1//compares R1<=R0
            ITE         LS
            LDRLS       R0,=0//if its less than or the same then return 0
            LDRHI       R0,=1//if false return 0
            BX          LR


            .global		Count
    		.thumb_func
    		.align

Count:      //R0 = cells R1 = numb R2 = value
            LDR             R3,=0
L1:
            CMP         R1,0 //compare numb and zero
            BEQ         Then //branch to then statement if equal
            SUB         R1,R1,1 //numb--
            LDR         R12,[R0],4 //cells[numb]
            CMP         R12,R2 //compare cells[numb] with value
            IT          EQ //if-then block
            ADDEQ       R3,R3,1 // if statement is true equal then count+1
            B           L1 //branch back to the begining of the loop
Then:
            MOV         R0,R3 //move r3 to r0
            BX          LR

.end
