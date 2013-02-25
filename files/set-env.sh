########################################################
# Setting up Environment...
########################################################

SCRIPT_DIR=$(dirname $BASH_SOURCE)

# for these we need the bin dirs in PATH
VAGRANTDIR="$SCRIPT_DIR/tools/vagrant/vagrantvagrant"
RUBYDIR="$VAGRANTDIR/embedded"
CYGWINSSHDIR="$SCRIPT_DIR/tools/cygwin-ssh"
CYGWINRSYNCDIR="$SCRIPT_DIR/tools/cygwin-rsync"
CONEMUDIR="$SCRIPT_DIR/tools/conemu/ConEmu"
VIMDIR="$SCRIPT_DIR/tools/vim/vim73"
PUTTYDIR="$SCRIPT_DIR/tools/putty"
UBUNTOFONTSDIR="$SCRIPT_DIR/tools/fonts/ubuntu-font-family-0.80"
FILEZILLADIR="$SCRIPT_DIR/tools/filezilla/FileZilla-3.6.0.2"
GITDIR="$SCRIPT_DIR/tools/portablegit"
HOME="$SCRIPT_DIR/home"

# prompt for .gitconfig username/email
GIT_CONF_USERNAME=$($GITDIR/cmd/git config --get user.name)
GIT_CONF_EMAIL=$($GITDIR/cmd/git config --get user.email)

# write to .gitconfig
$GITDIR/cmd/git config --global --replace user.name $GIT_CONF_USERNAME
$GITDIR/cmd/git config --global --replace user.email $GIT_CONF_EMAIL

# toggle proxy based on env var
if [ -n $HTTP_PROXY ]; then
  $GITDIR/cmd/git config --global --replace http.proxy $HTTP_PROXY
else 
  $GITDIR/cmd/git config --global --unset http.proxy
fi

# don't let VirtualBox use %HOME% instead of %USERPROFILE%, 
# otherwise it would become confused when W:\ is unmounted 
VBOX_USER_HOME=$USERPROFILE

TERM=msys

# command aliases
alias vi=gvim $*

PATH=$VAGRANTDIR\bin:$RUBYDIR\bin:$GITDIR\cmd:$CYGWINRSYNCDIR:$CYGWINSSHDIR:$CONEMUDIR:$VIMDIR:$PUTTYDIR:$FILEZILLADIR:$VBOX_INSTALL_PATH:$PATH

export PATH
