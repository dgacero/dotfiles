##### ZSH HISTORY #####
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=100000
export SAVEHIST=$HISTSIZE
# Share history between all sessions
setopt SHARE_HISTORY

##### ENVIRONMENT #####
export PATH="$HOME/.local/bin:$PATH"

if command -v nvim >/dev/null 2>&1; then
    export EDITOR="nvim"
elif command -v vim >/dev/null 2>&1; then
    export EDITOR="vim"
else
    export EDITOR="vi"
fi

export VISUAL=$EDITOR

# export TERM="xterm-256color"
# export COLORTERM=truecolor

##### ALIASES #####
alias ls="ls -lAh --color=auto --group-directories-first"
# alias rm="echo 'rm is disabled, use trash instead.'; false"
alias clear="echo 'clear is disabled, use Ctrl-L instead.'; false"
# NOTE: ripgrep must be installed
alias rg="rg --hidden"

##### ZSH APPEARANCE #####
# Disable Ctrl-D to close the terminal
set -o ignoreeof

# Command prompt
# if [[ -n "$TMUX" ]]; then
#     export PS1="%B%F{blue}%2~%f %F{green}❯%f%b "
# else
#     export PS1="%F{red}(Not in tmux)%f %B%F{blue}%2~%f %F{green}❯%f%b "
# fi
export PS1="%B%F{blue}%2~%f %F{green}❯%f%b "

# Newline after every command
precmd() {
    precmd() {
        echo
    }
}

##### DIRCOLORS #####
# See https://github.com/nordtheme/dircolors
export DIRCOLORS_FILE=$HOME/.dir_colors
if [[ ! -s $DIRCOLORS_FILE ]]; then
    curl -L \
        https://raw.githubusercontent.com/nordtheme/dircolors/refs/heads/develop/src/dir_colors \
        > $DIRCOLORS_FILE
fi
test -r "$HOME/.dir_colors" && eval $(dircolors $HOME/.dir_colors)

###### ANTIGEN (PLUGIN MANAGER) #####
export ANTIGEN_FILE=$HOME/antigen.zsh

# Download Antigen if it's not already installed
if [[ ! -s $ANTIGEN_FILE ]]; then
    curl -L git.io/antigen > $ANTIGEN_FILE
fi

# Apply plugins
{
source $ANTIGEN_FILE

antigen bundle zsh-users/zsh-autosuggestions

antigen bundle jeffreytse/zsh-vi-mode

# NOTE: Must be the last bundle, but come before zsh-history-substring-search
# See https://github.com/zsh-users/zsh-history-substring-search#instal
antigen bundle zsh-users/zsh-syntax-highlighting

# NOTE: Must be the last bundle
# See https://github.com/zsh-users/zsh-history-substring-search#install
antigen bundle zsh-users/zsh-history-substring-search

# Tell Antigen that you're done
antigen apply
}

### zsh-autosuggestions configuration
# NOTE: zsh-vi-mode overwrites some key bindings
# See https://github.com/jeffreytse/zsh-vi-mode?tab=readme-ov-file#execute-extra-commands
function zvm_after_init() {
    # Accepts the current suggestion
    bindkey "^I" autosuggest-accept  # Tab

    # Zsh default auto-completion
    bindkey "^[[Z" complete-word  # Shift + Tab
}

# Move forward one word
# With zsh-autosuggestions enabled, it accepts the next word in the current suggestion
bindkey -M vicmd "^[[Z" forward-word  # Shift + Tab

### zsh-vi-mode configuration
# Disable editing the current command line in an external editor
function zvm_after_lazy_keybindings() {
    bindkey -M visual -r "v"
}

# Always start with insert mode for each command line
ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT

### zsh-syntax-highlighting configuration
ZSH_HIGHLIGHT_HIGHLIGHTERS+=(brackets)  # Highlight brackets
ZSH_HIGHLIGHT_STYLES[path]="none"  # Don't underline paths
ZSH_HIGHLIGHT_STYLES[precommand]="fg=green"  # Don't underline paths

### zsh-history-substring-search configuration
# bindkey "^[[A" history-substring-search-up  # Up arrow
bindkey -M vicmd "k" history-substring-search-up
# bindkey "^[[B" history-substring-search-down  # Down arrow
bindkey -M vicmd "j" history-substring-search-down
export HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="fg=yellow,bold"
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND="fg=red,bold"
