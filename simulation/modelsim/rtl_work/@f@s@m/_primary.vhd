library verilog;
use verilog.vl_types.all;
entity FSM is
    port(
        Clock           : in     vl_logic;
        Resetn          : in     vl_logic;
        Run             : in     vl_logic;
        IR              : in     vl_logic_vector(8 downto 0);
        G_ne            : in     vl_logic;
        G_lt            : in     vl_logic;
        Done            : out    vl_logic;
        Gin             : out    vl_logic;
        IRin            : out    vl_logic;
        AddSub          : out    vl_logic;
        Ain             : out    vl_logic;
        Gout            : out    vl_logic;
        DINout          : out    vl_logic;
        Rin             : out    vl_logic_vector(7 downto 0);
        Rout            : out    vl_logic_vector(7 downto 0);
        incr_pc         : out    vl_logic;
        ADDR_in         : out    vl_logic;
        DOUT_in         : out    vl_logic;
        W_D             : out    vl_logic
    );
end FSM;
