module inverter(
    // Port interface
    input logic a,
    output logic f

    // Signal types: logic, wire, reg
);

    // Continuous assignment
    assign f = ~a;          // don't confuse with !, ~ is a bitwise NOT

endmodule

module universal_gates (
    input logic [3:0] a,    // 3 is number of bits, width of the bus
    input logic [3:0] b,    // bigger to smaller (3 -> 0)

    output logic [3:0] f_and,
    output logic [3:0] f_or,
    output logic [3:0] f_xor,
    output logic [3:0] f_nand,
    output logic [3:0] f_nor
);

    // & and | are bitwise symbols
    // bitwise AND
    // a = 0 1 1 0
    // b = 1 0 1 1
    // c = 0 0 1 0

    // logical AND (&&)
    // a = "1"
    // b = "1"
    // c = a && b = 1 && 1 = 1


    assign f_and = a & b;
    assign f_or = a | b;

    assign f_xor[3] = a[3] ^ b[3];  // assigning individual bits

    assign f_xor = a ^ b;
    assign f_nand = ~(a & b);
    assign f_nor = ~(a | b);

endmodule


// Recall the example from section 3 of the hand notes...
// F = X'Y + XZ
module boolean_alg(
    input logic x, y, z
    output logic f
);

    assign f = (~x & y) | (x & z);

endmodule


module mux #(

    parameter WIDTH = 32;

) (

    input logic [WIDTH-1:0] a,
    input logic [WIDTH-1:0] b,
    input logic s,

    output logic [WIDTH-1:0] f

);

    assign f = s ? b : a;   // ternary

endmodule


module mux4to1(
    input logic [3:0] d0, d1, d2, d3,
    input logic [1:0] s,
    output logic [3:0] y

);

    assign y = s[1] ? (s[0] ? d3 : d2) : (s[0] ? d1 : d0);

    // Another way to do combinational logic is the always_comb block
    // Procedural blocks: always_comb, always_ff, always_latch
    always_comb begin
        if (s[1] == 0) begin
            if (s[0] == 0) y = d0;      // 00
            else           y = d1;      // 01
        end
        else begin
            if (s[0] == 0) y = d2;      // 10
            else           y = d3;      // 11
        end
    end 

endmodule


module decoder3to8 (
    input logic [2:0] a,
    output logic [7:0] y
);

    always_comb begin
        case (s)

        // 3 bits, b = binary, ### = number in binary
        3'b000: y = 8'b0000_0001;
        3'b001: y = 8'b0000_0001; 
        3'b010: y = 8'b0000_0100;
        3'b011: y = 8'b0000_1000;
        3'b100: y = 8'b0001_0000;
        3'b101: y = 8'b0010_0000;
        3'b110: y = 8'b0100_0000;
        3'b111: y = 8'b1000_0000;

        endcase 
    end

endmodule


// assign vs always_comb
/*
    It just depends on convenience.

    Similarities: both will recompute the output whenever any of the inputs (RHS) change value
    
    Differences:
        assign:
            describes one signal's equation
            ternary operators
            order is irrelevant; each assign is an independent piece of hardware
            recomputes when any input (RHS) changes value
        
        always_comb:
            can drive several signals
            if/else case for while
            statements run from top to bottom
            if assigning two signals twice, the last
            recomputes when any signal read in the block changes, EXCEPT signals also written in the block
            portential for errors (inferred latches) if not fully defined

            logic t, a, b;

            assign t = a & b;
            assign y = t & c;

            assign y = t & c;
            assign t = a & b;

            always_comb begin
                y = t & c;      // read t before it's assigned, so it uses the old value
                t = a & b;      // t is written inside the block
            end
*/