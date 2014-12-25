;;; keydown-counter.asm -- Count keydown form P3.2 and outputs in P1 using LED

;; Author: Zeno Zeng <zenoofzeng@gmail.com>
;; Time-stamp: <2014-12-25 21:56:36 Zeno Zeng>

;;; Commentary:

;; Count keydown from P3.2 then ouputs using 8bit P1 (in LED)

;;; Code:

	ORG 0000H
        AJMP INIT
        ORG 0003H
        AJMP ONKEYDOWN

INIT:
        CLR A
        MOV TCON, #01H          ; 设置触发方式为脉冲，下降沿有效（IT0 = 1）
        MOV IE, #81H            ; 中断总允许，允许 EX0（P3.2 引入） 外中断 （EA = 1, EX0 = 1）

LISTENING:
        SJMP LISTENING

ONKEYDOWN:
        INC A
        MOV P1, A
        RETI

EXIT:
        END
