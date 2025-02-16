----------------------------------------------------------
-- EE453 Lab3 Tutorial - 8 by 8 shift and add multiplier
-- Yanjie (Jay) Wang 
-- Submodule: DFFClr - D Flip-Flop
----------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY DFFClr IS
  port (
        Clr, Clk, D   : IN  STD_LOGIC;
	Q, QB         : OUT STD_LOGIC
	);
END DFFClr;

ARCHITECTURE Behave of DFFClr IS

signal Qi  :  STD_LOGIC;

begin  QB <= not Qi;
       Q  <= Qi;
       
  process (Clr, Clk) 
    begin 
      if Clr = '1' then
      Qi <= '0';
      elsif Clk'EVENT and Clk = '1' then
      Qi <= D;
      end if;
  end process;
  
END Behave;
       
