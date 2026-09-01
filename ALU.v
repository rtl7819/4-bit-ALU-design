module alu4bit (
    output reg [3:0] result,
    output reg cout,
    input [3:0] A,
    input [3:0] B,
    input [2:0] alu_sel
);
    always @(*) begin // it is more standard to put * in sensitivity list than (A or B or alu_sel)
        //As cout is not present in every case, it may hold on to its value and create a latch in synthesis
        // Hence we need to initialise cout & result with 0 everytime at starting, else they'll create a latch
        result = 4'b0000;
        cout = 1'b0;

        case (alu_sel)
            3'b000: begin
                {cout , result} = A + B;
            end
            3'b001: begin
               // { cout , result } = A - B; There's no need for cout in subtraction
               result = A - B;
            end
            3'b010 : begin
                result = A & B;
            end
            3'b011 : begin
                result = A | B ;
            end
            3'b100 : begin
                result = A ^ B;
            end
            3'b101 : begin
                result = ~A;
            end
          //  default: result = 4'bxxxx; x is useful for synthesis but for real implementation, default case needs to be deterministic 
          default : result = 4'b0000;
        endcase
    end
endmodule
