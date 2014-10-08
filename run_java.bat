ECHO OFF
SET /p environment="Connect to Live or Dev?"
IF /i "%environment%" == "a" GOTO live
IF /i "%environment%" == "b" GOTO dev
ECHO Invalid Option
GOTO end
:live
ECHO "Live!!!!"
goto end
:dev
ECHO "Dev!!!"
:end
PAUSE