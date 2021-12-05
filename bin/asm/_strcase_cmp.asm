BITS 64                           ; 64-bit mode

INT_EXIT EQU 60

SECTION .text                     ; Code section
GLOBAL _start
GLOBAL _strcasecmp:function       ; Export '_strcasecmp'

tolower:
    MOV     AL, DIL               ; Places argument in AL.
    CMP     AL, 65                ; Compares byte with 'A'.
    JL      .tolower_end          ; Goes to .tolower_end if byte < 'A'
    CMP     AL, 90                ; Compares byte with 'Z'
    JG      .tolower_end          ; Goes to .tolower_end if byte > 'Z'
    ADD     AL, 32                ; Adds 32 to byte to convert the character to lowercase.

.tolower_end:
    RET

_strcasecmp:
    MOV     RCX, 0                ; RCX = 0 -> Used here as our common strings index.
    MOV     RDX, RDI              ; Saves 1st parameter into RDX as we will use other functions that needs the RDI register.
    MOV     R8, 0                 ; R8 = 0
    MOV     R9, 0                 ; R9 = 0
    JMP     ._strcasecmp_loop

._strcasecmp_inc:
    ADD     RCX, 1                ; RCX += 1

._strcasecmp_loop:
    MOV     DIL, BYTE [RDX + RCX] ; Gets 'str1[RCX]' and puts it into DIL.
    CALL    tolower               ; Calls .tolower.
    MOV     R8B, AL               ; Gets converted value into R8B.
    MOV     DIL, BYTE [RSI + RCX] ; get 'str2[RCX]' and puts it into DIL.
    CALL    tolower               ; Calls .tolower.
    MOV     R9B, AL               ; Gets converted value into R9B.
    TEST    R8B, R8B              ; Checks whether R8B is a NULL byte.
    JE      ._strcasecmp_end      ; If it is, goes to ._strcasecmp_end.
    TEST    R9B, R9B              ; Checks whether R9B is a NULL byte.
    JE      ._strcasecmp_end      ; If it is, goes to ._strcasecmp_end.
    CMP     R8B, R9B              ; Compares R8B and R9B
    JE      ._strcasecmp_inc      ; Loops if they are equal, otherwise, goes below.

._strcasecmp_end:
    MOVSX   R8D, R8B              ; Converts register to a bigger one ("converts char to int")
    MOVSX   R9D, R9B              ; Converts register to a bigger one ("converts char to int")
    MOV     EAX, R8D              ; RAX = R8D
    SUB     EAX, R9D              ; RAX -= R9D -> Substracting R9 from R8 gets the difference between the 2 bytes.
    ret

_start:
    MOV RDI, str1                 ; Places 'str1' as first argument (into RDI)
    MOV RSI, str2                 ; Places 'str2' as second argument (into RSI)
    CALL _strcasecmp              ; Calls '_strcasecmp' function.
    MOV RDI, RAX
    MOV RAX, INT_EXIT             ; Places INT_EXIT into RAX to prepare for a SYSCALL
    SYSCALL                       ; Uses INT_EXIT previously placed into RAX to calls the SYSCALL exit

SECTION .rodata

str1: DB 'Hello World', 10, 0
str2: DB 'Hello World', 10, 0
