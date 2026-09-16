`timescale 1ns / 1ps

module tb_fixed_priority_arbiter_4to1;

    // Inputs
    reg [3:0] req;

    // Outputs
    wire [3:0] grant;

    // Instantiate the Unit Under Test (UUT)
    fixed_priority_arbiter_4to1 uut (
        .req(req),
        .grant(grant)
    );

    initial begin
        // 1. VCD Waveform Dumping
        $dumpfile("arbiter_waveform.vcd");
        $dumpvars(0, tb_fixed_priority_arbiter_4to1);

        // 2. Terminal Monitoring Log
        $monitor("Time=%0t ns | req=4'b%b | grant=4'b%b", $time, req, grant);

        // --- Initial State ---
        req = 4'b0000; #10; // Expected: grant = 4'b0000

        // --- Single Request Tests ---
        req = 4'b0001; #10; // Master 0 active -> Grant = 4'b0001
        req = 4'b0010; #10; // Master 1 active -> Grant = 4'b0010
        req = 4'b0100; #10; // Master 2 active -> Grant = 4'b0100
        req = 4'b1000; #10; // Master 3 active -> Grant = 4'b1000

        // --- Priority Contention Tests ---
        req = 4'b0011; #10; // Master 0 & 1 active -> Grant Master 0 (4'b0001)
        req = 4'b1100; #10; // Master 2 & 3 active -> Grant Master 2 (4'b0100)
        req = 4'b1010; #10; // Master 1 & 3 active -> Grant Master 1 (4'b0010)
        req = 4'b1111; #10; // All Masters active   -> Grant Master 0 (4'b0001)

        // Reset inputs
        req = 4'b0000; #10;

        $display("Simulation finished successfully.");
        $finish;
    end

endmodule
