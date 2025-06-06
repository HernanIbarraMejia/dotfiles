source "$ZDOTDIR/aliases.zsh"
source "$ZDOTDIR/prompt.zsh"

# Completion
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
autoload -Uz compinit && compinit -d "$XDG_CACHE_HOME/zsh/.zcompdump"
_comp_options+=(globdots)
source "$ZDOTDIR/external/completion.zsh"

# Syntax Highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Vim mode
bindkey -v
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line
bindkey "^J" push-line-or-edit
bindkey -M vicmd "^J" push-line-or-edit

_make_cursor_block() { echo -ne '\e[2 q' }
_make_cursor_beam() { echo -ne '\e[6 q' }

zle-keymap-select() {
	case "$KEYMAP" in
		vicmd) _make_cursor_block
			;;
		viins|main) _make_cursor_beam
			;;
	esac
}

zle-line-init() { _make_cursor_beam }

zle -N zle-keymap-select
zle -N zle-line-init

# Set up fzf
source "$XDG_CONFIG_HOME/fzf/config.zsh"

# Options
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt INTERACTIVE_COMMENTS
setopt EXTENDED_GLOB
setopt CORRECT
setopt RC_QUOTES
setopt BSD_ECHO

# Keep at the end, after all fpath modifications
autoload "$USER_FUNCTIONS"/**/*(.:t)
