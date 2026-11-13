//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/11/2026 04:39:37 PM
// Design Name: 
// Module Name: calculator_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module calculator_top(
    input logic [3:0] op1,
    input logic [3:0] op2,
    input logic operation,
    input logic sign,
    input clk, 

    output logic [6:0] segBits,
    output logic [3:0] trigger
    );

    logic [19:0] result;
    logic [3:0] numberBits [3:0];
    logic [6:0] displayBits [3:0];
    
    miniALU mini_alu (.op1(op1), .op2(op2), .operation(operation), .sign(sign), .result(result));

    displayEncoder display_encoder (.result(result), .numberBits(numberBits));
    
    sevenSegDigit digit0 (.digit(numberBits[0]), .displayBits(displayBits[0]));
    sevenSegDigit digit1 (.digit(numberBits[1]), .displayBits(displayBits[1]));
    sevenSegDigit digit2 (.digit(numberBits[2]), .displayBits(displayBits[2]));
    sevenSegDigit digit3 (.digit(numberBits[3]), .displayBits(displayBits[3]));

    seg_driver driver (.displayBits(displayBits), .clk(clk), .trigger(trigger), .segBits(segBits));

endmodule
