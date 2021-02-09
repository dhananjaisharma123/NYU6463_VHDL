library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
    Port ( SrcA : in STD_LOGIC_VECTOR (31 downto 0);
           SrcB : in STD_LOGIC_VECTOR (31 downto 0);
           ALUControl : in STD_LOGIC_VECTOR (2 downto 0);
           SI : in STD_LOGIC;     --Special Instructions 
           ShAmt: in STD_LOGIC_VECTOR(3 downto 0);
           Zero : out STD_LOGIC;
           ALUResult : out STD_LOGIC_VECTOR (31 downto 0));
end ALU;

architecture Behavioral of ALU is
signal result1,result2,result3,result4,result5,result6:STD_LOGIC_VECTOR(31 downto 0);
signal LR_Out,RR_Out: STD_LOGIC_VECTOR(31 downto 0);
signal ip1,ip2:STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');

begin

LR:entity work.LRO port map(
           din=>ip1,
           rotAmt =>ShAmt,
           dout=>LR_Out);      
  
RR:entity work.RRO port map(din=>ip2,
           rotAmt =>ShAmt,
           dout=>  RR_Out);                

process(SrcA,SrcB,ALUControl,SI)
begin
    if (SI='0') then 
            case ALUControl is 
                when "001"=>    --ADDU result =  Rs+Rt
                    result1<=STD_LOGIC_VECTOR(unsigned(SrcA)+unsigned(SrcB));
                    Zero<='0';
                when "000"=>    --ADD  result =  Rs+Rt
                    result2<=STD_LOGIC_VECTOR(signed(SrcA)+signed(SrcB));
                    Zero<='0';
                when "010"=>     --AND  result =  Rs and Rt
                    result3<=SrcA AND SrcB;
                    Zero<='0';
                when "011"=>  --OR  result =  Rs OR Rt
                    result4<=SrcA OR SrcB;
                    Zero<='0';
                when "100"=>    --- result =  Rs NOR Rt
                    result5<=SrcA NOR SrcB;
                    Zero<='0';
                when "101"=>                                                       --BLE
                    if(signed(SrcA)<=signed(SrcB)) then   
                        Zero<='1';
                    else
                        Zero<='0';
                    end if;
                when "110"=>                                                       --BEQ
                    if(signed(SrcA)=signed(SrcB)) then 
                        Zero<='1';
                    else
                        Zero<='0';
                    end if;
                when others=>                                                       --BNE
                    if(signed(SrcA)/=signed(SrcB)) then 
                        Zero<='1';
                    else
                        Zero<='0';
                    end if;
            end case;
         end if;
    if (SI='1') then
        case ALUControl is
            when "010" =>                                                   --divison 
                result6<=(others=>'0');
            when "000" =>                                                      --XOR and left rotate
                ip1<=SrcA XOR SrcB;
            when "001" =>                                                       --Right rotate and XOR Rd=(Rs>>>ShAmt) XOR Rt
                ip2<=SrcA;
            when "101"=>                                                        --Left Rotate and add Rd=(Rs<<<ShAmt)+Rt
                ip1<=SrcA;
            when "110"=>                                                       --"110" Sub and Right rotate Rd = (Rs-Rt)>>>ShAmt
                ip2<=STD_LOGIC_VECTOR(signed(SrcA)-signed(SrcB));
            when others=>
        end case;  
    end if;                  
end process;

with SI&ALUControl select
    ALUResult<=result1 when "0001",
                        result2 when "0000",
                        result3 when "0010",
                        result4 when "0011",
                        result5 when "0100",
                        result6 when "1010",
                        LR_Out when "1000",
                        RR_out xor SrcB when "1001",
                        STD_LOGIC_VECTOR(signed(LR_out)+signed(SrcB)) when "1101",
                        RR_Out when others;
end Behavioral;
