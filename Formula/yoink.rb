class Yoink < Formula
  desc "Commerce extension developer and operator CLI"
  homepage "https://github.com/jumpmindinc/commerce-yoink"
  version "0.5.13"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://yoink.cdn.jumpmind.cloud/yoink/0.5.13/yoink-aarch64-apple-darwin.tar.gz"
      sha256 "bc816705974d852d77d31e6be410cb649ec362c971dce208cd6fa7291c6c5bc7"
    end
    if Hardware::CPU.intel?
      url "https://yoink.cdn.jumpmind.cloud/yoink/0.5.13/yoink-x86_64-apple-darwin.tar.gz"
      sha256 "207c0e33a3c5c8a999535db307a41214ef80c72bb0fe0bd86ba43b8b0bdd9db4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://yoink.cdn.jumpmind.cloud/yoink/0.5.13/yoink-aarch64-unknown-linux-musl.tar.gz"
      sha256 "02aad783777d6db1a5e901bf1626ede0c6de4e64394341be573c1eb8f83d3eb8"
    end
    if Hardware::CPU.intel?
      url "https://yoink.cdn.jumpmind.cloud/yoink/0.5.13/yoink-x86_64-unknown-linux-musl.tar.gz"
      sha256 "156f5997ddfd7e6adb6059056d50549945536c34da83e53d1cdf2c51c93621ef"
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
