//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/04/2026 07:26:22 PM
// Design Name: 
// Module Name: displayEncoder
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

module miniALU(
    input logic [3:0] op1,
    input logic [3:0] op2,
    input logic operation,
    input logic sign,

    output logic [19:0] result
    );

    always_comb begin
        case ({operation, sign})
            2'b00: result = op1 + op2;
            2'b01: result = op1 - op2;
            2'b10: result = op1 << op2;
            2'b11: result = op1 >> op2;
        endcase
    end

endmodule