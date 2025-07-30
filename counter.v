module counter (
    input clk,
    input reset,
    input enable,
    output reg [3:0] count
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            count <= 0;
        else if (enable)
            count <= count + 1;
    end
endmodule