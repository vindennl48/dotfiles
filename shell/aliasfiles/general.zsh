# General Commands
##################
  alias vim='nvim'
  alias vi='nvim'
  alias v='nvim'
  alias c='clear; clear'
  alias clear='clear; clear'
  alias t='tree'
  alias make_runnable='chmod a+x'
  alias l='ls -noGp'
  alias lsh='ls -noGpa'
  alias q1='exit'
  alias rmdir='rm -rf'
  alias p='python3'
  alias vimswitcher="p ~/Documents/Code/Python/VimSwitcher/main.py"
  alias rem="p ~/bin/dotfiles/python/shell/rm.py"
  alias rebuild="cd Builds/LinuxMakefile; bear -- make; cd ...; rm compile_commands.json; cp Builds/LinuxMakefile/compile_commands.json ."
  # Used for unlocking downloaded files from apple's quarantine process
  alias unlock="sudo xattr -r -d com.apple.quarantine"
  alias ..="cd .."

# Locations
  # alias lof='cd /Users/mitch/Documents/Code/Python/LOFRecord_Convert; python3 main.py'
  alias lof='cd /Users/mitch/Documents/Code/Python/LOFUpload; python3 main.py'
  alias ga='cd ~/Documents/code/AudioPlugins/AutoLevel' # most used shortcut
  alias gc='cd ~/Documents/code/'
  # alias gea='~/.oh-my-zsh/custom/'
  # alias ges='~/.config/nvim/'
  alias go='cd'
  # alias rea='cd /Users/mitch/Library/Application\ Support/REAPER'
  # FZF
  alias gpp='cd $(find . -type d | fzf)'
  alias gpo='cd $(find ~ -type d | fzf)'
  alias gvp='nvim $(find . | fzf)'
  alias gvo='nvim $(find ~ | fzf)'

# Source / Reload / Search aliases
  alias ss='source ~/.zshrc'
  alias sp='cat ~/.oh-my-zsh/custom/general.zsh | fzf'

# Edits
  alias ee='vim ~/bin/dotfiles/UserNotes.md'
  alias ea='vim ~/.oh-my-zsh/custom/general.zsh'
  alias eaa='vim ~/.zshrc'
  alias es='vim ~/.config/nvim/'

# TMUX
  alias ta='tmux attach -t'

# Plugins
  ## zsh-autosuggestions
  bindkey '^ ' autosuggest-accept

# Bindings
  bindkey '^V' edit-command-line

# Settings
  export VISUAL='nvim' # default visual
  export EDITOR='n$VISUAL' # default visual

# Git Commands
##############
  alias showa='git branch -a'
  alias goto='git checkout'
  alias gnew='git checkout -b'
  alias glog='git log --oneline --decorate --graph --all'

  # No arguments: `git status`
  # With arguments: acts like `git`
  g() {
    if [[ $# -gt 0 ]]; then
      git '$@'
    else
      git status
    fi
  }

  # #push up to remotes (throws error)
  # alias gpush="git push -u origin $(branch-name)"
  gpush(){
      git push -u origin $(branch-name)
  }

  #delete local branch
  deletelocal() {
    git branch -D $1
  }

  #delete remote branch
  # $1 is origin or upstream name, $2 is branch
  deleteremote() {
    git push $1 --delete $2
  }

  #delete local and remote branches
  deleteall() {
    deletelocal $2; deleteremote $1 $2;
  }

  #add files and create commit
  gac() {
      git add $@
      git commit
  }

  #used with CWD.py to set and change working directories
  cwd() {
    # ans=$(p ~/bin/dotfiles/python/CWD.py $@)
    # eval "$ans"
    eval $(p ~/bin/dotfiles/python/CWD.py $@)
  }
  alias cwdd="p ~/bin/dotfiles/python/CWD.py"

# Settings
##########
  # add bin/dotfiles/bin to path
  export PATH="/Users/mitch/bin/dotfiles/bin:$PATH"

  # Sourcing for fzf fuzzy finder
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

  # Environment Vars for pyenv
  export PYENV_ROOT="$HOME/.pyenv"

  # Stop python from creating pyc files
  export PYTHONDONTWRITEBYTECODE=1

  # Sourcing for pyenv
  export PYENV_ROOT="$HOME/.pyenv"
  command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
