if status is-interactive
    # Software initialization
    starship init fish | source
    zoxide init fish | source

    # Environment Variable
    set fish_greeting
    set -gx EDITOR nvim
    set -gx VISUAL nvim
    set -gx STARSHIP_CONFIG ~/.config/starship/starship.toml
    set -gx EZA_CONFIG_DIR ~/.config/eza/catppuccin-mocha-blue.yml
    set -gx SSH_AUTH_SOCK ~/.var/app/com.bitwarden.desktop/data/.bitwarden-ssh-agent.sock

    # Aliases
    alias ls 'eza --icons --group-directories-first -1'
    alias neofetch 'fastfetch -c neofetch.jsonc'
    alias cat bat

    # Hank don't abbreviate Cyberpunk
    abbr ff fastfetch
    abbr ll 'ls -l'
    abbr la 'ls -a'
    abbr lsa 'ls -a'
    abbr lla 'ls -la'
    # Commands to run in interactive sessions can go here
end
