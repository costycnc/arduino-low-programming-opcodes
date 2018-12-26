
set /p UserInputPath= What port is? (COM1,COM2,Com3,...) 


mode %UserInputPath% BAUD=9600 PARITY=n DATA=8
    echo E > %UserInputPath%
avrdude -p m328p -b 57600 -P %UserInputPath% -c arduino -U flash:w:GRBL_PD2_PC0.hex 

pause 