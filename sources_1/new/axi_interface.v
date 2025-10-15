`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.10.2025 10:04:28
// Design Name: 
// Module Name: axi_interface
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


module axi_interface(
    input  wire        aclk,
    input  wire        aresetn,

    // Camera pixel interface
    input  wire [7:0]  i_r,
    input  wire [7:0]  i_g,
    input  wire [7:0]  i_b,
    input  wire        i_valid,
    input  wire        i_sof,
    input  wire        i_eol,

    // AXI4-Stream Slave Interface
    output reg  [23:0] tdata,
    output reg         tvalid,
    input  wire        tready,
    output reg         tlast,
    output reg         tuser
);

    always @(posedge aclk) begin
        if (!aresetn) begin
            tvalid <= 1'b0;
            tlast  <= 1'b0;
            tuser  <= 1'b0;
        end else begin
            tdata  <= {i_r, i_g, i_b};
            tvalid <= i_valid;
            tlast  <= i_eol;
            tuser  <= i_sof;
        end
    end

endmodule
