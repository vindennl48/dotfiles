################################################################################
# ENVIRONMENT
################################################################################
## export ZDOTDIR="$HOME/.config/zsh" # move dotfiles to .config
export ZSH_HOME_PATH="$HOME/.config/zsh"
export VISUAL="nvim" # default visual 
export EDITOR="$VISUAL" # default editor

export DOTFILES_PATH="$HOME/bin/dotfiles" # custom dotfiles path
export PATH="$DOTFILES_PATH/bin:$PATH"    # add dotfiles bin to path

export PLUGIN_PATH="$HOME/.local/share/zsh/plugins"

## PYTHON ##
export PYTHONDONTWRITEBYTECODE=1 # Stop python from creating pyc files

## For C++ code linting ##
export PATH="/usr/local/opt/llvm/bin/:$PATH"

## FZF ##
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

## HISTORY ##
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

################################################################################
# FUNCTIONS
################################################################################
zsh_add_file() {
    local file="$1"
    if [ -f "$file" ]; then
        source "$file"
    # else
        # echo "Error: File '$file' not found."
    fi
}

zsh_add_plugin() {
  local plugin_name=$(echo $1 | cut -d '/' -f 2)
  if [ -d "$PLUGIN_PATH/$plugin_name" ]; then
    # For plugins
    zsh_add_file "$PLUGIN_PATH/$plugin_name/$plugin_name.plugin.zsh"
    zsh_add_file "$PLUGIN_PATH/$plugin_name/$plugin_name.zsh"
    zsh_add_file "$PLUGIN_PATH/$plugin_name/$plugin_name.zsh-theme"
  else
    git clone "https://github.com/$1.git" "$PLUGIN_PATH/$plugin_name"
  fi
}


################################################################################
## PLUGINS
################################################################################
# zsh_add_plugin "zap-zsh/zap-prompt"

zsh_add_plugin "romkatv/powerlevel10k"
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.

zsh_add_plugin "zsh-users/zsh-autosuggestions" # this one adds the grey text to the right of the cursor

# zsh_add_plugin "marlonrichert/zsh-autocomplete" # this is the one that has the weird history thing.. dont like

## NEED TO BE LAST ##
zsh_add_plugin "zsh-users/zsh-syntax-highlighting" # to add syntax highlighting to the terminal
zsh_add_plugin "catppuccin/zsh-syntax-highlighting" # to add syntax highlighting to the terminal


################################################################################
## ALIASES
################################################################################
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
alias p='python3'
alias rem='p $DOTFILES_PATH/python/shell/rm.py'      # this needs to update
alias unlock='sudo xattr -r -d com.apple.quarantine' # Used for unlocking downloaded files from apple's quarantine process
alias ..='cd ..'
alias ...='cd ...'
alias ....='cd ....'
alias .....='cd .....'
alias cat='bat'
alias cp='cp -i'
alias cpqcow='cp -i --sparse=always'
alias hdsize='df -H'

# Locations
# alias lof='cd /Users/mitch/Documents/Code/Python/LOFUpload; python3 main.py'
alias ga='cd ~/Documents/code/python/MidiRoute' # most used shortcut
alias gc='cd ~/Documents/code/'
alias go='cd'

# Mount Network Drive WSL
alias usbmount='sudo mount --mkdir -o uid=1000,gid=1000'
alias mountwsl='sudo mkdir -p /mnt/z; sudo mount -t drvfs "\\192.168.1.5\sambashare" /mnt/z'
alias mountarch='sudo mount --mkdir -t cifs //192.168.1.5/sambashare /mnt/z -o username=mitch,password='
alias addGithubKey='mkdir -p ~/.ssh; cp /mnt/z/github/id_ed25519 ~/.ssh/.; sudo chmod 400 ~/.ssh/id_ed25519; eval $(ssh-agent -s); ssh-add ~/.ssh/id_ed25519'

# FZF
alias gpp='cd $(find . -type d | fzf)'
alias gpo='cd $(find ~ -type d | fzf)'
alias gvp='nvim $(find . | fzf)'
alias gvo='nvim $(find ~ | fzf)'

# Source / Reload / Search aliases
alias ss='source ~/.zshrc'

# Edits
alias ee='vim $DOTFILES_PATH/UserNotes.md'
alias ea='vim $HOME/.config/zsh'
alias es='vim $HOME/.config/nvim/'

# TMUX
alias ta='tmux attach -t'

# Python
# This gets all the required packages for the specific project folder
alias pipGetPackages="pip install pipreqs pip-tools; pipreqs --savepath=requirements.in && pip-compile; rm requirements.in"
alias pipInstallPackages="pip install -r requirements.txt"

# Bindings
autoload -z edit-command-line
zle -N edit-command-line
bindkey '^v' edit-command-line

# Autocomplete
# allows case insensitivity
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Custom Python CLI tools
#########################
#used with CWD.py to set and change working directories
cwd() {
  # ans=$(p ~/bin/dotfiles/python/CWD.py $@)
  # eval "$ans"
  eval $(p ~/bin/dotfiles/python/CWD.py $@)
}
# alias cwdd="p ~/bin/dotfiles/python/CWD.py"

#used with mitch.py
alias mitch="p ~/bin/dotfiles/python/mitch.py"
#used with lof.py
alias lof="p ~/bin/dotfiles/python/lof.py"

# Custom Functions
##################
# Extracts any archive(s) (if unp isn't installed)
extract() {
	for archive in "$@"; do
		if [ -f "$archive" ]; then
			case $archive in
			*.tar.bz2) tar xvjf $archive ;;
			*.tar.gz) tar xvzf $archive ;;
			*.bz2) bunzip2 $archive ;;
			*.rar) rar x $archive ;;
			*.gz) gunzip $archive ;;
			*.tar) tar xvf $archive ;;
			*.tbz2) tar xvjf $archive ;;
			*.tgz) tar xvzf $archive ;;
			*.zip) unzip $archive ;;
			*.Z) uncompress $archive ;;
			*.7z) 7z x $archive ;;
			*) echo "don't know how to extract '$archive'..." ;;
			esac
		else
			echo "'$archive' is not a valid file!"
		fi
	done
}

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
# alias gpush='git push -u origin $(branch-name)'
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
