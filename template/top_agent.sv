`ifndef ${TOP_AGENT}_SV
`define ${TOP_AGENT}_SV

class ${top_agent} extends uvm_agent;
    ${top_sequencer} sqr;
    ${top_driver} drv;
    ${top_monitor} mon;
    string m_config;

    uvm_cmdline_processor ucp = uvm_cmdline_processor::get_inst();

    uvm_analysis_port #(${top_transaction}) ap;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        `uvm_info("${top_agent}", "new is called", UVM_LOW);
    endfunction

    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void connect_phase(uvm_phase phase);
    extern virtual task          main_phase(uvm_phase phase);

    `uvm_component_utils(${top_agent})
endclass

function void ${top_agent}::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(is_active == UVM_ACTIVE) begin
        sqr = ${top_sequencer}::type_id::create("sqr", this);
        drv = ${top_driver}::type_id::create("drv", this);
    end
    mon = ${top_monitor}::type_id::create("mon", this);
    `uvm_info("${top_agent}", "build_phase finish", UVM_LOW);
endfunction

function void ${top_agent}::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if(is_active == UVM_ACTIVE) begin
        drv.seq_item_port.connect(sqr.seq_item_export);
        ap = mon.i_ap;
    end else begin
        ap = mon.o_ap;
    end
    `uvm_info("${top_agent}", "connect_phase finish", UVM_LOW);
endfunction

task ${top_agent}::main_phase(uvm_phase phase);    //UVM 1.2 magic.. automatic_phase_objection
    super.main_phase(phase);
    if(is_active == UVM_ACTIVE) begin
        ucp.get_arg_value("+config=", m_config);
        if(m_config == "top_sanity") begin
            ${top_sequence}_0 seq = ${top_sequence}_0::type_id::create("seq", this);
            seq.set_starting_phase(phase);
            seq.start(sqr);
        end
        else if(m_config == "top_pressure") begin
            ${top_sequence}_1 seq = ${top_sequence}_1::type_id::create("seq", this);
            seq.set_starting_phase(phase);
            seq.start(sqr);
        end
    end
endtask
`endif