library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DataMem is
    Port ( A : in STD_LOGIC_VECTOR (31 downto 0);
            WD : in STD_LOGIC_VECTOR (31 downto 0);
           WE : in STD_LOGIC;
           RE: in STD_LOGIC;
           RD : out STD_LOGIC_VECTOR (31 downto 0);
           CLK : in STD_LOGIC);
end DataMem;

architecture Behavioral of DataMem is
type Mem is array(0 to 39) of STD_LOGIC_VECTOR(15 downto 0);
signal DataMem: Mem:=(
"0000000000000000", --#0
"0000000000001001", 
"0000000000000000", --#2
"0000000000000100", 
"0000000000000000", --#4
"1111111111111111", 
"1111111111111111", --#6
"0000000000000100", 
"0000000000000000", --#8
"0000000000000101", 
"0000000000000000", --#10
"0000000000000110", 
"0000000000000000", --#12
"0000000000000111", 
"0000000000000000", --#14
"0000000000001000", 
"0000000000000000", --#16
"0000000000001001", 
"0000000000000000", --#18
"0000000000001010",
"0000000000000000", --#20
"0000000000000111", 
"0000000000000000", --#22
"0000000000001100", 
"0000000000000000", --#24
"0000000000001101", 
"0000000000000000", --#26
"0000000000001110", 
"0000000000000000", --#28
"0000000000001111", 
"0000000000000000", --#30
"0000000000010000", 
"0000000000000000", --#32
"0000000000010001", 
"0000000000000000", --#34
"0000000000010010", 
"0000000000000000", --#36
"0000000000010011", 
"0000000000000000", --#38
"0000000000001010");
begin
process(CLK)
begin
if(rising_edge(clk) ) then 
    if(RE='1') then 
        RD<=DataMem(to_integer(unsigned(A)))&DataMem(to_integer(unsigned(A)+1));
    end if;
    if(WE='1') then 
        DataMem(to_integer(unsigned(A)))<=WD(31 downto 16);
        DataMem(to_integer(unsigned(A)+1))<=WD(15 downto 0);
    end if;
end if;
end process;
end Behavioral;
