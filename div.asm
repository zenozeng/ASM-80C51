;;; A simpler version of div based on 《单片机基础》 page87
;; 此版本省略了四舍五入、零处理等，只保留主干

;; 总之是用余数的左移代替除数的右移

SETDATA:
        ;; 被除数（会被逐渐取代为商）
        MOV R7, #07H            ; 高位
        MOV R6, #00H            ; 低位
        ;; 除数
        MOV R5, #01H            ; 高位
        MOV R4, #0CFH           ; 低位
        ; MOV R4, #0FH            ; 低位

INIT:
        CLR A

        ;; 余数
        MOV R3, #00H            ; 高位
        MOV R2, #00H            ; 低位

        MOV R1, #10H            ; 双字节数循环 16 次即可

LOOP:
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ;;
        ;; 左移操作
        ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

        CLR C

        ;; 低位左移
        MOV A, R6
        RLC A
        MOV R6, A

	;; 高位左移（注意低位的进位 Cy 也移动到了 R7 的尾部）
        MOV A, R7
        RLC A
        MOV R7, A

        ;; 将被除数高位送到余数低位，注意顶部的 Cy 也移动到了 R2 尾部
        MOV A, R2
        RLC A
        MOV R2, A

        ;; 左移余数高位（注意 Cy）（移动之后 Cy 清零）
        MOV A, R3
        RLC A
        MOV R3, A

        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ;;
        ;; 相减操作
        ;; 判定余数是否大于除数，若是则减去除数使之继续小于除数，同时记录当前位
        ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	;; 比较余数低位和除数低位
	MOV A, R2
        SUBB A, R4
        ;; JC NEXT ; 这句话似乎不应该加上，不知道为什么书上的标程有这句话，因为实际上是需要比较整个余数和除数的大小
        MOV R0, A               ; 拷贝 A 寄存器中低位差值，留待后用

        ;; 注意之前如果有借位，那么被传递过来了
        MOV A, R3
        SUBB A, R5
        JC NEXT

        ;; 该位为 1
	INC R6                  ; 写入结果
        ;; 写入高位差值到余数高位
        MOV R3, A
        ;; 写入低位差值到余数低位
        MOV A, R0
        MOV R2, A

NEXT:
        DJNZ R1, LOOP

EXIT:
        END
