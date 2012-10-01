#!/bin/bash
# 
# /etc/profile
#
# This file is intended to be used for ALL common
# Bourne-compatible shells. Shell specifics should be
# handled in /etc/profile.$SHELL where $SHELL is the name
# of the binary being run (discounting symlinks)
#
# Sections taken from SuSe's /etc/profile
# Note the explicit use of 'test' to cover all bases
#  and potentially incompatible shells

export PACKAGER="Nycholas de Oliveira e Oliveira <nycholas@gmail.com>"

#Determine our shell without using $SHELL, which may lie
shell="sh"
if test -f /proc/mounts; then
   case $(/bin/ls -l /proc/$$/exe) in
        *bash) shell=bash ;;
        *dash) shell=dash ;;
        *ash)  shell=ash ;;
        *ksh)  shell=ksh ;;
        *zsh)  shell=zsh ;;
    esac
fi

# Alias
alias l="ls -hF --color=always"
alias ls='ls -hF --color=always'
alias lr='ls -R'                    # recursive ls
alias lx='ll -BX'                   # sort by extension
alias lz='ll -rS'                   # sort by size
alias lt='ll -rt'                   # sort by date
alias lm='la | more'
alias ls="ls --color"
alias ll="ls -lh --color"
alias la="ls -a --color"
alias lla="ls -lha --color"
alias lll="ls -lhatr --color"
alias ..="cd .."
alias pacman32="pacman --root /opt/arch32 --cachedir /opt/arch32/var/cache/pacman/pkg --config /opt/arch32/pacman.conf"
alias android32="schroot -p -- android"
alias mvn32="schroot -p -- mvn"

# modified commands
alias diff='colordiff'              # requires colordiff package
alias grep='grep --color=auto'
alias more='less'
alias df='df -h'
alias du='du -c -h'
alias mkdir='mkdir -p'
alias nano='nano -w'
alias ping='ping -c 5'
alias ..='cd ..'
alias sudo='sudo -E'

# SVN
alias svnrm='svn st | grep ! | sed s/\!//g | xargs svn rm'
alias svnadd='svn st | grep ? | sed s/\?//g | xargs svn add'

# new commands
alias da='date "+%A, %B %d, %Y [%T]"'
alias du1='du --max-depth=1'
alias hist='history | grep $1'      # requires an argument
alias openports='netstat --all --numeric --programs --inet'
alias pg='ps -Af | grep $1'         # requires an argument (note: /usr/bin/pg is installed by the util-linux package; maybe a different alias name should be used)

# privileged access
if [ $UID -ne 0 ]; then
    alias sudo='sudo -E'
    alias scat='sudo cat'
    alias svim='sudo vim'
    alias root='sudo su'
    alias reboot='sudo reboot'
    alias halt='sudo halt'
    alias update='sudo pacman -Su'
    alias netcfg='sudo netcfg2'
fi

# Colored output from ls is nice, but the default color choices need
# work for use on a dark/partially transparent background. Directories
# stay blue but get bold, and symbolic links get bold cyan instead of
# magenta.
export CLICOLOR=1
export LSCOLORS="ExGxcxdxbxegedabagacad"

export GREP_COLOR="1;33"
alias grep='grep --color=auto'

export LESS="-R"

# Load shell specific profile settings
test -f "/etc/profile.$shell" &&  . "/etc/profile.$shell"

# http://stackoverflow.com/questions/791765/unable-to-forward-search-bash-history-similarly-as-with-ctrl-r
stty -ixon

# Set our umask
umask 022

# Editor
export EDITOR=nano

# Python
export PYTHONSTARTUP=~/.pythonrc

# SVN
export SVN_EDITOR="/usr/bin/kdiff3"

# GUI
export GTK_IM_MODULE=xim
export MOZ_DISABLE_PANGO=1
export SAL_GTK_USE_PIXMAPPAINT=1

