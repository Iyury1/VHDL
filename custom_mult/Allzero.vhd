----------------------------------------------------------
-- EE453 Lab3 Tutorial - 8 by 8 shift and add multiplier
-- Yanjie (Jay) Wang 
-- Submodule: Zero Detector
----------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY Allzero IS
  port (
        X         : IN  STD_LOGIC_VECTOR(16 downto 0);
	F         : OUT STD_LOGIC
	);
END Allzero;

ARCHITECTURE Behave of Allzero IS
   
begin
  
  process (X) 
    begin 
      F <= '1';
      for j in X'RANGE loop
        if X(j) = '1' then
	F <= '0';
	end if;
      end loop;
    end process;

END Behave;   
    
  
 
