module additional_e (

    // Inputs
    input               clk,
    input               rst_btn,
    input               go_btn,
    
    // Outputs
    output  reg [3:0]   led,
    output  reg         done_sig
);

    // States
    localparam  STATE_HIGH    = 2'd0;
    localparam  STATE_LOW  = 2'd1;
    localparam  STATE_WAIT      = 2'd2;
    localparam  STATE_RUN      = 2'd3;
    
    // Max counts for clock divider and counter
    localparam MAX_CLK_COUNT    = 20'd480000 - 1;
    localparam  MAX_LED_COUNT   = 4'hF;
    
    // Internal signals
    wire rst;
    wire go;
    
    // Internal storage elements
    reg         div_clk;
    reg [1:0]   state;
    reg [23:0]  clk_count;
    
    // Invert active-low buttons
    assign rst = ~rst_btn;
    assign go = ~go_btn;
    
    always @ (posedge rst or posedge clk) begin
        if (rst == 1'b1) begin
            state <= STATE_HIGH;
            led <= 4'b0;
        end
        else begin
            case (state)

            STATE_HIGH: begin
                if (go == 1'b0) begin
                    state <= STATE_LOW;
                end 
            end

            STATE_LOW begin
                if (go == 1'b1) begin
                    state <= STATE_WAIT;
                end
            end

            STATE_WAIT: begin
                if (clk_count==MAX_CLK_COUNT) begin
                    if (go == 1'b1) begin
                        state <= STATE_RUN;
                    end else begin
                        state <= STATE_HIGH;
                    end
                end
            end
            STATE_RUN: begin
                led <= led +1;
                state <= STATE_HIGH;
            end
            default: state <= STATE_HIGH;
            endcase
        end
    end
    always @ (posedge rst or posedge go) begin
        if (rst == 1'b1) begin
            clk_count <= 20'd0;
        if (state == STATE_WAIT) begin
            clk_count <= clk_count+1;
        end 
        else begin
            clk_count <= 20'd0;
        end 
        end
    end
endmodule
    




