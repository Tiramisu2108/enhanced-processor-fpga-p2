module add_sub (
    input  logic [8:0] A,
    input  logic [8:0] B,
    input  logic AddSub,
    output logic [8:0] AddSub_out,
    output logic cout
);
    logic [8:0] xor_B;
    assign xor_B = B ^ {9{AddSub}}; 
    
    logic [7:0] carry;
    
    full_adder fa0 (.a(A[0]), .b(xor_B[0]), .cin(AddSub),   .sum(AddSub_out[0]), .cout(carry[0]));
    full_adder fa1 (.a(A[1]), .b(xor_B[1]), .cin(carry[0]), .sum(AddSub_out[1]), .cout(carry[1]));
    full_adder fa2 (.a(A[2]), .b(xor_B[2]), .cin(carry[1]), .sum(AddSub_out[2]), .cout(carry[2]));
    full_adder fa3 (.a(A[3]), .b(xor_B[3]), .cin(carry[2]), .sum(AddSub_out[3]), .cout(carry[3]));
    full_adder fa4 (.a(A[4]), .b(xor_B[4]), .cin(carry[3]), .sum(AddSub_out[4]), .cout(carry[4]));
    full_adder fa5 (.a(A[5]), .b(xor_B[5]), .cin(carry[4]), .sum(AddSub_out[5]), .cout(carry[5]));
    
    full_adder fa6 (.a(A[6]), .b(xor_B[6]), .cin(carry[5]), .sum(AddSub_out[6]), .cout(carry[6]));
    full_adder fa7 (.a(A[7]), .b(xor_B[7]), .cin(carry[6]), .sum(AddSub_out[7]), .cout(carry[7]));
    full_adder fa8 (.a(A[8]), .b(xor_B[8]), .cin(carry[7]), .sum(AddSub_out[8]), .cout(cout));

endmodule
