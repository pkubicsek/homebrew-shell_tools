class Kubectlenv < Formula
  desc "kubectl version manager inspired by tfenv"
  homepage "https://github.com/pkubicsek/homebrew-shell_tools"
  url "https://github.com/pkubicsek/homebrew-shell_tools/archive/v1.1.0.tar.gz"
  sha256 "cef7263c67988873baf8dfd85de353581dd3977f01fffa7654f54d78e105111f"
  license "MIT"
    version "1.1.1"
  head "https://github.com/pkubicsek/homebrew-shell_tools.git", branch: "master"

  depends_on "bash"
  depends_on "curl"

  def install
    bin.install "bin/kubectlenv"
    
    # Create kubectlenv root directory structure
    (var/"kubectlenv").mkpath
    (var/"kubectlenv/versions").mkpath
    
    # Create bin directory in kubectlenv root for kubectl symlink
    (var/"kubectlenv/bin").mkpath
    
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
    ohai "To start using kubectlenv as primary kubectl manager:"
    ohai "  export KUBECTLENV_ROOT=#{kubectlenv_root}"
    ohai "  export PATH=\"#{kubectlenv_root}/bin:$PATH\""
    ohai ""
    ohai "This will override any existing kubectl (including Docker's kubectl)"
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

      To use kubectlenv-managed kubectl as PRIMARY kubectl (overriding Docker kubectl):
        export KUBECTLENV_ROOT=#{var}/kubectlenv
        export PATH="$KUBECTLENV_ROOT/bin:$PATH"

      Then run:
        kubectlenv install <version>
        kubectlenv use <version>

      This will make kubectlenv's kubectl the default, overriding any other kubectl
      installations including Docker Desktop.

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
