class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)
  seq_item queue[$];
   seq_item item;
   
  bit [7:0] sc_que[$];
  bit [7:0] tx_data;
  bit read_delay_clk;
  uvm_analysis_imp #(seq_item,scoreboard) scoreboard_port;
  
  function new(string name="scoreboard",uvm_component parent=null);
    super.new(name,parent);
    scoreboard_port=new("scoreboard_port",this);
    `uvm_info("scoreboard class","inside constructor",UVM_HIGH);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("scoreboard class","inside build phase",UVM_HIGH);
  endfunction
  
  function void write(seq_item item);
        queue.push_back(item);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("scoreboard class","inside connect phase",UVM_HIGH);
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("scoreboard class","inside run phase",UVM_HIGH);
    forever begin
      seq_item ex_item;
      wait(queue.size()>0);
      ex_item=queue.pop_front();
      if(ex_item.wen==1)
        begin
          `uvm_info("SCB", $sformatf("WRITE: Data=%0h, Queue size=%0d",ex_item.wdata, sc_que.size()), UVM_MEDIUM)
          sc_que.push_back(ex_item.wdata);
        end
      if(ex_item.ren==1 || (read_delay_clk != 0))
        begin
          if(read_delay_clk==0) read_delay_clk=1;
          else
            begin
              if(ex_item.ren==0) read_delay_clk=0;
              
              if(sc_que.size()>0)
                begin
                  tx_data=sc_que.pop_front();
                  `uvm_info("SCB", $sformatf("READ: Data=%0h, Queue size=%0d",tx_data, sc_que.size()), UVM_MEDIUM)
                  if(ex_item.rdata==tx_data)
                    begin
                      `uvm_info("SCB",$sformatf("PASS acual data:%0h expected data=%0h queue size=%0d ",ex_item.rdata,tx_data,sc_que.size()),UVM_LOW)
                    end
                  else
                    begin
                      `uvm_error("SCB",$sformatf("FAIL acual data:%0h expected data=%0h",ex_item.rdata,tx_data))
                    end
                end
            end
        end
      else
        read_delay_clk=0;
    end
  endtask
endclass

      
          
