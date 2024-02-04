class GitAnnexArchiver < Formula
  desc "Coordinates typical git-annex routines."
  homepage "https://github.com/ksesong/git-annex-archiver"
  url "https://github.com/ksesong/git-annex-archiver/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "b9975d79f8f2ee72dc15596b9e5374565d28a8cec5bb9564078112388255d66f"

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
    assert_equal "version: 0.2.1", shell_output("#{bin}/git-annex-archiver --version").strip
  end
end
