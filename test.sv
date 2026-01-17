class test extends uvm_test;
  `uvm_component_utils(test)
  enivornment env;
  fifo_seq wr_seq;
  fifo_seq_rd rd_seq;
  
  function new(string name="test",uvm_component parent=null);
    super.new(name,parent);
    `uvm_info("Test class","inside constructor",UVM_HIGH);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("Test class","inside build phase",UVM_HIGH);
    env=enivornment::type_id::create("env",this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("Test class","inside connect phase",UVM_HIGH);
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("Test class","inside run phase",UVM_HIGH);
    phase.raise_objection(this);
    wr_seq=fifo_seq::type_id::create("wr_seq");
    wr_seq.start(env.agen.sqnr);
    #10;
    rd_seq=fifo_seq_rd::type_id::create("rd_seq");
    rd_seq.start(env.agen.sqnr);
    #10;
    phase.drop_objection(this);
  endtask
endclass
