class Yoink < Formula
  desc "Commerce extension developer and operator CLI"
  homepage "https://github.com/jumpmindinc/commerce-yoink"
  version "0.5.24"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://yoink.cdn.jumpmind.cloud/yoink/0.5.24/yoink-aarch64-apple-darwin.tar.gz"
      sha256 "1642e2560dc3414136f23fea2eb678ec17e0889089b53af554739387c871b5cb"
    end
    if Hardware::CPU.intel?
      url "https://yoink.cdn.jumpmind.cloud/yoink/0.5.24/yoink-x86_64-apple-darwin.tar.gz"
      sha256 "c47c490c890fc213b8cb98d4cf7b5ba1e1f875454a93ee3cc9053dea07fe8245"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://yoink.cdn.jumpmind.cloud/yoink/0.5.24/yoink-aarch64-unknown-linux-musl.tar.gz"
      sha256 "47d7431369f787fdb20d9f0fc91bf5181f2cf191743dc871f2d72b0cc1cd79d4"
    end
    if Hardware::CPU.intel?
      url "https://yoink.cdn.jumpmind.cloud/yoink/0.5.24/yoink-x86_64-unknown-linux-musl.tar.gz"
      sha256 "b14b725aa1664757ca7313e32ebd4aea37e0bb8d6620490bd0584050a93402c1"
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
