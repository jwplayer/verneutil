# This file must be used with "source bin/activate" *from bash*
# you cannot run it directly


# Initialize variables that are used to determine where in the filesystem
# this virtual environment resides. Note that $VIRTUAL_ENV can be preserved
# by calling `deactivate nondestructive bootstrap`.

get_source_path() {
    local last
    for last; do true; done

    RBACTIVATE_CALLED=$last
}

# RBACTIVATE_RELPATH_FILE=$RBACTIVATE_CALLED
echo "RBACTIVATE_CALLED:$RBACTIVATE_CALLED"


# This should detect bash and zsh, which have a hash command that must
# be called to get it to forget past commands.  Without forgetting
# past commands the $PATH changes we made may not be respected
# if [ -n "${BASH-}" -o -n "${ZSH_VERSION-}" ] ; then
#     hash -r 2>/dev/null
# fi


get_virtual_env() {
    # Get the path that the script is being called from
    local RBACTIVATE_PATHROOT="$( cd -P "$( dirname "$SOURCE" )" && pwd )"  # calling directory
    local RBACTIVATE_ABSPATH_FILE="$RBACTIVATE_PATHROOT/$RBACTIVATE_CALLED"  # path to script
    VIRTUAL_ENV="${RBACTIVATE_ABSPATH_FILE%/*}"
    echo "RBACTIVATE_PATHROOT:$RBACTIVATE_PATHROOT"
    echo "RBACTIVATE_ABSPATH_FILE:$RBACTIVATE_ABSPATH_FILE"
    echo "VIRTUAL_ENV:$VIRTUAL_ENV"
    echo
}


# track the old version of gem env vars (if relevant)
# and don't overwrite env vars on multiple activations
if [ -z "${VIRTUAL_ENV}" ] ; then
    if [ -n "${GEM_HOME-}" ] ; then
        echo "setting gem home"
        _OLD_VIRTUAL_GEM_HOME="$GEM_HOME"
    fi

    if [ -n "${GEM_PATH-}" ] ; then
        _OLD_VIRTUAL_GEM_PATH="$GEM_PATH"
    fi

    if [ -n "${GEM_SPEC_CACHE-}" ] ; then
        _OLD_VIRTUAL_GEM_SPEC_CACHE="$GEM_SPEC_CACHE"
    fi
fi

get_virtual_env
export VIRTUAL_ENV



deactivate () {

    # unset virtualenv gem environment variables (destructive mode)
    if [ ! "${1-}" = "nondestructive" ] ; then
        # Self destruct!
        unset GEM_HOME
        unset GEM_PATH
        unset GEM_SPEC_CACHE
    fi

    # unset scratch vars only when bootstrapping
    if [ "${2-}" = "bootstrap" ] ;  then
        unset RBACTIVATE_CALLED
        unset RBACTIVATE_RELPATH_FILE
        unset -f get_virtual_env
    fi

    # reset old environment variables
    if [ -n "${_OLD_VIRTUAL_PATH-}" ] ; then
        PATH="$_OLD_VIRTUAL_PATH"
        export PATH
        unset _OLD_VIRTUAL_PATH
    fi

    # This should detect bash and zsh, which have a hash command that must
    # be called to get it to forget past commands.  Without forgetting
    # past commands the $PATH changes we made may not be respected
    if [ -n "${BASH-}" -o -n "${ZSH_VERSION-}" ] ; then
        hash -r 2>/dev/null
    fi

    if [ -n "${_OLD_VIRTUAL_PS1-}" ] ; then
        PS1="$_OLD_VIRTUAL_PS1"
        export PS1
        unset _OLD_VIRTUAL_PS1
    fi

    # Only keep $VIRTUAL_ENV around when "boostrapping"
    if [ ! "${2-}" = "bootstrap" ] ; then
        unset VIRTUAL_ENV
    fi

    # SELF DESTRUCT! Hasta la vista virtualenv
    if [ ! "${1-}" = "nondestructive" ] ; then

        # restore all gem variables
        if [ -n "${_OLD_VIRTUAL_GEM_HOME-}" ] ; then
            GEM_HOME="$_OLD_VIRTUAL_GEM_HOME"
            export GEM_HOME
            unset _OLD_VIRTUAL_GEM_HOME
        fi

        if [ -n "${_OLD_VIRTUAL_GEM_PATH-}" ] ; then
            GEM_PATH="$_OLD_VIRTUAL_GEM_PATH"
            export GEM_PATH
            unset _OLD_VIRTUAL_GEM_PATH
        fi

        if [ -n "${_OLD_VIRTUAL_GEM_SPEC_CACHE-}" ] ; then
            GEM_SPEC_CACHE="$_OLD_VIRTUAL_GEM_SPEC_CACHE"
            export GEM_SPEC_CACHE
            unset _OLD_VIRTUAL_GEM_SPEC_CACHE
        fi

        # Self destruct!
        unset -f deactivate
    fi
}

# unset irrelevant variables
deactivate nondestructive bootstrap

# Set the required paths
_OLD_VIRTUAL_PATH="$PATH"
PATH="$VIRTUAL_ENV/bin:$VIRTUAL_ENV/lib/ruby/bin:$PATH"
export PATH


# Set virtualenv gems environment vars
export GEM_HOME="$VIRTUAL_ENV/lib/ruby"
export GEM_PATH="$GEM_HOME"
export GEM_SPEC_CACHE="$GEM_HOME/specs"


# Set the command prompt
if [ -z "${VIRTUAL_ENV_DISABLE_PROMPT-}" ] ; then
    _OLD_VIRTUAL_PS1="$PS1"
    if [ "x" != x ] ; then
        PS1="$PS1"
    else
    if [ "`basename \"$VIRTUAL_ENV\"`" = "__" ] ; then
        # special case for Aspen magic directories
        # see http://www.zetadev.com/software/aspen/
        PS1="[`basename \`dirname \"$VIRTUAL_ENV\"\``] $PS1"
    else
        PS1="(`basename \"$VIRTUAL_ENV\"`)$PS1"
    fi
    fi
    export PS1
fi


# This should detect bash and zsh, which have a hash command that must
# be called to get it to forget past commands.  Without forgetting
# past commands the $PATH changes we made may not be respected
if [ -n "${BASH-}" -o -n "${ZSH_VERSION-}" ] ; then
    hash -r 2>/dev/null
fi

