class monitor extends uvm_monitor;
  `uvm_component_utils(monitor)
  virtual intf vif;
  seq_item item;
  uvm_analysis_port #(seq_item) monitor_port;
  
  function new(string name="monitor",uvm_component parent=null);
    super.new(name,parent);
    monitor_port=new("monitor_port",this);
    `uvm_info("monitor class","inside constructor",UVM_HIGH);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("monitor class","inside build phase",UVM_HIGH);
    if(!(uvm_config_db #(virtual intf)::get(this,"*","vif",vif)))
      begin
    `uvm_error("Driver class","Failed to get vif from config db");
      end
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("monitor class","inside connect phase",UVM_HIGH);
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("monitor class","inside run phase",UVM_HIGH);
   forever begin
    item=seq_item::type_id::create("item");
      wait(!vif.rst);
      @(vif.moncb);
      item.wen=vif.moncb.wen;
      item.wdata=vif.moncb.wdata;
      item.ren = vif.moncb.ren;
      item.rdata=vif.moncb.rdata;
      item.full=vif.moncb.full;
      item.empty=vif.moncb.empty;
      monitor_port.write(item);
    end 
  endtask
endclass
