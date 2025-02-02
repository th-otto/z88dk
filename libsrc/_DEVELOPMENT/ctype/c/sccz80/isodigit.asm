
; int isodigit(int c)

SECTION code_clib
SECTION code_ctype

PUBLIC isodigit
PUBLIC isodigit_fastcall

EXTERN asm_isodigit, error_zc


isodigit:
IF __CPU_GBZ80__
   ld  hl,sp+2
   ld  a,(hl+)
   ld  h,(hl)
   ld  l,a
ELIF __CPU_RABBIT__
   ld hl,(sp+2)
ELSE
   pop de
   pop hl
   push hl
   push de
ENDIF

isodigit_fastcall:

   inc h
   dec h
   jp nz, error_zc

   ld a,l
   call asm_isodigit
   
   ld l,h
IF __CPU_GBZ80__
   ld d,h
   ld e,l
ENDIF
   ret c
   
   inc l
IF __CPU_GBZ80__
   inc e
ENDIF
   ret


; SDCC bridge for Classic
IF __CLASSIC
PUBLIC _isodigit
defc _isodigit = isodigit
PUBLIC _isodigit_fastcall
defc _isodigit_fastcall = isodigit_fastcall
ENDIF

; Clang bridge for Classic
IF __CLASSIC
PUBLIC ___isodigit
defc ___isodigit = isodigit
ENDIF

