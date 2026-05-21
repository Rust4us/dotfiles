# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ============================================================
# Oh My Zsh setup
# ============================================================
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"
# Plugins (equivalentes a lo que Fish daba por defecto)
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# ============================================================
# Solo en sesión interactiva
# ============================================================
if [[ $- == *i* ]]; then

    sleep 0.05
    fastfetch

    # --------------------------------------------------------
    # Starship (con soporte de transience en Zsh)
    # --------------------------------------------------------
    if [[ "$TERM" != "linux" ]]; then
        eval "$(starship init zsh)"

        # Transient prompt (equivalente a enable_transience de Fish)
        zle-line-finish() { starship module character }
        zle -N zle-line-finish
    fi

    # --------------------------------------------------------
    # Colores desde Quickshell
    # --------------------------------------------------------
    if [[ -f ~/.local/state/quickshell/user/generated/terminal/sequences.txt ]]; then
        cat ~/.local/state/quickshell/user/generated/terminal/sequences.txt
    fi

    # --------------------------------------------------------
    # Colores de sintaxis (equivalente a fish_frozen_theme.fish)
    # --------------------------------------------------------
    ZSH_HIGHLIGHT_STYLES[command]='fg=blue'
    ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red,bold'
    ZSH_HIGHLIGHT_STYLES[comment]='fg=red'
    ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=yellow'
    ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=yellow'
    ZSH_HIGHLIGHT_STYLES[redirection]='fg=cyan,bold'
    ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=green'
    ZSH_HIGHLIGHT_STYLES[globbing]='fg=cyan'
    ZSH_HIGHLIGHT_STYLES[path]='fg=white,underline'

    # Color de autosuggestions (equivalente a fish_color_autosuggestion)
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=243'

    # --------------------------------------------------------
    # Aliases
    # --------------------------------------------------------
    alias clear="printf '\033[2J\033[3J\033[1;1H'"
    alias celar="printf '\033[2J\033[3J\033[1;1H'"
    alias claer="printf '\033[2J\033[3J\033[1;1H'"
    alias pamcan="pacman"
    alias q="qs -c ii"

    if [[ "$TERM" != "linux" ]]; then
        alias ls="eza --icons"
    fi

fi
alias dotfiles='/usr/bin/git --git-dir=/home/rust4us/.dotfiles/ --work-tree=/home/rust4us'

#=============================================#
# Mis Aliases
# ============================================
alias cat='bat'
alias catn='bat --style=plain'
alias catnp='bat --style=plain --paging=never'

function extractPorts() {
	ports="$(cat $1 | grep -oP '\d{1,5}/open' | awk '{print $1}' FS='/' | xargs | tr ' ' ',')"
	ip_address="$(cat $1 | grep -oP '^Host: .* \(\)' | head -n 1 | awk '{print $2}')"
	echo -e "\n[!] Extracting information...\n" > extractPorts.tmp
	echo -e "\n[*] IP Address: $ip_address" >> extractPorts.tmp
	echo -e "\n[*] OPEN Ports: $ports\n" >> extractPorts.tmp
	echo $ports | tr -d '\n' | wl-copy
	echo -e "[*] Ports copied to clipboard\n" >> extractPorts.tmp
	cat extractPorts.tmp
	rm extractPorts.tmp
}
function mkt() {
	mkdir {nmap,content,exploits}
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
