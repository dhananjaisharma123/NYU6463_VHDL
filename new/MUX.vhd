library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MUX is
    Port ( inp1 : in STD_LOGIC_VECTOR (31 downto 0);
           inp2 : in STD_LOGIC_VECTOR (31 downto 0);
           sel : in STD_LOGIC;
           dout : out STD_LOGIC_VECTOR (31 downto 0));
end MUX;

architecture Behavioral of MUX is

begin
with sel select
    dout<= inp1 when '0',
                 inp2 when '1',
                 (others=>'X') when others;
                 
end Behavioral;