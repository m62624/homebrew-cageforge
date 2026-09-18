class CageforgeCli < Formula
  desc "Command-line tool for running untrusted programs in Cageforge sandboxes"
  homepage "https://github.com/m62624/cageforge"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/m62624/cageforge/releases/download/v0.4.0/cageforge-cli-aarch64-apple-darwin.tar.xz"
      sha256 "41b42468c400b55d3325e994f96dae9f497537be6ce03d7c576739c1a6da09e4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/m62624/cageforge/releases/download/v0.4.0/cageforge-cli-x86_64-apple-darwin.tar.xz"
      sha256 "4c5d16abc95366a125a47b3b67f5ef65ec69ea8426ce11c981e33f988e837d06"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/m62624/cageforge/releases/download/v0.4.0/cageforge-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4c56bec82ea85c98e57b303540947f0e988d1d9830591f82b9ff8d5250cb2491"
    end
    if Hardware::CPU.intel?
      url "https://github.com/m62624/cageforge/releases/download/v0.4.0/cageforge-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7272bb79101b050319eb0b1ad269bd149eb683d8b2e5537a9762f166b8b02c4c"
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
