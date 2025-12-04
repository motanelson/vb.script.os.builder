Dim objShell
Set objShell = WScript.CreateObject("WScript.Shell")
objShell.Run ".\gcc.exe -nostdlib -c kernel.c -o .\kernel.o "
objShell.Run ".\as.exe boot.S -o .\boot.o"
objShell.Run "c:\nasm\nasm.exe mysys.S -o .\k.bin "
objShell.Run ".\ld.exe -T link.ld boot.o kernel.o -o .\ke.exe -nostdlib"
objShell.Run ".\objcopy.exe -O elf32-i386 ke.exe .\kernel.elf"
objShell.Run ".\objcopy.exe -O binary .\kernel.elf .\kernel.c32"
objShell.Run "c:\windows\system32\cmd.exe /c 'copy /b k.bin+kernel.c32 kernel.bin '"
objShell.Run ".\qemu-system-x86_64.exe -kernel .\kernel.bin"
Set objShell = Nothing