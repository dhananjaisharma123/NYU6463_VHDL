library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use std.env;


entity DIVIDER_tb is
--  Port ( );
end DIVIDER_tb;

architecture Behavioral of DIVIDER_tb is
signal N_tb,D_tb,rem_tb,quo_tb: std_logic_vector(31 downto 0);
signal clk_tb,start_tb,reset_tb,ready_tb,div_zero_error:std_logic:='0';
constant  clock_period : time := 5 ns;
begin
UUT: entity work.divider port map(N=>N_tb,
           D=>D_tb,
           VALID=>start_tb,
           clk1=>clk_tb,
           reset=>reset_tb,
           READY=>ready_tb,
           div_zero_error=>div_zero_error,
           remainder=>rem_tb,
           quotient => quo_tb);
           
    clk_gen:process
    begin
        wait for clock_period;
        clk_tb<= not clk_tb;
    end process;
     
    test:process 
    begin   
        N_tb<=std_logic_vector(to_unsigned(10005,32));
        D_tb<=std_logic_vector(to_unsigned(578,32));
        reset_tb<='1';
        wait for clock_period;
        reset_tb<='0';
        start_tb<='1';
        wait until ready_tb='1';
        assert rem_tb = std_logic_vector(to_unsigned(179,32)) and quo_tb = std_logic_vector(to_unsigned(17,32)) report "Wrong output for the test case 1" severity error;
        report "result 1 ready";
        
         reset_tb<='1';
         wait for clock_period*5;
         reset_tb<='0';
        
        N_tb<=std_logic_vector(to_unsigned(1000,32));
        D_tb<=std_logic_vector(to_unsigned(5578,32));
        reset_tb<='1';
        wait for clock_period;
        reset_tb<='0';
        start_tb<='1';
        wait until ready_tb='1';
        assert rem_tb = std_logic_vector(to_unsigned(1000,32)) and quo_tb = std_logic_vector(to_unsigned(0,32)) report "Wrong output for the test case 2" severity error;
        report "result 2 ready";
        
         reset_tb<='1';
         wait for clock_period*5;
         reset_tb<='0';
        
        N_tb<=std_logic_vector(to_unsigned(100055,32));
        D_tb<=std_logic_vector(to_unsigned(578,32));
        reset_tb<='1';
        wait for clock_period;
        reset_tb<='0';
        start_tb<='1';
        wait until ready_tb='1';
        assert rem_tb = std_logic_vector(to_unsigned(61,32)) and quo_tb = std_logic_vector(to_unsigned(173,32)) report "Wrong output for the test case 3" severity error;
        report "result 3 ready";
        
        reset_tb<='1';
         wait for clock_period*5;
         reset_tb<='0';
        
        N_tb<=std_logic_vector(to_unsigned(1000555,32));
        D_tb<=std_logic_vector(to_unsigned(78,32));
        reset_tb<='1';
        wait for clock_period;
        reset_tb<='0';
        start_tb<='1';
        wait until ready_tb='1';
        assert rem_tb = std_logic_vector(to_unsigned(49,32)) and quo_tb = std_logic_vector(to_unsigned(12827,32)) report "Wrong output for the test case 4" severity error;
        report "result 4 ready";
        
        reset_tb<='1';
         wait for clock_period*5;
         reset_tb<='0';
        
        N_tb<=x"FFFFFFFF";
        D_tb<=x"FFFF0000";
        reset_tb<='1';
        wait for clock_period;
        reset_tb<='0';
        start_tb<='1';
        wait until ready_tb='1';
        assert rem_tb = x"0000FFFF" and quo_tb = x"00000001" report "Wrong output for the test case 5" severity error;
        report "result 5 ready";
        
         reset_tb<='1';
         wait for clock_period*5;
         reset_tb<='0';
        
         N_tb<=std_logic_vector(to_unsigned(11223344,32));
        D_tb<=std_logic_vector(to_unsigned(443322,32));
        reset_tb<='1';
        wait for clock_period;
        reset_tb<='0';
        start_tb<='1';
        wait until ready_tb='1';
        assert rem_tb = std_logic_vector(to_unsigned(140294,32)) and quo_tb = std_logic_vector(to_unsigned(25,32)) report "Wrong output for the test case 6" severity error;
        report "result 6 ready";
        
         reset_tb<='1';
         wait for clock_period*5;
         reset_tb<='0';
        
        N_tb<=std_logic_vector(to_unsigned(544332211,32));
        D_tb<=std_logic_vector(to_unsigned(112233445,32));
        reset_tb<='1';
        wait for clock_period;
        reset_tb<='0';
        start_tb<='1';
        wait until ready_tb='1';
        assert rem_tb = std_logic_vector(to_unsigned(95398431,32)) and quo_tb = std_logic_vector(to_unsigned(4,32)) report "Wrong output for the test case 7" severity error;
        report "result 7 ready";
        
         reset_tb<='1';
         wait for clock_period*5;
         reset_tb<='0';
        
        N_tb<=std_logic_vector(to_unsigned(87550001,32));
        D_tb<=std_logic_vector(to_unsigned(10005578,32));
        reset_tb<='1';
        wait for clock_period;
        reset_tb<='0';
        start_tb<='1';
        wait until ready_tb='1';
        assert rem_tb = std_logic_vector(to_unsigned(7505377,32)) and quo_tb = std_logic_vector(to_unsigned(8,32)) report "Wrong output for the test case 8" severity error;
        report "result 8 ready";
        
        reset_tb<='1';
         wait for clock_period*5;
         reset_tb<='0';
        
        N_tb<=std_logic_vector(to_unsigned(1010101010,32));
        D_tb<=std_logic_vector(to_unsigned(10101010,32));
        reset_tb<='1';
        wait for clock_period;
        reset_tb<='0';
        start_tb<='1';
        wait until ready_tb='1';
        assert rem_tb = std_logic_vector(to_unsigned(10,32)) and quo_tb = std_logic_vector(to_unsigned(100,32)) report "Wrong output for the test case 9" severity error;
        report "result 9 ready";
        
         reset_tb<='1';
         wait for clock_period*5;
         reset_tb<='0';
        
        N_tb<=x"F0F0F0F0";
        D_tb<=x"0F0F0F0F";
        reset_tb<='1';
        wait for clock_period;
        reset_tb<='0';
        start_tb<='1';
        wait until ready_tb='1';
        assert rem_tb = x"0000FFFF"and quo_tb = std_logic_vector(to_unsigned(1,32)) report "Wrong output for the test case 10" severity error;
        report "result 10 ready";
        
         N_tb<=std_logic_vector(to_unsigned(105,32));
        D_tb<=std_logic_vector(to_unsigned(100,32));
        reset_tb<='1';
        wait for clock_period;
        reset_tb<='0';
        start_tb<='1';
        wait until ready_tb='1';
        assert rem_tb = std_logic_vector(to_unsigned(5,32)) and quo_tb = std_logic_vector(to_unsigned(1,32)) report "Wrong output for the test case 11" severity error;
        report "result 11 ready";
        
         reset_tb<='1';
         wait for clock_period*5;
         reset_tb<='0';
        
        N_tb<=std_logic_vector(to_unsigned(29102020,32));
        D_tb<=std_logic_vector(to_unsigned(12101987,32));
        reset_tb<='1';
        wait for clock_period;
        reset_tb<='0';
        start_tb<='1';
        wait until ready_tb='1';
        assert rem_tb = std_logic_vector(to_unsigned(4898046,32)) and quo_tb = std_logic_vector(to_unsigned(2,32)) report "Wrong output for the test case 12" severity error;
        report "result 12 ready";
        
         reset_tb<='1';
         wait for clock_period*5;
         reset_tb<='0';
        
        N_tb<=std_logic_vector(to_unsigned(1210121012,32));
        D_tb<=std_logic_vector(to_unsigned(121010,32));
        reset_tb<='1';
        wait for clock_period;
        reset_tb<='0';
        start_tb<='1';
        wait until ready_tb='1';
        assert rem_tb = std_logic_vector(to_unsigned(21012,32)) and quo_tb = std_logic_vector(to_unsigned(10000,32)) report "Wrong output for the test case 13" severity error;
        report "result 13 ready";
        
        reset_tb<='1';
         wait for clock_period*5;
         reset_tb<='0';
        
        N_tb<=std_logic_vector(to_unsigned(1024,32));
        D_tb<=std_logic_vector(to_unsigned(256,32));
        reset_tb<='1';
        wait for clock_period;
        reset_tb<='0';
        start_tb<='1';
        wait until ready_tb='1';
        assert rem_tb = std_logic_vector(to_unsigned(0,32)) and quo_tb = std_logic_vector(to_unsigned(4,32)) report "Wrong output for the test case 14" severity error;
        report "result 14 ready";
        
        reset_tb<='1';
         wait for clock_period*5;
         reset_tb<='0';
        
        N_tb<=x"FFF0FFF0";
        D_tb<=x"0FF00000";
        reset_tb<='1';
        wait for clock_period;
        reset_tb<='0';
        start_tb<='1';
        wait until ready_tb='1';
        assert rem_tb = x"00F0FFF0" and quo_tb = x"00000010" report "Wrong output for the test case 15" severity error;
        report "result 15 ready";
        
         reset_tb<='1';
         reset_tb<='1';
         wait for clock_period*5;
         reset_tb<='0';
        
         N_tb<=std_logic_vector(to_unsigned(10001,32));
        D_tb<=std_logic_vector(to_unsigned(10,32));
        reset_tb<='1';
        wait for clock_period;
        reset_tb<='0';
        start_tb<='1';
        wait until ready_tb='1';
        assert rem_tb = std_logic_vector(to_unsigned(1,32)) and quo_tb = std_logic_vector(to_unsigned(1000,32)) report "Wrong output for the test case 16" severity error;
        report "result 16 ready";
        
         reset_tb<='1';
         wait for clock_period*5;
         reset_tb<='0';
        
        N_tb<=std_logic_vector(to_unsigned(98989898,32));
        D_tb<=std_logic_vector(to_unsigned(89898989,32));
        reset_tb<='1';
        wait for clock_period;
        reset_tb<='0';
        start_tb<='1';
        wait until ready_tb='1';
        assert rem_tb = std_logic_vector(to_unsigned(9090909,32)) and quo_tb = std_logic_vector(to_unsigned(1,32)) report "Wrong output for the test case 17" severity error;
        report "result 17 ready";
        
         reset_tb<='1';
         wait for clock_period*5;
         reset_tb<='0';
        
        N_tb<=std_logic_vector(to_unsigned(343,32));
        D_tb<=std_logic_vector(to_unsigned(10033,32));
        reset_tb<='1';
        wait for clock_period;
        reset_tb<='0';
        start_tb<='1';
        wait until ready_tb='1';
        assert rem_tb = std_logic_vector(to_unsigned(343,32)) and quo_tb = std_logic_vector(to_unsigned(0,32)) report "Wrong output for the test case 18" severity error;
        report "result 18 ready";
        
        reset_tb<='1';
         wait for clock_period*5;
         reset_tb<='0';
        
        N_tb<=std_logic_vector(to_unsigned(343,32));
        D_tb<=std_logic_vector(to_unsigned(7,32));
        reset_tb<='1';
        wait for clock_period;
        reset_tb<='0';
        start_tb<='1';
        wait until ready_tb='1';
        assert rem_tb = std_logic_vector(to_unsigned(0,32)) and quo_tb = std_logic_vector(to_unsigned(49,32)) report "Wrong output for the test case 19" severity error;
        report "result 19 ready";
        
         reset_tb<='1';
         wait for clock_period*5;
         reset_tb<='0';
        
        N_tb<=x"FFF00FFF";
        D_tb<=x"FF0000FF";
        reset_tb<='1';
        wait for clock_period;
        reset_tb<='0';
        start_tb<='1';
        wait until ready_tb='1';
        assert rem_tb = x"00F00F00"and quo_tb = std_logic_vector(to_unsigned(1,32)) report "Wrong output for the test case 20" severity error;
        report "result 20 ready";
        
         reset_tb<='1';
         wait for clock_period*5;
         reset_tb<='0';
        
        N_tb<=std_logic_vector(to_unsigned(390600,32));
        D_tb<=std_logic_vector(to_unsigned(625,32));
        reset_tb<='1';
        wait for clock_period;
        reset_tb<='0';
        start_tb<='1';
        wait until ready_tb='1';
        assert rem_tb = std_logic_vector(to_unsigned(600,32)) and quo_tb = std_logic_vector(to_unsigned(624,32)) report "Wrong output for the test case 21" severity error;
        report "result 21 ready";
        
         reset_tb<='1';
         wait for clock_period*5;
         reset_tb<='0';
        
        N_tb<=std_logic_vector(to_unsigned(343343,32));
        D_tb<=std_logic_vector(to_unsigned(1111,32));
        reset_tb<='1';
        wait for clock_period;
        reset_tb<='0';
        start_tb<='1';
        wait until ready_tb='1';
        assert rem_tb = std_logic_vector(to_unsigned(44,32)) and quo_tb = std_logic_vector(to_unsigned(309,32)) report "Wrong output for the test case 22" severity error;
        report "result 22 ready";
        
         reset_tb<='1';
         wait for clock_period*5;
         reset_tb<='0';
        
        N_tb<=std_logic_vector(to_unsigned(343,32));
        D_tb<=std_logic_vector(to_unsigned(7,32));
        reset_tb<='1';
        wait for clock_period;
        reset_tb<='0';
        start_tb<='1';
        wait until ready_tb='1';
        assert rem_tb = std_logic_vector(to_unsigned(0,32)) and quo_tb = std_logic_vector(to_unsigned(49,32)) report "Wrong output for the test case 23" severity error;
        report "result 23 ready";
        
         reset_tb<='1';
         wait for clock_period*5;
         reset_tb<='0';
        
        N_tb<=std_logic_vector(to_unsigned(531441,32));
        D_tb<=std_logic_vector(to_unsigned(59049,32));
        reset_tb<='1';
        wait for clock_period;
        reset_tb<='0';
        start_tb<='1';
        wait until ready_tb='1';
        assert rem_tb = std_logic_vector(to_unsigned(0,32)) and quo_tb = std_logic_vector(to_unsigned(9,32)) report "Wrong output for the test case 24" severity error;
        report "result 24 ready";
        
         reset_tb<='1';
         wait for clock_period*5;
         reset_tb<='0';
        
        N_tb<=std_logic_vector(to_unsigned(343,32));
        D_tb<=std_logic_vector(to_unsigned(0,32));
        reset_tb<='1';
        wait for clock_period;
        reset_tb<='0';
        start_tb<='1';
        wait until ready_tb='1';
        assert div_zero_error='1' report "Wrong :Divison by zero bit did not go high for the test case 25" severity error;
        report "result 25 ready";
        wait for clock_period*5;
        
        env.finish;
    end process;
end Behavioral;
