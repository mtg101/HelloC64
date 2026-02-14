
; ROM routines

ROM_CLR_SCREEN = $E544

; as the AI said: I’ve got you. Typing out 16 constants is the exact kind of "busy work" 
; that a computer should be doing for you.

; --- C64 Color Constants ---
BLACK       = $00
WHITE       = $01
RED         = $02
CYAN        = $03
PURPLE      = $04
GREEN       = $05
BLUE        = $06
YELLOW      = $07
ORANGE      = $08
BROWN       = $09
LT_RED      = $0a
DK_GRAY     = $0b
MD_GRAY     = $0c
LT_GREEN    = $0d
LT_BLUE     = $0e
LT_GRAY     = $0f

; --- Common VIC-II Registers ---
BORDER_COL  = $d020
BG_COL      = $d021
COLOR_RAM   = $d800

SCREEN_RAM  = $0400
CHAR_ROM    = $d000 ; Note: This is in a different bank than RAM!
DEFAULT_CHR = $14   ; Value for $D018 to use Uppercase/Graphics
LOWER_CHR   = $16   ; Value for $D018 to use Lower/Upper


; --- KERNAL JUMP TABLE ---
; PSA: these are all really slow...
SCNKEY  = $ff9f ; Scan keyboard matrix (call manually if not letting system handle everything)
SETLFS  = $ffba ; Set logical file parameters
SETNAM  = $ffbd ; Set filename
OPEN    = $ffc0 ; Open a logical file
CLOSE   = $ffc3 ; Close a logical file
CHKIN   = $ffc6 ; Open channel for input
CHKOUT  = $ffc9 ; Open channel for output
CLRCHN  = $ffcc ; Restore default I/O
CHRIN   = $ffcf ; Get character from input
CHROUT  = $ffd2 ; Output character to screen
LOAD    = $ffd5 ; Load from device
SAVE    = $ffd8 ; Save to device
GETIN   = $ffe4 ; Get character from buffer (call SCNKEY first if taking control from the system)
PLOT    = $fff0 ; Set/Get cursor position

; --- VIC-II Video Controller ---
VIC_BASE    = $d000
SPRITE_0_X  = $d000
SPRITE_0_Y  = $d001

; --- VIC-II Control Registers ---
VIC_CR1     = $d011 ; Vertical scroll, Screen On/Off, Bitmap mode, Raster Bit 8
VIC_CR2     = $d016 ; Horizontal scroll, Multi-color mode, 40/38 column switch
RASTER_LINE = $d012 ; Current scanline (Read) / Trigger line (Write)
MEM_SETUP   = $d018 ; Where are the screen and characters located?
VIC_INTER   = $d019 ; Interrupt Status (ACK)
VIC_IMASK   = $d01a ; Interrupt Control (Which ones are enabled?)

; --- Bit Masks for VIC_CR1 ($D011) ---
; Use these with AND/ORA to change specific settings without messing up others
SCREEN_OFF  = %01101111 ; Use with AND to hide screen (clear bit 4)
SCREEN_ON   = %00010000 ; Use with ORA to show screen (set bit 4)
RASTER_MSB  = %10000000 ; The 9th bit (Bit 7) of the raster position

; ... repeat for Sprites 1-7
MSB_X       = $d010 ; Most Significant Bits of X (for sprites past pixel 255)


; --- Zero Page Pointers ---
; the safe ones if you've not disabled all the ROMs
ZP_PTR_1   = $fb  ; Safe Zero Page Uses $FB and $FC
ZP_PTR_2   = $fd  ; Safe Zero Page Uses $FD and $FE





