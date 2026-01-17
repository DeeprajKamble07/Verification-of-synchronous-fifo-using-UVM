interface intf(input logic clk,rst);
  logic wen,ren;
  logic [7:0] wdata,rdata;
  logic full,empty;
  
  clocking drvcb @(posedge clk);
    output wen,ren,wdata;
    input rdata,full,empty;
  endclocking
  
  clocking moncb @(posedge clk);
    input wen,ren,wdata,rdata,full,empty;
  endclocking
  
  modport drvmod(clocking drvcb);
    modport monmod(clocking moncb);
      
endinterface
