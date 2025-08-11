class Kubectlenv < Formula
  desc "kubectl version manager inspired by tfenv"
  homepage "https://github.com/pkubicsek/shell_tools"
  url "git@github.com:pkubicsek/shell_tools.git", tag: "v1.0.0", revision: "8ed5062f138a7eb1dda01b6972655e3311393bd6"
  license "MIT"
  version "1.0.0"
  head "git@github.com:pkubicsek/shell_tools.git", branch: "master"

  depends_on "bash"
  depends_on "curl"

  def install
    bin.install "bin/kubectlenv"
    
    # Create kubectlenv root directory structure
    (var/"kubectlenv").mkpath
    (var/"kubectlenv/versions").mkpath
    
    # Install shell completion files if they exist
    if (buildpath/"completions").exist?
      bash_completion.install "completions/kubectlenv.bash" => "kubectlenv"
      zsh_completion.install "completions/_kubectlenv"
      fish_completion.install "completions/kubectlenv.fish"
    end
  end

  def post_install
    # Create config directory
    (var/"kubectlenv/config").mkpath
    
    # Set default kubectlenv root
    kubectlenv_root = var/"kubectlenv"
    
    ohai "kubectlenv installed successfully!"
    ohai ""
    ohai "To start using kubectlenv, add the following to your shell profile:"
    ohai "  export KUBECTLENV_ROOT=#{kubectlenv_root}"
    ohai "  export PATH=\"$KUBECTLENV_ROOT:$PATH\""
    ohai ""
    ohai "Then reload your shell and run:"
    ohai "  kubectlenv install 1.28.0"
    ohai "  kubectlenv use 1.28.0"
    ohai ""
    ohai "For more information, run: kubectlenv help"
  end

  test do
    system "#{bin}/kubectlenv", "version"
    system "#{bin}/kubectlenv", "help"
  end

  def caveats
    <<~EOS
      kubectlenv manages kubectl versions in #{var}/kubectlenv

      To use kubectlenv-managed kubectl versions, add this to your shell profile:
        export KUBECTLENV_ROOT=#{var}/kubectlenv
        export PATH="$KUBECTLENV_ROOT:$PATH"

      Then run:
        kubectlenv install <version>
        kubectlenv use <version>

      Available commands:
        kubectlenv list          # List installed versions
        kubectlenv list-remote   # List available versions
        kubectlenv install 1.28.0
        kubectlenv use 1.28.0
        kubectlenv current
        kubectlenv help
    EOS
  end
end
