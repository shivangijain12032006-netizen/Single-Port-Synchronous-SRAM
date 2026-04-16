`timescale 1ns/1ns

module tb_simple_ram;

reg clk;
reg [7:0] data_in;
reg [3:0] address;
reg write_en;
wire [7:0] data_out;

// Instantiate your RAM
ram_sp_sync_read uut (
    .clk(clk),
    .data_in(data_in),
    .address(address),
    .write_en(write_en),
    .data_out(data_out)
);

// Clock generation
always #5 clk = ~clk;

initial begin
    // Dump file for GTKWave
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_simple_ram);

    // Initialize
    clk = 0;
    write_en = 0;
    address = 0;
    data_in = 0;

    // -------- WRITE --------
    #10;
    write_en = 1;
    address = 3;
    data_in = 8'hAA;   // write 10101010

    #10;
    address = 5;
    data_in = 8'h55;   // write 01010101

    // -------- READ --------
    #10;
    write_en = 0;
    address = 3;

    #10;
    address = 5;

    #20;
    $stop;
end

endmodule
