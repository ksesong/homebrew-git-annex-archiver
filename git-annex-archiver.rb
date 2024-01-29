class GitAnnexArchiver < Formula
  desc "Coordinates typical git-annex routines."
  homepage "https://github.com/ksesong/git-annex-archiver"
  url "https://github.com/ksesong/git-annex-archiver/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "ebcf84ea55c70f8f1598beede34aea1ec0d2ba2d0cfd2faf9e67e8b5416fa836"

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
    assert_equal "version: 0.1.0", shell_output("#{bin}/git-annex-archiver --version").strip
  end
end
