

; RNG uses SID chip's noise generator for really good RNs!

MATHS_SETUP_RNG
    lda #$FF        ; Set frequency high byte to max
    sta $D40E       ; Voice 3 Frequency (High)
    sta $D40F       ; Voice 3 Frequency (Low)
    lda #$80        ; $80 = Noise waveform, no sound output
    sta $D412       ; Voice 3 Control Register
    rts     

MATHS_RNG           = $D41B   

    