library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FuncUnit is
    Port ( Op : in STD_LOGIC_VECTOR (5 downto 0);
           Funct : in STD_LOGIC_VECTOR (5 downto 0);
           enable: in STD_LOGIC;
           MemtoReg : out STD_LOGIC;
           MemWrite : out STD_LOGIC;
           MemRead: out STD_LOGIC;
           Branch : out STD_LOGIC;
           ALUControl : out STD_LOGIC_VECTOR (2 downto 0);
           ALUSrc : out STD_LOGIC;
           RegDst : out STD_LOGIC;
           RegWrite : out STD_LOGIC;
           jump : out STD_LOGIC;
           a1:out std_logic;
           a2:out std_logic;
           si :out STD_LOGIC;
           stop: out STD_LOGIC);
end FuncUnit;

architecture Behavioral of FuncUnit is
begin
process(Op,Funct,enable)
begin
if(enable='1') then
    case op is
        when "000000"=>--R-Type Instructions
            jump<='0';
            MemtoReg<='0';
            MemWrite<='0';
            MemRead<='0';
            Branch <= '0';
            ALUSrc <='0';
            RegDst <='1';
            a1<='0';
            a2<='1';     
            --ALUControl<=Funct(2 downto 0);
            stop<='0';
            case Funct  is
                when "011010"=>
                    RegWrite<='1';
                    ALUControl<=Funct(2 downto 0);
                    si<='1'; 
                when "010000"=>
                    RegWrite<='1';
                    ALUControl<=Funct(2 downto 0);
                    si<='1';
                when "010001"=>
                    RegWrite<='1';
                    ALUControl<=Funct(2 downto 0);
                    si<='1';
                when "010101"=>
                    RegWrite<='1';
                    ALUControl<=Funct(2 downto 0);
                    si<='1';
                when "010110"=>
                    RegWrite<='1';
                    ALUControl<=Funct(2 downto 0);
                    si<='1';
                when others=>                             --For all the instructions except the Special instruction!!!
                    RegWrite<='1';
                    ALUControl<=Funct(2 downto 0);
                    si<='0';
            end case;    
        when "001100"=>--Jump Instruction 
            stop<='0';
            jump<='1';
            MemWrite<='0';
            MemRead<='0';
            RegWrite<='0';
        
        when "111111"=> --HALT
            stop<='1';
            jump<='0';
            MemWrite<='0';
            MemRead<='0';
            RegWrite<='0';
       
        when others =>--I-Type Instructions
            
            stop<='0';
            si<='0';
            jump<='0';
            
            case Op is 
            
                when "000011"=>                 --ANDI(03)
                    ALUSrc <='1';
                    RegDst <='0';
                    MemtoReg<='0';
                    MemRead<='0';
                    MemWrite<='0';
                    Branch <= '0';
                    RegWrite<='1';
                    a1<='1';
                    a2<='0'; 
                    ALUControl<="010";    
                when "000100"=>                    --ORI(04)
                    ALUSrc <='1';
                    RegDst <='0';
                    MemtoReg<='0';
                    MemRead<='0';
                    MemWrite<='0';
                    Branch <= '0';
                    RegWrite<='1';
                    a1<='1';
                    a2<='0'; 
                    ALUControl<="011"; 
                when "000111"=>                    --Load(07)
                    ALUSrc <='1';
                    RegDst <='0';
                    MemtoReg<='1';
                    MemWrite<='0';
                    MemRead<='1';
                    Branch <= '0';
                    RegWrite<='1';
                    ALUControl<="001"; 
                    a1<='1';
                    a2<='0'; 
                when "101011"=>                    --Store(2B)
                    ALUSrc <='1';
                    RegDst <='0';
                    MemtoReg<='0';
                    MemRead<='0';
                    MemWrite<='1';
                    Branch <= '0';
                    RegWrite<='0';
                    ALUControl<="001"; 
                    a1<='1';
                    a2<='0'; 
                when "001001"=>                    --BLE(09)
                    ALUSrc <='0';
                    RegDst <='0';
                    MemtoReg<='0';
                    MemRead<='0';
                    MemWrite<='0';
                    Branch <= '1';
                    RegWrite<='0';
                    ALUControl<="101";
                    a1<='1';
                    a2<='0';  
                    jump<='0'; 
                when "001010"=>                   --BEQ(0A)
                    ALUSrc <='0';
                    RegDst <='0';
                    MemtoReg<='0';
                    MemWrite<='0';
                    MemRead<='0';
                    Branch <= '1';
                    RegWrite<='0';
                    a1<='1';
                    a2<='0'; 
                    ALUControl<="110";
                    jump<='0'; 
                when "001011"=>                    --BNE(0B)
                    ALUSrc <='0';
                    RegDst <='0';
                    MemtoReg<='0';
                    MemWrite<='0';
                    MemRead<='0';
                    Branch <= '1';
                    RegWrite<='0';
                    a1<='1';
                    a2<='0'; 
                    ALUControl<="111";
                    jump<='0'; 
                when others=>                  --ADDI(08)
                    ALUSrc <='1';
                    RegDst <='0';
                    MemtoReg<='0';
                    MemWrite<='0';
                    MemRead<='0';
                    Branch <= '0';
                    RegWrite<='1';
                    a1<='1';
                    a2<='0'; 
                    ALUControl<="000"; 
                    
            end case;
    end case;
 end if;
end process;
end Behavioral;
