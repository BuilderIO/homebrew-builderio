require "language/node"

class DevTools < Formula
  desc "Builder.io Visual CMS Devtools - Setup and integrate Builder.io Visual CMS during development"
  homepage "https://www.builder.io/"
  url "https://registry.npmjs.org/@builder.io/dev-tools/-/dev-tools-1.11.43.tgz"
  version "1.11.43"
  sha256 "6c379c629864aeaeed17fc120243415dbfe20f89a8f15e04c71181da455b4e7a"

  license "MIT"

  livecheck do
    url "https://registry.npmjs.org/@builder.io/dev-tools"
    regex(/"version":"(\d+\.\d+\.\d+)"/)
  end

  depends_on "node@24"

  def install
    # Install the npm package with all dependencies
    system "npm", "install", *Language::Node.std_npm_install_args(libexec), "@builder.io/dev-tools@#{version}"
    
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
