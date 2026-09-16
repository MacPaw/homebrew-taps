class PortableMemory < Formula
  include Language::Python::Virtualenv

  desc "Open, vendor-neutral .mem format and tool for AI memory"
  homepage "https://github.com/MacPaw/portable-memory"
  url "https://files.pythonhosted.org/packages/7e/09/625b6f71344347801f9bb60d6dac77e66da3c28af6db954876f2a0b35832/portable_memory-0.3.0.tar.gz"
  sha256 "f8459b7eee26b69b7e2586e5de0bb5853ccc8b0370007a595992f1109fc5ffb3"
  license "MIT"
  head "https://github.com/MacPaw/portable-memory.git", branch: "main"

  depends_on "python@3.14"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mem --version")

    # What the standard memory-export prompt returns in ChatGPT, Claude or Gemini.
    (testpath/"export.txt").write <<~TEXT
      ```
      [2026-01-05] - Prefers concise answers with code examples
      [2026-02-11] - Maintains Swift and Python SDKs for an open memory format
      ```
    TEXT

    mem_bundle = testpath/"my-memory.mem"
    output = shell_output("#{bin}/mem paste #{testpath}/export.txt --out #{mem_bundle} --source test")
    assert_match "2 episodes", output
    assert_path_exists mem_bundle/"manifest.json"
    assert_path_exists mem_bundle/"CHECKSUMS"

    assert_match "OK", shell_output("#{bin}/mem validate #{mem_bundle}")
    assert_match "integrity:   OK", shell_output("#{bin}/mem inspect #{mem_bundle}")
    assert_match "Prefers concise answers", shell_output("#{bin}/mem render #{mem_bundle}")

    # Tampering with a record must fail integrity verification.
    inreplace mem_bundle/"items/episode.jsonl", "concise", "verbose"
    assert_match "FAIL", shell_output("#{bin}/mem validate #{mem_bundle} 2>&1", 1)
  end
end
