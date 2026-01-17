class fifo_seq extends uvm_sequence;
  `uvm_object_utils(fifo_seq)
  seq_item wr_item;
  
  function new(string name="fifo_seq");
    super.new(name);
    `uvm_info("sequence class","inside constructor",UVM_HIGH);
  endfunction
  
  task body();
    repeat(8)
      begin
        wr_item=seq_item::type_id::create("wr_item");
        start_item(wr_item);
        assert(wr_item.randomize() with {wen==1;});
        finish_item(wr_item);
      end
  endtask
endclass


class fifo_seq_rd extends fifo_seq;
  `uvm_object_utils(fifo_seq_rd)
  seq_item rd_item;
  
  function new(string name="fifo_seq_rd");
    super.new(name);
    `uvm_info("sequence class","inside constructor",UVM_HIGH);
  endfunction
  
  task body();
    repeat(8)
      begin
        rd_item=seq_item::type_id::create("rd_item");
        start_item(rd_item);
        assert(rd_item.randomize() with {ren==1;});
        finish_item(rd_item);
      end
  endtask
endclass

