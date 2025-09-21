class Twhisper < Formula
  desc "Terminal-based voice-to-text transcription tool with AI formatting"
  homepage "https://github.com/svenmalvik/twhisper"
  url "https://github.com/svenmalvik/twhisper/releases/download/v0.3.12/twhisper-0.3.12.tar.gz"
  sha256 "1bd8ba4c41e8373cba0dcba01ba512bea894ca5c59f3988c3dd2a4a0ab2cd5b2"
  license "MIT"

  depends_on "node@20"
  depends_on "sox"
  depends_on "whisper-cpp"

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

      For local/streaming transcription:
      3. Download a model (optional): mkdir -p ~/.whisper && curl -L "https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-tiny.en.bin" -o ~/.whisper/ggml-tiny.en.bin
         Note: whisper-cpp is now automatically installed as a dependency

      For detailed setup instructions, visit:
      https://github.com/svenmalvik/twhisper#configuration
    EOS
  end

  test do
    # Test that the binary exists and can show version
    assert_match "Twhisper v", shell_output("#{bin}/twhisper --version")
  end
end
