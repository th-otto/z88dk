
; int isxdigit(int c)

SECTION code_clib
SECTION code_ctype

PUBLIC isxdigit
PUBLIC isxdigit_fastcall

EXTERN asm_isxdigit, error_zc


isxdigit:
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

isxdigit_fastcall:

   inc h
   dec h
   jp nz, error_zc

   ld a,l
   call asm_isxdigit
   
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
PUBLIC _isxdigit
defc _isxdigit = isxdigit
PUBLIC _isxdigit_fastcall
defc _isxdigit_fastcall = isxdigit_fastcall
ENDIF

; Clang bridge for Classic
IF __CLASSIC
PUBLIC ___isxdigit
defc ___isxdigit = isxdigit
ENDIF

