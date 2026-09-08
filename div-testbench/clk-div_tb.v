//Define timescale for simulation : <time_unit>/<time_precision>
`timescale 1 ns /10 ps

//Define the testbench
module clock_divider_tb();

    //Internal signals
    wire out;

    //Storage elements (set initial values to 0)
    reg clk = 0;
    reg rst=0;

    //Simulation time: 10000*1ns=10 us
    localparam DURATION = 10000;

    //Generate clock signal:1 / (82*41.67)*1 ns) = 11,999,040.08 Mhz
    always begin

        //Delay for 41.67 time units
        //10 ps precision menans that 41.667 is rounded to 41.67 ns
        #41.667

        //Toggle clock line
        clk = ~clk;

    end

    //Instantiate the unit under test (UUT)
    clock_divider #(.COUNT_WIDTH(4), .MAX_COUNT(6)) uut(
        .clk(clk),
        .rst(rst),
        .out(out)
    );

    //Pulse reset line high at the beginning
    initial begin
        #10
        rst = 1'b1;
        #1
        rst = 1'b0;
    end

    //Run simulation (output to .vcd file)
    initial begin
        //Create simulatio n output file
        $dumpfile("clk-div_tb.vcd");
        $dumpvars(0, clock_divider_tb);

        //Wait for given amount of time for simulation to complete
        #(DURATION)

        //Notify and end simulation
        $display("Finished");
        $finish;
    end
    
endmodule

