# Path to your oh-my-zsh installation.
export ZSH="$HOME/.zsh"

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="avit"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration

export PATH="/Applications/Postgres.app/Contents/Versions/9.4/bin:/Library/Frameworks/Python.framework/Versions/Current/bin:$HOME/.rbenv/shims:$HOME/.rbenv/bin:$HOME/projects/go-workspace/bin:$HOME/.rbenv/shims:$HOME/.rbenv/bin:$HOME/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/MacGPG2/bin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8

EDITOR='vim'

# See https://github.com/chriskempson/base16-shell for more themes
BASE16_SHELL="$HOME/.config/base16-eighties.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL



function  ldap-group() {
  CMD="ldapsearch -h ad.corp.appnexus.com -x -b dc=ad,dc=corp,dc=appnexus,dc=com -D 'ad\jmurray' -x -W '(proxyAddresses=smtp:$1@appnexus.com)' | grep 'member: CN=' | sed 's/,.*$//' | sed 's/^.*=//'"
  eval "${CMD}"
}

function ldap-groups() {
  CMD=""
  CMD="ldapsearch -h ad.corp.appnexus.com -x -b dc=ad,dc=corp,dc=appnexus,dc=com -D 'ad\jmurray' -x -W '(cn=$1)' | grep 'memberOf' | sed 's/,.*$//' | sed 's/^.*=//'"
  eval "${CMD}"
}

alias jump='ssh -At jump.adnxs.net'
function ago() {
# a function to use go on jump with a couple of improvements
 
  if [ $# -eq 0 ]; then 
      # 0 arg supplied, check if clipboard has hostname and if it looks right, ssh to it
      h=`/usr/bin/pbpaste`
      if [ `echo $h | perl -ne 'if (/^\d{2,}\.[\w-]+\.[\w-]+\.\w{3,4}$/) {print 1;} else { print 0; }'` -eq 1 ]; then
   ssh $h
   exit
      fi
  fi
 
 
  if [ $# -eq 1 ]; then 
      if [ `echo $1 | perl -ne 'if (/^\d{2,}\.[\w-]+\.[\w-]+\.\w{3,4}$/) {print 1;} else { print 0; }'` -eq 1 ]; then
       # 1 arg supplied, probably well-formed hostname as it matched regexp, so try ssh directly
   ssh $1
   exit
      fi
  fi
 
  jump /usr/bin/go $@
}

function m {
  ago "murray" $@
}
