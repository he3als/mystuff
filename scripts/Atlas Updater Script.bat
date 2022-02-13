@echo off
:init
setlocal DisableDelayedExpansion
set "batchPath=%~0"
for %%k in (%0) do set batchName=%%~nk
set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
setlocal EnableDelayedExpansion

:checkPrivileges
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
ECHO Invoking UAC for Privilege Escalation

ECHO Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
ECHO args = "ELEV " >> "%vbsGetPrivileges%"
ECHO For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
ECHO args = args ^& strArg ^& " "  >> "%vbsGetPrivileges%"
ECHO Next >> "%vbsGetPrivileges%"
ECHO UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"
"%SystemRoot%\System32\WScript.exe" "%vbsGetPrivileges%" %*
exit /B

:gotPrivileges
setlocal & pushd .
cd /d %~dp0
if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)
:menu
title Atlas Update Script - made by he3als
color 03
cls
echo Warning: Updating to the latest Atlas folder or running the post-install script again might not work properly on your version of Atlas (OR BREAK SOMETHING). I take no responsiblity!
echo What would you like to do?
echo 1. Run the post-install script again (semi-updating Atlas)
echo 2. Update the Atlas desktop folder and script
echo 3. Exit
set /P c="Please input your answer here -> "
if /I "%c%" EQU "1" goto postinstall
if /I "%c%" EQU "2" goto updatefolderandscript
if /I "%c%" EQU "3" exit
:postinstall
cls
echo You should update the Atlas folder and script before doing this. I take no responsiblity for damage to your system.
set /P c="Continue? [Y/N] "
if /I "%c%" EQU "Y" goto postinstallconfirma
if /I "%c%" EQU "N" goto menu
:postinstallconfirma
echo.
echo Are you double sure? This will run the post install script that first runs when you install Atlas. However, that script applies most of the tweaks and will basically semi-update your version of Atlas.
set /P c="Continue? [Y/N] "
if /I "%c%" EQU "Y" goto postinstallconfirmb
if /I "%c%" EQU "N" goto menu
:postinstallconfirmb
C:\Windows\AtlasModules\nsudo -U:T -P:E -Wait C:\Windows\AtlasModules\atlas-config.bat /start
:updatefolderandscript
Powershell.exe -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/Atlas-OS/Atlas/main/src/20H2/AtlasModules/atlas-config.bat' -OutFile 'C:\Windows\AtlasModules\atlas-config.bat'" >nul 2>&1 && (
    goto atlasfolder
    (call )
) || (
    echo Failed downloading & installing Atlas config script.&pause&exit
)
goto atlasfolder
:atlasfolder
cls
echo Warning: Your current Atlas folder on your desktop will be deleted!
set /P c="Continue? [Y/N] "
if /I "%c%" EQU "Y" goto atlasfolderconfirm
if /I "%c%" EQU "N" goto menu
:atlasfolderconfirm
WHERE svn >nul 2>&1 && (
    goto svnfound
    (call )
) || (
    echo Svn was not found. You need to install it ^(choco install svn^) or add it to path.&pause&exit
)
:svnfound
IF EXIST "%USERPROFILE%\Desktop\Atlas" (
    goto delfolder
) ELSE (
    goto atlasfoldere
)
:delfolder
rd /s /q %USERPROFILE%\Desktop\Atlas && (
  goto atlasfoldere
  (call )
) || (
  echo Failed deleting Atlas folder. It may be in use?&pause&goto menu
)
:atlasfoldere
cd %USERPROFILE%\Desktop\
svn checkout https://github.com/Atlas-OS/Atlas/trunk/src/20H2/Desktop/Atlas
set foundErr=1
if errorlevel 0 if not errorlevel 1 set "foundErr="
if defined foundErr echo Failed using svn.&pause&goto menu
echo Completed.&pause&goto menu
