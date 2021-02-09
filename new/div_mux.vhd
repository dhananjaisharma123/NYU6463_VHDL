library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity div_mux is
    Port ( din0 : in STD_LOGIC_VECTOR (31 downto 0);
           din1 : in STD_LOGIC_VECTOR (31 downto 0);
           enable : in STD_LOGIC;
           selbit: in STD_LOGIC;
           dout : out STD_LOGIC_VECTOR (31 downto 0);
           clk : in STD_LOGIC);
end div_mux;

architecture Behavioral of div_mux is
signal temp  : STD_LOGIC_VECTOR (31 downto 0):=(others=>'0');
begin
process(clk)
begin
    if(selbit='0')then
        temp<=din0;
    elsif(selbit='1') then
        temp<=din1;
    end if;
end process;
dout<=temp;
end Behavioral;