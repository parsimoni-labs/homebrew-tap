class Ofpp < Formula
  desc "FPP-to-OCaml code generator for NASA F Prime models"
  homepage "https://tangled.org/parsimoni-labs/ofpp"
  license "ISC"
  version "20260224"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/ofpp-20260224.arm64_sonoma.bottle.tar.gz"
      sha256 "8993a0ecb7a1a3872cd6029c260fbcffc8fc2ab96b71686934ccdfe8e204de5d"
    end
    on_intel do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/ofpp-latest.sonoma.bottle.tar.gz"
      sha256 :no_check
    end
  end

  on_linux do
    url "https://homebrew-bottles.s3.fr-par.scw.cloud/ofpp-latest.x86_64_linux.bottle.tar.gz"
    sha256 :no_check
  end

  head "https://tangled.org/parsimoni-labs/mono.git", branch: "main"

  head do
    depends_on "ocaml" => :build
    depends_on "opam" => :build
    depends_on "dune" => :build
  end

  def install
    if build.head?
      system "opam", "init", "--disable-sandboxing", "--no-setup", "-y" unless File.exist?("#{Dir.home}/.opam")
      system "opam", "install", ".", "--deps-only", "--with-test=false", "-y", "--working-dir"
      system "opam", "exec", "--", "dune", "build", "bin/main.exe"
      bin.install "_build/default/bin/main.exe" => "ofpp"
    else
      bin.install "ofpp"
    end
  end

  test do
    system bin/"ofpp", "--help"
  end
end
