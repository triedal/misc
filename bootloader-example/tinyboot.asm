
;----------------------------------------------
; COMMANDS TO RUN BOOTLOADER
;----------------------------------------------
;
; nasm -f bin tinyboot.asm -o tinyboot.bin
;
; dd conv=notrunc if=tinyboot.bin of=floppy.flp
;
; qemu-system-i386 -fda floppy.flp
;
;----------------------------------------------

        bits    16                                ; Declare we are in 16 bit real mode

        org     0x7c00                            ; BIOS loads bootloader at this address

start:
        jmp         main


        
msg     db          "Hello, World!", 0


print:
        lodsb                                     ; Transfers byte @ DS:SI into AL && SI++
        or          al, al
        jz          return
        mov         ah, 0x0e                      ; Load "Teletype Output"
        int         0x10                          ; Print character to screen
        jmp         print
        
return:
        ret
        
main:
        cli                                       ; Disable hardware interrupts
        mov         si, msg
        call        print
        hlt

times 510 - ($-$$) db 0                           ; Fill remaining bytes to 0
dw 0xAA55                                         ; Boot Signature