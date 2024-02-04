class GitAnnexArchiver < Formula
  desc "Coordinates typical git-annex routines."
  homepage "https://github.com/ksesong/git-annex-archiver"
  url "https://github.com/ksesong/git-annex-archiver/archive/refs/tags/v0.2.3.tar.gz"
  sha256 "50592febba6fa9fec5e1a2f55a6d52c1d6ea83df535c4b933988b5c254ae6cd4"

  depends_on "rust" => :build

  def install
    system "cargo", "build", "--release", "--bin", "git-annex-archiver"
    bin.install "target/release/git-annex-archiver"
  end

  service do
    run opt_bin/"git-annex-archiver"
    environment_variables PATH: std_service_path_env
    process_type :interactive
    keep_alive crashed: true
  end

  test do
    assert_equal "version: 0.2.3", shell_output("#{bin}/git-annex-archiver --version").strip
  end
end
