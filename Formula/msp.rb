class Msp < Formula
  desc "Smart proxy for multiple stdio MCP servers"
  homepage "https://github.com/tiejunhu/mcp-smart-proxy"
  version "0.0.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tiejunhu/mcp-smart-proxy/releases/download/v0.0.11/msp-v0.0.11-aarch64-apple-darwin.tar.gz"
      sha256 "9e85a7bb031ea47e1e094b2b05d6ff8d66b54845a39fb80d2b854fa89522b57a"
    else
      url "https://github.com/tiejunhu/mcp-smart-proxy/releases/download/v0.0.11/msp-v0.0.11-x86_64-apple-darwin.tar.gz"
      sha256 "9b6d45f16d31199057f8546efde7f64ae3e67bc35cd02c398ec354939902c0ae"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/tiejunhu/mcp-smart-proxy/releases/download/v0.0.11/msp-v0.0.11-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2905327964640050369de119bac748d8e100ec2c3299e4cdcb0e8274f8a89fcc"
    else
      url "https://github.com/tiejunhu/mcp-smart-proxy/releases/download/v0.0.11/msp-v0.0.11-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "42c4b6dce3fe804f486101dd3153a67eb8823a57a4e0cf4c8fb6deaa9464b87f"
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
