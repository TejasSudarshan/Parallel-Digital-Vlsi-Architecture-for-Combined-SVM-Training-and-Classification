module Data_Mem(input clk,resetn,
output [8:0]X_train,Xsv,
output [8:0]C,Alpha_in,Alpha_data,
output signed [1:0]Y_train,Ysv
/*output [8:0]Alphaa,X_SV_O,
output [1:0]Y_SV_O,
output DONE_O*/
    );

reg signed [8:0]data_mem[0:99];
reg [8:0]alpha_mem[0:49];
reg [7:0]i_reg,i_nex;
reg [6:0]a_reg,a_nex;
reg [8:0]xt_reg,xt_nex,xsv_reg,xsv_nex,ai_reg,ai_nex,ad_reg,ad_nex;
reg signed [1:0]yt_reg,yt_nex,ysv_reg,ysv_nex;

//SVM TRAINER(.clk(clk),.resetn(resetn),.X_train(xt_reg),.Xsv(xsv_reg),.C(9'b000010100),.Alpha_in(ai_reg),.Alpha_data(ad_reg),.Y_train(yt_reg),.Ysv(ysv_reg),.Alpha(Alphaa),.X_SV(X_SV_O),.DONE(DONE_O),.Y_SV(Y_SV_O));


initial begin
$readmemb("XYTrain.mem",data_mem);
//$readmemh("alpha_memory.txt",alpha_mem);
end

initial begin
alpha_mem[0] = 0;
alpha_mem[1] = 5;
alpha_mem[2] = 1;
alpha_mem[3] = 20;
alpha_mem[4] = 0;
alpha_mem[5] = 1;
alpha_mem[6] = 0;
alpha_mem[7] = 0;
alpha_mem[8] = 0;
alpha_mem[9] = 0;
alpha_mem[10] = 0;
alpha_mem[11] = 1;
alpha_mem[12] = 2;
alpha_mem[13] = 4;
alpha_mem[14] = 5;
alpha_mem[15] = 7;
alpha_mem[16] = 3;
alpha_mem[17] = 15;
alpha_mem[18] = 1;
alpha_mem[19] = 0;
alpha_mem[20] = 0;
alpha_mem[21] = 0;
alpha_mem[22] = 0;
alpha_mem[23] = 0;
alpha_mem[24] = 0;
alpha_mem[25] = 1;
alpha_mem[26] = 2;
alpha_mem[27] = 3;
alpha_mem[28] = 5;
alpha_mem[29] = 1;
alpha_mem[30] = 0;
alpha_mem[31] = 0;
alpha_mem[32] = 0;
alpha_mem[33] = 9;
alpha_mem[34] = 0;
alpha_mem[35] = 0;
alpha_mem[36] = 0;
alpha_mem[37] = 0;
alpha_mem[38] = 0;
alpha_mem[39] = 20;
alpha_mem[40] = 1;
alpha_mem[41] = 1;
alpha_mem[42] = 1;
alpha_mem[43] = 1;
alpha_mem[44] = 0;
alpha_mem[45] = 1;
alpha_mem[46] = 0;
alpha_mem[47] = 0;
alpha_mem[48] = 0;
alpha_mem[49] = 3;
end

always @(posedge clk)
begin
if(~resetn)
begin
i_reg <= 0;
xt_reg <= 0;
yt_reg <= 1;
xsv_reg <= 0;
ysv_reg <= 1;
a_reg <= 0;
ai_reg <= 0;
ad_reg <= 0;
end
else
begin
i_reg <= i_nex;
xt_reg <= xt_nex;
yt_reg <= yt_nex;
xsv_reg <= xsv_nex;
ysv_reg <= ysv_nex;
a_reg <= a_nex;
ai_reg <= ai_nex;
ad_reg <= ad_nex;
end
end

always @(i_reg,a_reg,ai_reg,ad_reg,xt_reg,yt_reg,xsv_reg,ysv_reg)
begin
	if(i_reg < 100)
	begin
		if(a_reg < 50)
		begin
			ai_nex = alpha_mem[a_reg];
			ad_nex = alpha_mem[a_reg + 1];
			a_nex = a_reg + 2;
		end
		else
		begin
			xt_nex = data_mem[i_reg];
			yt_nex = data_mem[i_reg + 1];
			xsv_nex = data_mem[i_reg + 2];
			ysv_nex = data_mem[i_reg + 3];
			i_nex = i_reg + 4;
			a_nex = 0;
			ai_nex = 0;
			ad_nex = 0;
		end
	end
	else
	begin
		i_nex = 0;
		xt_nex = 0;
		yt_nex = 1;
		xsv_nex = 0;
		ysv_nex = 1;
	end
end


assign C = 20;
assign X_train = xt_reg;
assign Y_train = yt_reg;
assign Xsv = xsv_reg;
assign Ysv = ysv_reg;
assign Alpha_in = ai_reg;
assign Alpha_data = ad_reg;




endmodule
