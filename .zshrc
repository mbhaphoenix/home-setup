[[ -f ~/Git/zsh-snap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/Git/zsh-snap

source ~/Git/zsh-snap/znap.zsh

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


export ZSH_CACHE_DIR=~/.local/share/zsh/ohmyzsh
export EDITOR="nvim"
export GPG_TTY=$(tty)
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

# ANACONDA3_HOME=/usr/local/anaconda3
# export NVM_DIR="$HOME/.nvm"
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

alias ll="ls -rtlh"
alias all="ls -artlh"

alias g="gcloud"
alias gauth="g auth"
alias gc="g config"
alias gcc="gc configurations"

alias gcloudi="gcloud --impersonate-service-account=em52-sa-prd-data-root@prd-data-bootstrap-f48c.iam.gserviceaccount.com"
alias gcsi="gsutil -i em52-sa-prd-data-root@prd-data-bootstrap-f48c.iam.gserviceaccount.com"
alias gcurl='curl --header "Authorization: Bearer $(gcloud auth print-identity-token)"'

alias kx=kubectx
alias kn=kubens

FZF_MARKS_JUMP="^j"

setopt promptsubst

path+=( ~[sei40kr/fast-alias-tips-bin] )

znap source ohmyzsh/ohmyzsh lib/{completion,history,key-bindings,directories} # fix termsupport
znap source ohmyzsh/ohmyzsh plugins/{git,per-directory-history,gpg-agent,python,sudo} #fix kubectl

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
export HOMEBREW_HOME=/usr/local

# bindkey "$terminfo[kcuu1]" history-substring-search-up
# bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
# [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
#
export GOOGLE_CLOUD_SDK_HOME="$HOMEBREW_HOME/Caskroom/google-cloud-sdk/latest/google-cloud-sdk"
# The next line updates PATH for the Google Cloud SDK.
if [ -f "$GOOGLE_CLOUD_SDK_HOME/path.zsh.inc" ]; then . "$GOOGLE_CLOUD_SDK_HOME/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$GOOGLE_CLOUD_SDK_HOME/completion.zsh.inc" ]; then . "$GOOGLE_CLOUD_SDK_HOME/completion.zsh.inc"; fi
#
# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/Users/mehdiabbes/Runtimes/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/Users/mehdiabbes/Runtimes/anaconda3/etc/profile.d/conda.sh" ]; then
#         . "/Users/mehdiabbes/Runtimes/anaconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/Users/mehdiabbes/Runtimes/anaconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# # <<< conda initialize <<<
# conda activate python397
#
# eval "$(direnv hook zsh)"

