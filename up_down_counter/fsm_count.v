module fsm_count(
    //Parameters
    parameter MAX_COUNT = 4'hF
)(
    input clk,
    input rst,
    input go,

    output reg[3:0] out,

);

localparam STATE_IDLE = 2'd0;
localparam STATE_UP = 2'd1;
localparam STATE_DOWN = 2'd2;

reg [1:0] state;

always @ (posedge clk or posedge rst) begin
    if (rst==1'b1) begin
        state <= STATE_IDLE;
        out <= 4'b0;
    end
    else begin
        case (state)
            STATE_IDLE: begin
                if (go == 1'b1) begin
                    state <= STATE_UP;
                end
            end

            STATE_UP: begin
                if (out == MAX_COUNT) begin
                    state <= STATE_DOWN;
                end
                else if (go==1) begin
                    out <= out +1;
                end
            end
            STATE_DOWN: begin
                if (out == 4'b0) begin
                    state <= STATE_UP;
                end
                else if (go==1) begin
                    out <= out -1;
                end
            end
        endcase
    end
end
endmodule






        




