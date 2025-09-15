class Twhisper < Formula
  desc "Terminal-based voice-to-text transcription tool with AI formatting"
  homepage "https://github.com/svenmalvik/twhisper"
  url "https://github.com/svenmalvik/homebrew-twhisper/raw/main/twhisper-0.1.38.tar.gz"
  sha256 "4618aa8321bbc2814a7642e9cb02ac006993c721de8911a9defaac2d7181208c"
  license "MIT"

  depends_on "node@20"
  depends_on "sox"
  depends_on "whisper-cpp", optional: true

  def install
    # Install the pre-built binary and dependencies
    libexec.install Dir["*"]
    
    # Create a wrapper script that ensures Node.js and sox are available
    (bin/"twhisper").write <<~EOS
      #!/bin/bash
      export PATH="#{Formula["node@20"].opt_bin}:#{Formula["sox"].opt_bin}:/opt/hostedtoolcache/node/20.19.5/x64/bin:/snap/bin:/home/runner/.local/bin:/opt/pipx_bin:/home/runner/.cargo/bin:/home/runner/.config/composer/vendor/bin:/usr/local/.ghcup/bin:/home/runner/.dotnet/tools:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin"
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

      For local/streaming transcription (optional):
      3. Install whisper-cpp: brew install whisper-cpp
      4. Download a model: mkdir -p ~/.whisper && curl -L "https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-tiny.en.bin" -o ~/.whisper/ggml-tiny.en.bin

      For detailed setup instructions, visit:
      https://github.com/svenmalvik/twhisper#configuration
    EOS
  end

  test do
    # Test that the binary exists and can show help
    assert_match "voice-to-text", shell_output("#{bin}/twhisper --help 2>&1", 1)
  end
end
