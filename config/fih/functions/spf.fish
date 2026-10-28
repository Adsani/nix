function spf
    set os $(uname -s)

    if test "$os" = Linux
        set spf_last_dir "$HOME/.local/state/superfile/lastdir"
    end

    if test "$os" = Darwin
        set spf_last_dir "$HOME/Library/Application Support/superfile/lastdir"
    end

    command superfile $argv # Using the full binary name since I don't know why nix profile binary is 'superfile' instead of 'spf'

    if test -f "$spf_last_dir"
        source "$spf_last_dir"
        rm -f -- "$spf_last_dir" >>/dev/null
    end
end
