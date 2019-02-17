`ifndef ${TOP_TESTCASE}_SV
`define ${TOP_TESTCASE}_SV

class ${top_testcase} extends ${base_test};

    function new(string name = "${top_testcase}", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    extern virtual function void build_phase(uvm_phase phase);
    `uvm_component_utils(${top_testcase})
endclass

function void ${top_testcase}::build_phase(uvm_phase phase);
    super.build_phase(phase);
endfunction
`endif