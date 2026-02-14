

; mostly here to show how macros work
; --- Usage in your code ---
; +ACK_RASTER
!macro ACK_RASTER {
    asl $D019
}

; does all the stuff like KB and clocks the Kernel handles
!macro EXIT_FULL {
    jmp $EA31
}

; just pops the pushed registers that the interrupt system pushed automatically
!macro EXIT_FAST {
    jmp $FEB1
}

; 
RASTER_INTERRUPT_SETUP
    sei             ; 1. Stop all interrupts while we mess with the wires
    
    ; 2. Disable the CIA "Timer" interrupts (the 60Hz system tick)
    lda #$7f
    sta $dc0d       ; Clear CIA 1 interrupt control
    sta $dd0d       ; Clear CIA 2 interrupt control
    lda $dc0d       ; Acknowledge any pending CIA interrupts
    lda $dd0d       ; Acknowledge any pending CIA interrupts

    ; 3. Setup VIC-II to trigger a Raster Interrupt
    lda #$01
    sta VIC_IMASK   ; Enable Raster Interrupts only

    ; 4. Set the line number where the interrupt triggers
    ; default to row 0
    lda #0
    jsr RASTER_INTERRUPT_SET

    ; 5. Point the Vector to our custom routine
    lda #<RASTER_IRQ    ; Low byte
    sta $0314
    lda #>RASTER_IRQ    ; High byte
    sta $0315

    cli             ; 6. Re-enable interrupts
    rts             ; Return to BASIC (your IRQ is now running in the background!)

; A contains line
; so only up to 255... !TODO
RASTER_INTERRUPT_SET
    sta RASTER_LINE      
    lda VIC_CR1 
    and #$7f        ; Ensure the 8th bit of the raster line is 0 (for lines < 256)
    sta VIC_CR1

    rts


; --- THE ACTUAL INTERRUPT ROUTINE ---
RASTER_IRQ
    lda     #$00
    cmp     RASTER_LINE
    bne     .raster_irq_mid
.raster_irq_top
    lda     #YELLOW
    sta     BORDER_COL
    lda     #150       ; middle screen
    jsr     RASTER_INTERRUPT_SET
    jmp     .raster_irq_done

.raster_irq_mid
    lda     #RED
    sta     BORDER_COL
    lda     #0          ; top screen
    jsr     RASTER_INTERRUPT_SET

.raster_irq_done
    +ACK_RASTER         ; Use our "lazy" ASL $D019 macro
    +EXIT_FAST


