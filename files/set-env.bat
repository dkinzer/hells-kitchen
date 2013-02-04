@echo off

:: ########################################################
:: # Setting up Environment...
:: ########################################################

set SCRIPT_DIR=%~dp0

:: for these we need the bin dirs in PATH
set VAGRANTDIR=%SCRIPT_DIR%tools\vagrant\vagrant\vagrant
set RUBYDIR=%VAGRANTDIR%\embedded
set KDIFF3DIR=%SCRIPT_DIR%tools\kdiff3
set CYGWINSSHDIR=%SCRIPT_DIR%tools\cygwin-ssh
set CYGWINRSYNCDIR=%SCRIPT_DIR%tools\cygwin-rsync
set CONSOLE2DIR=%SCRIPT_DIR%tools\console2\Console2
set SUBLIMEDIR=%SCRIPT_DIR%tools\sublimetext2
set PUTTYDIR=%SCRIPT_DIR%tools\putty

:: set devkit vars
call %RUBYDIR%\devkitvars.bat

:: set Ansicon configuration for nvidia graphics card
set ANSICON_EXC=nvd3d9wrap.dll

:: use portable git, looks for %HOME%\.gitconfig 
set GITDIR=%SCRIPT_DIR%tools\portablegit
set HOME=%SCRIPT_DIR%home

:: prompt for .gitconfig username/email
FOR /F %%a IN ('cmd /C %GITDIR%\cmd\git config --get user.name') DO SET GIT_CONF_USERNAME=%%a
if "%GIT_CONF_USERNAME%"=="" (
  set /p GIT_CONF_USERNAME="Your Name (will be written to %HOME%\.gitconfig):"
)
FOR /F %%a IN ('cmd /C %GITDIR%\cmd\git config --get user.email') DO SET GIT_CONF_EMAIL=%%a
if "%GIT_CONF_EMAIL%"=="" (
  set /p GIT_CONF_EMAIL="Your Email (will be written to %HOME%\.gitconfig):"
)
:: write to .gitconfig
cmd /C %GITDIR%\cmd\git config --global --replace user.name %GIT_CONF_USERNAME%
cmd /C %GITDIR%\cmd\git config --global --replace user.email %GIT_CONF_EMAIL%

:: toggle proxy based on env var
if "%HTTP_PROXY%"=="" (
  cmd /C %GITDIR%\cmd\git config --global --unset http.proxy
) else (
  cmd /C %GITDIR%\cmd\git config --global --replace http.proxy %HTTP_PROXY%
)

:: don't let VirtualBox use %HOME% instead of %USERPROFILE%, 
:: otherwise it would become confused when W:\ is unmounted 
set VBOX_USER_HOME=%USERPROFILE%

set TERM=msys

:: command aliases
@doskey vi=gvim $*

set PATH=%VAGRANTDIR%\bin;%RUBYDIR%\bin;%GITDIR%\cmd;%KDIFF3DIR%;%CYGWINRSYNCDIR%;%CYGWINSSHDIR%;%CONSOLE2DIR%;%SUBLIMEDIR%;%PUTTYDIR%;%VBOX_INSTALL_PATH%;%PATH%
