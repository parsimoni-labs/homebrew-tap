class Ofpp < Formula
  desc "FPP-to-OCaml code generator for NASA F Prime models"
  homepage "https://tangled.org/parsimoni-labs/ofpp"
  license "ISC"
  version "20260224"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/ofpp-20260224.arm64_sonoma.bottle.tar.gz"
      sha256 "e28946a113c19bd377d14ad2b32fdb34d23b611b90eb05beb8298fe9d3139300"
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
