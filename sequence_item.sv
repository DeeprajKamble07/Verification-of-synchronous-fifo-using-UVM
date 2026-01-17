class seq_item extends uvm_sequence_item;
  `uvm_object_utils(seq_item)
  rand bit wen,ren;
  rand logic [7:0] wdata;
  logic [7:0] rdata;
  logic full,empty;
  
  function new(string name="fifo_seq");
    super.new(name);
    `uvm_info("seq_item class","inside constructor",UVM_HIGH);
  endfunction
  
  constraint c1{wdata inside {[1:10]};}
  constraint c2 {wen != ren;}
endclass
