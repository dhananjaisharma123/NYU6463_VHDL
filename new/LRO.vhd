library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity LRO is
    Port ( din : in STD_LOGIC_VECTOR (31 downto 0);
           rotAmt : in STD_LOGIC_VECTOR (3 downto 0);
           dout : out STD_LOGIC_VECTOR (31 downto 0));
end LRO;

architecture Behavioral of LRO is

begin
with rotAmt select 
        dout<=din(30 downto 0)&din(31) when "0001",
                    din(29 downto 0)&din(31 downto 30) when "0010",
                    din(28 downto 0)&din(31 downto 29) when "0011",
                    din(27 downto 0)&din(31 downto 28) when "0100",
                    din(26 downto 0)&din(31 downto 27) when "0101",
                    din(25 downto 0)&din(31 downto 26) when "0110",
                    din(24 downto 0)&din(31 downto 25) when "0111",
                    din(23 downto 0)&din(31 downto 24) when "1000",
                    din(22 downto 0)&din(31 downto 23) when "1001",
                    din(21 downto 0)&din(31 downto 22) when "1010",
                    din(20 downto 0)&din(31 downto 21) when "1011",
                    din(19 downto 0)&din(31 downto 20) when "1100",
                    din(18 downto 0)&din(31 downto 19) when "1101",
                    din(17 downto 0)&din(31 downto 18) when "1110",
                    din(16 downto 0)&din(31 downto 17) when "1111",
                    din when others;

end Behavioral;
