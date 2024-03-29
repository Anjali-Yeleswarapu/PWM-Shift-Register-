module PWM_Gen(
					input clk,
					output [7:0] pwm
					 );

reg [7:0] counter = 0;
reg [2:0] i = 0 ;
integer duty_val[0:7];
reg ShiftBuff[0:7]; 

initial
begin
	duty_val[0] = 10;
	duty_val[1] = 20;
	duty_val[2] = 30;
	duty_val[3] = 40;
	duty_val[4] = 50;
	duty_val[5] = 60;
	duty_val[6] = 70;
	duty_val[7] = 80;
end

initial
begin
	ShiftBuff[0] = 0;
	ShiftBuff[1] = 0;
	ShiftBuff[2] = 0;
	ShiftBuff[3] = 0;
	ShiftBuff[4] = 0;
	ShiftBuff[5] = 0;
	ShiftBuff[6] = 0;
	ShiftBuff[7] = 0;
end


reg latch = 0;
reg reset = 0;
reg S_in = 0;


always @(posedge clk) 
begin

	if(counter<100) counter <= counter + 1;
	else counter <= 0;	
	
end

//assign pwm = (counter<20)?1:0 ; 

ShiftReg Shft (clk,latch,reset,S_in,pwm);

always @(negedge clk)
begin
	if(counter<duty_val[i])
	S_in=1;
	else
	S_in=0;
	
	i = i+1 ; 
	
	if(i==0)
		begin
		latch=1;
		#1 latch=0;
		end	
end
endmodule


module ShiftReg(
    input clk,
	 input latch,
	 input reset,
	 input d0,
	 output reg [7:0] D_O
	 );

reg [7:0] D;
initial
	begin
	D=8'b0;
	D_O=8'b0;
	end
always @(posedge clk)
	begin
		if(reset==1)
			begin
			D <= 8'b0;
			D_O <= 8'b0;
			end
		else
			begin
						D[0]<=d0;
						D[1]<=D[0];
						D[2]<=D[1];
						D[3]<=D[2];
						D[4]<=D[3];
						D[5]<=D[4];
						D[6]<=D[5];
						D[7]<=D[6];
			end
	end
always @(posedge latch)
begin
D_O <= D ;
end
endmodule
