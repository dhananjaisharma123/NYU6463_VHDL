library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity REG_FILE is
    Port ( A1 : in STD_LOGIC_VECTOR (4 downto 0);
           A2 : in STD_LOGIC_VECTOR (4 downto 0);
           A3 : in STD_LOGIC_VECTOR (4 downto 0);
           WD3 : in STD_LOGIC_VECTOR (31 downto 0);
           WE3 : in STD_LOGIC;
           CLK : in STD_LOGIC;
           reset: in STD_LOGIC;
           write_div: in STD_LOGIC;
           remainder:in STD_LOGIC_VECTOR(31 downto 0);
           Quotient: in STD_LOGIC_VECTOR(31 downto 0); 
           RD1 : out STD_LOGIC_VECTOR (31 downto 0);
           RD2 : out STD_LOGIC_VECTOR (31 downto 0));
end REG_FILE;

architecture Behavioral of REG_FILE is
type regfile32 is array(0 to 31) of STD_LOGIC_VECTOR(31 downto 0); 
signal RF: regfile32:=(others=>(others=>'0'));
begin
    process(CLK,reset) 
    begin
    if(reset='1') then 
        RF<=(others=>(others=>'0'));
    else
        if(rising_edge(CLK)) then 
            if(write_div='1') then 
                RF(30)<=Quotient;
                RF(31)<=Remainder;
            end if;
            RD1<=RF(to_integer(unsigned(A1)));
            RD2<=RF(to_integer(unsigned(A2)));
            if(WE3='1') then 
                if(to_integer(unsigned(A3))/=0) then 
                    RF(to_integer(unsigned(A3)))<=WD3;
                end if;
            end if;
        end if;
    end if;
    end process;
end Behavioral;
