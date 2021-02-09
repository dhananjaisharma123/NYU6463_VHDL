library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use std.textio.all;
use std.env.finish;
entity FuncUnit_tb is
--  Port ( );
end FuncUnit_tb;

architecture Behavioral of FuncUnit_tb is
signal clk:std_logic:='0';
signal Instruction:STD_LOGIC_VECTOR(31 downto 0);
signal MemtoReg,MemWrite,MemRead,Branch,RegDst,RegWrite,jump,a1,a2,si,stop,ALUSrc:STD_LOGIC;
signal ALUControl:STD_logic_vector(2 downto 0);
signal logic_1:STD_LOGIC:='1';
signal Zero:STD_LOGIC;
signal ALUResult:STD_LOGIC_VECTOR(31 downto 0);
constant CLK_PERIOD : Time:=10ns;
begin
UU1:entity work.FuncUnit port map(Op=>Instruction(31 downto 26),
           Funct => Instruction(5 downto 0),
           enable=>logic_1,
           MemtoReg =>MemtoReg,
           MemWrite=>MemWrite,
           MemRead=>MemRead,
           Branch=>Branch,
           ALUControl=>ALUControl,
           ALUSrc =>ALUSrc,
           RegDst=>RegDst,
           RegWrite=>RegWrite,
           jump =>jump ,
           a1=>a1,
           a2=>a2,
           si=>si,
           stop=>stop); 
 UUT2:entity work.ALU port map(SrcA =>x"FFFFFFFF",
                                          SrcB=>x"F0F0F0F0",
                                          ALUControl=>ALUControl,
                                          SI =>si,
                                          ShAmt=>Instruction(9 downto 6),
                                          Zero=>Zero,
                                          ALUResult =>ALUResult);
           
gen_clock: process
begin
    wait for(CLK_PERIOD/2);
    clk <= not clk;
end process;

process is        
variable line_v,line_op,line_op1 : line;
variable Instr :STD_LOGIC_VECTOR(31 downto 0);
file read_file : text;
file write_file,write_file1 : text;
begin
file_open(read_file, "Instructions.txt", read_mode);
file_open(write_file, "FuncUnit_ALU_output_tb.txt", write_mode);

while not endfile(read_file) loop
      readline(read_file, line_v);
      read(line_v,Instr);
      Instruction<=Instr;
      write(line_op,MemtoReg&MemWrite&MemRead&Branch&ALUControl&ALUControl&ALUSrc&RegDst&RegWrite&jump&a1&a2&si&stop);  
      write(line_op1,Zero&ALUResult);
      writeline(write_file,line_op);
      writeline(write_file,line_op1);
      wait for CLK_PERIOD; 
end loop;
file_close(read_file); 
file_close(write_file1);
file_close(write_file);
finish;
end process;

end Behavioral;
