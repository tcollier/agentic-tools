# Agentic Tools for Claude Code

Stage-aware development workflow commands for Claude Code that help you build, audit, and improve codebases based on your company's current stage.

## Commands

### `/prototype [description]`
Build rapid prototypes with opinionated defaults for 10+ platforms:
- Web (React + TypeScript + Vite + Tailwind)
- iOS/Android (React Native + Expo)
- Desktop (Electron + React)
- CLI (Python + Click)
- Backend API (FastAPI + Python)
- Browser Extension (TypeScript + Manifest V3)
- Google AppsScript
- Serverless (Cloudflare Workers)
- Bot (Slack/Discord/Telegram)

### `/audit`
Evaluate your codebase against stage-appropriate criteria and create an actionable plan:
- Identifies your company stage (6 stages from Exploratory to Established)
- Explores the codebase
- Creates concrete, implementation-ready action items
- Optional: Uses [beads](https://github.com/steveyegge/beads) for persistent issue tracking (auto-installs if you want it)
- Fallback: Uses TodoWrite for session-local todos

### `/ready`
Execute the audit action plan to make your codebase ready for your current stage:
- Detects existing audit plan (beads or TodoWrite)
- Runs `/audit` if needed
- Implements each action item systematically
- Verifies changes as it goes

## Installation

### Interactive Install (Recommended)
```bash
claude/bin/install
```

The installer will ask whether you want:
1. **Global installation** (`~/.claude/`) - Available in all your projects
2. **Project installation** (`<project>/.claude/`) - Only available in this project (good for teams)

### Non-Interactive Install

**Global (all projects):**
```bash
claude/bin/install --global
```

**Project-specific:**
```bash
claude/bin/install --project .
```

**Remote project:**
```bash
claude/bin/install --project /path/to/project
```

## Company Stages

The audit and ready commands understand 6 company stages:

| Stage | Revenue | Team Size | Customers | What Matters |
|-------|---------|-----------|-----------|--------------|
| **1. Exploratory** | $0 | 1-3 | 0 | Can run locally |
| **2. Early Validation** | <$10K MRR | 2-5 | 1-5 | Git, README, can deploy |
| **3. Proven Concept** | $10K-$100K MRR | 5-15 | 10-50 | All P0 + basic monitoring |
| **4. Early Scaling** | $100K-$1M MRR | 15-50 | 50-500 | P0 + P1 + architecture |
| **5. Hypergrowth** | $1M+ MRR | 50-500+ | 500-10K+ | Everything + performance |
| **6. Established** | Varies | Varies | Varies | Excellence + efficiency |

Commands only flag what matters for YOUR stage, preventing both under-engineering and over-engineering.

## Beads Integration (Optional)

The `/audit` command can optionally use [beads](https://github.com/steveyegge/beads) for persistent issue tracking:

**Benefits:**
- Issues persist across Claude Code sessions (git-backed)
- Track dependencies between issues
- Query ready work: `bd ready`
- Works across machines and branches
- Built for AI agents

**Auto-install:**
When you run `/audit` for the first time, it will offer to install beads for you. Just say yes!

**Manual install:**
```bash
curl -fsSL https://raw.githubusercontent.com/steveyegge/beads/main/scripts/install.sh | bash
bd init
```

## Example Workflows

### Building a New Prototype
```bash
# In Claude Code
/prototype a CLI tool for analyzing git repositories

# Claude will:
# 1. Ask what you're building (or use your description)
# 2. Suggest Python + Click as the tech stack
# 3. Build a working prototype with sample data
# 4. Provide run instructions
```

### Making Code Production-Ready
```bash
# In Claude Code
/audit

# Claude will:
# 1. Ask what stage your company is at
# 2. Explore the codebase
# 3. Create specific action items (beads or TodoWrite)
# 4. Tell you what to skip (doesn't matter yet)

/ready

# Claude will:
# 1. Use the audit plan (or run /audit if needed)
# 2. Implement each item systematically
# 3. Verify changes as it goes
# 4. Summarize what was added and skipped
```

### Customizing Platform Defaults
Edit `.claude/prototype-preferences.json`:
```json
{
  "web": {
    "framework": "vue",
    "language": "typescript",
    "bundler": "vite",
    "styling": "tailwind"
  },
  "cli": {
    "language": "go",
    "framework": "cobra"
  }
}
```

## File Structure

After installation:
```
.claude/                           # or ~/.claude/ for global
├── commands/
│   ├── prototype.md              # Platform defaults + prototyping guide
│   ├── audit.md                  # Stage-aware analysis
│   └── ready.md                  # Execute audit plan
├── production-criteria.md        # 6 stages + what matters at each
└── prototype-preferences.json    # Your platform preferences
```

## Philosophy

**Stage-Appropriate Development:**
- Don't add tests when you're iterating rapidly (Stage 2)
- Don't skip tests when you're scaling (Stage 4)
- Don't optimize costs before you have scale (Stage 5)
- Each stage has different priorities

**Opinionated Defaults:**
- Battle-tested tech stacks for 10 platforms
- Fast iteration over perfect architecture
- Clear explanations for why each choice was made

**DRY Design:**
- Shared production criteria for audit and ready
- Platform defaults in one place
- User overrides via simple JSON config

## Contributing

Found a bug or have a suggestion? Open an issue or PR!

## License

MIT
