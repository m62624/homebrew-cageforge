class CageforgeCli < Formula
  desc "Command-line tool for running untrusted programs in Cageforge sandboxes"
  homepage "https://github.com/m62624/cageforge"
  version "0.7.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/m62624/cageforge/releases/download/v0.7.0/cageforge-cli-aarch64-apple-darwin.tar.xz"
      sha256 "7e109e527a6db40b5c63ea734f9beabc7eab480aa9f7ede72cde84131c3b061b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/m62624/cageforge/releases/download/v0.7.0/cageforge-cli-x86_64-apple-darwin.tar.xz"
      sha256 "95eb2e83c592db715c57b3ef67b22672000f35143eb1fcccec2ebdec72ad3cc3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/m62624/cageforge/releases/download/v0.7.0/cageforge-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3320b7deb74208e5d34e9f55aa4942837f45b1460df36e303b33246894f02aeb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/m62624/cageforge/releases/download/v0.7.0/cageforge-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ddeadd87651596bb57fac8ddcd425b2d018a0c600f94072550d5a16c57a4b64a"
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
