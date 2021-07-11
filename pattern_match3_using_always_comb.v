module pattern_match3 #(
  parameter PATTERN_SIZE = 6,
  parameter DATA_SIZE =32,
  parameter [PATTERN_SIZE-1:0] PATTERN = 'b100100
)(
  input [DATA_SIZE-1:0] i,
  input clk,
  input rstb,

  output reg [DATA_SIZE-1:0] o,
  output reg match
);

integer j;
reg [PATTERN_SIZE+DATA_SIZE-2:0] RACK;  //37:0

wire [PATTERN_SIZE+DATA_SIZE-2:0] current_data = {i,RACK[DATA_SIZE +: PATTERN_SIZE-1 ]};  // {i[31:0],RACK[36:32]}

logic getMatch;

always_comb begin
    getMatch = 0;
    for (j=0;j <= DATA_SIZE-1;j++) begin
      if (current_data[j+:PATTERN_SIZE] == PATTERN) getMatch = 1; //j should be 31
      $display("Index: %d Data: %h Match: %b",j,current_data[j+:PATTERN_SIZE], getMatch);
    end
end

always_ff @(posedge clk or negedge rstb)
  if (!rstb) begin
    RACK <= 'b0;
    match <= 'b0;
    o <= 'b0;
  end else begin
    RACK <= current_data;
    match <= getMatch;
    o <= i;
  end

endmodule


