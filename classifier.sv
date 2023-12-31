module Classifier(input [8:0]alpha_sv,
input [8:0]X_test,X_sv,
input signed [1:0]Y_sv,
input clk,resetn,
output signed [1:0]class
    );

reg [6:0]i_reg,i_nex;
reg signed [1:0]class_reg,class_nex;
reg [47:0]fx_reg,fx_nex;
	
	function [37:0]Kernel;
	input [8:0]a,b;
		Kernel =(a*b + 1)*(a*b + 1);
	 endfunction
	 
	 always @(posedge clk)
	 begin
	 if(~resetn)
	 begin
		class_reg <= 0;
		fx_reg <= 0;
		i_reg <= 0;
		end
	 else
	 begin
		class_reg <= class_nex;
		fx_reg <= fx_nex;
		i_reg <= i_nex;
		end
	 end
	 
	 always @(*)
	 begin
	 if(i_reg < 100)
	 begin
		fx_nex = fx_reg + alpha_sv*Y_sv*Kernel(X_test,X_sv);
		i_nex = i_reg + 1;
	end
	 else
	 begin
	 i_nex = 0;
	 fx_nex = 0;
	 if(fx_reg > 0)
			class_nex = 1;
		else
			class_nex = -1;
	 end
	 end
	 
	 assign class = class_reg;
	 

endmodule
