class Msp < Formula
  desc "Smart proxy for multiple stdio MCP servers"
  homepage "https://github.com/tiejunhu/mcp-smart-proxy"
  version "0.0.6"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tiejunhu/mcp-smart-proxy/releases/download/v0.0.6/msp-v0.0.6-aarch64-apple-darwin.tar.gz"
      sha256 "bfcdbdc4d18542e67a1c17df339cebd29b138abbb64cfb216e45dbeee5126b20"
    else
      url "https://github.com/tiejunhu/mcp-smart-proxy/releases/download/v0.0.6/msp-v0.0.6-x86_64-apple-darwin.tar.gz"
      sha256 "27e5db74911f09c02df7928dee545458ff552ddb92d82d302dea7f03b594071c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/tiejunhu/mcp-smart-proxy/releases/download/v0.0.6/msp-v0.0.6-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b9ea22421cc5cb641d51952b48c28efcf119be0f054057ee9595b1c69b1e51ed"
    else
      url "https://github.com/tiejunhu/mcp-smart-proxy/releases/download/v0.0.6/msp-v0.0.6-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3ded6e364dbb737479f8961959625151c7af32ccbc945d40a075484c8ebdbae4"
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
