class driver extends uvm_driver #(seq_item);
  `uvm_component_utils(driver)
  virtual intf vif;
  seq_item item;
  
  function new(string name="driver",uvm_component parent=null);
    super.new(name,parent);
    `uvm_info("driver class","inside constructor",UVM_HIGH);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("driver class","inside build phase",UVM_HIGH);
    if(!(uvm_config_db #(virtual intf)::get(this,"*","vif",vif)))
      begin
    `uvm_error("Driver class","Failed to get vif from config db");
      end
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("driver class","inside connect phase",UVM_HIGH);
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("driver class","inside run phase",UVM_HIGH);
    forever begin
      seq_item_port.get_next_item(req);
      drive(req);
      seq_item_port.item_done();
    end
  endtask
  
  task drive(seq_item item);
    @(vif.drvcb);
    vif.drvcb.wen<=item.wen;
    vif.drvcb.ren <= item.ren;
    vif.drvcb.wdata<=item.wdata;
  endtask
endclass
