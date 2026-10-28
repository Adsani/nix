if status is-interactive
    figlet -f slant Adsani
    fastfetch
    # Software initialization
    starship init fish | source
    zoxide init fish | source

    # Environment Variable
    set fish_greeting
    set -gx EDITOR nvim
    set -gx VISUAL nvim
    set -gx STARSHIP_CONFIG ~/.config/starship/starship.toml
    set -gx EZA_CONFIG_DIR ~/.config/eza/catppuccin-mocha-blue.yml
    set -gx SSH_AUTH_SOCK ~/.var/app/com.bitwarden.desktop/data/.bitwarden-ssh-agent.sock # Flatpak app
    # set -gx SSH_AUTH_SOCK ~/.bitwarden-ssh-agent.sock # Native bitwarden app. Choose one

    # Aliases
    alias ls 'eza --icons --group-directories-first -1'
    alias cat bat
    alias lsblk 'lsblk -o NAME,SIZE,TYPE,FSTYPE,LABEL,UUID,MOUNTPOINTS' # Custom lsblk option

    # Hank don't abbreviate Cyberpunk
    abbr neofetch 'fastfetch -c neofetch.jsonc'
    abbr ff fastfetch
    abbr lg lazygit
    abbr ll 'ls -l'
    abbr la 'ls -a'
    abbr lsa 'ls -a'
    abbr lla 'ls -la'
    abbr hms 'home-manager switch -b backup --flake ~/nix#adsani@Adsani-Fedora'
    # Commands to run in interactive sessions can go here
end

fish_add_path ~/.nix-profile/bin
