
#source /usr/share/fzf/key-bindings.zsh
#source ~/.fzf.zsh
source /usr/share/fzf/shell/key-bindings.zsh

export FZF_TMUX=1
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
#export FZF_CTRL_R_OPTS='--sort --exact'
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"

#Directly executing the command (CTRL-X CTRL-R)
fzf-history-widget-accept() {
  fzf-history-widget
  zle accept-line
}
zle     -N     fzf-history-widget-accept
bindkey '^X^R' fzf-history-widget-accept


export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
