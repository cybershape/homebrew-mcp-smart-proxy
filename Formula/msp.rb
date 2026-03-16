class Msp < Formula
  desc "Smart proxy for multiple stdio MCP servers"
  homepage "https://github.com/tiejunhu/mcp-smart-proxy"
  version "0.0.10"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tiejunhu/mcp-smart-proxy/releases/download/v0.0.10/msp-v0.0.10-aarch64-apple-darwin.tar.gz"
      sha256 "51767d8b4e43b3d38d3321649c9a5270332f18547580eebd73430ddff1276d09"
    else
      url "https://github.com/tiejunhu/mcp-smart-proxy/releases/download/v0.0.10/msp-v0.0.10-x86_64-apple-darwin.tar.gz"
      sha256 "e2c67d798dbc3dca3a272691ca753bb1c85fdb9f91ba9e6f66e9cf67bddbe2a5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/tiejunhu/mcp-smart-proxy/releases/download/v0.0.10/msp-v0.0.10-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "5ea13a44d76d172b45fcd2b3559791bf71ed2f2b81a06af82c727d110da8e554"
    else
      url "https://github.com/tiejunhu/mcp-smart-proxy/releases/download/v0.0.10/msp-v0.0.10-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1bff1f575fb4dd1002318f9a2b6b0b4c71febbb4d8ba9fa8ba5e96a3f57f69c0"
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
