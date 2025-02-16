----------------------------------------------------------
-- EE453 Lab3 Tutorial - 8 by 8 shift and add multiplier
-- Yanjie (Jay) Wang 
-- Test Bench: tstb
----------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tstb is
end tstb;

ARCHITECTURE Behave of tstb is

component AS_mult17_top
	port (
		padClk, padReset, padStart 	: IN  STD_LOGIC;
		padA                    	: IN  STD_LOGIC_VECTOR(9 downto 0);
		padB                    	: IN  STD_LOGIC_VECTOR(6 downto 0);
		padDone              		: OUT STD_LOGIC;	
		padResult            		: OUT STD_LOGIC_VECTOR(16 downto 0)
		);
end component;

for all : AS_mult17_top use entity Work.AS_mult17_top(Structure);

constant Clk_high   : time := 10 ns;
constant Clk_low    : time := 10 ns;
constant Clk_period : time := Clk_high + Clk_low;
constant A0         : integer := 1;
constant B0         : integer := 2;

signal	padClk      : std_logic := '0';
signal	padReset    : std_logic := '1';
signal	padStart    : std_logic := '1';
signal  padDone     : std_logic;  
signal  Overflow 	: std_logic := '0';  
signal  padA        : std_logic_vector(9 downto 0);
signal  padB        : std_logic_vector(6 downto 0);
signal  padResult   : std_logic_vector(16 downto 0);

begin

mult17 : AS_mult17_top port map (padClk=> padClk, padReset=>padReset, padStart=>padStart,
								padA=>padA, padB=>padB, padDone=>padDone, padResult=>padResult
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

end Behave;