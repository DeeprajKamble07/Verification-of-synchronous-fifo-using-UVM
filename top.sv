`timescale 1ns/1ns
import uvm_pkg::*;
`include "uvm_macros.svh"
`include "interface.sv"
`include "sequence_item.sv"
`include "sequence.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "monitor.sv"
`include "agent.sv"
`include "scoreboard.sv"
`include "enivornment.sv"
`include "test.sv"

module top;
  logic clk,rst;
  intf intff(clk,rst);
  fifo dut(.clk(intff.clk),.rst(intff.rst),.wen(intff.wen),
           .ren(intff.ren),.wdata(intff.wdata),.rdata(intff.rdata),
           .full(intff.full),.empty(intff.empty));
  initial begin
    uvm_config_db #(virtual intf)::set(null,"*","vif",intff);
  end
  initial begin
    run_test("test");
  end
  
  initial begin
    clk=0;
    forever #5 clk=~clk;
  end
  
  initial begin
    rst=1;
    #10 rst=0;
  end
  
  initial begin
    #5000;
    $display("sorry! ran out of clock");
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars();
  end
endmodule
  
