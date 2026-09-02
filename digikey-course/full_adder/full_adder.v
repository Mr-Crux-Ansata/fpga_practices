module full_adder (

    input [2:0] pmod,

    output [1:0] led

);

    wire xor_a_b;

    assign xor_a_b = pmod[2]^pmod[1];

    assign led[1] = xor_a_b ^ pmod[0];

    assign led[0] = (xor_a_b & pmod[0]) | (pmod[1] & pmod[2]);


endmodule
