module lab6 (
    input  logic [8:0] DIN,
    input  logic Resetn, Clock, Run,
    output logic [8:0] BusWires,
    
    output logic [8:0] ADDR,
    output logic [8:0] DOUT,
    output logic W,
    output logic Done
);
    logic [8:0] R [0:7];
    logic [8:0] A, G, IR, AddSub_out;
    logic Gin, IRin, AddSub, Ain, Gout, DINout;
    logic [7:0] Rin, Rout;
    logic incr_pc, ADDR_in, DOUT_in, W_D;
	 logic G_ne, G_lt;
	 assign G_ne = G[8] | G[7] | G[6] | G[5] | G[4] | G[3] | G[2] | G[1] | G[0];
	 assign G_lt = G[8];

    regn reg_IR (.R(DIN), .Rin(IRin), .Clock(Clock), .Q(IR));

    FSM control_unit(
        .Clock(Clock), 
        .Resetn(Resetn), 
        .Run(Run),
        .IR(IR), 
        .IRin(IRin),
        .G_ne(G_ne),
		  .G_lt(G_lt),
        .Done(Done), 
        .Gin(Gin),
        .AddSub(AddSub),
        .Ain(Ain),
        .Gout(Gout),
        .DINout(DINout),
        .Rin(Rin),
        .Rout(Rout),
        .incr_pc(incr_pc),
        .ADDR_in(ADDR_in),
        .DOUT_in(DOUT_in),
        .W_D(W_D)
    );

    regn reg_0 (.R(BusWires), .Rin(Rin[0]), .Clock(Clock), .Q(R[0]));
    regn reg_1 (.R(BusWires), .Rin(Rin[1]), .Clock(Clock), .Q(R[1]));
    regn reg_2 (.R(BusWires), .Rin(Rin[2]), .Clock(Clock), .Q(R[2]));
    regn reg_3 (.R(BusWires), .Rin(Rin[3]), .Clock(Clock), .Q(R[3]));
    regn reg_4 (.R(BusWires), .Rin(Rin[4]), .Clock(Clock), .Q(R[4]));
    regn reg_5 (.R(BusWires), .Rin(Rin[5]), .Clock(Clock), .Q(R[5]));
    regn reg_6 (.R(BusWires), .Rin(Rin[6]), .Clock(Clock), .Q(R[6]));
	
    regn reg_ADDR (.R(BusWires), .Rin(ADDR_in), .Clock(Clock), .Q(ADDR));
    regn reg_DOUT (.R(BusWires), .Rin(DOUT_in), .Clock(Clock), .Q(DOUT));
    
    always_ff @(posedge Clock) begin
        if (!Resetn) W <= 1'b0;
        else         W <= W_D;
    end

    regn reg_A (.R(BusWires), .Rin(Ain), .Clock(Clock), .Q(A));
    
    add_sub ALU(
        .A(A),
        .B(BusWires),
        .AddSub(AddSub),
        .AddSub_out(AddSub_out),
		  .cout()
    );
    
    regn reg_G (.R(AddSub_out), .Rin(Gin), .Clock(Clock), .Q(G));
    
    mux16to1 BUS_MUX (.DIN(DIN), .G(G), .R(R), .DINout(DINout), .Gout(Gout), .Rout(Rout), .BusWires(BusWires));
	 
	 
	counter reg_7 (.R(BusWires),  .Rin(Rin[7]), .E(incr_pc), .Clock(Clock), .Resetn(Resetn), .Q(R[7]));
endmodule


