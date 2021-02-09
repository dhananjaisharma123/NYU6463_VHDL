library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity PCadd is
    Port ( din : in STD_LOGIC_VECTOR (31 downto 0);
           dout : out STD_LOGIC_VECTOR (31 downto 0);
           clk: in STD_LOGIC);
end PCadd;

architecture Behavioral of PCadd is
begin
        dout<= STD_LOGIC_VECTOR(unsigned(din)+4);
end Behavioral; 