library verilog;
use verilog.vl_types.all;
entity add_sub is
    port(
        A               : in     vl_logic_vector(8 downto 0);
        B               : in     vl_logic_vector(8 downto 0);
        AddSub          : in     vl_logic;
        AddSub_out      : out    vl_logic_vector(8 downto 0);
        cout            : out    vl_logic
    );
end add_sub;
