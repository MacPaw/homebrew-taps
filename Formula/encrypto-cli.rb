class EncryptoCli < Formula
  desc "command-line Encrypto archiver/unarchiver"
  homepage "http://macpaw.com/encrypto"
  url "https://github.com/MacPaw/homebrew-taps/raw/binaries/encrypto-cli.bundle-0.0.1.zip"
  sha256 "205831200254bf2cb13765ca799b1f1299c01195224af5639aee46aa19c85f3d"

  def install
    prefix.install "encrypto-cli.bundle" => "encrypto-cli.bundle"
    bin.install_symlink prefix/"encrypto-cli.bundle/Contents/MacOS/encrypto-cli"
  end

  test do
    system "#{bin}/encrypto-cli"
  end
end