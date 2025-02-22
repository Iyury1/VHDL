LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;


entity array_mult_top is
    generic(
        INPUT_A_WIDTH : integer := 8;
        INPUT_B_WIDTH : integer := 8
    );
    port(
        padStart, padClk, padReset	: IN  STD_LOGIC;
        padA                    	: IN  STD_LOGIC_VECTOR(INPUT_A_WIDTH-1 downto 0);
        padB                    	: IN  STD_LOGIC_VECTOR(INPUT_B_WIDTH-1 downto 0);
        padResult            		: OUT STD_LOGIC_VECTOR(INPUT_A_WIDTH+INPUT_B_WIDTH-1 downto 0)
    );
end array_mult_top;


architecture Strucutral of array_mult_top is

    component array_mult is
        generic(
            INPUT_A_WIDTH : integer := 8;
            INPUT_B_WIDTH : integer := 8
        );
        port(
            A : in std_logic_vector(INPUT_A_WIDTH-1 downto 0);
            B : in std_logic_vector(INPUT_B_WIDTH-1 downto 0);
            Result : out std_logic_vector(INPUT_A_WIDTH+INPUT_B_WIDTH-1 downto 0)
        );
    end component;

    component PADDO 
	    port(A     : in  std_logic;
		    PAD   : out std_logic);
    end component;

    component PADDI 
	    port(Y     : out  std_logic;
		    PAD   : in   std_logic);
    end component;

    signal  Start, Clk, Reset : STD_LOGIC;
    signal  A              	  : STD_LOGIC_VECTOR(INPUT_A_WIDTH-1 downto 0);
    signal  B              	  : STD_LOGIC_VECTOR(INPUT_B_WIDTH-1 downto 0);
    signal	Done              : STD_LOGIC;
    signal	padDone              : STD_LOGIC;	
    signal  Result_wire        : STD_LOGIC_VECTOR(INPUT_A_WIDTH+INPUT_B_WIDTH-1 downto 0);

    signal  Result_reg        : STD_LOGIC_VECTOR(INPUT_A_WIDTH+INPUT_B_WIDTH-1 downto 0);

begin

    process(Clk) 
    begin
        if (Reset = '1') then
            Result_reg <= (others => '0');
        elsif rising_edge(Clk) then                
            Result_reg <= Result_wire;
        end if;
    end process;

    padResult <= Result_reg;

    -- Input A pad mapping
    padAGen: for i in INPUT_A_WIDTH-1 downto 0 generate
        begin
        inpA: PADDI port map (Y => A(i), PAD => padA(i));   
    end generate;

    -- Input B pad mapping
    padBGen: for i in INPUT_B_WIDTH-1 downto 0 generate
        begin
        inpB: PADDI port map (Y => B(i), PAD => padB(i));
    end generate;

    -- Output result pad mapping
    padResultGen: for i in INPUT_A_WIDTH+INPUT_B_WIDTH-1 downto 0 generate
        begin
        opRes: PADDO port map (PAD => padResult(i), A => Result_wire(i));
    end generate;

    -- Misc pad mapping
    padStartG: 	PADDI port map (Y => Start, PAD => padStart);
    padClkG: 	PADDI port map (Y => Clk, PAD => padClk);
    padResetG: 	PADDI port map (Y => Reset, PAD => padReset);
    padDoneG: 	PADDO port map (PAD => padDone, A => Done);
    coreG:  	array_mult port map (A => A, B => B, Result => Result_wire);
end Strucutral ; -- arch