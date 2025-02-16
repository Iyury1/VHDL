----------------------------------------------------------
-- EE453 Lab3 Tutorial - 8 by 8 shift and add multiplier
-- Yanjie (Jay) Wang 
-- Top level: AS_mult16_top
-- Maps the multiplier core to the input and output pads
----------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY AS_mult17_top IS
  port (
        padStart, padClk, padReset	: IN  STD_LOGIC;
        padA                    	: IN  STD_LOGIC_VECTOR(9 downto 0);
		padB                    	: IN  STD_LOGIC_VECTOR(6 downto 0);
		padDone              		: OUT STD_LOGIC;	
		padResult            		: OUT STD_LOGIC_VECTOR(16 downto 0)
		);
END AS_mult17_top;

ARCHITECTURE Structure of AS_mult17_top IS 

component AS_mult17 IS
	port (
        Start, Clk, Reset : IN  STD_LOGIC;
        A                 : IN  STD_LOGIC_VECTOR(9 downto 0);
		B                 : IN  STD_LOGIC_VECTOR(6 downto 0);
		Done              : OUT STD_LOGIC;	
		Result            : OUT STD_LOGIC_VECTOR(16 downto 0)
		);
END component;

component PADDO 
	port(A     : in  std_logic;
		PAD   : out std_logic);
end component;

component PADDI 
	port(Y     : out  std_logic;
		PAD   : in   std_logic);
end component;

signal  Start, Clk, Reset : STD_LOGIC;
signal  A              	  : STD_LOGIC_VECTOR(9 downto 0);
signal  B              	  : STD_LOGIC_VECTOR(6 downto 0);
signal	Done              : STD_LOGIC;	
signal	Result            : STD_LOGIC_VECTOR(16 downto 0);

begin
-- Input A pad mapping
padAGen: for i in 9 downto 0 generate
    begin
		inpA: PADDI port map (Y => A(i), PAD => padA(i));   
end generate;

-- Input B pad mapping
padBGen: for i in 6 downto 0 generate
    begin
		inpB: PADDI port map (Y => B(i), PAD => padB(i));
end generate;
  
-- Output result pad mapping
padResultGen: for i in 16 downto 0 generate
    begin
		opRes: PADDO port map (PAD => padResult(i), A => Result(i));
end generate;

-- Misc pad mapping
padStartG: 	PADDI port map (Y => Start, PAD => padStart);
padClkG: 	PADDI port map (Y => Clk, PAD => padClk);
padResetG: 	PADDI port map (Y => Reset, PAD => padReset);
padDoneG: 	PADDO port map (PAD => padDone, A => Done);
coreG:  	AS_mult17 port map (Start => Start, Clk => Clk, Reset => Reset,
								A => A, B => B, Done => Done, Result => Result);
END Structure;
