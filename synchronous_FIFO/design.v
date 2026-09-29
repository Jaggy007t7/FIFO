`timescale 1ns/1ps

module fifo #(
	parameter fifo_depth=16,
	data_width = 8
)(
	input wire clk,rst,enable,   // synchronous reset;
	input wire [data_width-1:0]data_in,
	input wire read, write,
	output wire [data_width-1:0]data_out,
	output wire overflow,empty
);

reg [data_width-1:0]fifo[0:fifo_depth-1];
reg overflow,empty;
reg [data_width-1:0]f_data_out;
// Pointers:-
reg [$clog2(fifo_depth)-1 : 0]rd_ptr, wr_ptr,count;

always @(posedge clk )begin 
	if(enable == 0)begin 
		overflow <= 0;
		empty <= 0;
		f_data_out <= 0;
	end
	else begin 
		if(rst)begin 
			overflow <= 0;
			empty <= 0;
			f_data_out <= 0;
			rd_ptr <= 0;
	 		wr_ptr <= 0;
		end
		else begin 
			if(read) begin 
				data_out <= fifo[rd_ptr];
				if(rd_ptr == fifo_depth-1'b1)begin 
					rd_ptr <= 0;
				end 
				else begin 
					rd_ptr <= rd_ptr+1;
				end
			end

			if(write)begin 
				fifo[wr_ptr] <= data_in;
				if(wr_ptr == fifo_depth-1'b1)begin 
					wr_ptr <= 0;
				end 
				else begin 
					wr_ptr <= wr_ptr+1'b1;
				end
			end

			case({read,write})
				2'b00: 
				2'b01:
				2'b10:
				2'b11:
				default: 
			endcase
		end
	end
end

endmodule
