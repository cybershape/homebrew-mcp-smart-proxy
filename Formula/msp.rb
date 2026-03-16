class Msp < Formula
  desc "Smart proxy for multiple stdio MCP servers"
  homepage "https://github.com/tiejunhu/mcp-smart-proxy"
  version "0.0.9"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tiejunhu/mcp-smart-proxy/releases/download/v0.0.9/msp-v0.0.9-aarch64-apple-darwin.tar.gz"
      sha256 "5b5a1388c0c37a502940b494b02c3b06525cad9f399dac87f10e01d93ef64468"
    else
      url "https://github.com/tiejunhu/mcp-smart-proxy/releases/download/v0.0.9/msp-v0.0.9-x86_64-apple-darwin.tar.gz"
      sha256 "1a40ca84206527e9ec7e3da1f892c8f08eaab884e621580c03a3fe2a3f7f0dec"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/tiejunhu/mcp-smart-proxy/releases/download/v0.0.9/msp-v0.0.9-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7355cf432f13ed67964f1de8116c26847a4ce4e10c5a56b64ee0aa99084613b0"
    else
      url "https://github.com/tiejunhu/mcp-smart-proxy/releases/download/v0.0.9/msp-v0.0.9-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f6fc1801784c17f33a140f995bdbd0d90af6424e5aa5c8fccaf88c41beb572db"
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
