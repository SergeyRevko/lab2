@ECHO OFF
"C:\Program Files (x86)\Atmel\AVR Tools\AvrAssembler2\avrasm2.exe" -S "D:\AVR_projects\lab2\labels.tmp" -fI -W+ie -C V2E -o "D:\AVR_projects\lab2\lab2.hex" -d "D:\AVR_projects\lab2\lab2.obj" -e "D:\AVR_projects\lab2\lab2.eep" -m "D:\AVR_projects\lab2\lab2.map" "D:\AVR_projects\lab2\lab2.asm"
