
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

entity reg is
    Port ( din : in STD_LOGIC_VECTOR (31 downto 0);
           dout : out STD_LOGIC_VECTOR (31 downto 0);
           load : in STD_LOGIC;
           clk : in STD_LOGIC;
           zero: out std_logic;
           reset : in STD_LOGIC);
end reg;

architecture Behavioral of reg is
signal reg_temp:STD_LOGIC_VECTOR (31 downto 0);
signal err:STD_LOGIC:='0';
begin
process(clk,reset)
begin
    if(reset='1')then 
        reg_temp<=(others=>'0');
    elsif(rising_edge(clk)) then 
        if(load='1') then 
            reg_temp<=din;
             if(din=std_logic_vector(to_unsigned(0,32))) then
                err<='1';
            else
                err<='0';
             end if;
        end if;
end if;
end process;
dout<=reg_temp;
zero<=err;
end Behavioral;