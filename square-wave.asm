;;; Output square wave (T = 1s, change every 500ms) at P1.0
;;; Time-stamp: <2015-01-05 23:13:12 Zeno Zeng>

	ORG 0000H
        AJMP MAIN
        ORG 000BH               ; 定时器 0 中断
	AJMP ONTIMEOUT

MAIN:
        MOV R1, #05H
        MOV TMOD, #01H          ; 定时工作模式，工作模式 1
        MOV TH0, #0C3H
        MOV TL0, #50H
        SETB ET0                ; enable 定时器中断
        SETB EA                 ; enable 中断
        SETB TR0                ; 启动定时器

LISTENING:
        SJMP LISTENING

ONTIMEOUT:                      ; called every 100ms
        MOV TH0, #0C3H
        MOV TL0, #50H
        DJNZ R1, OUTPUT
        RETI

OUTPUT:
        MOV R1, #0AH
        CPL P1.0
        RETI

        END
