class Msp < Formula
  desc "Smart proxy for multiple stdio MCP servers"
  homepage "https://github.com/tiejunhu/mcp-smart-proxy"
  version "0.0.14"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tiejunhu/mcp-smart-proxy/releases/download/v0.0.14/msp-v0.0.14-aarch64-apple-darwin.tar.gz"
      sha256 "fe511af668a9e0c49cc888d970c30e20b0ebdc5409aacbb27b83b3f84072d53a"
    else
      url "https://github.com/tiejunhu/mcp-smart-proxy/releases/download/v0.0.14/msp-v0.0.14-x86_64-apple-darwin.tar.gz"
      sha256 "c192d6491e2d8c4ff6c5c72474f0e5fe4a381fc5f1d0bf095cd53b588fac1bc2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/tiejunhu/mcp-smart-proxy/releases/download/v0.0.14/msp-v0.0.14-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e1f3bfaebaa2920cb0aef5ffe9837d1266dfda1deed74825512fcbb84dc908e4"
    else
      url "https://github.com/tiejunhu/mcp-smart-proxy/releases/download/v0.0.14/msp-v0.0.14-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "051a9475eb422897cdd7ac393be2dc95adba8cc28fddaccace9ddd617817b188"
    end
  end

  def install
    binary = Dir["msp", "*/msp", "mcp-smart-proxy", "*/mcp-smart-proxy"].first
    raise "msp binary not found in archive" unless binary

    bin.install binary => "msp"

    metafiles_dir = Dir["README.md", "LICENSE*", "COPYING*", "*/README.md", "*/LICENSE*", "*/COPYING*"].empty? ? nil : Dir["*", "."].find do |entry|
      next false unless File.directory?(entry)

      Dir[File.join(entry, "README.md"), File.join(entry, "LICENSE*"), File.join(entry, "COPYING*")].any?
    end

    prefix.install_metafiles(metafiles_dir || ".")
  end

  test do
    assert_match "A smart MCP proxy", shell_output("#{bin}/msp --help")
  end
end
