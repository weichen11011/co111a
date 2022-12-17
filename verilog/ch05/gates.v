`include "../ch03/gates.v"

module Memory(input[15:0] in, input clock,load ,input[14:0] address, output[15:0] out);
    wire[15:0] ram16Kout, screenout, Keyboardout;
    wire ramload;
    //choose
    Dmux4Way g1(load, address[14:13],a,b,c,d);
    Or g2(a,b,ramload);

    //memory
    RAM16K g3(in,clock,ramload,address[13:0],ram16Kout);
    RAM8K  screen(in,clock,c,address[12:0],screenout);
    Register keyboard(16'h0F0F,clock,1'b0,Keyboardout);

    //output
    Mux4Way16 g4(ram16Kout,ram16Kout,screenout,Keyboardout,address[14:13],out);

endmodule

module CPU(input[15:0] inM,instruction,input clock,reset,output[15:0] outM, output writeM, output[14:0] addressM,pc);
    wire[15:0] outALU,outam,outregisterA,outregisterD,ina,outpc;

    //register A
    Register A(ina,clock,loada,outregisterA);
    assign addressM = outregisterA[14:0];

    //register D
    Register D(outALU,clock,loadd,outregisterD);

    //ALU
    ALU g1(outregisterD,outam,instruction[11],instruction[10],instruction[9],instruction[8],instruction[7],
    instruction[6],outALU,zr,ng);
    And16 g28(outALU,outALU,outM);

    //Mux
    Mux16 g2(outALU,instruction,insta,ina);
    Mux16 g3(outregisterA,inM,amtoalu,outam);

    //pc
    PC g4(outregisterA,clock,loadpc,1'b1,reset,outpc);
    assign pc = outpc[14:0];

    //decoder
        //insta
        Not g5(instruction[15],insta);

        //loada
        And g6(instc,instruction[5],desta);
        Or g7(insta,desta,loada);

        //loadpc
            //JGT
            Not g8(insta,instc);
            //zr ng
            Or g9(zr,ng,outzr);
            Not g10(outzr,post);
            And g11(instruction[0],post,jgt);
            //JEQ
            And g12(instruction[1],zr,jeq);
            //JLT
            And g13(instruction[2],ng,jlt);
            //JGE
            Or g14(jgt,jeq,jge);
            //JNE
            Or g15(jlt,jgt,jne);
            //JLE
            Or g16(jeg,jlt,jle);
            //JMP
            Or g17(jgt,jle,jmp);

            //Nested or structure
            Or g18(jlt,jeq,j1);
            Or g19(jlt,j1,j2);
            Or g20(jge,j2,j3);
            Or g21(jne,j3,j4);
            Or g22(jle,j4,j5);
            Or g23(jmp,j5,j6);

            And g24(instc,j6,loadpc);

        //insta
        And g25(instc,instruction[12],amtoalu);

        //loadam
        And g26(instc,instruction[3],loadam);
        And g27(instc,instruction[3],writeM);    
endmodule

module Computer(input clock,reset);
    wire[15:0] I,out,outM;
    wire[14:0] addressM,pc;
    ROM32K g1(pc,I);
    CPU g2(out,I,clock,reset,outM,writeM,addressM,pc);
    Memory g3(outM,!clock,writeM,addressM,out);
endmodule