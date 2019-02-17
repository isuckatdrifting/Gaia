`ifndef ${TOP_DRIVER}_SV
`define ${TOP_DRIVER}_SV

class ${top_driver} extends uvm_driver #(${top_transaction});

    virtual ${top_if} vif;

    `uvm_component_utils(${top_driver})
    function new(string name = "${top_driver}", uvm_component parent = null);
        super.new(name, parent);
        `uvm_info("${top_driver}", "new is called", UVM_LOW);
    endfunction

    extern virtual function void bulid_phase(uvm_phase phase);
    extern          task         main_phase(uvm_phase phase);

endclass

function void ${top_driver}::bulid_phase(uvm_phase phase);
    super.bulid_phase(phase);
    if(!uvm_config_db#(virtual ${top_if})::get(this, "", "vif", vif))
        `uvm_fatal("${top_driver}", "virtual interface must be set for vif!!");
    `uvm_info("${top_driver}", "build_phase finish", UVM_LOW);
endfunction

task ${top_driver}::main_phase(uvm_phase phase);

    `uvm_info("${top_driver}", "main_phase is called", UVM_LOW);

    //Initialize Signals

    while(!vif.rstn)
        @(posedge vif.clk);

    forever begin
        seq_item_port.get_next_item(req);

        $display("\n\n\n");
        $display("==========================NEW SEQ %d========================");
        $display("--------------------------DRV %d------------------------");
        $display("--------------------------CONFIG-----------------------");
        //Print package configs
        `uvm_info("${top_driver}", "got one transaction", UVM_LOW);
        drive_one_pkt(req);
        seq_item_port.item_done();
    end
endtask

task ${top_driver}::drive_one_pkt(${top_transaction} tr);
    tr.print();
    repeat(10) @ (posedge vif.clk);

    `uvm_info("${top_driver}", "end drive initial", UVM_LOW);
endtask

`endif