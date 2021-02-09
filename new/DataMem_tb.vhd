
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use std.env.finish;
entity DataMem_tb is
--  Port ( );
end DataMem_tb;

architecture Behavioral of DataMem_tb is
signal Addr,RD,WD:STD_LOGIC_VECTOR(31 downto 0);
signal WE,RE:std_logic;
signal clk:std_logic:='0';
constant CLK_PERIOD:Time :=100ns;
begin
UUT: entity work.DataMem port map(A =>Addr,
            WD =>WD,
           WE =>WE,
           RE =>RE,
           RD=>RD,
           CLK=>clk);
gen_clock: process                 
begin                              
    wait for(CLK_PERIOD/2);        
    clk <= not clk;                   
end process;                                 

TB:process
begin
WD<=x"0F0F0F0F";
WE<='1';
RE<='0';
Addr<=x"00000023"; ---36
wait for CLK_Period;

WD<=x"DEAF0000";
WE<='1';
RE<='0';
Addr<=x"0000000c"; ---12
wait for CLK_Period;


WD<=x"0000DEAF";
WE<='1';
RE<='0';
Addr<=x"00000010"; --16
wait for CLK_Period*2;

---READ DATA
WE<='0';
RE<='1';
Addr<=x"00000010"; --16
assert (RD<=x"0000DEAF") report "Incorrect data";

WE<='0';
RE<='1';
Addr<=x"0000000c"; --12
assert (RD<=x"DEAF0000") report "Incorrect data";

WE<='0';
RE<='1';
Addr<=x"00000023"; --16
assert (RD<=x"0F0F0F0F") report "Incorrect data";
finish;
end process;

end Behavioral;