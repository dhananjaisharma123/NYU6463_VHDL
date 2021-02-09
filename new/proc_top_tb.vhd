----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/11/2020 11:31:45 AM
-- Design Name: 
-- Module Name: proc_top_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use std.env.finish;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity proc_top_tb is
--  Port ( );
end proc_top_tb;

architecture Behavioral of proc_top_tb is
signal enable,reset,done:STD_LOGIC;
signal clk:STD_LOGIC:='0';
constant clkPeriod:Time :=100ns;
begin
UUT:entity work.proc_top port map(enable =>enable,
           clk =>clk,
           reset =>reset,
           done =>done);
           
clockGEN: process
begin
wait for clkPeriod/2;
clk<=not clk;
end process;

behav:process
begin 
reset<='0';
enable<='1';
wait until done='1';
report "HALT Instruction reached";
finish;
end process;
end Behavioral;
