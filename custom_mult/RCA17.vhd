----------------------------------------------------------
-- EE453 Lab3 Tutorial - 8 by 8 shift and add multiplier
-- Yanjie (Jay) Wang 
-- Submodule: Ripple Carry Adder
----------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY RCA17 IS
  port (
        A, B      : IN   STD_LOGIC_VECTOR(16 downto 0);
	Cin       : IN   STD_LOGIC;
	Cout      : OUT  STD_LOGIC;
	Sum       : OUT STD_LOGIC_VECTOR(16 downto 0)
	);
END RCA17;

ARCHITECTURE Structure of RCA17 IS
   
   component FA
      port (
            X, Y, Cin : IN  STD_LOGIC;
	    Cout      : OUT  STD_LOGIC;
	    Sum       : OUT STD_LOGIC
	    );
   end component;
   
   signal C : STD_LOGIC_VECTOR(16 downto 0);
   
   begin
   
   Stage: for i in 16 downto 0 generate     
         Lowbit:    if i = 0 generate
	   BLOCK_INST : block
             --for all : FA use entity Work.FA(Behave);
           begin
             Fulladder1: FA port map (X=>A(0), Y=>B(0), Cin=>Cin, Cout=>C(0), Sum=>Sum(0)); 
	   end block;    
         end generate;
     
         Otherbits: if i /= 0 generate
	 BLOCK_INST : block
           --for all : FA use entity Work.FA(Behave);
         begin
           Fulladder2: FA port map (X=>A(i), Y=>B(i), Cin=>C(i-1), Cout=>C(i), Sum=>Sum(i));  
	 end block;   
         end generate;
   end generate;
 
 Cout <= C(16);
 
END Structure;
   
