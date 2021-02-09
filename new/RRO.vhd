library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RRO is
    Port ( din : in STD_LOGIC_VECTOR (31 downto 0);
           rotAmt : in STD_LOGIC_VECTOR (3 downto 0);
           dout : out STD_LOGIC_VECTOR (31 downto 0));
end RRO;

architecture Behavioral of RRO is

begin
    with rotAmt select 
        dout<=din(0)&din(31 downto 1) when "0001",
                    din(1 downto 0)&din(31 downto 2) when "0010",
                    din(2 downto 0)&din(31 downto 3) when "0011",
                    din(3 downto 0)&din(31 downto 4) when "0100",
                    din(4 downto 0)&din(31 downto 5) when "0101",
                    din(5 downto 0)&din(31 downto 6) when "0110",
                    din(6 downto 0)&din(31 downto 7) when "0111",
                    din(7 downto 0)&din(31 downto 8) when "1000",
                    din(8 downto 0)&din(31 downto 9) when "1001",
                    din(9 downto 0)&din(31 downto 10) when "1010",
                    din(10 downto 0)&din(31 downto 11) when "1011",
                    din(11 downto 0)&din(31 downto 12) when "1100",
                    din(12 downto 0)&din(31 downto 13) when "1101",
                    din(13 downto 0)&din(31 downto 14) when "1110",
                    din(14 downto 0)&din(31 downto 15) when "1111",
                    din when others;
end Behavioral;
