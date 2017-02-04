###############################################################################
# PATH

  export PATH=$HOME/bin
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
# todo.txt

  # `t` option is prepend the current date to a task automatically
  alias t="todo -t -d ~/.todo/todo.cfg"

###############################################################################
# OnlineJudgeHelper

  alias oj="python ~/GoogleDrive/MBA/app/OnlineJudgeHelper/oj.py"
  alias ojy="oj --yukicoder"

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
# OTHER

  zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

###############################################################################
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

  alias aa="anyframe-widget-select-widget"
  alias acd="anyframe-widget-cdr"
  alias ahi="anyframe-widget-put-history"
  alias ahe="anyframe-widget-execute-history"
  alias ag="anyframe-widget-cd-ghq-repository"

## Path to your oh-my-zsh installation.
#export ZSH=$HOME/.oh-my-zsh
#
## 重複パスを登録しない
#typeset -U PATH cdpath fpath manpath
#
## Set name of the theme to load.
## Look in ~/.oh-my-zsh/themes/
## Optionally, if you set this to "random", it'll load a random theme each
## time that oh-my-zsh is loaded.
##ZSH_THEME="robbyrussell"
#ZSH_THEME="agnoster"
#export DEFAULT_USER="yamagh"
#
## Example aliases
## alias zshconfig="mate ~/.zshrc"
## alias ohmyzsh="mate ~/.oh-my-zsh"
#
## Uncomment the following line to use case-sensitive completion.
## CASE_SENSITIVE="true"
#
## Uncomment the following line to disable bi-weekly auto-update checks.
## DISABLE_AUTO_UPDATE="true"
#
## Uncomment the following line to change how often to auto-update (in days).
#export UPDATE_ZSH_DAYS=7
#
## Uncomment the following line to disable colors in ls.
## DISABLE_LS_COLORS="true"
#
## Uncomment the following line to disable auto-setting terminal title.
## DISABLE_AUTO_TITLE="true"
#
## Uncomment the following line to disable command auto-correction.
## DISABLE_CORRECTION="true"
#
## Uncomment the following line to display red dots whilst waiting for completion.
## COMPLETION_WAITING_DOTS="true"
#
## Uncomment the following line if you want to disable marking untracked files
## under VCS as dirty. This makes repository status check for large repositories
## much, much faster.
## DISABLE_UNTRACKED_FILES_DIRTY="true"
#
## HISTORY
#HISTFILE=~/.zsh_history
#HISTSIZE=1000000
#SAVEHIST=1000000
## Command Execution Time Stamp
#HIST_STAMPS="yyyy-mm-dd"
## history (fc -l) コマンドをヒストリリストから取り除く。
#setopt hist_no_store
### すぐにヒストリファイルに追記する。
#setopt inc_append_history
### 直前と同じコマンドをヒストリに追加しない
#setopt hist_ignore_dups
### zsh の開始, 終了時刻をヒストリファイルに書き込む
#setopt extended_history
### ヒストリを呼び出してから実行する間に一旦編集
#setopt hist_verify
### ヒストリを共有
#setopt share_history
### コマンドラインの先頭がスペースで始まる場合ヒストリに追加しない
#setopt hist_ignore_space
#
## Would you like to use another custom folder than $ZSH/custom?
## ZSH_CUSTOM=/path/to/new-custom-folder
#
## Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
## Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
## Example format: plugins=(rails git textmate ruby lighthouse)
#plugins=(git zsh-bundle-exec bundler emoji-clock zsh-syntax-highlighting)
#
#source $ZSH/oh-my-zsh.sh
#
## User configuration ##########################################################
#
#export PATH=~/bin
#export PATH=$PATH":/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:"
#export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
## export MANPATH="/usr/local/man:$MANPATH"
#export PATH=$HOME/.cabal/bin:$PATH
#
## LANGUAGE
#export LANG=ja_JP.UTF-8
#
## Preferred editor for local and remote sessions
## if [[ -n $SSH_CONNECTION ]]; then
##   export EDITOR='vim'
## else
##   export EDITOR='mvim'
## fi
#
## Compilation flags
## export ARCHFLAGS="-arch x86_64"
#
## ssh
## export SSH_KEY_PATH="~/.ssh/dsa_id"
#
#zshaddhistory() {
#	local line=${1%%$'\n'}
#	local cmd=${line%% *}
#
#	# 以下の条件をすべて満たすものだけをヒストリに追加する
#	[[ ${#line} -ge 5
#	&& ${cmd} != (l|l[sal])
#	&& ${cmd} != (c|cd)
#	&& ${cmd} != (m|man)
#	]]
#}
#
## Java ########################################################################
#
#jr() {
#  javac $1 && java `basename \$1 .java`
#}
#
## OnlineJudgeHelper ###########################################################
#
#alias oj="python ~/GoogleDrive/MBA/app/OnlineJudgeHelper/oj.py"
#alias ojy="oj --yukicoder"
#
## todo.txt ####################################################################
#
## `t` option is prepend the current date to a task automatically
#alias t="todo -t -d ~/.todo/todo.cfg"
#
## ithief ######################################################################
#
#alias it=ithief
#
## Heroku ######################################################################
#### Added by the Heroku Toolbelt
#export PATH="/usr/local/heroku/bin:$PATH"
#
## peco settings ###############################################################
#
#peco-find-cd() {
#  local FILENAME="$1"
#  local MAXDEPTH="${2:-3}"
#  local BASE_DIR="${3:-`pwd`}"
#
#  if [ -z "$FILENAME" ] ; then
#    echo "Usage: peco-find-cd <FILENAME> [<MAXDEPTH> [<BASE_DIR>]]" >&2
#    return 1
#  fi
#
#  local DIR=$(find ${BASE_DIR} -maxdepth ${MAXDEPTH} -name ${FILENAME} | peco | head -n 1)
#
#  if [ -n "$DIR" ] ; then
#    DIR=${DIR%/*}
#    echo "pushd \"$DIR\""
#    pushd "$DIR"
#  fi
#}
#
#peco-git-cd() {
#  peco-find-cd ".git" "$@"
#}
#
#peco-docker-cd() {
#  peco-find-cd "Dockerfile" "$@"
#}
#
#peco-vagrant-cd() {
#  peco-find-cd "Vagrantfile" "$@"
#}
#
#peco-go-cd() {
#  peco-find-cd ".git" 5 "$GOPATH"
#}
#
## rbenv #######################################################################
#
#PATH="$HOME/.rbenv/bin:$PATH"
#eval "$(rbenv init -)"
#
## binstubs
##export PATH=./vendor/bin:$PATH
#
