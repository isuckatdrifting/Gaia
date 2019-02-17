`ifndef ${TOP_ENV}_SV
`define ${TOP_ENV}_SV

class ${top_env} extends uvm_env;

    ${top_agent} i_agt;
    ${top_agent} o_agt;
    ${top_model} mdl;
    ${top_scoreboard} scb;

    uvm_tlm_analysis_fifo #(${top_transaction}) agt_scb_fifo;
    uvm_tlm_analysis_fifo #(${top_transaction}) agt_mdl_fifo;
    uvm_tlm_analysis_fifo #(${top_transaction}) mdl_scb_fifo;

    function new(string name = "${top_env}", uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        i_agt = ${top_agent}::type_id::create("i_agt", this);
        i_agt.is_active = UVM_ACTIVE;
        o_agt = ${top_agent}::type_id::create("o_agt", this);
        o_agt.is_active = UVM_PASSIVE;
        mdl = ${top_model}::type_id::create("mdl", this);
        scb = ${top_scoreboard}::type_id::create("scb", this);
        agt_scb_fifo = new("agt_scb_fifo", this);
        agt_mdl_fifo = new("agt_mdl_fifo", this);
        mdl_scb_fifo = new("mdl_scb_fifo", this);
    endfunction

    extern virtual function void connect_phase(uvm_phase phase);
    `uvm_component_utils(${top_env});
endclass

function void ${top_env}::connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    i_agt.ap.connect_phase(agt_mdl_fifo.analysis_export);
    mdl.port.connect(agt_mdl_fifo.blocking_get_export);
    mdl.ap.connect(mdl_scb_fifo.analysis_export);
    scb.exp_port.connect(mdl_scb_fifo.blocking_get_export);
    o_agt.ap.connect(agt_scb_fifo.analysis_export);
    scb.act_port.connect(agt_scb_fifo.blocking_get_export);
endfunction
`endif