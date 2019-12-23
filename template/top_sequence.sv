`ifndef ${TOP_SEQUENCE}_SV
`define ${TOP_SEQUENCE}_SV

class ${TOP_SEQUENCE}_0 extends uvm_sequence #(top_transaction);
    top_transaction a_trans;

    function new(string name = "${TOP_SEQUENCE}_0");
        super.new(name);
        set_automatic_phase_objection(1);
    endfunction

    virtual task body();
        `uvm_info("DEBUG", "sequence initialize", UVM_LOW);
        repeat(10) begin
            `uvm_do(a_trans)
        end
        #${TIMEGAP_OF_SEQUENCE}; //IDLE time to observe the finish of waveform
    endtask

    `uvm_object_utils(${TOP_SEQUENCE}_0)
endclass

class ${TOP_SEQUENCE}_1 extends uvm_sequence #(top_transaction);
    top_transaction a_trans;
    string m_seq_num;
    int seq_num;

    uvm_cmdline_processor ucp = uvm_cmdline_processor::get_inst();

    function new(string name = "${TOP_SEQUENCE}_1");
        super.new(name);
        set_automatic_phase_objection(1);
    endfunction

    virtual task body();
        `uvm_info("DEBUG", "sequence initialize", UVM_LOW);
        ucp.get_arg_value("+seq_num=", m_seq_num);
        seq_num = m_seq_num.atoi();
        `uvm_info("DEBUG", $sformatf("runnning %d cases", seq_num), UVM_LOW);
        repeat(seq_num) begin
            `uvm_do(a_trans)
        end
        #${TIMEGAP_OF_SEQUENCE}; //IDLE time to observe the finish of waveform
    endtask

    `uvm_object_utils(${TOP_SEQUENCE}_1)
endclass
`endif