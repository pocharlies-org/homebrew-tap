cask "trisplit" do
  version "2.2.1"
  sha256 "dfcd1cb72595094e8666e976bf523cdad0c9ae125760ff546bba2055ed2a361e"

  url "https://github.com/pocharlies-org/trisplit/releases/download/v#{version}/Trisplit-#{version}.zip"
  name "Trisplit"
  desc "Grid window manager for macOS with per-monitor layouts"
  homepage "https://github.com/pocharlies-org/trisplit"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: ">= :ventura"

  app "Trisplit.app"

  # Self-signed, not notarized: drop the quarantine flag so Gatekeeper does not block it.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Trisplit.app"],
                   must_succeed: false
  end

  uninstall quit: "com.dibanez.trisplit"

  zap trash: [
    "~/Library/Application Support/trisplit",
    "~/Library/Caches/com.dibanez.trisplit",
    "~/Library/Logs/Trisplit",
    "~/Library/WebKit/com.dibanez.trisplit",
  ]

  caveats <<~EOS
    Trisplit is signed with a self-signed certificate (not notarized).
    On first launch, grant Accessibility in System Settings > Privacy & Security > Accessibility.
    Optional: brew install displayplacer, for monitor re-arrangement.
  EOS
end
