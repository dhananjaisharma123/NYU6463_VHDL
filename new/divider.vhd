library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity divider is
    Port ( N : in STD_LOGIC_VECTOR (31 downto 0);
           D : in STD_LOGIC_VECTOR (31 downto 0);
           VALID: in STD_LOGIC;
           clk1: in STD_LOGIC;
           reset:in STD_LOGIC;
           READY : inout STD_LOGIC;
           div_zero_error: out STD_LOGIC;
           remainder : out STD_LOGIC_VECTOR (31 downto 0);
           quotient : out STD_LOGIC_VECTOR (31 downto 0));
end divider;

architecture Behavioral of divider is
-- divison by zero error
signal error: std_logic;
--signals for R-register
signal r_reg_din,r_reg_dout: std_logic_vector(31 downto 0);
signal r_reg_enable,r_reg_reset:std_logic;
--signals for Q-register
signal q_reg_dout: std_logic_vector(31 downto 0);
signal q_reg_enable,q_reg_reset:std_logic;
--signal for adder 
signal adder_out:std_logic_vector(31 downto 0);
signal adder_enable: std_logic;
--signals for D-register
signal d_reg_dout: std_logic_vector(31 downto 0);
signal d_reg_enable,d_reg_reset,d_zero:std_logic;
--signal comparator
signal comp_out,comp_enable:std_logic;

--signal subtractor
signal sub_out:std_logic_vector(31 downto 0);
signal sub_enable:std_logic;

--signal mux
signal mux_selbit,mux_enable:STD_LOGIC;
signal mux_out:STD_LOGIC_VECTOR(31 downto 0);

--signal sign block
signal SB_enable1:std_logic;
signal SB_out1:STD_LOGIC_VECTOR(31 downto 0);
--State type declaration
type statetype is(idle,init,c0,c1,c2,output);
signal state: statetype;
begin


--Connections !!
R_reg:entity work.reg port map(din =>mux_out,dout =>r_reg_dout,load=>r_reg_enable,clk =>clk1,reset=>r_reg_reset);
Q_reg:entity work.reg port map(din =>adder_out,dout =>q_reg_dout,load=>q_reg_enable,clk =>clk1,reset=>q_reg_reset);
D_reg:entity work.reg port map(din =>D,dout =>d_reg_dout,load=>d_reg_enable,clk =>clk1,zero=>d_zero,reset=>d_reg_reset);
adder:entity work.Adder_one port map(din =>q_reg_dout,clk =>clk1, enable =>adder_enable,dout=>adder_out);
sub: entity work.subtractor port map(din1=>unsigned(r_reg_dout),din2=>unsigned(d_reg_dout),clk=>clk1,std_logic_vector(dout)=>sub_out,enable =>sub_enable);
comm: entity work.comparator port map(din1=>r_reg_dout,din2=>d_reg_dout,clk=>clk1,dout=>comp_out,enable=>comp_enable);
muxx: entity work.div_mux port map(din0=>N,din1=>sub_out,enable=>mux_enable,selbit=>mux_selbit,dout=>mux_out,clk=>clk1);

FSM:process(clk1,reset)
begin 
    if(reset='1') then 
        state<= idle;
    else
        if(rising_edge(clk1)) then 
            case state is 
                when idle =>
                if(VALID ='1') then 
                    state<=init;
                else
                    state<=idle;
                end if;
                when init=>
                    state <=c0;
                when c0=>
                    if(d_zero='1') then 
                        state<=output;
                    else
                        state<=c1;
                    end if;
                    
                when c1=>
                    if(comp_out='1') then
                        state<=c2;
                    else
                        state<=output;
                    end if;
                
                when c2=>
                    state<=c0;
                   
                when output=>
                    if(READY='1') then
                        state<=idle;
                    end if;
              end case;
           end if;
    end if;
end process;

CTRL:process(state)
begin
q_reg_reset<='0';
d_reg_enable<='0';
r_reg_enable<='0';
q_reg_enable<='0';
comp_enable<='0';
READY<='0';
mux_enable<='0';
adder_enable<='0';
sub_enable<='0';
case state is 
    when idle =>
    when init=>
        mux_selbit<='0';
        mux_enable<='1';
        r_reg_enable<='1';
        q_reg_reset<='1';
        d_reg_enable<='1';
   when c0 =>
        comp_enable<='1';
   
    when c1=>
        adder_enable<='1';
        sub_enable<='1';
     when c2=>
        mux_enable<='1';
        mux_selbit<='1';
        r_reg_enable<='1';
        q_reg_enable<='1';    
    when output=>
        if(d_zero='1') then 
            div_zero_error<='1';
        else 
            div_zero_error<='0';
        end if;
        remainder<=r_reg_dout;
        quotient<=q_reg_dout;
        READY<='1';
end case;
end process;

end Behavioral;