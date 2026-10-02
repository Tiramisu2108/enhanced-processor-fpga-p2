`timescale 1ns/1ps

module top_module_tb();

    logic CLOCK_50;
    logic [0:0] KEY;
    logic [9:0] SW;
    logic [9:0] LEDR;
    logic [6:0] HEX0, HEX1, HEX2;

    top_module DUT (.CLOCK_50(CLOCK_50), .KEY(KEY), .SW(SW), .LEDR(LEDR), .HEX0(HEX0), .HEX1(HEX1), .HEX2(HEX2));

    always #10 CLOCK_50 = ~CLOCK_50;

  initial begin
        CLOCK_50 = 0;
        KEY[0] = 1;      // Resetn = 1
        SW = 10'b0;      // Tắt Run (SW[9]=0)

        #15;
        KEY[0] = 0;      // Kéo Resetn = 0
        #25;             
        KEY[0] = 1;      // Nhả Resetn = 1
        #20;

        SW[8:0] = 9'b010100101; 
        SW[9] = 1;       // RUN
        
        #1000;           

        SW[8:0] = 9'b110100101; 
        
        #1500;          
        
        $finish; 
    end

endmodule
