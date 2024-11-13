`timescale 1ns / 1ps

module dual_port_ram_tb;

    reg [7:0] data_a, data_b;  // Data inputs for Port A and Port B
    reg [5:0] addr_a, addr_b;  // Address inputs for Port A and Port B (6-bit address)
    reg we_a, we_b;             // Write enables for Port A and Port B
    reg clk;                    // Clock signal
    wire [7:0] q_a, q_b;       // Output data for Port A and Port B

    // Instantiate the dual-port RAM module
    dual_port_ram uut (
        .data_a(data_a),
        .data_b(data_b),
        .addr_a(addr_a),
        .addr_b(addr_b),
        .we_a(we_a),
        .we_b(we_b),
        .clk(clk),
        .q_a(q_a),
        .q_b(q_b)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;  // Clock period = 10 ns
    end

    // Initial block to initialize signals and apply test vectors
    initial begin
        // Initialize signals
        clk = 0;
        data_a = 8'h00; // Initial data for Port A
        data_b = 8'h00; // Initial data for Port B
        addr_a = 6'h00; // Initial address for Port A
        addr_b = 6'h00; // Initial address for Port B
        we_a = 1'b0;    // Write enable for Port A (disabled)
        we_b = 1'b0;    // Write enable for Port B (disabled)

        // Dump waveform file
        $dumpfile("dump.vcd");
        $dumpvars(1, dual_port_ram_tb);

        // Apply test vectors
        #10;
        data_a = 8'h01;  // Set data for Port A
        addr_a = 6'h01;  // Set address for Port A
        we_a = 1'b1;     // Enable write on Port A
        #10;             // Wait for one clock cycle

        // Write to Port B
        data_b = 8'h02;  // Set data for Port B
        addr_b = 6'h02;  // Set address for Port B
        we_b = 1'b1;     // Enable write on Port B
        #10;             // Wait for one clock cycle

        // Disable write for both ports, check outputs
        we_a = 1'b0;
        we_b = 1'b0;
        #10;
        addr_a = 6'h01;  // Read from address 1 for Port A (should get 0x01)
        addr_b = 6'h02;  // Read from address 2 for Port B (should get 0x02)

        // Change data and address for Port A and Port B
        #10;
        data_a = 8'h03;  // New data for Port A
        addr_a = 6'h02;  // Set address for Port A (2)
        we_a = 1'b1;     // Enable write for Port A
        #10;

        // Read again from Port A and Port B
        we_a = 1'b0;  // Disable write for Port A
        we_b = 1'b0;  // Disable write for Port B
        addr_a = 6'h02;  // Read from address 2 for Port A (should get 0x03)
        addr_b = 6'h02;  // Read from address 2 for Port B (should still get 0x02)
        #10;

        // Finish simulation
        $finish;
    end

endmodule
