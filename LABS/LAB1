/*
	This code was written to support the book, "ARM Assembly for Embedded Applications",
	by Daniel W. Lewis. Permission is granted to freely share this software provided
	that this notice is not removed. This software is intended to be used with a run-time
	library adapted by the author from the STM Cube Library for the 32F429IDISCOVERY
	board and available for download from http://www.engr.scu.edu/~dlewis/book3.
*/

#include <stdint.h>
#include <stdio.h>

uint32_t Bits2Unsigned(int8_t bits[8]){
		uint32_t value=0;

	// To be implemented by student
	// Input:	bits[0] = Least significant bit
	//        bits[7] = Most significant bit
	// Output:	0 <= return value < 255
	for(int i =7; i>=0; i--)
	{
		//using polynomial expansion 2*n+2*n
		value = ((2*value) + bits[i]);
	}
	return value ;
}

int32_t Bits2Signed(int8_t bits[8]){
	int32_t value = 0;
	int i;
	// To be implemented by student
	// Input:	bits[0] = Least significant bit
	//        bits[7] = Most significant bit
	// Output: -128 <= return value <= +127
	for(i = 6; i>=0; i--){
		value = ((value*2)+bits[i]);
	}
	//converting a binary to unsigned
	value-=bits[7]*128;
	return value ;
}

void Increment(int8_t bits[8]){
	// To be implemented by student
	// Adds 1 to the number represented by bits
	// Where:	bits[0] = Least significant bit
	//			bits[7] = Most significant bit
	int i;
	for(i =0; i<8; i++)
	{
		//first check if 0 then make 1
		if(bits[i]==0){
			bits[i]=1;
			break;
		}
		//if it is 1 then change to zero
		if(bits[i]==1){
			bits[i]=0;
		}
	}
	return;
}

void Unsigned2Bits(uint32_t n, int8_t bits[8]){
	// To be implemented by student
	// Input:	0 <= n <= 255
	// Output:	Converts n to an array of bits
	// Where:	bits[0] = Least significant bit
	//        bits[7] = Most significant bit
	int i;
	for(i=0; i<8; i++)
	{
		//repeat division opposite of Bits2Signed
		bits[i]=n%2;
		n=n/2;
	}
}
