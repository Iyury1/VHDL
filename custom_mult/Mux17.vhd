----------------------------------------------------------
-- EE453 Lab3 Tutorial - 8 by 8 shift and add multiplier
-- Yanjie (Jay) Wang 
-- Submodule: Multiplexer 
----------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY Mux17 IS
  port (
        A, B      : IN  STD_LOGIC_VECTOR(16 downto 0);
	Sel       : IN  STD_LOGIC;
	Y         : OUT STD_LOGIC_VECTOR(16 downto 0)
	);
END Mux17;

ARCHITECTURE Behave of Mux17 IS
   
begin
  
  Y  <= A when Sel = '1' else B;

END Behave;   
    
  
 
