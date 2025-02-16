----------------------------------------------------------
-- EE453 Lab3 Tutorial - 8 by 8 shift and add multiplier
-- Yanjie (Jay) Wang 
-- Submodule: SM - State Machine for Control signal
----------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY SM IS
  port (
        Start, Clk, LSB, Stop, Reset : IN   STD_LOGIC;
	Init, Shift, Add, Done : OUT STD_LOGIC
	);
END SM;

ARCHITECTURE Moore of SM IS

  type STATETYPE is ( I, C, A, S, E);
  signal State : STATETYPE;
  
    begin
    Init <= '1' when State = I
      else '0';
    Add <= '1' when State = A 
      else '0';
    Shift <= '1' when State = S
      else '0' ;
    Done <= '1' when State = E
      else '0';
   
    Process (Clk, Reset) begin  
      if Reset ='1' then State <= E;
      elsif CLK'EVENT and CLK = '1' then
        case State is
	when C =>
	  if LSB = '1' then State <= A;
	  elsif Stop = '0' then State <= S;
	  else State <= E;
	  end if;
	when A => State <= S;
	when S => State <= C;
	when E => 
	  if Start = '1' then State <= I; 	
	  end if;
	when I => State <= C;
	end case;
      end if;
    end process;
end Moore;
       
