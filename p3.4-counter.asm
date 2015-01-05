;;; Time-stamp: <2015-01-05 23:32:32 Zeno Zeng>

MAIN:
        MOV TMOD, #06H          ; 计数模式；M1M0 = 2, 8位常数自动装入
        MOV TH0, #00H
        MOV TL0, #00H
        CLR A
        SETB ET0                ; enable 定时器中断
        SETB EA                 ; enable 中断
        SETB TR0                ; 启动定时器

LOOP:
        MOV A, TL0
        MOV P1, A
        SJMP LOOP

FINALLY:
        END
