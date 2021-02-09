----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/05/2020 09:17:46 PM
-- Design Name: 
-- Module Name: PCreg - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PCreg is
 Port ( din : in STD_LOGIC_VECTOR (31 downto 0);
           load : in STD_LOGIC;
           clk:in STD_LOGIC;
           clear : in STD_LOGIC;
           dout : out STD_LOGIC_VECTOR (31 downto 0));
end PCreg;

architecture Behavioral of PCreg is
signal temp:STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');
begin
process(clk,clear)
begin
    if(clear ='1') then 
        temp<=(others=>'0');
    elsif(rising_edge(clk)) then
        if(load='1') then 
            temp<=din;
        end if;
    end if;
end process;
dout<=temp;
end Behavioral;
