library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mult_row is
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
end mult_row;

architecture Dataflow of mult_row is

    signal m : std_logic;


    component mult_cell is
        port(
            mi : in std_logic;
            ppi : in std_logic;
            qi : in std_logic;
            cin : in std_logic;
            ppi_plus1 : out std_logic;
            cout : out std_logic
        );
    end component;
    
    signal c : std_logic_vector(INPUT_WIDTH downto 0);
    signal ppi_out : std_logic_vector(INPUT_WIDTH-1 downto 0);

    begin
        c(0) <= '0';
        ppi_plus1_1 <= ppi_out(0);
        ppi_plus1 <= ppi_out(INPUT_WIDTH-1 downto 1);
        cout <= c(INPUT_WIDTH-1);
        cols: for i in 0 to INPUT_WIDTH-1 generate
            mult: component mult_cell
                port map (
                    mi => mi(i),
                    ppi => ppi(i),
                    qi => qi,
                    cin => c(i),
                    ppi_plus1 => ppi_out(i),
                    cout => c(i+1)
                );
        end generate cols;

end Dataflow;