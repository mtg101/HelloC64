;
; Example
;

*=$0801
!byte $0c,$08,$b5,$07,$9e,$20,$32,$30,$36,$32,$00,$00,$00

main
    jsr $E544     ; Call the Function that clears the screen
    ldy #0

hello
    lda .hellotext,y
    beq +
    sta $400+ofs,y
    lda #1
    sta $d800+ofs,y
    iny
    jmp hello
+

border
    sta $D020
    stx $D020
    sty $D020
    sta $D020
    stx $D020
    sty $D020
    sta $D020
    stx $D020
    sty $D020
    sta $D020
    stx $D020
    sty $D020
    sta $D020
    stx $D020
    sty $D020
    jmp border

.hellotext
    !scr "hello, world!",0
    !set ofs = 14


