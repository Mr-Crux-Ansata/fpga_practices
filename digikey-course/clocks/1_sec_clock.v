module 1_sec_clock (

    input [0] pmod,
    input clk,
    output reg [3:0] led

);

wire rst;

assign rst = ~pmod[0];

reg [3:0] counter ;

always @ (posedge clk or posedge rst) begin
    if (rst == 1'b1) begin
        counter <= 4'b0;
        led <= 4'b0;

    end else begin 
        if (counter == 4'b1011) begin
            counter <= 4'b0;
            led <= led + 1'b1;
        end
        else begin
            counter <= counter + 1'b1;
        end
  
    end
    end
    
endmodule

