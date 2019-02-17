`ifndef ${TOP_SCOREBOARD}_SV
`define ${TOP_SCOREBOARD}_SV

class ${top_scoreboard} extends uvm_scoreboard;

    ${top_transaction} expect_queue[$];

    uvm_blocking_get_port #(${top_transaction}) exp_port;
    uvm_blocking_get_post #(${top_transaction}) act_port;

    `uvm_component_utils(${top_scoreboard})

    extern function new(string name, uvm_component parent = null);
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual task main_phase(uvm_phase phase);
endclass

function ${top_scoreboard}::new(string name, uvm_component parent = null);
    super.new(name, parent);
    `uvm_info("${top_scoreboard}", "new is called", UVM_LOW);
endfunction

function void ${top_scoreboard}::build_phase(uvm_phase phase);
    super.build_phase(phase);
    exp_port = new("exp_port", this);
    act_port = new("act_port", this);
    `uvm_info("${top_scoreboard}", "build phase finish", UVM_LOW);
endfunction

task ${top_scoreboard}::main_phase(uvm_phase phase);

    ${top_transaction} get_expect, get_actual, tmp_tran;
    bit result;
    int i;

    super.main_phase(phase);
    i = 0;
    fork
        while(1) begin
            exp_port.get(get_expext);
            expect_queue.push_back(get_expect);
        end
        while(1) begin
            act_port.get(get_actual);
            if(expect_queue.size() > 0) begin
                tmp_tran = expect_queue.pop_front();
                result = get_actual.compare(tmp_tran);  //Auto Compare Logic
                i++;
                if(result) begin
                    `uvm_info("${top_scoreboard}", $sformatf("SEQ %d Compare SUCCESSFULLY", i), UVM_LOW);
                end else begin
                    `uvm_error("${top_scoreboard}", $sformatf("SEQ %d Compare FAILED", i), UVM_LOW);
                    $display("the expect pkt is");
                    tmp_tran.print();
                    $display("the actual pkt is");
                    get_actual.print();
                end
            end else begin
                `uvm_error("${top_scoreboard}", "Received from DUT, while Expect Queue is empty");
                $display("the unexpected pkt is");
                get_actual.print();
            end
        end
    join
endtask
`endif