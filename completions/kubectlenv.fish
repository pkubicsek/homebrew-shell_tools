# Fish completion for kubectlenv

function __kubectlenv_installed_versions
    kubectlenv list 2>/dev/null | tail -n +2
end

function __kubectlenv_remote_versions
    kubectlenv list-remote 2>/dev/null | tail -n +2
end

# Complete kubectlenv commands
complete -c kubectlenv -f
complete -c kubectlenv -n '__fish_use_subcommand' -a 'install' -d 'Install kubectl version'
complete -c kubectlenv -n '__fish_use_subcommand' -a 'uninstall' -d 'Uninstall kubectl version'
complete -c kubectlenv -n '__fish_use_subcommand' -a 'use' -d 'Switch to kubectl version'
complete -c kubectlenv -n '__fish_use_subcommand' -a 'list' -d 'List installed versions'
complete -c kubectlenv -n '__fish_use_subcommand' -a 'list-remote' -d 'List available versions'
complete -c kubectlenv -n '__fish_use_subcommand' -a 'current' -d 'Show current version'
complete -c kubectlenv -n '__fish_use_subcommand' -a 'version' -d 'Show kubectlenv version'
complete -c kubectlenv -n '__fish_use_subcommand' -a 'help' -d 'Show help'

# Complete versions for install command
complete -c kubectlenv -n '__fish_seen_subcommand_from install' -a '(__kubectlenv_remote_versions)'

# Complete versions for uninstall and use commands
complete -c kubectlenv -n '__fish_seen_subcommand_from uninstall use' -a '(__kubectlenv_installed_versions)'
