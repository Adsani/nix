if status is-interactive
    starship init fish | source
    zoxide init fish | source
    set -gx SSH_AUTH_SOCK /home/Adsani/.var/app/com.bitwarden.desktop/data/.bitwarden-ssh-agent.sock
    # Commands to run in interactive sessions can go here
end
