# Shell Tools Homebrew Tap

This is a Homebrew tap that provides various shell utilities and tools.

## Installation

```bash
brew tap username/shell_tools
```

## Available Formulas

### kubectlenv

kubectl version manager inspired by tfenv.

```bash
# Install kubectlenv
brew install kubectlenv

# Add to your shell profile
export KUBECTLENV_ROOT="$(brew --prefix)/var/kubectlenv"
export PATH="$KUBECTLENV_ROOT:$PATH"

# Install and use kubectl versions
kubectlenv install 1.28.0
kubectlenv use 1.28.0
kubectlenv list
kubectlenv current
```

#### Features

- **Multi-platform support**: Works on macOS, Linux, and Windows
- **Multi-architecture**: Supports amd64, arm64, and arm
- **Version management**: Install, switch between, and uninstall kubectl versions
- **Simple commands**: Similar to tfenv interface
- **Automatic detection**: Detects OS and architecture automatically
- **Safe operations**: Prevents uninstalling currently active versions

#### Usage

```bash
# List available kubectl versions
kubectlenv list-remote

# Install a specific version
kubectlenv install 1.28.0
kubectlenv install 1.27.5

# List installed versions
kubectlenv list

# Switch to a version
kubectlenv use 1.28.0

# Check current version
kubectlenv current

# Uninstall a version
kubectlenv uninstall 1.27.5

# Show help
kubectlenv help
```

#### Environment Variables

- `KUBECTLENV_ROOT`: Root directory for kubectlenv (default: `~/.kubectlenv`)
- `KUBECTLENV_CONFIG_DIR`: Configuration directory (default: `~/.config/kubectlenv`)

## Development

To test locally:

```bash
# Test the formula
brew install --build-from-source ./Formula/kubectlenv.rb

# Or test without installing
brew test ./Formula/kubectlenv.rb
```

## Contributing

1. Fork this repository
2. Create a feature branch
3. Add your formula to the `Formula/` directory
4. Test your formula
5. Submit a pull request

## License

MIT License - see individual formulas for specific licensing information.
