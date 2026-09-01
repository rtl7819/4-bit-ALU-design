//For exhaustive testbench that checks all the cases we'll need 3 for loops
// they need to loop through 16*16 combinations of A&B and 8 combinations of alu_Sel
// So a total of 8*16*16 = 2048 test cases are to be checked

`timescale 1ns/1ns
`include "alu.v"

module alu4bit_ExhaustiveTb();
    reg [3:0] A, B;
    reg [2:0] alu_sel;
    wire [3:0] out;
    wire carryout;

    reg [3:0] Expected_out;
    reg Expected_carryout;

    integer i,j,k;
    integer errors;

    alu4bit DUT(
        .A(A), .B(B), .alu_sel(alu_sel) ,
        .result(out) , 
        .cout(carryout)
    );

    initial begin
        
        errors = 0;
        
        //Testing all ALU operations
        for(i = 0; i < 8 ; i = i+1) begin
            //Testing all inputs of A & B
            for ( j = 0 ; j < 16 ; j = j+1 ) begin
                for(k = 0 ; k < 16 ; k = k+1) begin
                    alu_sel = i ;
                    A = j ;
                    B = k;

                    #5 ; // Waiting for the combinational dut to respond

                    case(alu_sel) 
                        3'b000 : begin
                            {Expected_carryout , Expected_out } = A + B;
                        end
                        3'b001 : begin
                            Expected_out = A - B;
                            Expected_carryout = 1'b0;
                        end
                        3'b010 : begin
                            Expected_out = A & B;
                        end
                        3'b011 : begin
                            Expected_out = A | B;
                        end
                        3'b100 : begin
                            Expected_out = A ^ B;
                        end
                        3'b101 : begin
                            Expected_out = ~ A;
                        end
                        3'b110,3'b111 : begin
                            Expected_out = 4'b0000;
                            Expected_carryout = 1'b0;
                        end
                    endcase

                    if((out !== Expected_out) || (carryout !== Expected_carryout)) begin
                        errors = errors + 1;
                        $display( "FAIL: A=%d B=%d SEL=%b | Expected: result=%b cout=%b | Got: result=%b cout=%b", A, B, alu_sel, Expected_out, Expected_carryout, out, carryout );
                    end
                end
            end
        end
        if(errors == 0) begin
            $display("--------------------");
            $display("ALL tests passed");
            $display("--------------------");
        end
        else begin
            $display("--------------------");
            $display("TEST FAILED: %d errors", errors);
            $display("--------------------");
        end

        $finish;

    end
endmodule
