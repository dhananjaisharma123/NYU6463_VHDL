The following folder contains the project folder for NYU6463 processor

The architecture of the NYU6463 is
"proc_top.vhd" is the top module which contains the FSM to control the working of the processor and in this file all the other components are connected.

The design was implemented with the FSM changing state at every rising as well as the falling clock but during synthesising the design it was noticed that the processor couldn't be synthesised with both the events therefore in order to have a synthesisable design the rising edge of the clock was considered for the operation.

No of cycles for different types of instructions:-
1)I-Type,R-Type:- 2 cycles
   Since in each instruction there are two memory access(one register read then followed by register    
   file write for R-Type and I-Type instructions except for store which has an access to the data   
   memory for writing the result)
2) J-Type:-1 cycle
   In this no memory access is required therefore it only takes one clock cycle
   
3) Store Instruction: 3 cycles 
This instruction is the bottleneck of the system, as the execution of load instruction takes three memory entries two to register file and one to data memory.

Thus the execution time for the program is 
Fraction of Load instruction = l
Fraction of division instructions = m (N numerator D denominators)
Time of Execution of complete program = [3l+2(1-l-m)+(N-D)*3]clk_period

Testing of the processor:
1) All the individual components except the muxes,adders were tested and test bench is included in 									   
   the submission along with the output textfile for the checking of ALU and Functional Unit
2) All the instructions in the problem sheet are executed and was found to be working fine.
3) In the second half of the instruction memory a program was written in order to find the factorial      
   of the value stored at M20(M[20])! and the result of the calculated factorial is stored in the R1  
   register which is a unsigned value in order have bigger range.


The program takes around 34us to execute of which division takes the longest time.

The program which is run to test the durability and accuracy of the NYU 6463 is 
"00100000","00110000","00000000","00000010",--#0 R[3] = R0+2
"00011100","00100000","00000000","00000000",--#4 R[1] = M[R[0]+0]
"00011100","01000000","00000000","00000010",--#8 R[2] = M[R[0]+2]
"00000000","00100010","00000000","00011010",--#12 division R1/R2
"00100000","01100011","00000000","00000010",--#16 R3 =R3+2
"10101100","01100011","00000000","00000000", --#20 L20 R3,R3,#0 (M[R3+0]<=R3)
"00100000","00100001","11111111","11111111",--#24 R1 =R1-1
"00101100","00100010","11111111", "11111100",--#28 BNE R1,R2,#-4
"00011100","00100000","00000000","00000000",--#32 r1 = M[R0+0] LW
"00011100","01000000","00000000","00000010",--#36 r2 = M[R0+2] LW
"00000000","00100010","00011000","00010010",--#40 r3=r1 and r2 AND
"00001100","10000001","00000000","11111111",--#44 r4=r1and xFF ANDI
"00000000","00100010","00101000","00011101",--#48 r5 =r1 or r2
"00000000","00100010","00101000","00011110",--#52 r6 =r1 nor r2
"00010000","11100001","11110000","11110000",--#56 r7=r1and xF0F0 ORI
"10101100","01100000","00000000","00000100",--#60 R3->M[R0+4] 
"00100100","00100010","00000000","00000001",--#64 r2<r1 branch  taken
"11111111","11111111","11111111","11111111",--#68  halt
"00101000","01000001","00000000","00000011",--#72 r2=r1 branch
"00101100","00100010","00000000","00000001",--#76 r1!=r2 branch
"11111111","11111111","11111111","11111111",--#80 halt
"00110000","00000000","00000000","00000011",--#84 jump 2
"11111111","11111111","11111111","11111111",--#88 halt
"11111111","11111111","11111111","11111111",--#92 halt
"00000000","00100010","01000000","00100000",--#96 r8=r1+r2
"00000000","00100010","01001000","01010000",--#100 r9= r2 xor r1<<1
"00000000","00100010","01010000","10010001",--#104  r10 = (r2>>>2) xor r1 
"00000000","00100010","01011000","11010101",--#108 r11 = (r2<<<3) +R1 
"00000000","00100010","01100001","00010110",--#112 r12 = (r2-r1)>>4 
"00100000","11000000","00000000","00000001",--#116 ADDI R6,R0,#1   FACTORIAL PROGRAM !!!
"00100000","10100000","00000000","00000000",--#120 ADDI R5,R0,#0
"00011100","10000000","00000000","00010100", --#124 LW R4,R0,#20
"00100000","00100100","00000000","00000000",--#128 ADDI R1,R4,#0
"00100000","01100000","00000000","00000000", --#132 ADDI R3,R0,#0
"00000000","10000101","00000000","00010110",--#136 SBRR R4,R5,R2
"00100000","10100101","00000000","00000001",--#140 ADDI R5,R5,1
"00101100","01000110","00000000","00000001",--#144 BNE R2,R6,#1
"11111111","11111111", "11111111","11111111",--#148 HALT
"00000000","01100001","00011000","00100001", --#152 ADDU R3,R1,R3  ---Function  to calculate the product of two numbers 
"00100000","01000010","11111111","11111111", --#156 ADDI R2,R2,#-1
"00101100","01000110","11111111","11111101", --#160 BNE R2,R6,#-3
"00100000","00100011","00000000","00000000",  --#164 ADDI R1,R3,#0
"00101000","00100001","11111111","11110110", --#168 BEQ R1,R1,-10

 
