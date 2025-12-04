Dim objShell
Set objShell = WScript.CreateObject("WScript.Shell")
objShell.Run ".\gcc.exe -m32 -nostdlib -c kernel.c -o .\kernel.o "
objShell.Run ".\as.exe --32 boot.S -o .\b.o "
objShell.Run "c:\nasm\nasm.exe boot.asm -o .\k.bin "
objShell.Run ".\ldc.exe -T link.ld .\b.o kernel.o -o .\ke.exe -nostdlib"
objShell.Run ".\objcopy.exe -O binary .\ke.exe .\kernel.c32"
objShell.Run "c:\windows\system32\cmd.exe /c 'copy /b k.bin+kernel.c32 kernel.bin '"
objShell.Run ".\qemu-system-x86_64.exe -fda .\kernel.bin"
Set objShell = Nothing