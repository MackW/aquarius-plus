; PROJECT: Character Check (25th row)
; ASM COMPATIBILITY: TASM (e.g., TASM -80 -b charchck.asm charchck.caq)

; James' Cassette Compatible Init (CLOAD > RUN)
LOADER:

	.org $38E1 
	.db	$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF 
	.db	$00 

	; Can replace with custom SIX character identifier
	.db	"CHRCHK"
	
	.db	$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF 
	.db	$00 
	.db	$25,$39,$0a,$00 
	.db	$8e 

	; Do not edit this line. It has to be EXACTLY 30 characters inside the quotes 
	; to ensure proper byte offset for the code to line up
	.db	" For Aquarius S2 (do not edit)" 

	.db	00 
	.db	$2d, $39, $14, $00 
	.db	$42, $B0, $30 
	.db	00 
	.db	$49, $39, $1e, $00 
	.db	$94, $20, "14340", $2C, "088" 
	.db	$3A 
	.db	$94, $20, "14341", $2C, "057" 
	.db	00 
	.db	(TERMINATE & 255) 
	.db	(TERMINATE >> 8) 
	.db	$28, $00 
	.db	$42, $B0, $B5, $28, $30, $29, $3A, $80 
	.db	$00 
	.db	$00, $00	
	
	; Clear and Fill BG/Border
	call	FILLSCENE
	
	; Draw User Scene
	call	DRAWSCENE
	
; Start Main Program
MAIN: 

	; Add Custom Code Here - Press RETURN to Exit
	call	INPUT
	jr		nz,	MAIN
	
	; Clear Screen and Exit
	call	$1e45
	
; Basic Input Handler
INPUT:

	; Short Pause
	ld		bc,$3000
	call	$1d4b

	; Check for RETURN key
	ld		bc, $feff
	in		a,(c)
	bit		3, a
	
	ret

; Clear and Fill Border
FILLSCENE:

	ld		b,$9f
	ld		hl,$3000
	call	$1e59
	ld		b,$6
	call	$1e59
	ret

; Draw Scene
DRAWSCENE:

	ld      de, 12288
	ld		hl, SCENECHAR
	ld      bc, 1000
	ldir
	ld      de, 13312
	ld		hl, SCENECOLOR
	ld      bc, 1000
	ldir
	ret

; Scene Character Data (Raw 1000 Bytes)
SCENECHAR:

; Start of 25th row character space
	.db 143,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138
; Start of the REAL character space
	.db 143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143
	.db 143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143
	.db 143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143
	.db 143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143
	.db 143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143
	.db 143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143
	.db 143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143
	.db 143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143
	.db 143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143
	.db 143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143
	.db 143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143
	.db 143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143
	.db 143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143
	.db 143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143
	.db 143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143
	.db 143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143
	.db 143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143
	.db 143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143
	.db 143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143
	.db 143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143
	.db 143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143
	.db 143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143
	.db 143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143
	.db 143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143,143

; Scene Color Data (Raw 1000 Bytes)
SCENECOLOR:

; Start of 25th row color space
	.db 38,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138
; Start of REAL color space
	.db 112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7
	.db 7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112
	.db 112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7
	.db 7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112
	.db 112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7
	.db 7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112
	.db 112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7
	.db 7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112
	.db 112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7
	.db 7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112
	.db 112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7
	.db 7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112
	.db 112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7
	.db 7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112
	.db 112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7
	.db 7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112
	.db 112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7
	.db 7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112
	.db 112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7
	.db 7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112
	.db 112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7
	.db 7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112
	.db 112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7
	.db 7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112,7,112

; Conclude ML Routine
TERMINATE:
	
	.db $00,$00,$00,$00,$00,$00,$00,$00 
	.db $00,$00,$00,$00,$00,$00,$00,$00 
	.db $00,$00,$00,$00,$00,$00,$00,$00 
	.end
