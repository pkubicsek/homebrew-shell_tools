# Bash completion for kubectlenv

_kubectlenv() {
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    opts="install uninstall use list list-remote current version help"

    case "${prev}" in
        install)
            # Complete with remote versions
            local versions
            versions=$(kubectlenv list-remote 2>/dev/null | tail -n +2)
            COMPREPLY=( $(compgen -W "${versions}" -- ${cur}) )
            return 0
            ;;
        uninstall|use)
            # Complete with installed versions
            local versions
            versions=$(kubectlenv list 2>/dev/null | tail -n +2)
            COMPREPLY=( $(compgen -W "${versions}" -- ${cur}) )
            return 0
            ;;
        *)
            ;;
    esac

    COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
    return 0
}

complete -F _kubectlenv kubectlenv
