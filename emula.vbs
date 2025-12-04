Dim objShell
Set objShell = WScript.CreateObject("WScript.Shell")
objShell.Run ".\gcc.exe -c kernel.c -o .\kernel.o -nostdlib"
objShell.Run ".\as.exe boot.S -o .\boot.o"
objShell.Run ".\ld.exe -T link.ld boot.o kernel.o -o .\kernels.o"
objShell.Run ".\objcopy.exe -O elf32-i386 kernels.o .\kernel.c32"
objShell.Run ".\qemu-system-x86_64.exe -kernel .\kernel.c32"
Set objShell = Nothing