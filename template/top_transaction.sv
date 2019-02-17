`ifndef ${TOP_TRANSACTION}_SV
`define ${TOP_TRANSACTION}_SV

class ${top_transaction} extends uvm_sequence_item;

    rand bit temp;

    `uvm_object_utils_begin(${top_transaction})
        
    `uvm_object_utils_end

    function new(string name = "${top_transaction}");
        super.new();
    endfunction
endclass
`endif