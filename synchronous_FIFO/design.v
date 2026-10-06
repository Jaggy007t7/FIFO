`timescale 1ns/1ps

module fifo #(
	parameter fifo_depth=16,
	parameter data_width = 8
)(
	input wire clk,rst,   // synchronous reset;
	input wire [data_width-1:0]data_in,
	input wire read, write,
	output wire [data_width-1:0]data_out,
	output wire full,empty
);

reg [data_width-1:0]fifo[0:fifo_depth-1];
reg [data_width-1:0]f_data_out;
// Pointers:-
reg [$clog2(fifo_depth)-1 : 0]rd_ptr, wr_ptr;

always @(posedge clk )begin 
	if(rst)begin 
		f_data_out <= 0;
		rd_ptr <= 0;
		wr_ptr <= 0;
	end
	else begin 
		if(write && (wr_ptr + 1'b1 != rd_ptr))begin 
			fifo[wr_ptr] <= data_in;
			wr_ptr <= wr_ptr+1'b1;
		end

		if(read && (wr_ptr != rd_ptr))begin 
			f_data_out <= fifo[rd_ptr];
			rd_ptr <= rd_ptr+1'b1;
		end
			
	end
end
assign full = (wr_ptr + 1'b1 == rd_ptr)? 1'b1 : 1'b0;
assign empty = (wr_ptr == rd_ptr) ? 1'b1 : 1'b0;
assign data_out = f_data_out;

endmodule
