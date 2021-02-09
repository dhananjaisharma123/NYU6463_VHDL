library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity A3Mux is
    Port ( inp1 : in STD_LOGIC_VECTOR (4 downto 0);
           inp2 : in STD_LOGIC_VECTOR (4 downto 0);
           sel: in STD_LOGIC;
           dout : out STD_LOGIC_VECTOR (4 downto 0));
end A3Mux;

architecture Behavioral of A3Mux is
begin
with sel select
    dout<= inp1 when '0',
                 inp2 when '1',
                 (others=>'X') when others;
end Behavioral;