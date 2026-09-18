`timescale 1ns / 1ps

module and_beh_intra (
    input  a,
    input  b,
    output reg y
);
    // Behavioral block: intra-assignment delay
    always @(*) begin
        y = #1 a & b;
    end

endmodule