library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity adder is
    Port ( inp1 : in STD_LOGIC_VECTOR (31 downto 0);
           inp2 : in STD_LOGIC_VECTOR (31 downto 0);
           dout : out STD_LOGIC_VECTOR (31 downto 0));
end adder;

architecture Behavioral of adder is
begin
    dout<=STD_LOGIC_VECTOR(to_unsigned(to_integer(signed(inp1))+to_integer(unsigned(inp2)),32));
end Behavioral;