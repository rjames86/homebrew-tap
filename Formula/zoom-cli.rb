class ZoomCli < Formula
  desc "Node module and CLI for controlling Zoom meetings on macOS using AppleScript"
  homepage "https://github.com/rjames86/zoom-cli"
  url "https://github.com/rjames86/zoom-cli/archive/v1.0.0.tar.gz"
  sha256 "ddb9119da6846497f51e758ff2415ec3b938a16863ec15ecba3d4bcd425bc1d2"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args(prefix: false)
    system "npm", "run", "build"

    # Install the built CLI
    bin.install "dist/cli.js" => "zoom-cli"

    # Make sure the shebang is correct
    inreplace "#{bin}/zoom-cli", %r{^#!/usr/bin/env node}, "#!/usr/bin/env node"

    # Install the module for programmatic use
    lib.install Dir["dist/*"]
    lib.install "package.json"
  end

  test do
    # Test that the CLI can be invoked
    output = shell_output("#{bin}/zoom-cli help")
    assert_match "Zoom CLI - Control Zoom meetings from the command line", output
  end
end