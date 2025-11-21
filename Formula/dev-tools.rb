require "language/node"

class DevTools < Formula
  desc "Builder.io AI Powered Design to Code"
  homepage "https://www.builder.io/"
  url "https://registry.npmjs.org/@builder.io/dev-tools/-/dev-tools-1.18.11.tgz"
  sha256 "e106a2d4d1579e3bbda15061f3b58b7f04f6b8110404b2802f119e5e3ca2d333"

  license "MIT"

  livecheck do
    url "https://registry.npmjs.org/@builder.io/dev-tools"
    regex(/"version":"(\d+\.\d+\.\d+)"/i)
  end

  depends_on "node@24"

  def install
    # Install the npm package with all dependencies
    system "npm", "install", *Language::Node.local_npm_install_args, "--prefix", libexec, "@builder.io/dev-tools@#{version}"

    # Create wrapper scripts for the different command names
    (bin/"builder.io").write <<~EOS
      #!/bin/bash
      # Check for updates using brew-update.sh
      if command -v brew >/dev/null 2>&1; then
        # Find the brew-update.sh script in the tap directory
        TAP_DIR="$(brew --prefix)/Library/Taps/builderio/homebrew-builderio"
        if [[ -f "$TAP_DIR/brew-update.sh" ]]; then
          "$TAP_DIR/brew-update.sh"
        fi
      fi
      exec "#{libexec}/node_modules/@builder.io/dev-tools/cli/main.cjs" "$@"
    EOS

    (bin/"builderio").write <<~EOS
      #!/bin/bash
      # Check for updates using brew-update.sh
      if command -v brew >/dev/null 2>&1; then
        # Find the brew-update.sh script in the tap directory
        TAP_DIR="$(brew --prefix)/Library/Taps/builderio/homebrew-builderio"
        if [[ -f "$TAP_DIR/brew-update.sh" ]]; then
          "$TAP_DIR/brew-update.sh"
        fi
      fi
      exec "#{libexec}/node_modules/@builder.io/dev-tools/cli/main.cjs" "$@"
    EOS

    chmod 0755, bin/"builder.io"
    chmod 0755, bin/"builderio"
  end

  test do
    # Test that the CLI runs and shows help
    assert_match "Builder.io Dev Tools", shell_output("#{bin}/builder-dev-tools --help", 1)
  end
end
