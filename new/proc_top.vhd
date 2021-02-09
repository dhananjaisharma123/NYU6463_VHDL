library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity proc_top is
Port ( enable : in STD_LOGIC;
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           done : out STD_LOGIC);
end proc_top;

architecture Behavioral of proc_top is
type state_def is(IDLE,DEC,MR_RW,RW,div,HALT);
signal state: state_def;
signal isMW_RW,WE_M: STD_logic;

signal PCPlus4,PCBranch,address,PCIn,PC,Instruction:STD_LOGIC_VECTOR(31 downto 0);
signal PC_enable:STD_LOGIC:='0';
signal ALUControl : STD_LOGIC_VECTOR(2 downto 0);
signal MemtoReg,MemRead,MemWrite,Branch,ALUSrc,RegDst,RegWrite,jump,si,stop:STD_LOGIC:='0';

signal SignImm,SignImmShift:STD_LOGIC_VECTOR(31 downto 0);
signal WriteReg,ReadRegTarget,ReadRegSource:STD_LOGIC_VECTOR(4 downto 0);

signal Result,RD2,SrcA,SrcB,ALUResult,ReadData:STD_LOGIC_VECTOR(31 downto 0);
signal Zero:STD_LOGIC;

signal PCSrc:STD_LOGIC:='0';
signal logic_1:STD_LOGIC:='1';
signal JumpAddress,JumpAddr: STD_LOGIC_VECTOR(31 downto 0);
signal a1,a2:STD_LOGIC;

signal write_div,is_div,div_ready,div_zero_error,div_start:STD_LOGIC;
signal remainder,quotient: STD_LOGIC_VECTOR(31 downto 0);
begin
PCSrc<=Branch and Zero;          
JumpAddr<="0000"&Instruction(25 downto 0)&"00"; 
is_div<=si and not(ALUControl(2)) and ALUControl(1) and not(ALUControl(0)); --Identifying the given instruction is divide
Divider:entity work.divider port map(N=>SrcA,
           D=>SrcB,
           VALID=>div_start,
           clk1=>clk,
           reset=>reset,
           READY =>div_ready,
           div_zero_error=>div_zero_error,
           remainder=>remainder,
           quotient =>quotient);           
JumpAdder: entity work.adder port map(inp1=>JumpAddr,
           inp2=>PCPlus4,
           dout =>JumpAddress);
PC_MUX: entity work.MUX port map( inp1=>PCPlus4,
           inp2 =>PCBranch,
           sel=>PCSrc,
           dout=>address);
JumpMux:entity work.MUX port map( inp1=>address,
           inp2 =>JumpAddress,
           sel=>Jump,
           dout=>PCIn);
PCreg: entity work.PCreg port map(din =>PCIn,
           load=>PC_enable,
           clk=>clk,
           clear=>reset,
           dout=>PC);
           
 PCadder: entity work.PCadd port map( din =>PC,
           dout=>PCPlus4,
           clk=>clk);
           
InstrMem:entity work.InsMem port map(addr =>PC,
           dout=>Instruction);
            
FuncUnit:entity work.FuncUnit port map(Op=>Instruction(31 downto 26),
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
           
SignExt:entity work.SignExten port map(din =>Instruction(15 downto 0),
           dout=>SignImm);
           
SignImmShift<=SignImm(29 downto 0) & "00";

BranchAdder: entity work.adder port map(inp1=>SignImmShift,
           inp2=>PCPlus4,
           dout =>PCBranch);
           
Addr3Mux: entity work.A3Mux port map( inp1=>Instruction(25 downto 21),
           inp2 =>Instruction(15 downto 11),
           sel=>RegDst,
           dout=>WriteReg);

Addr2Mux: entity work.A3Mux port map( inp1=>Instruction(20 downto 16), ------Check this one!!!!!!!!!
           inp2 =>Instruction(25 downto 21),
           sel=>a1,
           dout=>ReadRegTarget);  
   
Addr1Mux: entity work.A3Mux port map( inp1=>Instruction(20 downto 16), ------Check this one!!!!!!!!!
           inp2 =>Instruction(25 downto 21),
           sel=>a2,
           dout=>ReadRegSource);   
           
RegFile: entity work.REG_FILE port map(A1=>ReadRegSource,   -----CHeck this too!!!!
           A2=>ReadRegTarget,
           A3 =>WriteReg,
           WD3 =>Result,
           WE3=>RegWrite,
           CLK =>clk,
           reset=>reset,
           write_div=>write_div,
           remainder=>remainder,
           Quotient=>quotient,
           RD1=>SrcA,
           RD2=>RD2);
ALUMux: entity work.MUX port map(inp1=>RD2,
           inp2=>SignImm,
           sel=>ALUSrc,
           dout=>SrcB);
           
ALU: entity work.ALU port map(SrcA=>SrcA,
           SrcB=>SrcB,
           ALUControl =>ALUControl,
           SI =>si,
           ShAmt=>Instruction(9 downto 6),
           Zero=>Zero,
           ALUResult=>ALUResult);
 WE_M<=MemWrite and isMW_RW;   
DataMem: entity work.DataMem port map(A =>ALUResult,
            WD =>RD2,
           WE =>WE_M,
           RE =>MemRead,
           RD=>ReadData,
           CLK=>clk);
           
MemMux:entity work.MUX port map(inp1=>ALUResult,
           inp2=>ReadData,
           sel=>MemtoReg,
           dout=>Result);



FSM:process(clk,reset)
begin
    if(reset='1') then 
        state<=idle;
    else
        if(rising_edge(clk)) then
            case state is 
                when idle =>
                    if(enable='1') then 
                        state<=DEC;
                    end if;
                when DEC=>
                    if(stop='1') then
                        state<=HALT;
                    else
                        state<=MR_RW;
                    end if;
               
                when MR_RW=>
                    if(stop='1') then
                        state<=HALT;
                    elsif(is_div='1') then 
                        state<=div;
                    elsif(MemRead='1') then
                        state<=RW;
                    else
                        state<=DEC;
                    end if;
                 when div=>
                    if(div_ready='1') then 
                        state<=DEC;
                    else
                        state<=div;
                    end if;
                when RW=>
                     if(stop='1') then
                        state<=HALT;
                    else
                        state<=DEC;
                    end if;
                when HALT=>
                    state<=HALT;           
            end case;
        end if;
    end if;
end process;

FSM_control:process(state,div_ready)

begin
            case state is 
                when idle =>
                    write_div<='0';
                    pc_enable<='0';
                    done<='0';  
                    isMW_RW<='0';
                when DEC=>
                    write_div<='0';
                     PC_enable<='0';  
                    done<='0';
                    isMW_RW<='0';
                when div=>
                    div_start<='1';
                    if(div_ready='1') then
                        PC_enable<='1';
                        write_div<='1';
                    else
                        PC_enable<='0';  
                    end if;
                    done<='0';
                    isMW_RW<='0';
                when MR_RW=>
                    write_div<='0';
                    done<='0';
                    isMW_RW<='1';
                    if(MemRead='1' or is_div='1') then 
                        PC_enable<='0';  
                    else
                        PC_enable<='1';
                    end if;
                when RW=>
                    write_div<='0';
                    isMW_RW<='0';
                    done<='0';
                    PC_enable<='1'; 
                when others=>
                    write_div<='0';
                    pc_enable<='0';
                    isMW_RW<='0';
                    done<='1';            
            end case;
end process;
end Behavioral;
