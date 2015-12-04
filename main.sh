#!/bin/bash

# verneutil is a program to create Ruby virtual environments.
#




SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  THISDIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
THISDIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"



#
# colors for the console
#

RED="\033[0;31m"
REDB="\033[1;31m"
GREEN="\033[0;32m"
GREENB="\033[1;32m"
YELLOW="\033[0;33m"
YELLOWB="\033[1;33m"
BLUE="\033[0;34m"
BLUEB="\033[1;34m"
MAGENTA="\033[0;35m"
MAGENTAB="\033[1;35m"
CYAN="\033[0;36m"
CYANB="\033[1;36m"
GRAY="\033[0;37m"
GRAYB="\033[1;37m"
BOLD="\033[1m"
RESET="\033[0m"

error() {
    echo -e "${REDB}ERROR: ${RESET}$1"
}


info() {
    echo -e "${GREENB}INFO: ${RESET}$1"
}


bold() {
    echo -e "${BOLD}$1${RESET}"
}

# FIX ME: this needs to be portable
ruby_versions_available() {
    $THISDIR/ruby-build/bin/ruby-build --definitions
}


get_installed_rubies() {
    RUBIES=()
    local version
    for version in $THISDIR/.rubies/*
      do
        RUBIES+=("${version##*/}")
      done
}


# Check specified version against ruby-build to see if it can be
# installed
is_ruby_version_available() {
    local version=$1
    local rb_version
    local RB_RUBIES_STR=$(ruby_versions_available)
    local RB_RUBIES=()

    for rb_version in $RB_RUBIES_STR
      do
        RB_RUBIES+=($rb_version)
      done


    if [[ ! " ${RB_RUBIES[*]} " =~ " $version " ]];
      then
        # true, version available
        return 1
      else
        # false, version not available
        return 0

    fi
}


# -------------------------------------
#  MANAGER FUNCTIONS
# -------------------------------------

mgr_list_rubies() {
    local version
    get_installed_rubies

    for version in ${RUBIES[@]}
      do
        bold "* $version"
      done
}




# build ruby in place at the specified ENVDIR
mgr_build_ruby() {

    RUBY_VERSION=$1

    if is_ruby_version_available $RUBY_VERSION;
      then
        bold "installing ruby version $RUBY_VERSION via ruby-build..."
      else
        error "ruby version $version cannot be installed, run 'cmd' to list available versions"
        exit 1
    fi


    if [ -d $THISDIR/.rubies/$RUBY_VERSION ];
      then
        info "ruby version $RUBY_VERSION already installed"
        exit 0
      else
        mkdir $THISDIR/.rubies/$RUBY_VERSION
    fi

    echo ""

    if $($THISDIR/ruby-build/bin/ruby-build $RUBY_VERSION $THISDIR/.rubies/$RUBY_VERSION);
        then
            bold "ruby version $RUBY_VERSION successfully installed"
        else
            error "unable to create ruby version $RUBY_VERSION"
            rm -rf $THISDIR/.rubies/$RUBY_VERSION
            exit 1
    fi

}


ctl_init_app() {
    local cwd=$(pwd)
    cd $THISDIR
    git submodule init
    git submodule update
    cd $cwd
}


# -------------------------------------
#  CLIENT FUNCTIONS
# -------------------------------------


# What compiled rubies are available for your use

is_environment_available() {
    get_installed_rubies

    if [[ " ${RUBIES[@]} " =~ " ${1} " ]];
      then
        return 1
      else
        error "the specified ruby version ($1) is not available"
        echo
        bold "The following versions are available:"
        for version in ${RUBIES[@]}
        do
            echo "  * $version"
        done
        echo
        exit 1
    fi
    return 0
}



# creates ruby env at specified location
make_ruby_env() {

    ENVDIR=$1
    is_environment_available $2


    # Make the specified environment, if possible
    if [ -d $ENVDIR ] || [ -f $ENVDIR ];
      then
        error "virtual environment ($ENVDIR) conflicts with existing directory or file"
        exit 1
      else
        # make all required directories
        echo "creating virtual environment ($ENVDIR)"
        echo "Activate virtual enviroment by running:"
        bold "source $ENVDIR/activate"
        echo

        mkdir -p $ENVDIR/lib/ruby/specs
        mkdir -p $ENVDIR/bin
        cp $THISDIR/activate.sh $ENVDIR/activate

        # Absolute path to ruby binaries
        ln -s $THISDIR/.rubies/$2/bin/* $ENVDIR/bin/

    fi
}



# Controller subprogram
controller() {
    local CMD="$1"

    shift || true

    case "$CMD" in

    # Global Commands

    "-h" | "--help")   echo "A useful help message about ctl goes here";;

    "-i" | "--install")             mgr_build_ruby "$1";;

    "-a" | "--available")           ruby_versions_available;;

    "-l" | "--list")                mgr_list_rubies;;

    *)      echo "Try --help, although it's not at all helpful";;

     esac

}



# MAIN PRORGRAM
main() {
    local CMD="$1"

    shift || true

    case "$CMD" in

    # Global Commands

    "ctl")                controller "$@";;

    "-h" | "--help")   echo "A useful help message goes here";;

    "-l" | "--list")                mgr_list_rubies;;

    "-c" | "--create")      make_ruby_env "$@";;

    "init")    ctl_init_app;;

    *)      echo "Try --help, although it's not helpful";;

     esac
}


main $@

