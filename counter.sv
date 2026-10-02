module counter (
    input  logic [8:0] R,
    input  logic Rin, E, Clock, Resetn,
    output logic [8:0] Q
);
    always_ff @(posedge Clock) begin
        if (!Resetn)
            Q <= 9'b0;
        else if (Rin) 
            Q <= R;
        else if (E) 
            Q <= Q + 1'b1;
    end
endmodule
