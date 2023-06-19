`timescale 1ns / 1ps

module hb_filter_tb();
    
	logic clk;
	logic reset_n;

    logic signed [15:0] A; //register declaration for storing each line of file.
	logic signed [15:0] B;
	logic signed [15:0] hb_1_out;

    integer outfile0,outfile1; //file descriptors
	int c, d;

	hb_filter hb_filter_inst1(
		.clk			(clk),
		.reset_n		(reset_n),
		.x_in			(A),    
		.y_out			(hb_1_out)
	);
	
	always begin 
	#10 clk = ~clk;
	end
	
initial begin
    #1 reset_n=1'b0;
	#9 clk = 1'b0;
	#1 reset_n= 1'b1;
	
    $display("starting simulation");
	$display($time, " << half band filter simulation>>");
	
    //The $fopen function opens a file and returns a multi-channel descriptor 
    //in the format of an unsized integer. 
    outfile0=$fopen("inputs.txt","r");   //"r" means reading and "w" means writing
    outfile1=$fopen("outputs.txt","r");

	
    //read the contents of the file A_hex.txt as hexadecimal values into register "A".
	while (!$feof(outfile0)) begin
	     @(negedge clk) begin
			c = $fscanf(outfile0,"%d",A);
			d = $fscanf(outfile1,"%d",B);
			$display("INPUT:%d <<< -- >>> OUTPUT:%d  ACTUAL OUTPUT:%d",A,B,hb_1_out);
		 end
	  
      end
    //once reading and writing is finished, close all the files.
    $fclose(outfile0);
    $fclose(outfile1);

    //wait and then stop the simulation.
    #100;
    $stop;
end    
      
endmodule