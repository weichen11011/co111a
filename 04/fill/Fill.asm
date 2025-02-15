// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.

// check input
(start)
@KBD
D=M
@Black
D;JNE
@White
D;JEQ


// white
(White)
@8192
D=A
(white)
@16384
A=D+A
M=0
D=D-1
@white
D;JGE
@24576
D=M
@White
D;JEQ

// black
(Black)
@8192
D=A
(black)
@16384
A=D+A
M=-1
D=D-1
@black
D;JGE
@24576
D=M
@Black
D;JNE

@start
0;JMP






