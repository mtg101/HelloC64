;
; VS64 generated Example was the starting point...
;

*=$0801
!byte $0c,$08,$b5,$07,$9e,$20,$32,$30,$36,$32,$00,$00,$00

    jmp     MAIN

!source     "src/c64_defs.asm"
!source     "src/c64_maths.asm"
!source     "src/c64_raster.asm"

MAIN
    jsr     ROM_CLR_SCREEN
    jsr     MATHS_SETUP_RNG
    jsr     RASTER_INTERRUPT_SETUP

    ldy     #0

HELLO
    lda     .hellotext,y
    beq     +
    sta     $400+ofs,y
    lda     #1
    sta     $d800+ofs,y
    iny
    jmp     HELLO
+

HOLD
    jmp     HOLD

.hellotext
    !scr    "hello, world!",0
    !set    ofs = 14


