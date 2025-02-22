LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mult_top_tb is

end mult_top_tb;


architecture Behav of mult_top_tb is

    component array_mult_top is
        generic(
            INPUT_A_WIDTH : integer := 8;
            INPUT_B_WIDTH : integer := 8
        );
        port(
            padStart, padClk, padReset	: IN  STD_LOGIC;
            padA                    	: IN  STD_LOGIC_VECTOR(7 downto 0);
            padB                    	: IN  STD_LOGIC_VECTOR(7 downto 0);
            padResult            		: OUT STD_LOGIC_VECTOR(15 downto 0)
        );
    end component;

    constant Clk_high   : time := 10 ns;
    constant Clk_low    : time := 10 ns;
    constant Clk_period : time := Clk_high + Clk_low;
    constant A0         : integer := 1;
    constant B0         : integer := 2;
    
    signal	padClk      : std_logic := '0';
    signal	padReset    : std_logic := '1';
    signal	padStart    : std_logic := '1';
    signal  padDone     : std_logic := '1';  
    signal  Overflow 	: std_logic := '0';  
    signal  padA        : std_logic_vector(7 downto 0);
    signal  padB        : std_logic_vector(7 downto 0);
    signal  padResult   : std_logic_vector(15 downto 0);

    for all : array_mult_top use entity Work.array_mult_top(Strucutral);



    begin

    mult : array_mult_top port map (padClk=>padClk, padReset=>padReset, padStart=>padStart,
        padA=>padA, padB=>padB, padResult=>padResult
        );

        Clk_generator : process
        begin
            padClk 	<= 	'1' after Clk_high, 
                        '0' after Clk_period;
            wait for Clk_period;
        end process Clk_generator;
        
        Reset_generator : process
        begin
            padReset <= '0' after Clk_period;
            wait;
        end process Reset_generator;
        
        Input_generator : process(padReset, padStart, padDone)
        begin
            if padReset = '1' then
                padA <= (others => '0');
                padB <= (others => '0');
            elsif(padDone = '1' and padStart = '1') then
                for i in 0 to 2 loop
                    for j in 1 to 3 loop
                        padA <= padA + A0;
                        padB <= padB + B0; 
                    end loop;
                end loop;
            else
                padA <= padA;
                padB <= padB;     	 
            end if; 
        end process Input_generator;

    end Behav;