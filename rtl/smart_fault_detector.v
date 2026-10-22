// Smart Fault Detection System
// Detects a missing heartbeat after TIMEOUT_CYCLES clock cycles.
module smart_fault_detector #(
    parameter TIMEOUT_CYCLES = 5
)(
    input  wire clk,
    input  wire rst,
    input  wire heartbeat,
    output reg  fault
);

    localparam COUNTER_WIDTH = $clog2(TIMEOUT_CYCLES + 1);
    reg [COUNTER_WIDTH-1:0] counter;

    always @(posedge clk) begin
        if (rst) begin
            counter <= 0;
            fault   <= 0;
        end
        else if (heartbeat) begin
            counter <= 0;
            fault   <= 0;
        end
        else if (!fault) begin
            if (counter >= TIMEOUT_CYCLES - 1) begin
                fault <= 1;
            end
            else begin
                counter <= counter + 1'b1;
            end
        end
    end

endmodule
