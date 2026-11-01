class Ncompose < Formula
  desc "Docker Compose for native macOS binaries"
  homepage "https://github.com/mach25/ncompose"
  url "https://github.com/mach25/ncompose/releases/download/v0.0.1/ncompose-0.0.1-macos-universal.tar.gz"
  sha256 "4beeda8c11f599387eb93637247cc2fb04c990429b043ea749166cc545c1c55d"
  license any_of: ["MIT", "Apache-2.0"]

  depends_on :macos

  def install
    bin.install "bin/ncompose"
    # The CLI injects this into services; it finds it in ../lib relative to itself.
    lib.install "lib/libncompose_shim.dylib"
  end

  def caveats
    <<~EOS
      ncompose gives every service its own loopback address. Create the address pool
      once (asks for sudo; installs a LaunchDaemon that re-creates it at boot):
        ncompose system install
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ncompose --version")
    (testpath/"ncompose.yaml").write <<~YAML
      services:
        web:
          binary: /usr/bin/true
          ports: ["18080:8080"]
    YAML
    output = shell_output("#{bin}/ncompose config")
    assert_match "127.10.0.2", output
  end
end
