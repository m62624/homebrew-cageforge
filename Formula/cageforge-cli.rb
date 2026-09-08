class CageforgeCli < Formula
  desc "Command-line adapter for running programs through Cageforge sandboxes"
  homepage "https://github.com/m62624/cageforge"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/m62624/cageforge/releases/download/v0.1.0/cageforge-cli-aarch64-apple-darwin.tar.xz"
      sha256 "b18aae59619a289426f5109653e6d9534c138fc1bf8796104228bffa30b939f8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/m62624/cageforge/releases/download/v0.1.0/cageforge-cli-x86_64-apple-darwin.tar.xz"
      sha256 "4318404a54a84c5dd660b82ebecb4384de6fcfbbd12af94b5349c758c2111cfe"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/m62624/cageforge/releases/download/v0.1.0/cageforge-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "205e2e319c369c152db4bcc9948d0cc7ddd420064b3c93d690f56e1f88de7695"
    end
    if Hardware::CPU.intel?
      url "https://github.com/m62624/cageforge/releases/download/v0.1.0/cageforge-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "926a433b5a678cda817e595aead5a5b318ce7439391558707c247e3197117ed8"
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
