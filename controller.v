module controller (
    input clk,
    input reset,
    input [7:0] instruction,
    output reg acc_en,
    output reg instr_en,
    output reg mem_wr,
    output reg mem_rd,
    output reg [3:0] alu_op,
    output reg halt
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            acc_en <= 0;
            instr_en <= 0;
            mem_wr <= 0;
            mem_rd <= 0;
            alu_op <= 0;
            halt <= 0;
        end else begin
            instr_en <= 1;
            case (instruction[7:4])
                4'b0001: begin alu_op <= 4'b0001; acc_en <= 1; end // ADD
                4'b0010: begin alu_op <= 4'b0010; acc_en <= 1; end // SUB
                4'b0011: begin mem_rd <= 1; acc_en <= 1; end       // LOAD
                4'b0100: begin mem_wr <= 1; end                    // STORE
                4'b1111: begin halt <= 1; end                      // HALT
                default: begin acc_en <= 0; end
            endcase
        end
    end
endmodule