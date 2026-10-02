module mux16to1 (
    input  logic [8:0] DIN,
    input  logic [8:0] G,
    input  logic [8:0] R [0:7],
    input  logic DINout,
    input  logic Gout,
    input  logic [7:0] Rout,
    output logic [8:0] BusWires
);
    always_comb begin
        if (DINout) BusWires = DIN;
        else if (Gout) BusWires = G;
        else if (Rout[0]) BusWires = R[0];
        else if (Rout[1]) BusWires = R[1];
        else if (Rout[2]) BusWires = R[2];
        else if (Rout[3]) BusWires = R[3];
        else if (Rout[4]) BusWires = R[4];
        else if (Rout[5]) BusWires = R[5];
        else if (Rout[6]) BusWires = R[6];
        else if (Rout[7]) BusWires = R[7];
        else BusWires = 9'b0;
    end
endmodule