module FSM (
    input  logic Clock, Resetn, Run,
    input  logic [8:0] IR,
    input  logic G_ne, G_lt,
    
    output logic Done, Gin, IRin, AddSub, Ain, Gout, DINout,
    output logic [7:0] Rin,
    output logic [7:0] Rout,
    
    output logic incr_pc, ADDR_in, DOUT_in, W_D 
);

    typedef enum logic [4:0] {
        Idle  = 5'd0,
		  PC1 = 5'd1,
		  PC2 = 5'd2,
        Fetch = 5'd3,
        Decode = 5'd4,
        MV = 5'd5,
        MVI1 = 5'd6,
		  MVI2 = 5'd7,
		  MVI3 = 5'd8,
        ADD1 = 5'd9,
        ADD2 = 5'd10,
        ADD3 = 5'd11,
        SUB1 = 5'd12,
        SUB2 = 5'd13,
        SUB3 = 5'd14,
        LD1 = 5'd15,
        LD2 = 5'd16,
		  LD3 = 5'd17,
		  ST1 = 5'd18,
        ST2 = 5'd19,
        ST3 = 5'd20,
        BRNE1 = 5'd21,
		  BRNE2 = 5'd22,
		  BRNE3 = 5'd23,
		  BRLT1 = 5'd24,
		  BRLT2 = 5'd25,
		  BRLT3 = 5'd26,
		  done = 5'd27
    } state_t;
    
    state_t present_state, next_state;

    logic [2:0] I;
    logic [7:0] Xreg, Yreg;
    logic Rxin, Rxout, Ryout;

    always_ff @(posedge Clock) begin
        if (!Resetn) present_state <= Idle;
        else present_state <= next_state;
    end

    always_comb begin 
        next_state = present_state;
        case(present_state)
            Idle:   if(Run || ~Resetn) next_state = PC1; else next_state = Idle;
				PC1: next_state = PC2;
            PC2: next_state = Fetch;
            Fetch:  next_state = Decode;
            Decode: case(I)
							3'b000: next_state = MV;	// mv
                     3'b001: next_state = MVI1;	// mvi
                     3'b010: next_state = ADD1;	// add
                     3'b011: next_state = SUB1;	// sub
                     3'b100: next_state = LD1;	// ld
                     3'b101: next_state = ST1;	// st
							3'b110: next_state = BRNE1;   // brne
                     3'b111: next_state = BRLT1;   // brlt
                     default: next_state = Idle;
						endcase
            MV:  next_state = done;
				
            MVI1:  next_state = MVI2;
				MVI2: next_state = MVI3;
				MVI3: next_state = done;
				
            ADD1: next_state = ADD2;
            ADD2: next_state = ADD3;
            ADD3: next_state = done;
				
            SUB1: next_state = SUB2;
            SUB2: next_state = SUB3;
            SUB3: next_state = done;
            
            LD1: next_state = LD2;
            LD2: next_state = LD3;
				LD3: next_state = done;
				
            ST1: next_state = ST2;
            ST2: next_state = ST3;
				ST3: next_state = done;
				
            BRNE1: next_state = BRNE2;
            BRNE2: if (G_ne) next_state = BRNE3; else next_state = done;
            BRNE3: next_state = done;

            BRLT1: next_state = BRLT2;
            BRLT2: if (G_lt) next_state = BRLT3; else next_state = done;
            BRLT3: next_state = done;		
				done: if (Run) next_state = PC1; else next_state = Idle;
            default: next_state = Idle;
        endcase
    end
	

   assign I = IR[8:6];
   dec3to8 decX (IR[5:3], 1'b1, Xreg);
   dec3to8 decY (IR[2:0], 1'b1, Yreg);
   assign Done = (present_state == done);
   assign IRin = (present_state == Fetch);
	
	assign incr_pc = (present_state == PC2) | (present_state == MVI2) | 
							(present_state == BRLT2) | (present_state == BRNE2);
	assign ADDR_in = (present_state == PC1) | (present_state == MVI1) | 
							(present_state == LD1) | (present_state == ST1) | 
                     (present_state == BRNE1) | (present_state == BRLT1);
							
	assign Rxin = (present_state == MV) | (present_state == MVI3) | 
                  (present_state == ADD3) | (present_state == SUB3) | 
                  (present_state == LD3);
						
	assign Rxout = (present_state == ADD1) | (present_state == SUB1) | (present_state == ST2);
	
	assign Ryout = (present_state == MV) | (present_state == ADD2) | (present_state == SUB2) | 
                   (present_state == LD1) | (present_state == ST1);
						 
	assign DINout = (present_state == MVI3) | (present_state == LD3) | 
                    (present_state == BRNE3) | (present_state == BRLT3);
	assign Ain = (present_state == ADD1) | (present_state == SUB1);
   assign Gin = (present_state == ADD2) | (present_state == SUB2);
   assign Gout = (present_state == ADD3) | (present_state == SUB3);
   assign AddSub = (present_state == SUB2);
	assign DOUT_in = (present_state == ST2);
   assign W_D = (present_state == ST3);

	logic br_taken;
   assign br_taken = (present_state == BRNE3) | (present_state == BRLT3);

   assign Rin[6:0] = {7{Rxin}} & Xreg[6:0]; 
    
   assign Rin[7]   = (Rxin & Xreg[7]) | br_taken;
	logic pc_out;
   assign pc_out = (present_state == PC1) | (present_state == MVI1) | 
                    (present_state == BRNE1) | (present_state == BRLT1);

   assign Rout = ({8{Rxout}} & Xreg) | 
                  ({8{Ryout}} & Yreg) | 
                  {pc_out, 7'b0000000};
endmodule

