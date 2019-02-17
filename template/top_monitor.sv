`ifndef ${TOP_MONITOR}_SV
`define ${TOP_MONITOR}_SV

class ${top_monitor} extends umvm_monitor;

    virtual ${top_if} vif;

    uvm_analysis_port #(${top_transaction}) i_ap;
    uvm_analysis_port #(${top_transaction}) o_ap;

    `uvm_component_utils(${top_monitor})
    function new(string name = "${top_monitor}", uvm_component_parent = null);
        super.new(name, parent);
        `uvm_info("${top_monitor}", "new is called", UVM_LOW);
    endfunction

    extern virtual function void build_phase(uvm_phase phase);
    extern task main_phase(uvm_phase phase);
    extern task collect_one_pkt();
endclass

function void ${top_monitor}::build_phase(uvm_phase phase)
    super.build_phase(phase);
    if(!uvm_config_db#(virtual ${top_if})::get(this, "", "vif", vif))
        `uvm_fatal("${top_monitor}", "virtual interface must be set for vif!!")
    i_ap = new("i_ap", this);
    o_ap = new("o_ap", this);
    `uvm_info("${top_monitor}", "build_phase finish", UVM_LOW);
endfunction

task ${top_monitor}::main_phase(uvm_phase phase);

    while(1) begin
        collect_one_pkt();
    end
endtask

task ${top_monitor}::collect_one_pkt();
    ${top_transaction} i_tr;
    ${top_transaction} o_tr;
    
    i_tr = new("i_tr");
    o_tr = new("o_tr");

    `uvm_info("${top_monitor}", "begin to collect one pkt", UVM_LOW);
    fork
        
        begin
            // I_AGT_MON
            // Monitor logic here
            i_ap.write(i_tr);

            //O_AGT_MON
            o_ap.write(o_tr);
        end
        begin
            //EXCEPTION LOGIC HERE
        end
    join_any
    disable fork;

endtask
`endif