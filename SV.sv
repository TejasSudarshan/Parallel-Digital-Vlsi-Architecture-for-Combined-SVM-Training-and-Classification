module SVEC(input [8:0]ALFA,
input [8:0]x_Train,
input signed [1:0]y_Train,
output reg [8:0]XSV,
output reg signed [1:0]YSV,
output reg Done
    );
always @(*)
begin
if(ALFA > 0)
		begin
			XSV = x_Train;
			YSV = y_Train;
			Done = 1;
		end
		else
		begin
			XSV = 9'b000000000;
			YSV = 0;
			Done = 0;
		end
end

endmodule
