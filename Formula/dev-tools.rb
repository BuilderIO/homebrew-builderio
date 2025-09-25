require "language/node"

class DevTools < Formula
  desc "Builder.io AI Powered Design to Code"
  homepage "https://www.builder.io/"
  url "https://registry.npmjs.org/@builder.io/dev-tools/-/dev-tools-1.11.44.tgz"
  version "1.11.44"
  sha256 "d7783ca82b1ce948c64a601a7eba8245ce8171d8ee6dfcdde99c2aa03574c0de"

  license "MIT"

  livecheck do
    url "https://registry.npmjs.org/@builder.io/dev-tools"
    regex(/"version":"(\d+\.\d+\.\d+)"/i)
  end

  depends_on "node@24"

  def install
    # Install the npm package with all dependencies
    system "npm", "install", *Language::Node.std_npm_args(libexec), "@builder.io/dev-tools@#{version}"

    # Create wrapper scripts for the different command names
    (bin/"builder.io").write <<~EOS
      #!/bin/bash
      exec "#{libexec}/lib/node_modules/@builder.io/dev-tools/cli/main.cjs" "$@"
    EOS

    (bin/"builderio").write <<~EOS
      #!/bin/bash
      exec "#{libexec}/lib/node_modules/@builder.io/dev-tools/cli/main.cjs" "$@"
    EOS

    chmod 0755, bin/"builder.io"
    chmod 0755, bin/"builderio"
  end

  test do
    # Test that the CLI runs and shows help
    assert_match "Builder.io Dev Tools", shell_output("#{bin}/builder-dev-tools --help", 1)
  end
end
