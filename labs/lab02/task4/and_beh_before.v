`timescale 1ns / 1ps

module and_beh_before (
    input  a,
    input  b,
    output reg y
);
    // Behavioral block: delay placed BEFORE assignment
    always @(*) begin
        #1 y = a & b;
    end

endmodule