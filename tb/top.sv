import uvm_pkg::*;
`include "uvm_macros.svh"

`include "../tests/test.sv"
`include "env.sv"
`include "agent.sv"


module top;
    logic clk;
    logic rst_n;

    intial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end

    initial begin
        rst_n. = 0;
        #20 rst_n = 1;
    end

    initial begin
        uvm_config_db #(virtual fifo_if)::set(null,"*","vif",intf);

        run_test();
    end

    fifo_if #(.DATA_WIDTH(8)) inft (
        .clk(clk),
        .rst_n(rst_n)
    );

    fifo #(
        .DATA_WIDTH(8),
        .DEPTH(16)
    ) dut (
        .clk (intf.clk);
        .rst_n (intf.rst_n);
        .wr_en (intf.wr_en),
        .din   (intf.din),
        .rd_en (intf.rd_en),
        .dout  (intf.dout),
        .full  (intf.full),
        .empty (intf.empty)
    )



endmodule: top