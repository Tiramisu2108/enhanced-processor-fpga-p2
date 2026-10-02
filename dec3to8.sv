module dec3to8(
	input logic [2:0] W,
	input logic En,
	output logic [7:0] Y
);

always_comb
// @(W or En) 
 begin
if (En == 1) case (W)
3'b000: Y = 8'b00000001; 
3'b001: Y = 8'b00000010;
3'b010: Y = 8'b00000100;
3'b011: Y = 8'b00001000;
3'b100: Y = 8'b00010000;
3'b101: Y = 8'b00100000;
3'b110: Y = 8'b01000000; 
3'b111: Y = 8'b10000000;
endcase
else Y = 8'b00000000;
end
endmodule

module regn #(parameter n = 9) (
    input  logic [n-1:0] R,
    input  logic         Rin,
    input  logic         Clock,
    output logic [n-1:0] Q
);

    always_ff @(posedge Clock) begin
        if (Rin) begin
            Q <= R;
        end
    end

endmodule
