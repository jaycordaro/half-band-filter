/* BSD 2-Clause License

Copyright (c) 2023 Jay Cordaro
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. */

module hb_filter(input logic clk,
				 input logic reset_n,
				 input logic signed [15:0] x_in,    
				 output logic signed [15:0] y_out
				 );
				 
	logic signed [15:0] x_in_reg;
	
	logic signed [15:0] taps [26:0];  // a 27-tap FIR filter
	logic signed [30:0] sum;
	
	logic signed [30:0] y;
	
	logic signed [30:0] p0, p1, p2, p3, p4, p5, p6; // partial sums
	
	const logic signed [15:0] w0 =    459;
	const logic signed [15:0] w2 =   -484;
	const logic signed [15:0] w4 =    749;
	const logic signed [15:0] w6 =  -1154;
	const logic signed [15:0] w8 =   1834;
	const logic signed [15:0] w10 = -3323;
	const logic signed [15:0] w12 = 10377;
	const logic signed [15:0] w13 = 16383;
	
	logic outcount;
	
	always_ff @(posedge clk or negedge reset_n) begin
		if (~reset_n) begin
			x_in_reg <= 16'b0000000000000000;
		end else begin
			x_in_reg <= x_in;
		end
	end
	
	always_ff @(posedge clk or negedge reset_n) begin
		if (~reset_n) begin
		  taps <= '{default: 16'b0000000000000000};
		end else begin
		  taps <= {taps[25:0], x_in};
		end
	end
	
  always_comb begin
    // compute the products of symmetric coefficients and register values
    p0 = w0 *( taps[0] + taps[26]);
    p1 = w2 *( taps[2] + taps[24]);
    p2 = w4 *( taps[4] + taps[22]);
    p3 = w6 *( taps[6] + taps[20]);
    p4 = w8 *( taps[8] + taps[18]);
    p5 = w10*(taps[10] + taps[16]);
    p6 = w12*(taps[12] + taps[14]);
    // compute the dot product of coefficients and register values
    sum = p0 + p1 + p2 + p3 + p4 + p5 + p6 + w13*taps[13];
    y = sum; // assign output
  end
  
   
    
    always_ff @(posedge clk or negedge reset_n) begin
		if (~reset_n) begin
			y_out <=0;
			outcount <= 0;

		end else if (outcount == 1 ) begin
			outcount <=0;
			y_out <= y >> 15;

		end else begin
			outcount <= outcount + 1;

		end
	end
  

endmodule
