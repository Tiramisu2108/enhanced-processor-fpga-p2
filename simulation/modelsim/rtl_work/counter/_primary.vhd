library verilog;
use verilog.vl_types.all;
entity counter is
    port(
        R               : in     vl_logic_vector(8 downto 0);
        Rin             : in     vl_logic;
        E               : in     vl_logic;
        Clock           : in     vl_logic;
        Resetn          : in     vl_logic;
        Q               : out    vl_logic_vector(8 downto 0)
    );
end counter;
