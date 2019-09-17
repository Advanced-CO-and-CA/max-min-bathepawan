/******************************************************************************
* file: ABS.s
* Author: Pawan Bathe (CS18M519)
* TA: G S Nitesh Narayana
* Guide: Prof. Madhumutyam IITM, PACE
******************************************************************************/

/*
ARM Assembly Code to find MIN, MAX and ARRAY LENGTH for given array
*/
  @BSS SECTION
  .bss
  	MAX: .word 0             @ will hold the max element in array 
  	MIN: .word 0             @ will hold min element in array
    LENGTH: .word 0          @ will hold array length 

  @ DATA SECTION
      .data
	data_items: .word 10, 4, 28, 100, 8, 31, 17, 19, 22, 111, 101, 134, 96, 1, 98, 97, 2, 0    
	

  @ TEXT section
      .text

.globl _main

_main:
    LDR R0, = data_items
    LDR R1, [R0], #4             
	MOV R2, R1                      @ Intialize R1(MIN) and R2(MAX) with first element of array
	MOV R3, #1                      @ Initialize R3 (i.e count of array elements) to 1

LOOP:
	LDR R4, [R0], #4                 
	CMP R4, #0
	BEQ EXIT                        @Stop Scanning further elements if elements is end marker i.e 0
	ADD R3, R3, #1
	CMP R4, R2                      @Check if current element is greater, than max element, update max if so
	BGT SWAP_MAX					@Update max element if current element is greater 
	CMP R4, R1                      @Check if current element is smaller, than min element.
	BLT SWAP_MIN					@Update min element if current element is smaller 
	B LOOP							@ Continue next iteration of loop 

SWAP_MIN:
	MOV R1, R4
	B LOOP

SWAP_MAX:
    MOV R2, R4
	B LOOP
	
EXIT:
	LDR R9, =MIN 					@ Store MIN
	STR R1, [R9]
    LDR R8, =MAX 					@ Store MAX
	STR R2, [R8]
    LDR R7, =LENGTH 				@ Store ARRAY LENGTH
    STR R3, [R7]
    SWI 0x11
    .end