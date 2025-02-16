----------------------------------------------------------
-- EE453 Lab3 Tutorial - 8 by 8 shift and add multiplier
-- Yanjie (Jay) Wang 
-- Top level: AS_mult16
----------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY AS_mult17 IS
  port (
        Start, Clk, Reset : IN  STD_LOGIC;
    A                 : IN  STD_LOGIC_VECTOR(9 downto 0);
	B                 : IN  STD_LOGIC_VECTOR(6 downto 0);
	Done              : OUT STD_LOGIC;	
	Result            : OUT STD_LOGIC_VECTOR(16 downto 0)
	);
END AS_mult17;

ARCHITECTURE Structure of AS_mult17 IS 

component Shift17
  generic ( input_width : integer := 8);
  port (
        Clk, Clr, LD, SH, DIR : IN  STD_LOGIC;
	D                     : IN  STD_LOGIC_VECTOR(input_width-1 downto 0);
	Q                     : OUT STD_LOGIC_VECTOR(16 downto 0)
	);
end component;

component Allzero
  port (
        X         : IN  STD_LOGIC_VECTOR(16 downto 0);
	F         : OUT STD_LOGIC
	);
end component;

component RCA17
  port (
        A, B      : IN   STD_LOGIC_VECTOR(16 downto 0);
	Cin       : IN   STD_LOGIC;
	Cout      : OUT  STD_LOGIC;
	Sum       : OUT STD_LOGIC_VECTOR(16 downto 0)
	);
end component;

component Mux17
  port (
        A, B      : IN  STD_LOGIC_VECTOR(16 downto 0);
	Sel       : IN  STD_LOGIC;
	Y         : OUT STD_LOGIC_VECTOR(16 downto 0)
	);
end component;

component Reg17
    port (
        Clr, Clk      : IN  STD_LOGIC;
	D             : IN  STD_LOGIC_VECTOR(16 downto 0);
	Q             : OUT STD_LOGIC_VECTOR(16 downto 0)
	);
end component;

component SM
  port (
        Start, Clk, LSB, Stop, Reset : IN   STD_LOGIC;
	Init, Shift, Add, Done : OUT STD_LOGIC
	);
end component;

-- Interanl Signal Decalration
signal SRA1, SRB1, ADDout, MUXout, REGout : STD_LOGIC_VECTOR(16 downto 0);
signal Zero, Init, Shift, Add : STD_LOGIC;
signal Low : STD_LOGIC;
signal High : STD_LOGIC;
signal OFL, REGclr : STD_LOGIC;

begin

Low <= '0';
High <= '1';

SR1 : Shift17  
	generic map (input_width => 10)
	port map (Clk=>Clk, Clr=>Reset, LD=>Init, SH=>Shift, DIR=> Low,
                        D=>A, Q=>SRA1);
			
SR2 : Shift17  
	generic map (input_width => 7)
	port map (Clk=>Clk, Clr=>Reset, LD=>Init, SH=>Shift, DIR=> High, 
                        D=>B, Q=>SRB1);
			
Z1  : Allzero port map (X=>SRA1, F=>Zero);
A1  : RCA17    port map (A=>SRB1, B=>REGout, Cin=>Low, Cout=>OFL, Sum=>ADDout);
M1  : Mux17    port map (A=>ADDout, B=>REGout, Sel=>Add, Y=>MUXout);
R1  : Reg17    port map (D=>MUXout, Q=>REGout, Clk=>Clk, Clr=>REGclr);
F1  : SM      port map (Start=>Start, Clk=>Clk, LSB=>SRA1(0), Stop=>Zero, 
                        Reset=>Reset, Init=>Init, Shift=>Shift, Add=>Add, Done=>Done);
			
REGclr <= Init or Reset;
Result <= REGout;

END Structure;
