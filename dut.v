// ============================================================================
// Module      : fixed_priority_arbiter_4to1
// Description : 4-input Fixed-Priority Arbiter using synthesizable casez
// Priority    : req[0] (Highest) > req[1] > req[2] > req[3] (Lowest)
// Standard    : Verilog-2001
// ============================================================================

module fixed_priority_arbiter_4to1 (
    input  wire [3:0] req,   // Request lines from 4 Masters
    output reg  [3:0] grant  // One-hot grant lines to 4 Masters
);

    // ------------------------------------------------------------------------
    // Combinational Priority Logic using casez
    // ------------------------------------------------------------------------
    always @(*) begin
        casez (req)
            4'b???1: grant = 4'b0001; // req[0] active -> Grant Master 0
            4'b??10: grant = 4'b0010; // req[1] active, req[0] inactive -> Grant Master 1
            4'b?100: grant = 4'b0100; // req[2] active, req[0,1] inactive -> Grant Master 2
            4'b1000: grant = 4'b1000; // req[3] active, req[0,1,2] inactive -> Grant Master 3
            default: grant = 4'b0000; // No active requests
        endcase
    end

endmodule
