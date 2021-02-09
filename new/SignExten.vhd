library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity SignExten is
    Port ( din : in STD_LOGIC_VECTOR (15 downto 0);
           dout : out STD_LOGIC_VECTOR (31 downto 0));
end SignExten;

architecture Behavioral of SignExten is

begin
with din(15) select 
    dout<= x"FFFF"&din(15 downto 0) when '1',
                 x"0000"&din(15 downto 0) when others;
end Behavioral;
