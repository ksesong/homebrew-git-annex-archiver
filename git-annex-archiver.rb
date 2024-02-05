class GitAnnexArchiver < Formula
  desc "Coordinates typical git-annex routines."
  homepage "https://github.com/ksesong/git-annex-archiver"
  url "https://github.com/ksesong/git-annex-archiver/archive/refs/tags/v0.3.1.tar.gz"
  sha256 "1c56f4f783659c655da0f40b78cc9f99bd75cec0f7df41722d1d3af0831aede3"

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
    assert_equal "version: 0.3.1", shell_output("#{bin}/git-annex-archiver --version").strip
  end
end
