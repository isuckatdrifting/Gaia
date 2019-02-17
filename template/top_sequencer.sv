`ifndef ${TOP_SEQUENCER}_SV
`define ${TOP_SEQUENCER}_SV

class ${top_sequencer} extends uvm_sequencer #(${top_transaction});
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    `uvm_component_utils(${top_sequencer})
endclass
`endif