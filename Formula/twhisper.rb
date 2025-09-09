class Twhisper < Formula
  desc "Terminal-based voice-to-text transcription tool with AI formatting"
  homepage "https://github.com/svenmalvik/twhisper"
  url "https://github.com/svenmalvik/twhisper/archive/refs/tags/v#{version}.tar.gz"
  sha256 "dc894049b06b027a65223553468b7c55c1a1d09b3e78eb07ab1208ba045e7d16"
  license "MIT"
  head "https://github.com/svenmalvik/twhisper.git", branch: "main"

  depends_on "node@20"

  def install
    # Install Node.js dependencies (including dev dependencies for build)
    system "npm", "install"
    
    # Build the TypeScript project
    system "npm", "run", "build:prod"
    
    # Create the libexec directory for the Node.js application
    libexec.install Dir["*"]
    
    # Create a wrapper script that ensures Node.js is available
    (bin/"Twhisper").write <<~EOS
      #!/bin/bash
      export PATH="#{Formula["node@20"].opt_bin}:$PATH"
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
    assert_match "voice-to-text", shell_output("#{bin}/Twhisper --help 2>&1", 1)
  end
end