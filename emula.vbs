Dim objShell
Set objShell = WScript.CreateObject("WScript.Shell")
objShell.Run "c:\windows\system32\cmd.exe /c 'del k.bin '"
objShell.Run "c:\windows\system32\cmd.exe /c 'del *.o '"
objShell.Run ".\gcc.exe -c kernel.c -o .\kernel.o -nostdlib"
objShell.Run ".\as.exe boot.S -o .\boot.o"
objShell.Run "c:\windows\system32\cmd.exe /c 'c:\nasm\nasm.exe mysys.S -o k.bin '"
objShell.Run ".\ld.exe -T link.ld boot.o kernel.o -o .\kernels.o"
objShell.Run ".\objcopy.exe -O binary kernels.o .\kernel.c32"
objShell.Run "c:\windows\system32\cmd.exe /c 'copy .\k.bin .\kernel.c32 .\kernel.bin '"
objShell.Run ".\qemu-system-x86_64.exe -fda .\kernel.bin"
Set objShell = Nothing