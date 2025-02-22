library ieee;

use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity mult_tb is

end entity;



architecture arch of mult_tb is

    constant INPUT_A_WIDTH : integer := 8;

    constant INPUT_B_WIDTH : integer := 8;

    signal A_tb : std_logic_vector(INPUT_A_WIDTH-1 downto 0);

    signal B_tb : std_logic_vector(INPUT_B_WIDTH-1 downto 0);

    signal Res_tb : std_logic_vector(INPUT_A_WIDTH+INPUT_B_WIDTH-1 downto 0);

    signal clk_tb : std_logic;

    constant clk_period : time := 40 ns;

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

begin

    mult: array_mult
        generic map(INPUT_A_WIDTH => INPUT_A_WIDTH, INPUT_B_WIDTH => INPUT_B_WIDTH)
        port map(A => A_tb, B => B_tb, Result => Res_tb);

    clk_process: process begin
        clk_tb <= '0';
        wait for clk_period/2;
        clk_tb <= '1';
        wait for clk_period/2;

    end process clk_process;

    mult_proc: process begin
        A_tb <= std_logic_vector(to_unsigned(2,8));
        B_tb <= std_logic_vector(to_unsigned(3,8));
        wait for clk_period;
        A_tb <= std_logic_vector(to_unsigned(4,8));
        B_tb <= std_logic_vector(to_unsigned(5,8));
        wait for clk_period;
        A_tb <= std_logic_vector(to_unsigned(5,8));
        B_tb <= std_logic_vector(to_unsigned(5,8));
        wait for clk_period;
        A_tb <= std_logic_vector(to_unsigned(6,8));
        B_tb <= std_logic_vector(to_unsigned(2,8));
        wait for clk_period;
        A_tb <= std_logic_vector(to_unsigned(6,8));
        B_tb <= std_logic_vector(to_unsigned(2,8));
        wait for clk_period;
        A_tb <= std_logic_vector(to_unsigned(1,8));
        B_tb <= std_logic_vector(to_unsigned(10,8));
        wait for clk_period;
        A_tb <= std_logic_vector(to_unsigned(6,8));
        B_tb <= std_logic_vector(to_unsigned(2,8));
        wait for clk_period;
        A_tb <= std_logic_vector(to_unsigned(25,8));
        B_tb <= std_logic_vector(to_unsigned(20,8));
        wait for clk_period;
        A_tb <= std_logic_vector(to_unsigned(250,8));
        B_tb <= std_logic_vector(to_unsigned(250,8));
        wait;
    end process mult_proc;
end arch ; -- arch