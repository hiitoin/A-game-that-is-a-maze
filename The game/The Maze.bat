@echo off
title by:hiitoin
set /p name="Put username>"
cls
echo %name% is a good name :)
pause

:Menu
cls
echo 1)play
echo 2)help
echo 3)exit
echo.
set /p what="Put 1,2, or, 3>"
if %what%== 1 (
goto game
)
if %what%== 2 (
goto help
)
if %what%== 3 (
exit
)

:game
setlocal enabledelayedexpansion

REM ##################
REM # by:hiitoin #
REM ##################

:start
REM ################
set player=
set x=6
set y=3
set ry=2
set rx=4
REM ################
set MAP_HEIGHT=0
set MAP_LENGTH=0

for /f %%i in (map.txt) do (
	set map!MAP_HEIGHT!=%%i
	set /a MAP_HEIGHT+=1
)

set tmpmap=%map0%
:length
if defined tmpmap (
    set "tmpmap=%tmpmap:~1%"
    set /a "MAP_LENGTH+=1"
    goto length
)

set /a MAP_HEIGHT-=1
for /l %%y in (0,1,%MAP_HEIGHT%) do (
	for /l %%x in (0,1,%MAP_LENGTH%) do (
		set x%%xy%%y=!map%%y:~%%x,1!
	)
)

:loop
cls
set x%x%y%y%=%player%
set tx=%x%
set ty=%y%
set /a renderYM=%y%-%ry%
set /a renderYD=%y%+%ry%

set /a x1=!x!-5&set /a x2=!x!-4&set /a x3=!x!-3&set /a x4=!x!-2&set /a x5=!x!-1&set /a x6=!x!+1&set /a x7=!x!+2&set /a x8=!x!+3&set /a x9=!x!+4&set /a x10=!x!+5

echo            ͻ
for /l %%y in (%renderYM%,1,%renderYD%) do (
	set mapLine%%y=!x%x1%y%%y!!x%x2%y%%y!!x%x3%y%%y!!x%x4%y%%y!!x%x5%y%%y!!x%x%y%%y!!x%x6%y%%y!!x%x7%y%%y!!x%x8%y%%y!!x%x9%y%%y!!x%x10%y%%y!
	echo  !mapLine%%y! 
)
echo            ͼ

choice /c:WASDQ /m "Controls: W,A,S,D | Q - goto Menu>" /n
if %errorlevel%==1 set /a ty-=1&goto move
if %errorlevel%==2 set /a tx-=1&goto move
if %errorlevel%==3 set /a ty+=1&goto move
if %errorlevel%==4 set /a tx+=1&goto move
if %errorlevel%==5 goto Menu
goto loop

:move
if "!x%tx%y%ty%!"=="." set x%x%y%y%=.&set x=%tx%&set y=%ty%
goto loop

:help
cls
echo if you type 1 to play you can see the Controls
pause
goto Menu