----------------------------------------------------------
-- EE453 Lab3 Tutorial - 8 by 8 shift and add multiplier
-- Yanjie (Jay) Wang 
-- Submodule: Reg16
----------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY Reg17 IS

  port (
        Clr, Clk      : IN  STD_LOGIC;
	D             : IN  STD_LOGIC_VECTOR(16 downto 0);
	Q             : OUT STD_LOGIC_VECTOR(16 downto 0)
	);
END Reg17;

ARCHITECTURE Structure of Reg17 IS

component DFFclr
  port (
        Clr, Clk, D   : IN  STD_LOGIC;
	Q, QB         : OUT STD_LOGIC
	);
end component;



begin

  STAGES: for i in 16 downto 0 generate
    BLOCK_INST : block     
      --for all : DFFClr use entity Work.DFFClr(Behave);
    begin
        FF: DFFClr port map (Clr, Clk, D(i), Q(i), open);
    end block;
  end generate;
  
END Structure;
