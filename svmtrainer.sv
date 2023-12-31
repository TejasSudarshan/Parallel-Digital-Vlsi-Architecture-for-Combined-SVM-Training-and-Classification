module SVM_TRAINER(input CLK,RESETN,
output [8:0]Alpha,
output [8:0]X_SV,
output signed [1:0]Y_SV,
output DONE
    );

wire [8:0]X_training,Xsvec;
wire Cm,AlphaIn,AlphaData;
wire signed [1:0]Y_training,Ysvec;

Data_Mem MMU1(.clk(CLK),.resetn(RESETN),.X_train(X_training),.Xsv(Xsvec),.C(Cm),.Alpha_in(AlphaIn),.Alpha_data(AlphaData),.Y_train(Y_training),.Ysv(Ysvec));
SVM TRAINER(.clk(CLK),.resetn(RESETN),.X_train(X_training),.Xsv(Xsvec),.C(Cm),.Alpha_in(AlphaIn),.Alpha_data(AlphaData),.Y_train(Y_training),.Ysv(Ysvec),.Alpha(Alpha),.X_SV(X_SV),.DONE(DONE),.Y_SV(Y_SV));

endmodule
