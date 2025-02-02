
; int ispunct(int c)

SECTION code_clib
SECTION code_ctype

PUBLIC ispunct
PUBLIC ispunct_fastcall

EXTERN asm_ispunct, error_zc

ispunct:
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

ispunct_fastcall:

   inc h
   dec h
   jp nz, error_zc

   ld a,l
   call asm_ispunct
   
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
PUBLIC _ispunct
defc _ispunct = ispunct
PUBLIC _ispunct_fastcall
defc _ispunct_fastcall = ispunct_fastcall
ENDIF

; Clang bridge for Classic
IF __CLASSIC
PUBLIC ___ispunct
defc ___ispunct = ispunct
ENDIF

