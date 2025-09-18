# Twhisper

```
┌───┬───┬───┬───┬───┬───┬───┬───┐
│ T │ W │ H │ I │ S │ P │ E │ R │
└───┴───┴───┴───┴───┴───┴───┴───┘
 Terminal Whisper CLI
```

A terminal-based voice-to-text transcription tool that transforms your speech into perfectly formatted text using AI. Record audio with a simple spacebar press, get accurate transcriptions, and have your text automatically formatted for emails, code documentation, messages, or general use.

## 🏗️ Architecture

Twhisper is built as a **monorepo** with a workspace-based architecture:

```
twhisper/
├── cli/                    # React/Ink CLI application
├── shared/                 # Shared services and utilities
├── electron/              # Future Electron status bar app
├── supabase/              # Database configuration
├── scripts/               # Development utilities
├── docs/                  # Documentation
└── test/                  # Integration tests
```

## 📦 Installation

### Option 1: Homebrew (Recommended)

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

### Option 2: From Source (Development)

```bash
# Clone the repository
git clone https://github.com/svenmalvik/twhisper.git
cd twhisper

# Install dependencies
npm ci

# Build all workspaces
npm run build

# Run the CLI
npm run start --workspace=cli
```

## 🛠️ Prerequisites

Before using Twhisper, you need:

