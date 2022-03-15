org 100h
jmp inicio

var1 dw 035C3h
var2 dw 0A9F1h

inicio:
mov AX,var1
mov BX,var2
xor AX,BX
not AX
ret



; [SOURCE]: C:\emu8086\MySource\mycode.asm
