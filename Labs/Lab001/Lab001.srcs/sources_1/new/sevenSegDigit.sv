`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/04/2026 07:43:31 PM
// Design Name: 
// Module Name: sevenSegDigit
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


module sevenSegDigit(
    input logic [3:0] digit,
    output logic [6:0] displayBits
    );

    always_comb begin
        case (digit)
            4'b0000: displayBits = 7'b1000000; // 0
            4'b0001: displayBits = 7'b1111001; // 1
            4'b0010: displayBits = 7'b0100100; // 2
            4'b0011: displayBits = 7'b0110000; // 3
            4'b0100: displayBits = 7'b0011001; // 4
            4'b0101: displayBits = 7'b0010010; // 5
            4'b0110: displayBits = 7'b0000010; // 6
            4'b0111: displayBits = 7'b1111000; // 7
            4'b1000: displayBits = 7'b0000000; // 8
            4'b1001: displayBits = 7'b0010000; // 9
        endcase
    end

endmodule
