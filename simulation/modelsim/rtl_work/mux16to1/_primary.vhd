library verilog;
use verilog.vl_types.all;
entity mux16to1 is
    port(
        DIN             : in     vl_logic_vector(8 downto 0);
        G               : in     vl_logic_vector(8 downto 0);
        R               : in     vl_logic;
        DINout          : in     vl_logic;
        Gout            : in     vl_logic;
        Rout            : in     vl_logic_vector(7 downto 0);
        BusWires        : out    vl_logic_vector(8 downto 0)
    );
end mux16to1;
