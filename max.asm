;;; max.asm --- Compare 2 8-bit numbers

;; Author: Zeno Zeng <zenoofzeng@gmail.com>
;; Time-stamp: <2014-12-19 22:10:11 Zeno Zeng>

;;; Commentary:

;; Compare 50H(RAM) and 51H(RAM) then move max to A

;;; Code:

INIT:   ;; 初始化数据
        MOV DPTR, #50H
        MOV A, #50H
        MOVX @DPTR, A
        MOV DPTR, #51H
        MOV A, #40H
        MOVX @DPTR, A

START:  CLR C                   ; 清零 Cy

        ;; 拷贝 50H 到 R0

        MOV DPTR, #50H          ; 设置 DPTR
        MOVX A, @DPTR           ; 把 50H 赋值到 A 寄存器
        MOV R0, A

        ;; 拷贝 51H 到 A

        INC DPTR
        MOVX A, @DPTR

        ;; 比较 50H 与 51H

        SUBB A, R0              ; 若有借位，Cy 为 1

        ;; if A (51H) < RO (50H)
        JC MOV50H               ; Cy != 0, A < R0

        ;; else
        MOV DPTR, #51H
        MOVX A, @DPTR
        JMP FINALLY

MOV50H: MOV DPTR, #50H
        MOVX A, @DPTR

FINALLY:
        END
