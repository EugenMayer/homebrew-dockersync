class Unison < Formula
  desc "File synchronization tool for OSX"
  homepage "https://www.cis.upenn.edu/~bcpierce/unison/"
  url "https://github.com/bcpierce00/unison/archive/v2.51.2.tar.gz"
  version "2.52.2"is
  sha256 "a2efcbeab651be6df69cc9b253011a07955ecb91fb407a219719451197849d5e"

  bottle do
    cellar :any_skip_relocation
    sha256 "eb01217a48646b393a4769bdc25e1e947667816a38de9003211ac0342b8ec611" => :high_sierra
    sha256 "f9a68dceab3225aecf77c698a6db9f6aacd4f3795a63c2abc4c4cffdb0a13af5" => :sierra
    sha256 "74a22e776363cdc5a6d849c77e92d08747cc97b8f48a579ccae909eb8eccdcfc" => :el_capitan
  end

  depends_on "ocaml" => :build

  def install
    ENV.deparallelize
    ENV.delete "CFLAGS" # ocamlopt reads CFLAGS but doesn't understand common options
    ENV.delete "NAME" # https://github.com/Homebrew/homebrew/issues/28642
    system "make", "src/mkProjectInfo"
    system "make", "UISTYLE=text"
    bin.install "src/unison"
    prefix.install_metafiles "src"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/unison -version")
  end
end
