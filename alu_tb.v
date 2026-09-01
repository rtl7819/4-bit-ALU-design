`timescale 1ns/1ns
`include "alu.v"

module alu4bit_tb ();
    reg [3:0] A, B;
    reg [2:0] alu_sel;
    wire [3:0] out;
    wire carryout;

    alu4bit DUT(
        .A(A), .B(B), .alu_sel(alu_sel) ,
        .result(out) , 
        .cout(carryout)
    );

    initial begin
        $monitor("Time = %0t | A = %b | B = %b | Opcode = %b | Result = %b | Cy = %b",$time , A, B, alu_sel, out , carryout);

        //addition
        A = 4'b1001;
        B = 4'b1010;
        alu_sel = 3'b000; // at every iteration, whenever we give i/p we must give opcode to the ALU as well!!
        #10;
        A = 4'b1100;
        B = 4'b0010;
        alu_sel = 3'b000;
        #10;

        //subtration
         A = 4'b1001;
        B = 4'b1010;
        alu_sel = 3'b001; // at every iteration, whenever we give i/p we must give opcode to the ALU as well!!
        #10;
        A = 4'b1100;
        B = 4'b0010;
        alu_sel = 3'b001;
        #10;

        //AND
         A = 4'b1001;
        B = 4'b1010;
        alu_sel = 3'b010; // at every iteration, whenever we give i/p we must give opcode to the ALU as well!!
        #10;
        A = 4'b1100;
        B = 4'b0010;
        alu_sel = 3'b010;
        #10;

        //OR
         A = 4'b1001;
        B = 4'b1010;
        alu_sel = 3'b011; // at every iteration, whenever we give i/p we must give opcode to the ALU as well!!
        #10;
        A = 4'b1100;
        B = 4'b0010;
        alu_sel = 3'b011;
        #10;

        //XOR
         A = 4'b1001;
        B = 4'b1010;
        alu_sel = 3'b100; // at every iteration, whenever we give i/p we must give opcode to the ALU as well!!
        #10;
        A = 4'b1100;
        B = 4'b0010;
        alu_sel = 3'b100;
        #10;

        //NOT
         A = 4'b1001;
        B = 4'b1010;
        alu_sel = 3'b101; // at every iteration, whenever we give i/p we must give opcode to the ALU as well!!
        #10;
        A = 4'b1100;
        B = 4'b0010;
        alu_sel = 3'b101;
        #10;

        //INVALID case test
         A = 4'b1001;
        B = 4'b1010;
        alu_sel = 3'b111; // at every iteration, whenever we give i/p we must give opcode to the ALU as well!!
        #10;
        A = 4'b1100;
        B = 4'b0010;
        alu_sel = 3'b110;
        #10;

        $finish;
    end
endmodule
