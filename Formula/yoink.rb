class Yoink < Formula
  desc "Commerce extension developer and operator CLI"
  homepage "https://github.com/jumpmindinc/commerce-yoink"
  version "0.5.28"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://yoink.cdn.jumpmind.cloud/yoink/0.5.28/yoink-aarch64-apple-darwin.tar.gz"
      sha256 "4f818c1267d092744e00634e81c4614cf79f1b94b105a233810385e6ed0bfd54"
    end
    if Hardware::CPU.intel?
      url "https://yoink.cdn.jumpmind.cloud/yoink/0.5.28/yoink-x86_64-apple-darwin.tar.gz"
      sha256 "14f815cd0bec1cadda1ed6de972142438f578926bb855c6d5f29ead33c4acd0c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://yoink.cdn.jumpmind.cloud/yoink/0.5.28/yoink-aarch64-unknown-linux-musl.tar.gz"
      sha256 "c5779bf321850cfce50c9dc26b8f444dcb9b38a15cdbae5296942a2a92156a57"
    end
    if Hardware::CPU.intel?
      url "https://yoink.cdn.jumpmind.cloud/yoink/0.5.28/yoink-x86_64-unknown-linux-musl.tar.gz"
      sha256 "28651c78d97b27961d77225b884be0800af6b34790e92d3613a07da74d47e2ef"
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
