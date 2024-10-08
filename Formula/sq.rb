class Sq < Formula
  desc "Sequoia-PGP command-line tool"
  homepage "https://sequoia-pgp.org"
  url "https://gitlab.com/sequoia-pgp/sequoia-sq/-/archive/v0.38.0/sequoia-sq-v0.38.0.tar.gz"
  sha256 "9fd32ad0de3388804e21205003821710d2faf99d5c85a50bd97da3e7e480921b"
  license "GPL-2.0-or-later"

  depends_on "capnp" => :build
  depends_on "nettle" => :build
  depends_on "rust" => :build

  on_linux do
    depends_on "openssl@3" # Uses Secure Transport on macOS
  end

  def install
    ENV["OPENSSL_DIR"] = Formula["openssl@3"].opt_prefix if OS.linux?
    ENV["ASSET_OUT_DIR"] = buildpath

    system "cargo", "install", *std_cargo_args
    man1.install Dir["man-pages/*.1"]

    bash_completion.install "shell-completions/sq.bash"
    zsh_completion.install "shell-completions/_sq"
    fish_completion.install "shell-completions/sq.fish"
  end

  test do
    # This isn't a test, it's a useless placeholder.
    # If I had a test, I'd have submitted this formula to Homebrew.
    true
  end
end
