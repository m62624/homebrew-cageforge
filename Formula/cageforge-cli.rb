class CageforgeCli < Formula
  desc "Command-line adapter for running programs through Cageforge sandboxes"
  homepage "https://github.com/m62624/cageforge"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/m62624/cageforge/releases/download/v0.1.0/cageforge-cli-aarch64-apple-darwin.tar.xz"
      sha256 "cd46c236f666f8da7f947faa20ea64a0ad74d9e3e8c712ca4cb27c8c44f0652c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/m62624/cageforge/releases/download/v0.1.0/cageforge-cli-x86_64-apple-darwin.tar.xz"
      sha256 "8b18102411d5a10b179f1e283d088626be60e405c961632248ec9f0944d3cd33"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/m62624/cageforge/releases/download/v0.1.0/cageforge-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "103c268536dcf93c72cf0d5d6b7732085036128b111bc644afb627ec61661810"
    end
    if Hardware::CPU.intel?
      url "https://github.com/m62624/cageforge/releases/download/v0.1.0/cageforge-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "40119b46d92b2252dd30f974d46bf93195b7276a074b9b9b4678476a87a52d50"
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
