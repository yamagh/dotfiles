###############################################################################
# PATH

  if [ -x /usr/libexec/path_helper ]; then
    eval `/usr/libexec/path_helper -s`
  fi

  export PATH=$HOME/bin:$PATH
  export PATH=$PATH":/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:"
  export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
  export PATH=$HOME/.cabal/bin:$PATH

###############################################################################
# HISTORY

  HISTFILE=~/.zsh_history
  HISTSIZE=1000000
  SAVEHIST=1000000
  # Command Execution Time Stamp
  HIST_STAMPS="yyyy-mm-dd"
  # history (fc -l) コマンドをヒストリリストから取り除く。
  setopt hist_no_store
  ## すぐにヒストリファイルに追記する。
  setopt inc_append_history
  ## 直前と同じコマンドをヒストリに追加しない
  setopt hist_ignore_dups
  ## zsh の開始, 終了時刻をヒストリファイルに書き込む
  setopt extended_history
  ## ヒストリを呼び出してから実行する間に一旦編集
  setopt hist_verify
  ## ヒストリを共有
  setopt share_history
  ## コマンドラインの先頭がスペースで始まる場合ヒストリに追加しない
  setopt hist_ignore_space

###############################################################################
# LS SETTINGS

  export LSCOLORS=exfxcxdxbxegedabagacad
  export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
  alias ls="ls --color"
  alias ll="ls -l --color"
  alias la="ls -a --color"
  alias lla="ls -la --color"
  zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

###############################################################################
# CDR

  # Load cdr, add-zsh-hook
  autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
  add-zsh-hook chpwd chpwd_recent_dirs
   
  # Settings
  zstyle ':completion:*' recent-dirs-insert both
  zstyle ':chpwd:*' recent-dirs-max 500
  zstyle ':chpwd:*' recent-dirs-default true
  zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/shell/chpwd-recent-dirs"
  zstyle ':chpwd:*' recent-dirs-pushd true

###############################################################################
# Git

  alias ga="git add"
  alias gc="git commit"
  alias gs="git status"
  alias gb="git branch"
  alias gl="git log"

###############################################################################
# Rails

  alias br="bin/rails"
  alias be="bundle exec"

###############################################################################
# todo.txt

  # `t` option is prepend the current date to a task automatically
  alias t="~/.ghq/github.com/ginatrapani/todo.txt-cli/todo.sh -t -d ~/.todo/todo.cfg"
  alias tp="t pom"
  alias te="t edit"

  # For `edit` action setting
  export EDITOR=vim

###############################################################################
# OnlineJudgeHelper

# alias oj="python ~/GoogleDrive/MBA/app/OnlineJudgeHelper/oj.py"
# alias ojy="oj --yukicoder"
  alias oj="python ~/.ghq/github.com/kmyk/online-judge-tools/oj"

###############################################################################
# Heroku

  export PATH="/usr/local/heroku/bin:$PATH"

###############################################################################
# rbenv

  PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
  
  # binstubs
  #export PATH=./vendor/bin:$PATH

###############################################################################
# tmux

  if [ -z $TMUX ]; then
    if $(tmux has-session 2> /dev/null); then
      printf 'Attach tmux? [y/N]: '
      if read -q; then
        tmux -2 attach && exit
      fi
    else
      printf 'Run tmux? [y/N]: '
      if read -q; then
        tmux -2 && exit
      fi
    fi
  fi

###############################################################################
# pyenv

  export PYENV_ROOT=$HOME/.pyenv
  export PATH=$PYENV_ROOT/bin:$PATH
  eval "$(pyenv init -)"

###############################################################################
# ithief

  alias it="ithief"

###############################################################################
# peco

function peco_mdfind_cd() {
    cd "$(mdfind 'kMDItemContentType == "public.folder" || kMDItemFSNodeCount > 0' $1 | peco)"  
}
alias pmc="peco_mdfind_cd"

###############################################################################
# Util
mkcd(){
  mkdir $1 && cd $1
}


###############################################################################
# OTHER

  zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# zplug

  source $HOME/.zplug/init.zsh

# PLUGIN LIST
  
  zplug mafredri/zsh-async, from:github
  zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme
    # Depeds on: mafredri/zsh-async
  zplug zsh-users/zsh-autosuggestions,     from:github
  zplug zsh-users/zsh-completions,         from:github
  zplug zsh-users/zsh-syntax-highlighting, from:github
  zplug mollifier/anyframe,                from:github

# Install Plugins

  if ! zplug check --verbose; then
    printf 'Install? [y/N]: '
    if read -q; then
      echo; zplug install
    fi
  fi
  zplug load --verbose

# autoload

  autoload -U promptinit; promptinit
  autoload -U compinit && compinit

###############################################################################
# PLUGIN SETTINGS

# anyframe

  alias af="anyframe-widget-select-widget"
  alias afcd="anyframe-widget-cdr"
  alias afgh="anyframe-widget-cd-ghq-repository"
  #alias afhi="anyframe-widget-put-history"
  #alias afhe="anyframe-widget-execute-history"

  bindkey '^kc' anyframe-widget-cdr
  bindkey '^kg' anyframe-widget-cd-ghq-repository

# zsh-autosuggestions

  bindkey '^f' autosuggest-accept
  bindkey '^e' autosuggest-execute

