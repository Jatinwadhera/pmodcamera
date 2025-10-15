`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Jatin
// Project: Camera Capture to DDR (Zynq)
// Module: camera_capture_axi_top
// Description: Top-level module instantiating pmod_top and axi_interface and connecting them
//////////////////////////////////////////////////////////////////////////////////

module axi_top (
    // Camera input interface
    input  wire        i_pclk_0_0,          // Pixel clock from camera (PCLK)
    input  wire        i_reset_n_0_0,       // Active low reset
    input  wire        i_vsync_0_0,         // VSYNC
    input  wire        i_href_0_0,          // HREF
    input  wire [7:0]  i_data_0_0,          // 8-bit data from camera
    input  wire        i_start_capture_0_0, // Trigger for capture start

    // AXI4-Stream slave interface signals
    input  wire        aclk,
    input  wire        aresetn,
    output wire [23:0] tdata,
    output wire        tvalid,
    input  wire        tready,
    output wire        tlast,
    output wire        tuser

    // Uncomment if XCLK output required
    // output wire        o_xclk
);

    // Internal signals for RGB and control
    wire [7:0] w_r, w_g, w_b;
    wire       w_valid, w_sof, w_eol;

    // Instantiate camera capture module (pmod_top)
    pmod_top u_pmod_top (
        .i_pclk_0_0         (i_pclk_0_0),
        .i_reset_n_0_0      (i_reset_n_0_0),
        .i_vsync_0_0        (i_vsync_0_0),
        .i_href_0_0         (i_href_0_0),
        .i_data_0_0         (i_data_0_0),
        .i_start_capture_0_0(i_start_capture_0_0),

        .o_r                (w_r),
        .o_g                (w_g),
        .o_b                (w_b),
        .o_valid            (w_valid),
        .o_sof              (w_sof),
        .o_eol              (w_eol)

        // Uncomment if you want to use XCLK output
        // .o_xclk             (o_xclk)
    );

    // Instantiate AXI4-Stream interface module
    axi_interface u_axi_interface (
        .aclk    (aclk),
        .aresetn (aresetn),
        .i_r     (w_r),
        .i_g     (w_g),
        .i_b     (w_b),
        .i_valid (w_valid),
        .i_sof   (w_sof),
        .i_eol   (w_eol),
        .tdata   (tdata),
        .tvalid  (tvalid),
        .tready  (tready),
        .tlast   (tlast),
        .tuser   (tuser)
    );

endmodule
