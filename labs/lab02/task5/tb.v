module tb;

    reg  [3:0] t_a;
    reg  [3:0] t_b;
    reg        t_op;
    wire [3:0] t_result;

    integer i, j;
    integer errors = 0;
    reg  [3:0] exp_result;

    alu u1 (
        .a(t_a),
        .b(t_b),
        .op(t_op),
        .result(t_result)
    );

    initial begin
        $display("Starting ALU Testbench...");

        // Test 1: Verify sensitivity list fix by toggling 'op' while keeping operands fixed
        t_a = 4'd7; t_b = 4'd3; t_op = 1'b0; #5;
        if (t_result !== 4'd10) begin
            $display("ERROR: ADD failed. Expected 10, got %d", t_result);
            errors = errors + 1;
        end

        t_op = 1'b1; #5; // Change only op
        if (t_result !== 4'd4) begin
            $display("ERROR: SUB failed after op toggle. Expected 4, got %d", t_result);
            errors = errors + 1;
        end

        // Test 2: Comprehensive test across all combinations
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                t_a = i;
                t_b = j;
                
                // Check ADD
                t_op = 1'b0;
                exp_result = t_a + t_b;
                #5;
                if (t_result !== exp_result) begin
                    $display("ERROR: ADD mismatch for a=%d, b=%d: got %d, expected %d", t_a, t_b, t_result, exp_result);
                    errors = errors + 1;
                end

                // Check SUB
                t_op = 1'b1;
                exp_result = t_a - t_b;
                #5;
                if (t_result !== exp_result) begin
                    $display("ERROR: SUB mismatch for a=%d, b=%d: got %d, expected %d", t_a, t_b, t_result, exp_result);
                    errors = errors + 1;
                end
            end
        end

        if (errors == 0) begin
            $display("SUCCESS: All ALU test cases passed!");
        end else begin
            $display("FAILURE: Found %0d error(s).", errors);
        end

        $finish;
    end

endmodule