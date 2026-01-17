module fifo #(parameter width=8, 
              depth=8 ,
              addr=$clog2(depth))
  (input logic  clk,rst,wen,ren,
   input logic [width-1:0] wdata,
   output logic [width-1:0] rdata,
   output logic full,empty);
  logic [width-1:0] mem [0:depth-1];
  logic [addr:0] wptr,rptr;
  
  always@(posedge clk)
    begin
      if(rst)
        wptr<=0;
      else begin
        if(wen && !full)
          begin
            mem[wptr]<=wdata;
            wptr<=wptr+1;
          end
      end
    end
  
  always@(posedge clk)
    begin
      if(rst)
        rptr<=0;
      else begin
        if(ren && !empty)
          begin
            rdata<=mem[rptr];
            rptr<=rptr+1;
          end
      end
    end
  assign full=(wptr[addr] != rptr[addr]) && (wptr[addr-1:0] == rptr[addr-1:0]);
  assign empty=(wptr==rptr);
endmodule
