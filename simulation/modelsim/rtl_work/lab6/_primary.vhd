library verilog;
use verilog.vl_types.all;
entity lab6 is
    port(
        DIN             : in     vl_logic_vector(8 downto 0);
        Resetn          : in     vl_logic;
        Clock           : in     vl_logic;
        Run             : in     vl_logic;
        BusWires        : out    vl_logic_vector(8 downto 0);
        ADDR            : out    vl_logic_vector(8 downto 0);
        DOUT            : out    vl_logic_vector(8 downto 0);
        W               : out    vl_logic;
        Done            : out    vl_logic
    );
end lab6;
