// Problem 1

module not(
    input logic a,

    output logic f
);

    assign f = ~a;

endmodule


module and(
    input logic a,
    input logic b,

    output logic f
);

    assign f = a & b;

endmodule


module or(
    input logic a,
    input logic b,

    output logic f
);

    assign f = a | b;

endmodule


module xor(
    input logic a,
    input logic b,

    output logic f
);

    assign f = a ^ b;

endmodule


module nand(
    input logic a,
    input logic b,

    output logic f
);

    assign f = ~(a & b);

endmodule


module nor(
    input logic a,
    input logic b,

    output logic f
);

    assign f = ~(a | b);

endmodule


module parity(
	input logic [63:0] a,
	output logic parity_result
);

	assign parity_result = ~^a;

endmodule


// Problem 2

module expr(
    input logic a, b, c,
    output logic f
);

    assign f = (a & ~c) | ~b;

endmodule


// Problem 3

module comparator4bit(
	input logic a3, a2, a1, a0,  // Inputs a and b are split up for some reason...
	input logic b3, b2, b1, b0,  // Let's combine them using concatenation!
	output logic eq, gt, lt
);

	logic [3:0] a = {a3, a2, a1, a0};
	logic [3:0] b = {b3, b2, b1, b0};

    always_comb begin
        if (a > b) begin
            eq = 0;
            gt = 1;
            lt = 0;
        end
        else if (a < b) begin
            eq = 0;
            gt = 0;
            lt = 1;
        end
        else begin
            eq = 1;
            gt = 0;
            lt = 0;
        end
    end

endmodule


// Problem 4

module sign_extension(
	input logic [6:0] a,
	output logic [15:0] y
);

    assign y = {9{a[6]}, a};

endmodule


// Problem 5

module mux2(
	input logic [3:0] d0, d1,
	input logic s,
	output logic [3:0] y
);

    assign y = s ? d0 : d1;

endmodule


module mux4(
	input logic [3:0] d0, d1, d2, d3,
	input logic [1:0] s,
	output logic [3:0] y
);

    logic [3:0] low, high;

	mux2 lowmux(d0, d1, s[0], low);
	mux2 highmux(d2, d3, s[0], high);
	mux2 finalmux(low, high, s[1], y);

endmodule


// Problem 6

module priority_casez(
    input logic [3:0] a,
    output logic [3:0] y
);

    always_comb begin
        casez (a)
            4'b1???: y = 4'b1000;
            4'b01??: y = 4'b0100;
            4'b001?: y = 4'b0010;
            default: y = a;
        endcase
    end

endmodule


// Problem 7

module csel_block4 (
    input logic [3:0] a, b,
    output logic [3:0] s0, s1,	// Sums assuming carry-in = 0 / 1
    output logic c0, c1    		// Carry-outs assuming carry-in = 0 / 1
);

    logic [3:0] g, p;
    logic [3:0] carry0, carry1;

    assign g = a & b;
    assign p = a ^ b;

    assign carry0[0] = 0;
    assign carry0[1] = g[0] | (p[0] & carry0[0]);
    assign carry0[2] = g[1] | (p[1] & carry0[1]);
    assign carry0[3] = g[2] | (p[2] & carry0[2]);
    assign c0 = g[3] | (p[3] & carry0[3]);
    assign s0 = p ^ carry1;

    assign carry1[0] = 1;
    assign carry1[1] = g[0] | (p[0] & carry1[0]);
    assign carry1[2] = g[1] | (p[1] & carry1[1]);
    assign carry1[3] = g[2] | (p[2] & carry1[2]);
    assign c1 = g[3] | (p[3] & carry1[3]);
    assign s1 = p ^ carry1;

endmodule


module csel_adder8 (
    input logic [7:0] a, b,
    input logic cin,
    output logic [7:0] s,
    output logic cout
);
    logic [3:0] low0, low1, high0, high1;
    logic low_c0, low_c1, high_c0, high_c1; 

    csel_block4(a[3:0], b[3:0], low0, low1, low_c0, low_c1);
    csel_block4(a[7:4], b[7:4], high0, high1, high_c0, high_c1);

    logic [3:0] low_sum;
    logic carry_mid;

    assign low_sum = cin ? low1 : low0;
    assign carry_mid = cin ? low_c1 : low_c0;

    assign s[3:0] = low_sum;
    assign s[7:4] = carry_mid ? high1 : high0;
    assign cout = carry_mid ? high_c1 : high_c0;

endmodule
