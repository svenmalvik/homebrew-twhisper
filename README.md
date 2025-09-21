# Twhisper

```
┌───┬───┬───┬───┬───┬───┬───┬───┐
│ T │ W │ H │ I │ S │ P │ E │ R │
└───┴───┴───┴───┴───┴───┴───┴───┘
```

A powerful macOS desktop application that transforms your speech into perfectly formatted text using AI. With a convenient menu bar interface, get accurate transcriptions and have your text automatically formatted for emails, code documentation, messages, or general use. Supports English, Norwegian, Danish, and Finnish.

## 🏗️ Architecture

Twhisper is built as a **desktop application** for macOS with a clean menu bar interface:

```
twhisper/
├── electron/              # Electron desktop application
├── shared/                # Shared services and utilities
├── scripts/               # Development utilities
├── docs/                  # Documentation
└── test/                  # Integration tests
```

## 📦 Installation

### macOS DMG

Download the latest DMG from the [releases page](https://github.com/svenmalvik/twhisper/releases) for the desktop application:

1. Download the `twhisper-[version].dmg` file
2. Open the DMG and drag `Twhisper.app` to the Applications folder
3. Launch the app from Applications folder
4. **If blocked by macOS security**: Go to System Settings > Security and click "Open Anyway"
5. Look for the Twhisper icon in your menu bar (top right)
6. Right-click the icon to start recording

### From Source (Development)

```bash
# Clone the repository
git clone https://github.com/svenmalvik/twhisper.git
cd twhisper

# Install dependencies
npm ci

# Build the application
npm run build

# Run the Electron app
npm run start:electron
```

## 🛠️ Prerequisites

Before using Twhisper, you need:

**Required:**
- **Azure OpenAI Account** - [Set up here](https://azure.microsoft.com/en-us/products/ai-services/openai-service) for GPT text formatting

**Optional (for advanced features):**
- **Azure OpenAI Transcription Deployment** - Only needed if you set `USE_LOCAL_WHISPER=false` to use cloud transcription instead of local whisper.cpp

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
USE_LOCAL_WHISPER=false
# Set to false to use Azure OpenAI Whisper instead (requires AZURE_OPENAI_WHISPER_DEPLOYMENT)
AZURE_OPENAI_WHISPER_DEPLOYMENT=your-gpt-transcription-deployment-name
```

**Note**: Additional settings are available in the auto-generated configuration file. When you first run Twhisper, it creates `~/.twhisper/config` with all available options and their defaults.

### Configuration Priority

Configuration values are loaded in this priority order:
1. **Configuration File** (`~/.twhisper/config`) - highest priority
2. **Default Values** - lowest priority

**Note**: When you first run Twhisper, it will create a configuration file at `~/.twhisper/config` with all available settings and their defaults. You can customize any additional settings there.

## 🚀 Usage

### Basic Voice Transcription

Once configured, simply:
1. Look for the Twhisper icon in your menu bar
2. Right-click the icon to open the context menu
3. Select "Start Recording" or use the keyboard shortcut

### Menu Bar Controls

- **Click menu bar icon** - Access all recording and configuration options
- **Start Recording** - Begin voice transcription
- **Stop Recording** - End current recording session
- **Settings** - Access configuration options
- **Quit** - Exit the application

### Keyboard Shortcuts

- **Global hotkey** - Start/stop recording from anywhere on your Mac
- **Settings shortcut** - Quick access to configuration
- **Language switching** - Cycle through supported languages for local Whisper (English, Norwegian, Danish, Finnish)

## 🔧 Development

### Application Commands

```bash
# Install dependencies
npm ci

# Build the application
npm run build

# Build specific workspace
npm run build --workspace=electron
npm run build --workspace=shared

# Run tests
npm run test

# Development mode
npm run dev:electron   # Electron development mode
npm run dev:shared     # Watch mode for shared services

# Utility scripts
npm run debug:transcription    # Debug transcription service
npm run validate:macos        # Validate macOS requirements
npm run test:release-build    # Test release build process
```

### Electron Development

```bash
# Run Electron app in development
cd electron
npm run dev            # Development mode with hot reload
npm run start          # Run built version

# From root (recommended)
npm run dev:electron
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
├── electron/                     # Electron Desktop Application
│   ├── src/
│   │   ├── main/                # Main process (menu bar, system integration)
│   │   ├── renderer/            # Renderer process (UI)
│   │   └── preload/             # Preload scripts (IPC bridge)
│   ├── assets/                  # Application icons and resources
│   ├── dist/                    # Built Electron app
│   └── package.json             # Electron dependencies
│
├── shared/                      # Shared Services & Utilities
│   ├── services/                # Core business logic
│   │   ├── ProcessingPipeline.ts # Main orchestration
│   │   ├── RecordingService.ts   # Audio recording
│   │   ├── TranscriptionService.ts # Whisper integration
│   │   ├── FormattingService.ts  # GPT formatting
│   │   └── ...
│   ├── types/                   # TypeScript definitions
│   ├── interfaces/              # Service contracts
│   ├── utils/                   # Utility functions
│   ├── dist/                    # Built shared services
│   └── package.json             # Shared dependencies
│
├── scripts/                     # Development Scripts
│   ├── debug-transcription.js   # Debug utilities
│   ├── validate-macos.sh        # System validation
│   └── build-dmg.sh            # DMG building script
│
├── docs/                        # Documentation
│   ├── 1_specs/                 # Specifications
│   ├── 2_plans/                 # Planning documents
│   └── 3_tasks/                 # Task definitions
│
└── test/                        # Integration Tests
    ├── api-contract-validation-test.js
    ├── basic-integration-test.js
    └── ...
```

## 🧪 Testing

```bash
# Full test suite (may timeout due to API limits)
npm run test

# Integration tests
npm run test:integration

# Test release build process
npm run test:release-build

# Shared service tests
npm run test --workspace=shared

# Electron tests
npm run test --workspace=electron
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
- **Desktop App**: Electron + React (native macOS UI)
- **Backend Services**: Node.js + TypeScript
- **AI Integration**: Azure OpenAI (Whisper + GPT)
- **Audio**: node-record-lpcm16 + whisper.cpp
- **System Integration**: macOS menu bar, global shortcuts
- **Build**: TypeScript + npm workspaces + Electron Builder

## 📋 Troubleshooting

### Common Issues

1. **Environment Variables Not Loading**
   - The CLI now automatically loads `.env` from the project root
   - Ensure your `.env` file is in the root directory when developing

2. **Build Errors**
   - Build shared services first: `npm run build --workspace=shared`
   - Then build Electron app: `npm run build --workspace=electron`

3. **Import Errors**
   - Make sure shared services are built before building Electron app
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
npm run dev:electron     # Electron development mode
npm run dev:shared       # Watch mode for shared services

# Before committing
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