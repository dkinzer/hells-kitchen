########################################################
# Setting up Environment...
########################################################

SCRIPT_DIR=$(dirname $BASH_SOURCE)

# for these we need the bin dirs in PATH
RUBYDIR="$SCRIPT_DIR/tools/ruby/ruby-1.9.3-p374-i386-mingw32/bin"
CYGWINSSHDIR="$SCRIPT_DIR/tools/cygwin-ssh"
CYGWINRSYNCDIR="$SCRIPT_DIR/tools/cygwin-rsync"
CONEMUDIR="$SCRIPT_DIR/tools/conemu/ConEmu"
VIMDIR="$SCRIPT_DIR/tools/vim/vim73"
PUTTYDIR="$SCRIPT_DIR/tools/putty"
UBUNTOFONTSDIR="$SCRIPT_DIR/tools/fonts/ubuntu-font-family-0.80"
FILEZILLADIR="$SCRIPT_DIR/tools/filezilla/FileZilla-3.6.0.2"
DEVKITDIR="$SCRIPT_DIR/tools/devkit"
MINGWDIR="$DEVKITDIR/mingw"
GITDIR="$SCRIPT_DIR/tools/portablegit"
HOME="$SCRIPT_DIR/home"

export HOME

VBOX_USER_HOME=$USERPROFILE

TERM=msys

# command aliases
alias vi=gvim $*

PATH=$DEVKITDIR/bin:$MINGWDIR/bin:$RUBYDIR:$GITDIR/cmd:$CYGWINRSYNCDIR:$CYGWINSSHDIR:$CONEMUDIR:$VIMDIR:$PUTTYDIR:$FILEZILLADIR:$VBOX_INSTALL_PATH:$PATH

export PATH
