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

// float EccentricAnomaly(float e, float M)

        .global         EccentricAnomaly
        .thumb_func
        .align
EccentricAnomaly:    // S0 = e, S1 = M
        PUSH            {LR}
        VPUSH           {S16,S17,S18,S19} // perserve s16-s19
        VMOV            S16,S0 //s16=e
        VMOV            S17,S1 //s17=m
        VMOV            S0,S1 // s0=m
        BL              sinDeg
        VMUL.F32        S18,S16,S0 //S18 = e*sinDeg(M)
        BL              cosDeg
        VMOV            S2,1.0
        VMLA.F32        S2,S16,S0 // S2 = 1+e*Cosdeg(M)(s2=s2+s16*S0)
        VMUL.F32        S0,S2,S18 // S0 = 1+e*cosDeg(M)* e*sinDeg(M)
        BL              Rad2Deg
        VADD.F32        S0,S17,S0  // S0 = 1+e*cosDeg(M)* e*sinDeg(M)+1+e*cosDeg(M)* e*sinDeg(M)
        VPOP            {S16,S17,S18,S19}
        POP             {PC}


// float Kepler(float m, float ecc)

        .global         Kepler
        .thumb_func
        .align
Kepler:    // S0 = m, S1 = ecc
        PUSH            {LR}
        VPUSH           {S16-S28}
        VMOV            S20,S0 // save S0 into S20
        VMOV            S16,S1 // save ecc into S16
        LDR             R0,=epsilon // set S21 to epsilon
        VLDR            S21,[R0]
        BL              Deg2Rad
        VMOV            S17,S0  // set s17 to e
        VMOV            S18,S0// set s18 to e

L1:     VMOV            S0,S17 // set s0 to e
        BL              sinf
        VMUL.F32        S22,S16,S0 // S22 = ecc*sinf(e)
        VSUB.F32        S23,S17,S22 //S23= e-ecc * sinf(e) ;
        VSUB.F32        S23,S23,S16 //S23 delta = e - ecc * sinf(e) - m;
        VMOV            S0,S17
        BL              cosf
        VMOV            S25,1.0
        VMUL.F32        S24,S16,S0 // S24 = ecc*cosf(e)
        VSUB.F32        S25,S25,S24 // s25 = 1-ecc*cosf(e)
        VDIV.F32        S28,S23,S25// s28 = delta/1-ecc*cosf(e)
        VSUB.F32        S17,S17,S28 //s17 = e-delta/1-ecc*cosf(e)
        VABS.F32        S26,S23 // |delta|
        VCMP.F32        S26,S21 // cmp  |delta|with eplison
        VMRS            APSR_nzcv, FPSCR
        BGT             L1
        VMOV            S0,S18
        VPOP            {S16-S28}
        POP             {PC}


        .align
epsilon:
        .float          1E-6

        .end
