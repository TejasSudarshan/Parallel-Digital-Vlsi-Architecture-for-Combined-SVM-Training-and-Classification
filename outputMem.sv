module output_Mem(input [8:0]alphA,
input [8:0]xSVec,
input signed [1:0]ySVec,
input [1:0]opcode,
input clk,resetn,done,
output [6:0]count,
output [8:0]alpha_out,
output [8:0]xsv_out,
output signed [1:0]ysv_out
    );
	 
	 reg signed [8:0]sv_mem[0:99];
	 reg [8:0]alf_mem[0:49];
	 reg [8:0]xs_nex,xs_cur;
	 reg [8:0]alfn,alfc;
	 reg signed [1:0]ys_nex,ys_cur;

parameter train = 2'b00,classify = 2'b01;

reg [6:0]j_reg,j_nex,cnt_reg,cnt_nex,a_reg,a_nex,jcn,jcr,acn,acr;
always @(posedge clk)
begin
if(~resetn)
begin
j_reg <= 0;
cnt_reg <= 0;
a_reg <= 0;
jcr <= 0;
acr <= 0;
xs_cur <= 0;
ys_cur <= 0;
alfc <= 0;
end
else
begin
j_reg <= j_nex;
cnt_reg <= cnt_nex;
a_reg <= a_nex;
jcr <= jcn;
acr <= acn;
xs_cur <= xs_nex;
ys_cur <= ys_nex;
alfc <= alfn;
end
end

always @(*)
begin
case(opcode)
train:begin
	if(j_reg < 100)
	begin
		if(done)
		begin
				sv_mem[j_reg] = xSVec;
				sv_mem[j_reg + 1] = ySVec;
				alf_mem[a_reg] = alphA;
				a_nex = a_reg + 1;
				j_nex = j_reg + 2;
				cnt_nex = cnt_reg + 1;
		end
		else
		begin
			sv_mem[j_reg] = 0;
			sv_mem[j_reg + 1] = 0;
			alf_mem[a_reg] = 0;
			a_nex = a_reg + 1;
			j_nex = j_reg + 2;
			cnt_nex = cnt_reg;
		end
	end
	else
	begin
	cnt_nex = 0;
	j_reg = 0;
	a_reg = 0;
	end
      end
classify:begin
				if(jcr < 100)
				begin
					xs_nex = sv_mem[jcr];
					ys_nex = sv_mem[jcr+1];
					jcn = jcr + 2;
					alfn = alf_mem[acr];
					acn = acr + 1;
				end
				else
				begin
					acn = 0;
					jcn = 0;
				end
	      end
endcase
end

assign alpha_out = alfc;
assign xsv_out = xs_cur;
assign ysv_out = ys_cur;

/*always @(*)
begin
alfn = alf_mem[];
xs_nex = sv_mem[];
ys_nex = sv_mem[];
end*/



assign count = cnt_reg;

endmodule
