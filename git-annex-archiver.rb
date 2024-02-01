class GitAnnexArchiver < Formula
  desc "Coordinates typical git-annex routines."
  homepage "https://github.com/ksesong/git-annex-archiver"
  url "https://github.com/ksesong/git-annex-archiver/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "b879dc9d4ae93e9c42ee470a20cfe0a14c2090959ae574af93df4a6c772de11e"

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
    assert_equal "version: 0.1.1", shell_output("#{bin}/git-annex-archiver --version").strip
  end
end
