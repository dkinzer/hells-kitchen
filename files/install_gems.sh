echo $PATH
SCRIPT_DIR=$(dirname $BASH_SOURCE)
source "$SCRIPT_DIR/set-env.sh"
gem install bundler -v 1.2.1 --no-ri --no-rdoc
bundle install --gemfile=$SCRIPT_DIR/Gemfile --verbose
