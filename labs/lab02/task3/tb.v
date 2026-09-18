module tb;

  reg [1:0] t_A;
  reg [1:0] t_B;

  wire t_GT;
  wire t_LT;
  wire t_EQ;

  comp2 U1(
    .A(t_A),
    .B(t_B),
    .GT(t_GT),
    .LT(t_LT),
    .EQ(t_EQ)
  );

  integer A_val;
  integer B_val;

  initial begin
    for (A_val = 0; A_val < 4; A_val = A_val + 1) begin
      for (B_val = 0; B_val < 4; B_val = B_val + 1) begin

        t_A = A_val;
        t_B = B_val;

        #1;

        // Self-check
        if (t_A > t_B) begin
          if (t_GT !== 1 || t_LT !== 0 || t_EQ !== 0)
            $display("FAIL: A=%d B=%d", t_A, t_B);
        end
        else if (t_A < t_B) begin
          if (t_GT !== 0 || t_LT !== 1 || t_EQ !== 0)
            $display("FAIL: A=%d B=%d", t_A, t_B);
        end
        else begin
          if (t_GT !== 0 || t_LT !== 0 || t_EQ !== 1)
            $display("FAIL: A=%d B=%d", t_A, t_B);
        end

      end
    end

    $display("Testing complete.");
    $finish;
  end

endmodule