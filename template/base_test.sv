`ifndef ${BASE_TEST}_SV
`define ${BASE_TEST}_SV

class ${base_test} extends uvm_test;
    ${top_env} env;
    
    function new(string name = "${base_test}", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void report_phase(uvm_phase phase);
    `uvm_component_utils(${base_test})
endclass

function void ${base_test}::build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = ${top_env}::type_id::create("env", this);
    //uvm_top.set_timeout(${TIMEOUT}ns, 0);
endfunction

function void ${base_test}::report_phase(uvm_phase phase);
    uvm_report_server server;
    int error_cnt;
    super.report_phase(phase);
    `uvm_info("${base_test}", "report_phase is called", UVM_LOW);

    server = uvm_report_server::get_server();
    error_cnt = server.get_severity_count(UVM_FATAL) + server.get_severity_count(UVM_ERROR)
    if (error_cnt != 0) begin
        $display("                            ");
        $display("****************************");
        $display("**    TEST CASE FAILED    **");
        $display("****************************");
        $display("  FFFFF   A    IIIII  L     ");
        $display("  F      A A     I    L     ");
        $display("  FFFF  AAAAA    I    L     ");
        $display("  F    A     A   I    L     ");
        $display("  F    A     A IIIII  LLLLL ");
        $display("****************************");
        $display("                            ");
        $display("ERROR %d times", error_cnt);
    end else begin
        $display("                            ");
        $display("****************************");
        $display("**    TEST CASE PASSED    **");
        $display("****************************");
        $display("  PPPP    A    SSSSS  SSSSS ");
        $display("  P   P  A A   S      S     ");
        $display("  PPPP  AAAAA  SSSSS  SSSSS ");
        $display("  P    A     A     S      S ");
        $display("  P    A     A SSSSS  SSSSS ");
        $display("****************************");
        $display("                            ");
    end
endfunction
`endif