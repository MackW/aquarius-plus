module spiregs(
    input  wire        clk,

    input  wire        esp_ssel_n,
    input  wire        esp_sclk,
    input  wire        esp_mosi,
    output wire        esp_miso,

    output wire        busreq,

    input  wire        bus_phi,
    output reg  [15:0] bus_a,
    input  wire  [7:0] bus_rddata,
    output reg   [7:0] bus_wrdata,
    output reg         bus_wrdata_en,
    output reg         bus_rd_n,
    output reg         bus_wr_n,
    output reg         bus_mreq_n,
    output reg         bus_iorq_n,

    output reg         reset_req,
    output reg  [63:0] keys);

    //////////////////////////////////////////////////////////////////////////
    // SPI slave
    //////////////////////////////////////////////////////////////////////////
    wire        msg_start, msg_end, rxdata_valid;
    wire  [7:0] rxdata;

    reg   [7:0] txdata_r = 8'h00;
    wire        txdata_ack;

    spislave spislave(
        .clk(clk),

        .esp_ssel_n(esp_ssel_n),
        .esp_sclk(esp_sclk),
        .esp_mosi(esp_mosi),
        .esp_miso(esp_miso),
        
        .msg_start(msg_start),
        .msg_end(msg_end),
        .rxdata(rxdata),
        .rxdata_valid(rxdata_valid),
        .txdata(txdata_r),
        .txdata_ack(txdata_ack));

    //////////////////////////////////////////////////////////////////////////
    // Data reception
    //////////////////////////////////////////////////////////////////////////
    reg [63:0] data_r;

    localparam
        ST_IDLE = 2'b00,
        ST_CMD  = 2'b01,
        ST_DATA = 2'b10;

    reg [1:0] state_r;
    reg [7:0] cmd_r;
    reg [2:0] byte_cnt_r;

    always @(posedge clk) begin
        if (msg_start)
            state_r <= ST_CMD;
        if (msg_end)
            state_r <= ST_IDLE;
        if (msg_start || msg_end)
            byte_cnt_r <= 3'b0;
        if (rxdata_valid)
            byte_cnt_r <= byte_cnt_r + 3'b1;

        if (state_r == ST_CMD && rxdata_valid) begin
            cmd_r   <= rxdata;
            state_r <= ST_DATA;
        end

        if (state_r == ST_DATA && rxdata_valid) begin
            data_r <= {rxdata, data_r[63:8]};
        end
    end

    //////////////////////////////////////////////////////////////////////////
    // Commands
    //////////////////////////////////////////////////////////////////////////
    reg phi_r;
    always @(posedge clk) phi_r <= bus_phi;
    wire phi_falling = phi_r && !bus_phi;
    wire phi_rising = !phi_r && bus_phi;

    reg busreq_r = 1'b0;
    assign busreq = busreq_r;

    localparam
        CMD_RESET           = 8'h01,
        CMD_SET_KEYB_MATRIX = 8'h10,
        CMD_BUS_ACQUIRE     = 8'h20,
        CMD_BUS_RELEASE     = 8'h21,
        CMD_MEM_WRITE       = 8'h22,
        CMD_MEM_READ        = 8'h23,
        CMD_IO_WRITE        = 8'h24,
        CMD_IO_READ         = 8'h25;

    // 01h: Reset command
    always @(posedge clk) begin
        reset_req <= 1'b0;
        if (cmd_r == CMD_RESET && msg_end) reset_req <= 1'b1;
    end

    // 10h: Set keyboard matrix
    always @(posedge clk)
        if (cmd_r == CMD_SET_KEYB_MATRIX && msg_end) keys <= data_r;

    // 20h/21h: Acquire/release bus
    always @(posedge clk) begin
        if (phi_falling) begin
            if (cmd_r == CMD_BUS_ACQUIRE) busreq_r <= 1'b1;
            if (cmd_r == CMD_BUS_RELEASE) busreq_r <= 1'b0;
        end
    end

    localparam
        BST_IDLE   = 3'd0,
        BST_CYCLE0 = 3'd1,
        BST_CYCLE1 = 3'd2,
        BST_CYCLE2 = 3'd3,
        BST_DONE   = 3'd4;

    reg [2:0] bus_state_r = BST_IDLE;

    always @(posedge clk) begin
        case (bus_state_r)
            BST_IDLE: begin
                bus_rd_n   <= 1'b1;
                bus_wr_n   <= 1'b1;
                bus_mreq_n <= 1'b1;
                bus_iorq_n <= 1'b1;
                txdata_r   <= 8'h00;
                bus_wrdata_en <= 1'b0;

                if (rxdata_valid) begin
                    case (byte_cnt_r)
                        3'd1: bus_a[7:0]  <= rxdata;
                        3'd2: begin
                            bus_a[15:8] <= rxdata;
                            if (cmd_r == CMD_MEM_READ || cmd_r == CMD_IO_READ) bus_state_r <= BST_CYCLE0;
                        end
                        3'd3: begin
                            bus_wrdata <= rxdata;
                            if (cmd_r == CMD_MEM_WRITE || cmd_r == CMD_IO_WRITE) bus_state_r <= BST_CYCLE0;
                        end
                    endcase
                end
            end

            BST_CYCLE0: begin
                if (phi_falling) begin
                    if (cmd_r == CMD_MEM_READ || cmd_r == CMD_MEM_WRITE)
                        bus_mreq_n <= 1'b0;
                    if (cmd_r == CMD_IO_READ || cmd_r == CMD_IO_WRITE)
                        bus_iorq_n <= 1'b0;
                    if (cmd_r == CMD_MEM_READ || cmd_r == CMD_IO_READ)
                        bus_rd_n <= 1'b0;
                    if (cmd_r == CMD_MEM_WRITE || cmd_r == CMD_IO_WRITE)
                        bus_wrdata_en <= 1'b1;
                    
                    bus_state_r <= BST_CYCLE1;
                end
            end

            BST_CYCLE1: begin
                if (phi_falling) begin
                    if (cmd_r == CMD_MEM_WRITE || cmd_r == CMD_IO_WRITE)
                        bus_wr_n <= 1'b0;

                    bus_state_r <= BST_CYCLE2;
                end
            end

            BST_CYCLE2: begin
                if (phi_falling) begin
                    if (cmd_r == CMD_MEM_READ || cmd_r == CMD_IO_READ)
                        txdata_r <= bus_rddata;

                    bus_mreq_n <= 1'b1;
                    bus_iorq_n <= 1'b1;
                    bus_rd_n   <= 1'b1;
                    bus_wr_n   <= 1'b1;
                    bus_state_r <= BST_DONE;
                end
            end

            BST_DONE: begin
                if (phi_rising) begin
                    bus_wrdata_en <= 1'b0;
                end
            end

        endcase

        if (msg_start) bus_state_r <= BST_IDLE;
    end

endmodule
