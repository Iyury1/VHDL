----------------------------------------------------------
-- EE453 Lab3 Tutorial - 8 by 8 shift and add multiplier
-- Yanjie (Jay) Wang 
-- Submodule: shift register
----------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY Shift17 IS
  generic (
      input_width : integer := 8
  );
  port (
        Clk, Clr, LD, SH, DIR : IN  STD_LOGIC;
	D                     : IN  STD_LOGIC_VECTOR(input_width-1 downto 0);
	Q                     : OUT STD_LOGIC_VECTOR(16 downto 0)
	);
END Shift17;

ARCHITECTURE Behave of Shift17 IS
   
begin
  
  Shift : process (Clr, Clk)
    variable St : STD_LOGIC_VECTOR(Q'LEFT downto 0);  
  begin
    if Clr = '1' then
       St := (others => '0'); 
       Q  <= St;
    elsif Clk'EVENT and Clk='1' then
      if LD = '1' then
         St := (others => '0');        
	 St(input_width-1 downto 0) := D;
	 Q <= St;
      elsif SH = '1' then
        case DIR is
        when '0' => St := '0' & St(St'LEFT downto 1);
        when '1' => St := St(St'LEFT-1 downto 0) & '0';
	when others => St := (others => 'Z');
        end case;
        Q <= St;
      end if;
    end if;
  end process; 
END Behave;   
    
  
 