**Required:**
- **Azure OpenAI Account** - [Set up here](https://azure.microsoft.com/en-us/products/ai-services/openai-service) for GPT text formatting

**Optional (for advanced features):**
- **Azure OpenAI Whisper Deployment** - Only needed if you set `USE_LOCAL_WHISPER=false` to use cloud transcription instead of local whisper.cpp

**Default behavior:** Twhisper uses local whisper.cpp for transcription (faster, offline, no API costs) and Azure OpenAI GPT for text formatting. You can optionally configure it to use Azure OpenAI for both transcription and formatting.

## ⚙️ Configuration

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

## 🚀 Usage

### Basic Voice Transcription

Once configured, simply run:

```bash
Twhisper
```

### Features Available to Everyone

Twhisper provides all features to every user without restrictions:

**🎤 Recording & Transcription:**
- ✅ **10-minute recordings** - Perfect for long meetings, interviews, and presentations
- ✅ **Real-time streaming** - See your words appear as you speak
- ✅ **Multilingual support** - English, Norwegian, Danish, and Finnish transcription
- ✅ **Local & cloud options** - Use local whisper.cpp or Azure OpenAI Whisper

**🎨 Text Formatting:**
- ✅ **All formatting modes** - Default, slack, professional casual
- ✅ **AI-powered formatting** - Azure OpenAI GPT for intelligent text enhancement
- ✅ **Automatic clipboard copy** - Seamless workflow integration

**💻 User Experience:**
- ✅ **Terminal UI** - Clean, responsive interface with React/Ink
- ✅ **Keyboard shortcuts** - Efficient voice-to-text workflow
- ✅ **Cross-platform** - Works on macOS, (Linux, and Windows not tested)

### Keyboard Controls

- **SPACE** - Start/stop audio recording
- **TAB** - Switch between formatting modes (default → slack → professional casual)
- **M** - Toggle processing mode (batch ↔ streaming)
- **W** - Toggle language (multilingual support included)
- **S** or **Ctrl+,** - Open Settings UI to view configuration
- **ESC** - Cancel current recording
- **Q** - Quit application

#### Settings UI Controls

When the Settings UI is open:
- **TAB** / **Shift+TAB** - Navigate between sections (circular)
- **↑** / **↓** - Navigate between fields within a section
- **ESC** - Close Settings UI

## 🔧 Development

### Monorepo Commands

```bash
# Install dependencies for all workspaces
npm ci

# Build all workspaces
npm run build

# Build specific workspace
npm run build --workspace=cli
npm run build --workspace=shared

# Run tests
npm run test
npm run test:fast      # TypeScript + lint checks only

# Development mode
npm run dev            # Watch mode for all workspaces
npm run dev:cli        # Watch mode for CLI only

# Utility scripts
npm run debug:transcription    # Debug transcription service
npm run validate:macos        # Validate macOS requirements
npm run test:release-build    # Test release build process
```

### CLI Development

```bash
# Run CLI in development
cd cli
npm run dev            # Watch mode
npm run start          # Run built version

# From root (recommended)
npm run start --workspace=cli
```

### Shared Services Development

```bash
# Build shared services
cd shared
npm run build
npm run dev           # Watch mode

# Run tests
npm run test
npm run test:integration
```

## 🏗️ Project Structure

```
twhisper/
├── cli/                           # CLI Application
│   ├── src/
│   │   ├── ui/                   # React/Ink UI components
│   │   └── index.ts              # CLI entry point
│   ├── dist/                     # Built CLI
│   └── package.json              # CLI dependencies
│
├── shared/                       # Shared Services & Utilities
│   ├── services/                 # Core business logic
│   │   ├── ProcessingPipeline.ts # Main orchestration
│   │   ├── RecordingService.ts   # Audio recording
│   │   ├── TranscriptionService.ts # Whisper integration
│   │   ├── FormattingService.ts  # GPT formatting
│   │   └── ...
│   ├── types/                    # TypeScript definitions
│   ├── interfaces/               # Service contracts
│   ├── utils/                    # Utility functions
│   ├── dist/                     # Built shared services
│   └── package.json              # Shared dependencies
│
├── electron/                     # Future Electron App
│   └── package.json              # Electron workspace
│
├── supabase/                     # Database & Functions (legacy)
│   ├── config.toml               # Supabase configuration
│   ├── functions/                # Edge functions
│   └── migrations/               # Database schema
│
├── scripts/                      # Development Scripts
│   ├── debug-transcription.js    # Debug utilities
│   ├── validate-macos.sh         # System validation
│   └── test-release-build.sh     # Release testing
│
├── docs/                         # Documentation
│   ├── 1_specs/                  # Specifications
│   ├── 2_plans/                  # Planning documents
│   └── 3_tasks/                  # Task definitions
│
└── test/                         # Integration Tests
    ├── api-contract-validation-test.js
    ├── basic-integration-test.js
    └── ...
```

## 🧪 Testing

```bash
# Fast tests (TypeScript + lint)
npm run test:fast

# Full test suite (may timeout due to API limits)
npm run test

# Integration tests
npm run test:integration

# Test release build process
npm run test:release-build

# Shared service tests
npm run test --workspace=shared

# CLI tests
npm run test --workspace=cli
```

## 📈 Architecture Patterns

### Service-Oriented Architecture
- **ServiceManager**: Manages lifecycle of all services
- **ProcessingPipeline**: Orchestrates recording → transcription → formatting
- **Event-driven**: Services communicate via EventEmitter patterns

### Monorepo Benefits
- **Code Sharing**: Shared services used by both CLI and future Electron app
- **Type Safety**: Consistent TypeScript types across all workspaces
- **Dependency Management**: Centralized dependency management
- **Build Pipeline**: Coordinated builds with proper dependency order

### Technology Stack
- **Frontend**: React + Ink (terminal UI)
- **Backend Services**: Node.js + TypeScript
- **AI Integration**: Azure OpenAI (Whisper + GPT)
- **Audio**: node-record-lpcm16 + whisper.cpp
- **Database**: Supabase (PostgreSQL) - legacy components
- **Authentication**: Removed - no authentication required
- **Build**: TypeScript + npm workspaces

## 📋 Troubleshooting

### Common Issues

1. **Environment Variables Not Loading**
   - The CLI now automatically loads `.env` from the project root
   - Ensure your `.env` file is in the root directory when developing

2. **Build Errors**
   - Build shared services first: `npm run build --workspace=shared`
   - Then build CLI: `npm run build --workspace=cli`

3. **Import Errors**
   - Make sure shared services are built before building CLI
   - Check TypeScript project references in `tsconfig.json`

4. **Audio Issues**
   - Run `npm run validate:macos` to check system requirements
   - Ensure microphone permissions are granted

For detailed troubleshooting, see [docs/TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md).

## 🤝 Contributing

1. **Fork the repository**
2. **Create a feature branch**: `git checkout -b feature/amazing-feature`
3. **Install dependencies**: `npm ci`
4. **Build all workspaces**: `npm run build`
5. **Run tests**: `npm run test:fast`
6. **Commit changes**: `git commit -m 'Add amazing feature'`
7. **Push to branch**: `git push origin feature/amazing-feature`
8. **Open a Pull Request**

### Development Workflow

```bash
# Start development
npm run dev              # Watch mode for all workspaces
npm run start --workspace=cli  # Run CLI

# Before committing
npm run test:fast        # Quick validation
npm run lint            # Code style check
npm run type-check      # TypeScript validation
```

## 📄 License

MIT License - see [LICENSE](LICENSE) file for details.

## 🔗 Links

- **Homepage**: [https://github.com/svenmalvik/twhisper](https://github.com/svenmalvik/twhisper)
- **Issues**: [https://github.com/svenmalvik/twhisper/issues](https://github.com/svenmalvik/twhisper/issues)
- **Homebrew Tap**: [https://github.com/svenmalvik/homebrew-twhisper](https://github.com/svenmalvik/homebrew-twhisper)

---

**Made with ❤️ by [Sven Malvik](https://github.com/svenmalvik)**