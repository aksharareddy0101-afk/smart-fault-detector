`timescale 1ns/1ps

module tb_smart_fault_detector;

    reg clk = 0;
    reg rst = 1;
    reg heartbeat = 0;
    wire fault;
    integer errors = 0;

    smart_fault_detector #(
        .TIMEOUT_CYCLES(5)
    ) dut (
        .clk(clk),
        .rst(rst),
        .heartbeat(heartbeat),
        .fault(fault)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("smart_fault_detector.vcd");
        $dumpvars(0, tb_smart_fault_detector);

        // Reset the circuit.
        repeat (2) @(negedge clk);
        rst = 0;

        // Heartbeat should keep fault cleared.
        heartbeat = 1;
        @(negedge clk);
        if (fault !== 0) begin
            $display("FAIL: fault should be 0 after heartbeat");
            errors = errors + 1;
        end
        heartbeat = 0;

        // With no heartbeat, fault should assert after the timeout.
        repeat (6) @(negedge clk);
        if (fault !== 1) begin
            $display("FAIL: fault did not assert after timeout");
            errors = errors + 1;
        end

        // A new heartbeat should clear the fault.
        heartbeat = 1;
        @(negedge clk);
        if (fault !== 0) begin
            $display("FAIL: heartbeat did not clear fault");
            errors = errors + 1;
        end

        if (errors == 0)
            $display("PASS: all smart_fault_detector checks passed");
        else
            $display("FAIL: %0d check(s) failed", errors);

        $finish;
    end

    initial begin
        $monitor("time=%0t rst=%b heartbeat=%b fault=%b",
                 $time, rst, heartbeat, fault);
    end

endmodule
