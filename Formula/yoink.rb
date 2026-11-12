class Yoink < Formula
  desc "Commerce extension developer and operator CLI"
  homepage "https://github.com/jumpmindinc/commerce-yoink"
  version "0.5.34"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://yoink.cdn.jumpmind.cloud/yoink/0.5.34/yoink-aarch64-apple-darwin.tar.gz"
      sha256 "dcf3733417a29bc31b67740b80ab0f6437affdb380de6d3e81fd6c68d437e8d3"
    end
    if Hardware::CPU.intel?
      url "https://yoink.cdn.jumpmind.cloud/yoink/0.5.34/yoink-x86_64-apple-darwin.tar.gz"
      sha256 "b84bbb246916b69c257061ebe91b2005e94a9fe4fd78b87d492ea3a35c01d190"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://yoink.cdn.jumpmind.cloud/yoink/0.5.34/yoink-aarch64-unknown-linux-musl.tar.gz"
      sha256 "911e1f5742b0fd74142e9be68fde317516fda4bb53f42ccbf31259f326f05969"
    end
    if Hardware::CPU.intel?
      url "https://yoink.cdn.jumpmind.cloud/yoink/0.5.34/yoink-x86_64-unknown-linux-musl.tar.gz"
      sha256 "198a94d820cc2989a206a9cd92bc5fb9023723882c673ba13d38053e8b9b8371"
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
