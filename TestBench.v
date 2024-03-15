module PWM_Test;

	// Inputs
	reg clk;

	// Outputs
	wire [7:0] pwm;

	// Instantiate the Unit Under Test (UUT)
	PWM_Gen uut (
		.clk(clk), 
		.pwm(pwm)
	);

	initial begin
		// Initialize Inputs
		clk = 0;

		// Wait 100 ns for global reset to finish
		#10;
        
		// Add stimulus here
		#5000000 $finish;
	end
 always
 #1 clk=~clk;
endmodule
