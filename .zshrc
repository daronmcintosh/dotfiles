# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

DOTFILES_DIR="$HOME/.dotfiles"
# alias dotfiles="git --work-tree=$HOME --git-dir=$DOTFILES_DIR"
# TODO: report untracked changes on initial start?
# dotfiles status
# dotfiles add <file(s)>
# dotfiles commit -m "changes"
# dotfiles push

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export EDITOR="code --wait"
export DOCKER_BUILDKIT=1

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  common-aliases
  git
  gh
  zsh-autosuggestions
  fzf
  # fast-syntax-highlighting
  docker
  kubectl
  terraform
  gcloud
  node
  tmux
  golang
  asdf
)

# plugin settings that has to be defined before oh my zsh is sourced
# export ZSH_TMUX_AUTOSTART="true"
export DISABLE_FZF_KEY_BINDINGS="false"

source $ZSH/oh-my-zsh.sh
source $HOME/.aliases
# .zshrc.local may not exists
if [ -f $HOME/.zshrc.local ]; then
  source $HOME/.zshrc.local
fi

# completion stuff
zstyle ':completion:*' menu yes select
zstyle ':completion::complete:*' use-cache 1 # enables completion caching
zstyle ':completion::complete:*' cache-path ~/.zsh/cache
zstyle ':completion:*' users root $USER
zstyle ':completion:*:*:git:*' script ~/.completions/git-completion.bash
autoload -Uz compinit && compinit -i

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
