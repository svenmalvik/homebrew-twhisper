class Twhisper < Formula
  desc "Terminal-based voice-to-text transcription tool with AI formatting"
  homepage "https://github.com/svenmalvik/twhisper"
  url "https://github.com/svenmalvik/homebrew-twhisper/raw/main/twhisper-0.1.40.tar.gz"
  sha256 "434f317f9853a2d39007b8e519fb6545a34b271f4cc52238e51d273dbccba341"
  license "MIT"

  depends_on "node@20"
  depends_on "sox"

  def install
    # Install the pre-built binary and dependencies
    libexec.install Dir["*"]
    
    # Create a wrapper script that ensures Node.js and sox are available
    (bin/"twhisper").write <<~EOS
      #!/bin/bash
      export PATH="#{Formula["node@20"].opt_bin}:#{Formula["sox"].opt_bin}:$PATH"
      exec "#{Formula["node@20"].opt_bin}/node" "#{libexec}/dist/index.js" "$@"
    EOS
  end

  def caveats
    <<~EOS
      Twhisper requires Azure OpenAI credentials to function.
      
      Before using Twhisper:
      1. Set up Azure OpenAI service with Whisper and GPT deployments
      2. Create a .env file in your working directory or set environment variables:
         AZURE_OPENAI_API_KEY=your_api_key
         AZURE_OPENAI_ENDPOINT=https://your-resource.openai.azure.com
         AZURE_OPENAI_WHISPER_DEPLOYMENT=your-whisper-deployment
         AZURE_OPENAI_GPT_DEPLOYMENT=your-gpt-deployment
         AZURE_OPENAI_API_VERSION=2024-02-01
      
      For detailed setup instructions, visit:
      https://github.com/svenmalvik/twhisper#configuration
    EOS
  end

  test do
    # Test that the binary exists and can show help
    assert_match "voice-to-text", shell_output("#{bin}/twhisper --help 2>&1", 1)
  end
end