#export INTEL_BATCH=1 awesome3dStuff
export XDG_DATA_DIRS="$XDG_DATA_DIRS:/usr/share"
export SAL_GTK_USE_PIXMAPPAINT=1

# Go lang
export GOROOT="/home/nycholas/src/golang"
export GOARCH="386"
export GOOS="linux"
export GOBIN="/home/nycholas/app/golang/"

# Java
#export ANT_HOME="/home/nycholas/app/apache-ant"
#export MAVEN_HOME="/home/nycholas/app/apache-maven"
#export MVN_HOME="$MAVEN_HOME"
export JAVA_HOME="/opt/java"
export JRE_HOME="/opt/java/jre"
export CATALINA_HOME="/home/nycholas/app/apache-tomcat"
export SHINDIG_HOME="/home/nycholas/app/apache-shindig"
export JBOSS_HOME="/home/nycholas/app/jboss-as"
export JBOSSTA_HOME="/home/nycholas/app/jbossta"
export GLASSFISH_HOME="/home/nycholas/app/glassfish"
export GRAILS_HOME="/home/nycholas/app/grails"
export ANDROID_HOME="/opt/android-sdk"
export ANDROID_SDK_ROOT="/opt/android-sdk"
export GDK_NATIVE_WINDOWS=1
export AWT_TOOLKIT=MToolkit
export GDK_USE_XFT=1
export QT_XFT=true

# Ogre 3d
export OGRE_SRC="/usr/local/src/_ogre"
export OGRE_HOME="/usr/local/src/_ogre"

# CrystalSpace
export CRYSTAL="/usr/share/crystalspace-1.4"
export CEL="/opt/celstart-1.2.1-linux-x86"

# Set our default path
PATH="$PATH:/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:$MVN_HOME/bin:$JAVA_HOME/bin:$CATALINA_HOME/bin:/home/nycholas/app/eclipse:$JBOSS_HOME/bin:$ANT_HOME/bin:/home/nycholas/app/android-sdk-linux_x86-1.0_r1/tools:$GLASSFISH_HOME/bin:/usr/local/src/jam:$CEL:/opt/kde/bin:/home/nycholas/bin:$GRAILS_HOME/bin:/home/nycholas/app/golang:/usr/lib64/panda3d:/opt/google-appengine:/usr/local/vrpn/bin:/usr/local/panda/bin:/opt/java/bin:/opt/android-sdk/platform-tools:/opt/android-sdk/tools"
export PATH

export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/usr/lib/pkgconfig:/usr/local/lib/pkgconfig:/usr/share/pkgconfig"

# Some readline stuff that is fairly common
HISTSIZE=1000
HISTCONTROL="erasedups"

INPUTRC="/etc/inputrc"
LESS="-R"
LC_COLLATE="C"

export HISTSIZE HISTCONTROL INPUTRC LESS LC_COLLATE

# Load profiles from /etc/profile.d
if test -d /etc/profile.d/; then
    for profile in /etc/profile.d/*.sh; do
        test -x $profile && . $profile
    done
    unset profile
fi

# Termcap is outdated, old, and crusty, kill it.
unset TERMCAP

# Man is much better than us at figuring this out
unset MANPATH

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

#  begin blinking
export LESS_TERMCAP_mb=$'\E[01;31m'
#  begin bold
export LESS_TERMCAP_md=$'\E[01;33m'
#  end mode
export LESS_TERMCAP_me=$'\E[0m'
#  begin standout-mode - info box
export LESS_TERMCAP_so=$'\E[01;41;37m'
#  end standout-mode
export LESS_TERMCAP_se=$'\E[0m'
#  begin underline
export LESS_TERMCAP_us=$'\E[01;32m'
#  end underline
export LESS_TERMCAP_ue=$'\E[0m'

_compssh ()
{
   cur=${COMP_WORDS[COMP_CWORD]};
   COMPREPLY=($(compgen -W '$(cat ${HOME}/.ssh/config | grep "^Host\b" - | sed -e "s/Host //")' -- $cur))
}
complete -F _compssh ssh



