`timescale 1ns / 1ps


module dual_port_ram
(
   input [7:0] data_a, data_b,     // Data inputs for port A and port B
   input [5:0] addr_a, addr_b,     // Address inputs for port A and port B (6-bit addresses for 64 words)
   input clk,                       // Clock input
   input we_a, we_b,                // Write enables for port A and port B
   output reg [7:0] q_a, q_b       // Output registers for port A and port B
);

    // RAM declaration: 64 words of 8 bits each
    reg [7:0] ram [0:63];

    // Read/Write logic for port A
    always @(posedge clk) begin
        if (we_a) begin
            ram[addr_a] <= data_a;     // Write data to RAM on port A
        end else begin
            q_a <= ram[addr_a];        // Read data from RAM for port A
        end
    end

    // Read/Write logic for port B
    always @(posedge clk) begin
        if (we_b) begin
            ram[addr_b] <= data_b;     // Write data to RAM on port B
        end else begin
            q_b <= ram[addr_b];        // Read data from RAM for port B
        end
    end

endmodule

