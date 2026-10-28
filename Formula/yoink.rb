class Yoink < Formula
  desc "Commerce extension developer and operator CLI"
  homepage "https://github.com/jumpmindinc/commerce-yoink"
  version "0.5.26"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://yoink.cdn.jumpmind.cloud/yoink/0.5.26/yoink-aarch64-apple-darwin.tar.gz"
      sha256 "2fdd4fb0f7c4011a4543514767513aae67857357beb3c559b587b0a650ad76d7"
    end
    if Hardware::CPU.intel?
      url "https://yoink.cdn.jumpmind.cloud/yoink/0.5.26/yoink-x86_64-apple-darwin.tar.gz"
      sha256 "8d53f3921c798fff6a96b523d1db8f1ae56c905b09077031af9b6b9c2e1d8b29"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://yoink.cdn.jumpmind.cloud/yoink/0.5.26/yoink-aarch64-unknown-linux-musl.tar.gz"
      sha256 "93598af74a479606ff34f26de700b2a4da12d34ccbf2ba52945f9b56fc093b34"
    end
    if Hardware::CPU.intel?
      url "https://yoink.cdn.jumpmind.cloud/yoink/0.5.26/yoink-x86_64-unknown-linux-musl.tar.gz"
      sha256 "54785776f218313ff9150da1d99cd56bf65f005e6725ad19cba14b6c9dae0869"
    end
  end
  license "LicenseRef-Proprietary"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static": {}
  }

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
      bin.install "yoink"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "yoink"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "yoink"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "yoink"
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
