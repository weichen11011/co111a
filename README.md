# 課程：計算機結構 -- 筆記、習題與報告

## 期中
第四章mult
1. https://github.com/davidsmithmke/nand2tetris-project4/blob/master/mult/Mult.asm
第五章是照著影片的教學一步步寫出來的
影片網址: 
1. https://www.youtube.com/watch?v=CBeVn-RSavk 這個是CPU的
2. https://www.youtube.com/watch?v=ckYSlJtpXaE&t=4s 這個是memory的

![image](https://github.com/weichen11011/co111a/blob/main/%E8%9E%A2%E5%B9%95%E6%93%B7%E5%8F%96%E7%95%AB%E9%9D%A2%202022-12-29%20102543.png)
![image](https://github.com/weichen11011/co111a/blob/main/%E8%9E%A2%E5%B9%95%E6%93%B7%E5%8F%96%E7%95%AB%E9%9D%A2%202022-12-29%20102639.png)


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
  
