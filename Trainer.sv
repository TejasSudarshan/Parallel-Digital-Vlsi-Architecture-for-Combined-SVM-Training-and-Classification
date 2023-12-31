module SVM(input clk,resetn,
input [8:0]X_train,Xsv,
input [8:0]C,Alpha_in,Alpha_data,
input signed [1:0]Y_train,Ysv,
output [8:0]Alpha,
output [8:0]X_SV,
output DONE,
output signed [1:0]Y_SV
    );
Gradient_Ascent GA(.Clk(clk),.Resetn(resetn),.x_train(X_train),.x_sv(Xsv),.y_train(Y_train),.y_sv(Ysv),.c(C),.alpha(Alpha),.alpha_in(Alpha_in),.alpha_data(Alpha_data));
SVEC SV(.ALFA(Alpha),.x_Train(X_train),.y_Train(Y_train),.XSV(X_SV),.YSV(Y_SV),.Done(DONE));
endmodule
