class CageforgeCli < Formula
  desc "Command-line tool for running untrusted programs in Cageforge sandboxes"
  homepage "https://github.com/m62624/cageforge"
  version "0.7.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/m62624/cageforge/releases/download/v0.7.1/cageforge-cli-aarch64-apple-darwin.tar.xz"
      sha256 "9059c65a8d349113b7a051c59f656a3eff01e6658e0926be8c3e9f3dd9e92bcb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/m62624/cageforge/releases/download/v0.7.1/cageforge-cli-x86_64-apple-darwin.tar.xz"
      sha256 "7382272de5e76d467d587df99f69fb41e280967a7c0567fbbe984b833a26516d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/m62624/cageforge/releases/download/v0.7.1/cageforge-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5ecf30fb9c6e16b29a9d2a22a2f397a23150c54e7f998987577e7a571e1eb7cb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/m62624/cageforge/releases/download/v0.7.1/cageforge-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "620df4c9099f3cb9c0c5157e812f9a0ccab55abf6061a7ba901215db51c5e8a1"
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
