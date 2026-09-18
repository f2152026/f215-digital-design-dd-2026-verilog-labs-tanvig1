`timescale 1ns / 1ps

module and_df (
    input  a,
    input  b,
    output y
);
    // Continuous dataflow assignment with delay
    assign #1 y = a & b;

endmodule