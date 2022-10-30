[[ -f ~/Git/zsh-snap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/Git/zsh-snap

source ~/Git/zsh-snap/znap.zsh

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH_CACHE_DIR=~/.local/share/zsh/ohmyzsh

export EDITOR="nvim"

export HISTSIZE=99999999999
export SAVEHIST=$HISTSIZE

# Don't store ts and duration of the execution.
setopt EXTENDED_HISTORY

# Write to the history file immediately, not when the shell exits.
setopt INC_APPEND_HISTORY

# Share history between all sessions.
setopt SHARE_HISTORY

# Do not display a line previously found.
setopt HIST_FIND_NO_DUPS

# Don't record an entry starting with a space.
setopt HIST_IGNORE_SPACE

# Don't write duplicate entries in the history file.
setopt HIST_SAVE_NO_DUPS

# Remove superfluous blanks before recording entry.
setopt HIST_REDUCE_BLANKS

function take() {
    mkdir -p $@ && cd ${@:$#}
}

function growl() {
    [ "$(uname)" == "Darwin" ] && terminal-notifier -title "Psssssst !!" -subtitle "A message from your shell:" -message "$@"
}

function sgrowl() {
    growl "$@"
    [ "$(uname)" == "Darwin" ] && say "$@"
}

function shch() {
    curl https://cheat.sh/$1
}

function update_all() {
    znap pull; growl "znap update finished"
    brew update && brew upgrade && brew upgrade --greedy && growl "brew update finished"
    nvim +silent +PlugUpgrade +PlugUpdate +qall && growl "vim plug update finished"
}

FZF_MARKS_JUMP="^j"

setopt promptsubst

path+=( ~[sei40kr/fast-alias-tips-bin] )

znap source ohmyzsh/ohmyzsh lib/{completion,history,key-bindings,directories} # fix termsupport
znap source ohmyzsh/ohmyzsh plugins/{git,per-directory-history,gpg-agent,kubectl,python,sudo}

znap source djui/alias-tips
znap source junegunn/fzf shell/{key-bindings.zsh,completion.zsh}
znap source zsh-users/zsh-history-substring-search
znap source zsh-users/zsh-completions
znap source zsh-users/zsh-autosuggestions
znap source oz/safe-paste # Don't execute lines when pasting
znap source romkatv/powerlevel10k
znap source voronkovich/gitignore.plugin.zsh # gitignore.io gi() and gii()
znap source willghatch/zsh-saneopt # Supposed sane options
znap source rupa/z
znap source jsporna/terraform-zsh-plugin
znap source jsporna/terraform-docs-zsh-plugin
znap source Aloxaf/fzf-tab
znap source urbainvaes/fzf-marks
znap source changyuheng/fz
znap source larkery/zsh-histdb
znap source marlonrichert/zcolors
znap eval zcolors "zcolors ${(q)LS_COLORS}"

znap eval iterm2 'curl -fsSL https://iterm2.com/shell_integration/zsh'
znap eval zoxide 'zoxide init zsh'

znap source zdharma-continuum/fast-syntax-highlighting

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export PATH="/usr/local/sbin:$PATH"

# bindkey "$terminfo[kcuu1]" history-substring-search-up
# bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

