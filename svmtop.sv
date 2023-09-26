module SVM_TOP(input mClk,mResetn,
input [1:0]Opc,
input [8:0]Xtest,
output signed [1:0]Class
    );
	 
	 wire [8:0]alFa;
	 wire [8:0]xSv;
	 wire signed [1:0]ySv;
	 wire dOne;
	 wire [6:0]Count;
	 wire [8:0]AlphaOut,Xsupvec;
	 wire signed [1:0]Ysupvec;
	 
SVM_TRAINER svm_unit_1(.CLK(mClk),.RESETN(mResetn),.Alpha(alFa),.X_SV(xSv),.Y_SV(ySv),.DONE(dOne));
output_Mem outmem_unit_1(.alphA(alFa),.xSVec(xSv),.ySVec(ySv),.opcode(Opc),.clk(mClk),.resetn(mResetn),.done(dOne),.count(Count),.alpha_out(AlphaOut),.xsv_out(Xsupvec),.ysv_out(Ysupvec));
Classifier classify_U1(.alpha_sv(AlphaOut),.X_test(Xtest),.X_sv(Xsupvec),.Y_sv(Ysupvec),.clk(mClk),.resetn(mResetn),.class(Class));
endmodule
