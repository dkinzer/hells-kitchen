@echo off

:: ########################################################
:: # Setting up Environment...
:: ########################################################

set SCRIPT_DIR=%~dp0

:: for these we need the bin dirs in PATH
set VAGRANTDIR=%SCRIPT_DIR%tools\vagrant\vagrant\vagrant
set RUBYDIR=%VAGRANTDIR%\embedded
set CYGWINSSHDIR=%SCRIPT_DIR%tools\cygwin-ssh
set CYGWINRSYNCDIR=%SCRIPT_DIR%tools\cygwin-rsync
set CONEMUDIR=%SCRIPT_DIR%tools\conemu\ConEmu
set VIMDIR=%SCRIPT_DIR%tools\vim\vim73
set PUTTYDIR=%SCRIPT_DIR%tools\putty
set UBUNTOFONTSDIR=%SCRIPT_DIR%tools\fonts\ubuntu-font-family-0.80
set FILEZILLADIR=%SCRIPT_DIR%tools\filezilla\FileZilla-3.6.0.2

:: set devkit vars
call %RUBYDIR%\devkitvars.bat

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

set PATH=%VAGRANTDIR%\bin;%RUBYDIR%\bin;%GITDIR%\cmd;%CYGWINRSYNCDIR%;%CYGWINSSHDIR%;%CONEMUDIR%;%VIMDIR%;%PUTTYDIR%;%FILEZILLADIR%;%VBOX_INSTALL_PATH%;%PATH%
