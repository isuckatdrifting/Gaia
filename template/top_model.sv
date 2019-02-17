`ifndef ${TOP_MODEL}_SV
`define ${TOP_MODEL}_SV

class ${top_model} extends uvm_component;
    uvm_blocking_get_port #(${top_transaction}) port;
    uvm_analysis_port #(${top_transaction}) ap;

    extern function new(string name, uvm_component parent);
    extern funciton void build_phase(uvm_phase phase);
    extern virtual task main_phase(uvm_phase phase);

    `uvm_component_utils(${top_model})
endclass

function ${top_model}::new(string name, uvm_component parent);
    super.new(name, parent);
endfunction

function void ${top_model}::build_phase(uvm_phase phase);
    super.build_phase(phase);
    port = new("port", this);
    ap = new("ap", this);
endfunction

task ${top_model}::main_phase(uvm_phase);
    ${top_transaction} tr;
    ${top_transaction} new_tr;

    // Temp Variables

    super.main_phase(phase)
    
    while(1) begin
        port.get(tr);
        new_tr = new("new_tr");
        ap.write(new_tr);
    end
endtask
`endif