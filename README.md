# 課程：計算機結構 -- 筆記、習題與報告

## 期中

### 第二章的ALU是參考自老師的版本 (先看一遍程式碼在自己打)

![image](https://github.com/weichen11011/co111a/blob/main/5.png)

    // zx
    Mux16(a = x, b[0..15] = false, sel = zx, out = ozx);

    // nx
    Not16(in = ozx, out = nnx);
    Mux16(a = ozx, b = nnx, sel = nx, out = exx);

    // zy
    Mux16(a = y, b[0..15] = false, sel = zy, out = ozy);

    // ny
    Not16(in = ozy, out = nny);
    Mux16(a = ozy, b = nny, sel = ny, out = exy);

    // f
    Add16(a = exx, b = exy, out = xplusy);
    And16(a = exx, b = exy, out = xandy);
    Mux16(a = xandy, b = xplusy, sel = f, out = fxy);

    //no
    Not16(in = fxy, out = nfxy);
    Mux16(a = fxy, b = nfxy, sel = no, out[0..7] = ret0, out[8..14] = ret1, out[15] = retsign, out = out);

    //zr
    Or8Way(in[0..7] = ret0, out = ret0is0);
    Or8Way(in[0..6] = ret1, in[7] = retsign, out = ret1is0);

    Or(a = ret0is0, b = ret1is0, out = yzr);
    Not(in = yzr, out = zr);
    
    //ng
    And(a = retsign, b = true, out = ng);
    
if (zx == 1) set x = 0        // 16-bit constant

if (nx == 1) set x = !x       // bitwise not

if (zy == 1) set y = 0        // 16-bit constant

if (ny == 1) set y = !y       // bitwise not

if (f == 1)  set out = x + y  // integer 2's complement addition

if (f == 0)  set out = x & y  // bitwise and

if (no == 1) set out = !out   // bitwise not

if (out == 0) set zr = 1

if (out < 0) set ng = 1

此為ALU輸出分別代表的意思

### 第三章pc (第三章不會的部分都是去這個網址參考上面的圖) https://nand2tetris-hdl.github.io/ 

    Inc16(in=loop,out=pc);
    Mux16(a=loop,b=pc,sel=inc,out=muxa);
    Mux16(a=muxa,b=in,sel=load,out=loadb);
    Mux16(a=loadb,b=false,sel=reset,out=cout);
    Register(in=cout,load=true,out=out,out=loop);
    

![image](https://github.com/weichen11011/co111a/blob/main/image.png)

inc16 為16位元遞增器，能使整個電路為1。第一個是在控制這個迴圈電路，後面兩個Mux分別是決定要寫入還是要重製。如果有要寫入的值會傳給Reg然後這裡的load設為true代表一定會寫入，之後再將值輸出然後再繼續回到迴圈。

### 第四章mult 

A指令:
為16位元的二進制表示 Ex: @21

C指令:
包含comp,dest,jump的使用 

comp [6:12] 決定暫存器和運算

dest [3:5] 決定存在哪裡

jump [0:2] 決定運算結果和0的條件判斷，跳轉位置須提前存在A暫存器

https://github.com/davidsmithmke/nand2tetris-project4/blob/master/mult/Mult.asm

### 第五章是照著影片的教學一步步寫出來的
影片網址: 
1. https://www.youtube.com/watch?v=CBeVn-RSavk 這個是CPU的
2. https://www.youtube.com/watch?v=ckYSlJtpXaE&t=4s 這個是memory的

![image](https://github.com/weichen11011/co111a/blob/main/%E8%9E%A2%E5%B9%95%E6%93%B7%E5%8F%96%E7%95%AB%E9%9D%A2%202022-12-29%20102543.png)


### CPU
![image](https://github.com/weichen11011/co111a/blob/main/2.PNG)
![image](https://github.com/weichen11011/co111a/blob/main/3.PNG)

    //registerA
    ARegister(in=ina, load=loada, out=outa, out[0..14]=addressM);

    //registerD
    DRegister(in=outALU, load=loadd, out=outd);
    
1.如何選定為A記憶體

先從instruction[15]開始看，如果為A instruction 在16的位置的值就為0，相反就是C instruction。程式碼上的insta和instc就是在判斷是要使用A指令還是C指令，instc = instruction[15]。

        //insta
        Not(in=instruction[15], out=insta);

        //loada 
        And(a=instc, b=instruction[5], out=desta);
        Or(a=insta, b=desta, out=loada);
        
        //loadd
        And(a=instruction[15], b=instruction[4], out=loadd);

        //loadpc
         //JGT
         Not(in=insta, out=instc);
         
當instruction[5]=1的時候，會寫入A暫存器，instruction[4]則是在判斷D暫存器的。所以當instruction[15]=1和instruction[4]=1時，代表是使用C指令，然後寫入D暫存器。

    //insta
    //Am to ALU
    And(a=instc, b=instruction[12], out=amtoalu);

    //ALU
    ALU(x=outd, y=outam, zx=instruction[11], nx=instruction[10], zy=instruction[9], ny=instruction[8], f=instruction[7], no=instruction[6], out=outM, out=outALU ,zr=zr, ng=ng);
    
再往下寫就需要用到ALU out出來的值zr和ng，也會將outM 輸出，控制ALU的寫入是instruction[12]，所以要使用instc。

         //JGT
         Not(in=insta, out=instc);
         //zr ng
         Or(a=zr, b=ng, out=outzr);
         Not(in=outzr, out=post);
         And(a=instruction[0], b=post, out=JGT);

         //JEQ
         And(a=instruction[1], b=zr, out=JEQ);

         //JLT
         And(a=instruction[2], b=ng, out=JLT);

         //JGE
         Or(a=JGT, b=JEQ, out=JGE);

         //JNE
         Or(a=JLT, b=JGT, out=JNE);

         //JLE
         Or(a=JEQ, b=JLT, out=JLE);

         //JMP
         Or(a=JGT, b=JLE, out=JMP);

         //Nested Or structure
         Or(a=JGT, b=JEQ, out=j1);
         Or(a=JLT, b=j1, out=j2);
         Or(a=JGE, b=j2, out=j3);
         Or(a=JNE, b=j3, out=j4);
         Or(a=JLE, b=j4, out=j5);
         Or(a=JMP, b=j5, out=j6);

         And(a=instc, b=j6, out=loadpc);
        
zr 為 out=0時，zr就為0，其他都為1， ng 就是當 out<0 時為0，其餘皆為1。在C指令再決定要不要跳出的值為instruction[1][2][3]，最基本的就是JGT(>0)，JEQ(0)，JLT(<0)，分別在instruciton[1][2][3] = 1 的時候。剩下的指令就是基本的再做延伸，比較特別的是JMP是無條件跳出。下面的Nested Or structure 就是在判斷上述的指令有沒有為1的然後跳出，跳轉前須提前存在A暫存器，當J6也為1的時候，就會跑PC的部分。

    //pc
    PC(in=outa, load=loadpc, inc=true, reset=reset, out[0..14]=pc);
    
inc 設為true 就是不管怎麼樣都會寫入。    

## Memory

![image](https://github.com/weichen11011/co111a/blob/main/4.PNG)

![image](https://github.com/weichen11011/co111a/blob/main/%E8%9E%A2%E5%B9%95%E6%93%B7%E5%8F%96%E7%95%AB%E9%9D%A2%202022-12-29%20102639.png)

    //load dmux
    DMux4Way(in= load, sel= address[13..14], a=ramloada, b=ramloadb, c=screenload);
    Or(a=ramloada, b=ramloadb, out=ramload);

    //memory
    RAM16K(in = in,load = ramload, address = address[0..13] , out = ramout);
    Screen(in = in,load = screenload, address = address[0..12], out = screenout);
    Keyboard(out = kbd);

    //output mux
    Mux4Way16(a=ramout, b=ramout, c=screenout, d=kbd, sel=address[13..14], out=out);

因為Memory有分0(00)，16K(10)，24K(11) Dmux的作用就在於要選擇哪一個，如果address[13..14]的組合有1的出現就寫入RAM16K，沒有則寫入Screen。Keyboard和Screen都是一開始就給的，最用再用Mux將每個的值輸出。

## 期末 
#### 邏輯閘程式碼除 *ALU* 修改自老師的專案 其餘皆改寫自期中所做的1~5章習題
#### 測試程式 ALU_test.v Computer_test.v gates16_test.v PC_test.v DFF RAM16K_test.v sum.hack DFF 修改自老師的專案

  * 2022/12/10 第一章完成
  * 2022/12/11 第二章完成
  * 2022/12/15 第三章除PC外完成
  * 2022/12/17 第五章和PC完成
  
### 操作

iverilog -o 檔案名稱 執行程式
vvp 檔案名稱


通常會將所有元件寫在同一個檔案，然後再寫各自元件的測試檔案。
此為一個簡單的原件寫法

        module(input,output)
             內容
        endmodule

Mux測試程式

    `include "./mux.v"

    module main;
        reg[15:0] a,b,c,d,e,f,g,h;
        reg[2:0] sel;
        wire[15:0] mux, mux4, mux8;

        Mux16 g1(a,b,sel[0],mux);
        Mux4Way16 g2(a,b,c,d,sel[1:0],mux4);
        Mux8Way16 g3(a,b,c,d,e,f,g,h,sel[2:0],mux8);

        initial 
        begin
            $monitor("%4dns sel =%d mux =%x mux4 =%x mux8 =%x",$stime,sel,mux,mux4,mux8);
            a =16'h0;
            b =16'h1;
            c =16'h2;
            d =16'h3;
            e =16'h4;
            f =16'h5;
            g =16'h6;
            h =16'h7;
            sel =0; 
        end

        always #50 begin
            sel = sel+1;
        end

        initial #500 $finish;
    endmodule

一開始會先設好要輸入的值，線路跟輸出的部分。測試的時候是使用類似迴圈的概念，一直跑到finish出現，有設一個類似時序的管控，當到達指定的數字時會做裡面的指令或停止。

寫元件的邏輯跟hdl檔的思維差不多，但線路的部分需要設wire才能連上，和多加了測試程式。


### 心得
在修這堂課以前，從來沒想過CPU的組成是由一大堆的基本邏輯閘慢慢堆疊出來的，也沒想過每個邏輯閘的用途。然而在這堂課中，將當初在數位邏輯學到的知識學以致用，用程式將邏輯閘的輸入輸出表示出來。不同於在書本上的學習，自己實做出來的印象反而更加的印象深刻。從最簡單、基礎的邏輯閘到最後成功做出CPU，獲得的成就感也很多，雖然從hdl語法轉到verilog之間，遇到了很多問題，主要還是兩者的邏輯還是稍微有點差異，讓我卡住了一段時間，但最難的還是測試，不像之前丟進程式自己跑就好，而是要自己想出如何測試才是正確的，雖然有時候會做到很崩潰，但總體來說還是很有趣的。

### 問題
1. 在寫PC的時候，register一直無法存入資料，困擾了我很久。最後，在跟老師討論後才發現，我將true和false的寫法記錯了，覺得特別好笑，被這個小問題綁住了這麼久。
2. RAM跑不出來
3. 有時候會忘記寫線路
4. CPU  
  
