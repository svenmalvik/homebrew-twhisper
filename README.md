```
┌───┬───┬───┬───┬───┬───┬───┬───┐
│ T │ W │ H │ I │ S │ P │ E │ R │
└───┴───┴───┴───┴───┴───┴───┴───┘
 Terminal Whisper CLI
```

A terminal-based voice-to-text transcription tool that transforms your speech into perfectly formatted text using AI. Record audio with a simple spacebar press, get accurate transcriptions, and have your text automatically formatted for emails, code documentation, messages, or general use.

## Installation

To install Twhisper using this tap:

```bash
# Add the tap
brew tap svenmalvik/twhisper

# Install Twhisper
brew install twhisper
```

Or install directly in one command:

```bash
brew install svenmalvik/twhisper/twhisper
```

## Prerequisites

Before using Twhisper, you need:

**Required:**
- **Azure OpenAI Account** - [Set up here](https://azure.microsoft.com/en-us/products/ai-services/openai-service) for GPT text formatting

**Optional (for advanced features):**
- **Azure OpenAI Whisper Deployment** - Only needed if you set `USE_LOCAL_WHISPER=false` to use cloud transcription instead of local whisper.cpp

**Default behavior:** Twhisper uses local whisper.cpp for transcription (faster, offline, no API costs) and Azure OpenAI GPT for text formatting. You can optionally configure it to use Azure OpenAI for both transcription and formatting.

## Configuration

**First-time setup**: When you run Twhisper for the first time without any configuration, it will display a helpful welcome message with setup instructions.

Twhisper supports two methods of configuration:

### 1. Settings UI (View Configuration)

Press **S** or **Ctrl+,** while running Twhisper to open the Settings UI to view your current configuration:

- **Azure OpenAI**: View API credentials and deployments
- **Application**: View default mode, recording limits, and auto-copy behavior  
- **Audio**: View sample rates, channels, and audio thresholds
- **Interface**: View theme, waveform display, and refresh rates

**Note**: The Settings UI is read-only for viewing configuration. To make changes, edit the configuration file.

### 2. Configuration File

Create a `~/.twhisper/config` file with your configuration:

```bash
# Required: Azure OpenAI Configuration for text formatting
AZURE_OPENAI_API_KEY=your_api_key_here
AZURE_OPENAI_ENDPOINT=https://your-resource.openai.azure.com
AZURE_OPENAI_GPT_DEPLOYMENT=your-gpt-deployment-name
AZURE_OPENAI_API_VERSION=2024-02-15-preview

# Optional: Transcription Settings (defaults to local whisper.cpp)
USE_LOCAL_WHISPER=true  # Uses local whisper.cpp (default)
# Set to false to use Azure OpenAI Whisper instead (requires AZURE_OPENAI_WHISPER_DEPLOYMENT)
```

**Note**: Additional settings are available in the auto-generated configuration file. When you first run Twhisper, it creates `~/.twhisper/config` with all available options and their defaults.

### Configuration Priority

Configuration values are loaded in this priority order:
1. **Configuration File** (`~/.twhisper/config`) - highest priority
2. **Default Values** - lowest priority

**Note**: When you first run Twhisper, it will create a configuration file at `~/.twhisper/config` with all available settings and their defaults. You can customize any additional settings there.

## Usage

### Basic Voice Transcription

Once configured, simply run:

```bash
Twhisper
```

### Getting Started with Professional

Ready to unlock the full power of Twhisper? Here's how to get started:

```bash
# Step 1: Sign in (starter plan is instant) - Google OAuth only
twhisper login

# Step 2: Check your current plan
twhisper status

# Step 3: Upgrade to Professional (if desired)
twhisper subscribe

# Manage your subscription anytime
twhisper manage         # Update billing, cancel, or modify your plan
twhisper logout         # Sign out when needed
```

**Quick Commands:**
```bash
twhisper --help         # Need help? We've got you covered
twhisper --version      # Check which version you're running
twhisper status --refresh # Get the latest subscription info
```

#### Why Choose Professional?

**Starter Plan:**
- ✅ 1-minute recordings
- ✅ All formatting modes (default, email, code, message, slack, professional casual)
- ✅ Full AI transcription

**Professional Plan:
- ⭐ **10-minute recordings** - Perfect for long meetings, interviews, and presentations
- ⭐ **Real-time streaming** - See your words appear as you speak
- ⭐ **Priority support** - Get help when you need it most
- ⭐ **Support development** - Help us build amazing features for you

### Keyboard Controls

- **SPACE** - Start/stop audio recording
- **TAB** - Switch between formatting modes (default → email → code → message → slack → professional casual)
- **S** or **Ctrl+,** - Open Settings UI to view configuration
- **ESC** - Cancel current recording
- **Q** - Quit application

#### Settings UI Controls

When the Settings UI is open:
- **TAB** / **Shift+TAB** - Navigate between sections (circular)
- **↑** / **↓** - Navigate between fields within a section
- **ESC** - Close Settings UI

**Note**: The Settings UI is read-only for viewing configuration values.

### Formatting Modes

Twhisper offers six intelligent formatting modes that automatically adapt your transcribed speech for different contexts:

- **Default**: Clean, professional text with proper grammar, punctuation, and filler words removed. Perfect for general documentation and note-taking.
- **Email**: Professional business email formatting with appropriate structure, greetings, closings, and courteous tone. Ideal for workplace communication.
- **Code**: Technical documentation style with precise programming terminology and clear instructions. Optimized for AI IDEs and development commands.
- **Message**: Casual, conversational tone suitable for messaging apps and informal communication. Maintains natural speech patterns while improving clarity.
- **Slack**: Friendly team messaging format with engaging emojis and casual tone. Perfect for workplace chat applications.
- **Professional Casual**: Polished yet approachable business communication. Smart, confident tone suitable for professional Slack/Teams messages.

**How to switch modes**: Press **TAB** during recording or while idle to cycle through modes: default → email → code → message → slack → professional casual → default...

## Features

- 🎤 **Voice Recording**: Press SPACE to start/stop audio recording
- 🤖 **AI Transcription**: Uses local whisper.cpp by default, with Azure OpenAI Whisper as fallback
- ✨ **Smart Formatting**: Azure OpenAi-powered text formatting with multiple modes
- 📋 **Auto Clipboard**: Automatically copies formatted text to your clipboard
- ⌨️ **Keyboard Controls**: Simple keyboard shortcuts for all operations
- ⚙️ **Settings UI**: View current configuration in terminal interface
- 🎯 **Multiple Modes**: Default, Email, Code, Message, and Professional Casual formatting styles
- 🔄 **Flexible Configuration**: Config files and UI settings
- 🔐 **Authentication**: Google OAuth integration for secure account management (Google accounts only, for now)
- 💳 **Professional Subscriptions**: Stripe-powered subscription management with extended features
- 📊 **Usage Tracking**: Monitor recording limits and subscription status
- 🚀 **Streaming Mode**: Real-time transcription for Professional users

## Updating

To update to the latest version:

```bash
brew update
brew upgrade twhisper
```

## Uninstalling

To remove Twhisper:

```bash
brew uninstall twhisper
brew untap svenmalvik/twhisper  # Optional: removes the tap
```

## Troubleshooting

### Common Issues & Quick Fixes

**🔑 "API key not found" error:**
- Double-check your Azure OpenAI credentials in your `~/.twhisper/config` file
- Make sure your Azure OpenAI resource is active and accessible
- Try running `twhisper status` to see your current configuration

**🎤 "No microphone access" error:**
- Grant microphone permissions in System Preferences → Security & Privacy → Microphone
- Restart your terminal after granting permissions
- On newer macOS versions, you may need to restart the entire Terminal app

**🌐 "Network error" during transcription:**
- Verify your Azure OpenAI endpoint and deployment names are correct
- Check your internet connection
- Ensure your API quotas haven't been exceeded (check Azure portal)

**🔐 Authentication Issues:**
- If login fails, try `twhisper logout` followed by `twhisper login`
- Check your internet connection for Google OAuth
- Clear browser cache if the login page doesn't load properly

**💳 Subscription Problems:**
- Run `twhisper status --refresh` to get the latest subscription info
- If Professional features aren't working, try logging out and back in
- Contact support if payment went through but features aren't activated

**💡 Pro Tip:** Run `twhisper status` anytime to check your setup and subscription status!

## Support & Community

We're here to help! 🤝

### Get Help Fast
- **Installation problems?** [Report here](https://github.com/svenmalvik/homebrew-twhisper/issues) - we'll get you up and running
- **App not working as expected?** [Let us know](https://github.com/svenmalvik/Twhisper/issues) - we fix bugs quickly
- **Professional subscribers** get priority support - we typically respond within 24 hours

### Self-Service Options
- Run `twhisper --help` for quick command reference
- Check `twhisper status` to diagnose common issues
- Review the troubleshooting section above for instant fixes

### Feature Requests
Got an idea that would make Twhisper better? We love hearing from our users! [Share your ideas](https://github.com/svenmalvik/Twhisper/issues) with us.

## Contributing

1. Fork this repository
2. Make your changes to the formula
3. Test the formula locally
4. Submit a pull request

## License

This tap is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

The Twhisper CLI tool itself is also licensed under the MIT License.