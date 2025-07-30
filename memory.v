module memory (
    input [3:0] addr,
    input [7:0] data_in,
    output reg [7:0] data_out,
    input mem_wr,
    input mem_rd,
    input clk
);
    reg [7:0] array [15:0];

    always @(posedge clk) begin
        if (mem_wr)
            array[addr] <= data_in;
        if (mem_rd)
            data_out <= array[addr];
    end
endmodule