# 課程：計算機結構 -- 筆記、習題與報告

## 期中

第二章的ALU是參考自老師的版本

第三章pc https://nand2tetris-hdl.github.io/

![image](https://github.com/weichen11011/co111a/blob/main/image.png)

第四章mult https://github.com/davidsmithmke/nand2tetris-project4/blob/master/mult/Mult.asm

第五章是照著影片的教學一步步寫出來的
影片網址: 
1. https://www.youtube.com/watch?v=CBeVn-RSavk 這個是CPU的
2. https://www.youtube.com/watch?v=ckYSlJtpXaE&t=4s 這個是memory的

![image](https://github.com/weichen11011/co111a/blob/main/%E8%9E%A2%E5%B9%95%E6%93%B7%E5%8F%96%E7%95%AB%E9%9D%A2%202022-12-29%20102543.png)
![image](https://github.com/weichen11011/co111a/blob/main/%E8%9E%A2%E5%B9%95%E6%93%B7%E5%8F%96%E7%95%AB%E9%9D%A2%202022-12-29%20102639.png)

## CPU
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
         
當instruction[5]=1的時候，會寫入A記憶體，instruction[4]則是在判斷D記憶體的。所以當instruction[15]=1和instruction[4]=1時，代表是使用C指令，然後寫入D記憶體。

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
        
zr 為 out=0時，zr就為0，其他都為1， ng 就是當 out<0 時為0，其餘皆為1。在C指令再決定要不要跳出的值為instruction[1][2][3]，最基本的就是JGT(>0)，JEQ(0)，JLT(<0)，分別在instruciton[1][2][3] = 1 的時候。剩下的指令就是基本的再做延伸，比較特別的是JMP是無條件跳出。下面的Nested Or structure 就是在判斷上述的指令有沒有為1的然後跳出，當J6也為1的時候，就會跑PC的部分。

    //pc
    PC(in=outa, load=loadpc, inc=true, reset=reset, out[0..14]=pc);
    
inc 設為true 就是不管怎麼樣都會寫入。    



## 期末 
#### 邏輯閘程式碼除 *ALU* 修改自老師的專案 其餘皆改寫自期中所做的1~5章習題
#### 測試程式 ALU_test.v Computer_test.v gates16_test.v PC_test.v DFF RAM16K_test.v sum.hack 修改自老師的專案

  * 2022/12/10 第一章完成
  * 2022/12/11 第二章完成
  * 2022/12/15 第三章除PC外完成
  * 2022/12/17 第五章和PC完成
  
### 心得
在修這堂課以前，從來沒想過CPU的組成是由一大堆的基本邏輯閘慢慢堆疊出來的，也沒想過每個邏輯閘的用途。然而在這堂課中，將當初在數位邏輯學到的知識學以致用，用程式將邏輯閘的輸入輸出表示出來。不同於在書本上的學習，自己實做出來的印象反而更加的印象深刻。從最簡單、基礎的邏輯閘到最後成功做出CPU，獲得的成就感也很多，雖然從hdl語法轉到verilog之間，遇到了很多問題，主要還是兩者的邏輯還是稍微有點差異，讓我卡住了一段時間，但最難的還是測試，不像之前丟進程式自己跑就好，而是要自己想出如何測試才是正確的，雖然有時候會做到很崩潰，但總體來說還是很有趣的。

### 問題
1. 在寫PC的時候，register一直無法存入資料，困擾了我很久。最後，在跟老師討論後才發現，我將true和false的寫法記錯了，覺得特別好笑，被這個小問題綁住了這麼久。
2. RAM跑不出來
3. 有時候會忘記寫線路
4. CPU  
  
