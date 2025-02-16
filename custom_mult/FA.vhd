----------------------------------------------------------
-- EE453 Lab3 Tutorial - 8 by 8 shift and add multiplier
-- Yanjie (Jay) Wang 
-- Submodule: Full Adder
----------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY FA IS
  port (
        X, Y, Cin : IN  STD_LOGIC;
	Cout      : OUT  STD_LOGIC;
	Sum       : OUT STD_LOGIC
	);
END FA;

ARCHITECTURE Behave of FA IS
   
begin
  
  Sum  <= X xor Y xor Cin;
  Cout <= (X and Y) or (X and Cin) or (Y and Cin);
END Behave;   
    
  
 
