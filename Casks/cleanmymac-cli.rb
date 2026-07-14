cask "cleanmymac-cli" do
  version "1.0.0"
  sha256 "f22dcf72e26a680e16e7d4deb0f36c0588f5beb0f7a892248e0ddacf68fb737a"

  url "https://cli.cleanmymac.com/"
  name "CleanMyMac 5 CLI"
  desc "Command-line interface for CleanMyMac"
  homepage "https://cleanmymac.com"

  app "CleanMyMac_5_CLI.app"

  binary "CleanMyMac_5_CLI.app/Contents/MacOS/CleanMyMac_5_CLI", target: "cleanmymac"
  binary "CleanMyMac_5_CLI.app/Contents/MacOS/CleanMyMac_5_CLI", target: "cmm"

  uninstall signal: [
    ["TERM", "com.macpaw.CleanMyMac5.CLI"],
    ["KILL", "com.macpaw.CleanMyMac5.CLI"],
  ]

  zap trash: [
    "~/Library/Group Containers/S8EX82NJP6.com.macpaw.CleanMyMac5.CLI",
    "~/Library/Application Scripts/S8EX82NJP6.com.macpaw.CleanMyMac5.CLI",
  ]
end
