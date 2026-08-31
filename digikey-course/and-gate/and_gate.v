// Module: button 0 lights 2 LEDs, button 0 and 1 light up each other
module and_gate (

    //Inputs
    input pmod_0,
    input pmod_1,

    //Outputs
    output led_0
);

    //Continuous assignment:NOT and AND operators
    assign led_0 = ~pmod_0 & ~pmod_1;

endmodule