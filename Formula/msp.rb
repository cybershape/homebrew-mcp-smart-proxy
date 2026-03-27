class Msp < Formula
  desc "Smart proxy for multiple stdio MCP servers"
  homepage "https://github.com/cybershape/mcp-smart-proxy"
  version "0.0.20"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cybershape/mcp-smart-proxy/releases/download/v0.0.20/msp-v0.0.20-aarch64-apple-darwin.tar.gz"
      sha256 "1df30c9088be9a74cb971d2e303a7dc1a229cbc6b79031259c46bb134f9a330f"
    else
      url "https://github.com/cybershape/mcp-smart-proxy/releases/download/v0.0.20/msp-v0.0.20-x86_64-apple-darwin.tar.gz"
      sha256 "175e0f48316607a16176306030ba36347063a48f2270557f8d8ddc3702f65c44"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/cybershape/mcp-smart-proxy/releases/download/v0.0.20/msp-v0.0.20-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0e3880acfed1fb49c1563b0d7a870da8ef70fcc08f7732fbb086310a5af269e9"
    else
      url "https://github.com/cybershape/mcp-smart-proxy/releases/download/v0.0.20/msp-v0.0.20-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ac9780ebbe3818e569135e658b0e5fe21871dd9daafad84c9ec17a171a18ae22"
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
