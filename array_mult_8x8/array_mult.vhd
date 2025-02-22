library ieee;

use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity array_mult is
    generic(
        INPUT_A_WIDTH : integer := 8;
        INPUT_B_WIDTH : integer := 8
    );
    port(
        A : in std_logic_vector(INPUT_A_WIDTH-1 downto 0);
        B : in std_logic_vector(INPUT_B_WIDTH-1 downto 0);
        Result : out std_logic_vector(INPUT_A_WIDTH+INPUT_B_WIDTH-1 downto 0)
    );
end array_mult;


architecture Structural of array_mult is

    component mult_row is
        generic(
            INPUT_WIDTH : integer := 4
        );
        port(
            qi : in std_logic;
            cin : in std_logic;
            cout : out std_logic;
            mi : in std_logic_vector(INPUT_WIDTH-1 downto 0);
            ppi : in std_logic_vector(INPUT_WIDTH-1 downto 0);
            ppi_plus1 : out std_logic_vector(INPUT_WIDTH-2 downto 0);
            ppi_plus1_1 : out std_logic
        );
    end component;

    type product_vec is array(INPUT_B_WIDTH downto 0) of std_logic_vector(INPUT_B_WIDTH+INPUT_A_WIDTH-1 downto 0);

    signal res : std_logic_vector(INPUT_A_WIDTH+INPUT_B_WIDTH-1 downto 0);


    signal p : product_vec;
    signal c : std_logic_vector(INPUT_B_WIDTH downto 0);

    begin
        Result <= p(INPUT_B_WIDTH);
        p(0)(INPUT_A_WIDTH-1 downto 0) <= (others => '0');
        c <= (others => '0');
        rows: for i in 0 to INPUT_B_WIDTH-1 generate
            mult: component mult_row
                generic map (
                    INPUT_WIDTH => INPUT_A_WIDTH
                )
                port map (
                    qi => B(i),
                    cin => c(i),
                    cout => p(i+1)(INPUT_A_WIDTH+i),
                    mi => A,
                    ppi => p(i)(INPUT_A_WIDTH-1+i downto i),
                    ppi_plus1 => p(i+1)(INPUT_A_WIDTH-1+i downto i+1),
                    ppi_plus1_1 => p(INPUT_B_WIDTH)(i)
                );
        end generate rows;

end Structural;