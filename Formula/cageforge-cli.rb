class CageforgeCli < Formula
  desc "Command-line tool for running untrusted programs in Cageforge sandboxes"
  homepage "https://github.com/m62624/cageforge"
  version "0.6.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/m62624/cageforge/releases/download/v0.6.1/cageforge-cli-aarch64-apple-darwin.tar.xz"
      sha256 "d9d7fc23c5716479d4f408c84716934918e37f9f4ee881e9e94ed2f46d6e9296"
    end
    if Hardware::CPU.intel?
      url "https://github.com/m62624/cageforge/releases/download/v0.6.1/cageforge-cli-x86_64-apple-darwin.tar.xz"
      sha256 "318636302f464af1f5347108e0573b4f07428fe5bbf8a163094a8f5e799b1a38"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/m62624/cageforge/releases/download/v0.6.1/cageforge-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "366567995afe41d2ba7cc05c8ae6277c25d09f8942a354639b51fa9422ac0bee"
    end
    if Hardware::CPU.intel?
      url "https://github.com/m62624/cageforge/releases/download/v0.6.1/cageforge-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "891c323b5dc31998b923306bb2c021aa185a6f2ffffd2504542b574be7c117cb"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-pc-windows-gnu":    {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "cageforge-cli"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "cageforge-cli"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "cageforge-cli"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "cageforge-cli"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
