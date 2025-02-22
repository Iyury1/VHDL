library ieee;

use ieee.std_logic_1164.all;

entity mult_cell is
    port(
        mi : in std_logic;
        ppi : in std_logic;
        qi : in std_logic;
        cin : in std_logic;
        ppi_plus1 : out std_logic;
        cout : out std_logic
    );
end mult_cell;

architecture Dataflow of mult_cell is

    signal m : std_logic;

    begin
        ppi_plus1 <= (not ppi and cin and not mi) or (ppi and not cin and not mi) or
                     (not ppi and not cin and mi and qi) or (not ppi and cin and mi and not qi) or
                     (ppi and cin and mi and qi) or (ppi and not cin and mi and not qi);
        
        cout <= (ppi and cin) or (mi and qi and cin) or (mi and qi and ppi);

end Dataflow;