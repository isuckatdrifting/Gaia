`timescale 1ns/1ps
`include "uvm_macros.svh"

import uvm_pkg::*;

`include "${top_if}.sv"
`include "${top_transaction}.sv"
`include "${top_sequence}.sv"
`include "${top_sequencer}.sv"
`include "${top_driver}.sv"
`include "${top_monitor}.sv"
`include "${top_agent}.sv"
`include "${top_model}.sv"
`include "${top_scoreboard}.sv"
`include "${top_env}.sv"
`include "${base_test}.sv"
`include "${top_testcase}.sv"

module ${top_tb};

    reg clk;
    reg rstn;

    ${top_if} ${top_if}_d(clk, rstn);
    ${top_if} ${top_if}_i(clk, rstn);
    ${top_if} ${top_if}_o(clk, rstn);

    initial begin
        clk = 0;
        forever begin
            #15 clk = ~clk;
        end
    end

    initial begin
        rstn = 1'b0;
        #1000;
        rstn = 1'b1;
    end

    /////////////////WIRES///////////////

    /////////////////DUT/////////////////
    DUT DUT_0(

    );

    /////////////////I_AGT_DRV_IF//////////////
    //assign ${top_if}_d.......

    /////////////////I_AGT_MON_IF//////////////
    //assign ${top_if}_i......

    /////////////////O_AGT_MON_IF//////////////
    //assign ${top_if}_o......

    initial begin
        run_test("top_testcase");
    end
    
    initial begin
        uvm_config_db#(virtual ${top_if})::set(null, "*.i_agt.drv", "vif", ${top_if}_d);
        uvm_config_db#(virtual ${top_if})::set(null, "*.i_agt.mon", "vif", ${top_if}_i);
        uvm_config_db#(virtual ${top_if})::set(null, "*.o_agt.mon", "vif", ${top_if}_o);
    end

endmodule
