module top_module (
    input clk,
    input reset,
    output [7:0] acc_out
);
    wire [7:0] instruction, alu_out, mem_out, acc_in, reg_out;
    wire [3:0] alu_op;
    wire acc_en, instr_en, mem_wr, mem_rd, halt;
    wire [3:0] pc_out;

    counter pc (.clk(clk), .reset(reset), .enable(1'b1), .count(pc_out));

    memory memory_inst (.addr(pc_out), .data_in(acc_out), .data_out(instruction), .mem_wr(1'b0), .mem_rd(1'b1), .clk(clk));

    controller controller_inst (.clk(clk), .reset(reset), .instruction(instruction),
                                .acc_en(acc_en), .instr_en(instr_en), .mem_wr(mem_wr),
                                .mem_rd(mem_rd), .alu_op(alu_op), .halt(halt));

    register instr_reg (.clk(clk), .reset(reset), .en(instr_en), .d(instruction), .q(reg_out));

    alu alu_inst (.a(acc_out), .b(reg_out), .alu_op(alu_op), .result(alu_out));

    memory data_mem (.addr(reg_out[3:0]), .data_in(acc_out), .data_out(mem_out),
                     .mem_wr(mem_wr), .mem_rd(mem_rd), .clk(clk));

    assign acc_in = (mem_rd) ? mem_out : alu_out;

    register acc (.clk(clk), .reset(reset), .en(acc_en), .d(acc_in), .q(acc_out));

endmodule