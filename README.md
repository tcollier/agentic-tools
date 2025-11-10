# Agentic Tools for Claude Code

Stage-aware codebase auditing for Claude Code that helps you evaluate and improve your codebase based on your company's current stage.

## Command

### `/audit`
Evaluate your codebase against stage-appropriate criteria and create an actionable plan:
- Identifies your company stage (6 stages from Exploratory to Established)
- Intelligently handles codebases of all sizes (simple, medium, or large)
- For large codebases: breaks into modules and audits separately
- Creates concrete, implementation-ready action items
- Optional: Uses [beads](https://github.com/steveyegge/beads) for persistent issue tracking (auto-installs if you want it)
- Fallback: Uses TodoWrite for session-local todos

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

The audit command understands 6 company stages:

| Stage | Revenue | Team Size | Customers | What Matters |
|-------|---------|-----------|-----------|--------------|
| **1. Exploratory** | $0 | 1-3 | 0 | Can run locally |
| **2. Early Validation** | <$10K MRR | 2-5 | 1-5 | Git, README, can deploy |
| **3. Proven Concept** | $10K-$100K MRR | 5-15 | 10-50 | All P0 + basic monitoring |
| **4. Early Scaling** | $100K-$1M MRR | 15-50 | 50-500 | P0 + P1 + architecture |
| **5. Hypergrowth** | $1M+ MRR | 50-500+ | 500-10K+ | Everything + performance |
| **6. Established** | Varies | Varies | Varies | Excellence + efficiency |

The command only flags what matters for YOUR stage, preventing both under-engineering and over-engineering.

## Module-Based Audits

For large codebases (>200 files or 4+ modules), `/audit` intelligently breaks down the evaluation:

### Automatic Detection
- **Simple** (<50 files): Single-pass audit
- **Medium** (50-200 files): Single-pass with structural focus
- **Large** (>200 files or 4+ modules): Module-by-module audit

### Module Identification
For large codebases, automatically detects:
- Monorepo packages (`packages/*`, `apps/*`, `services/*`)
- Tech boundaries (backend vs frontend vs mobile)
- Service boundaries (microservices)
- Domain boundaries (feature-based organization)

### Benefits
- Per-module readiness scores (API: 7/10, Web: 5/10)
- Module-labeled action items (`-l module:api`, `[Frontend]`)
- Cross-cutting concern identification (logging, CI/CD, monitoring)
- Focused, manageable action plans for complex repositories

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

## Example Workflow

```bash
# In Claude Code
/audit

# Claude will:
# 1. Ask what stage your company is at
# 2. Assess codebase size and structure
# 3. For large codebases: identify modules
# 4. Explore the codebase (whole or by module)
# 5. Create specific action items (beads or TodoWrite)
# 6. Provide readiness score(s) and summary
# 7. Tell you what to skip (doesn't matter yet)

# View action items with beads:
bd ready             # See what's ready to work on
bd list --priority 0 # See critical items
bd list -l module:api # See API-specific items

# Or implement todos manually if using TodoWrite
```

## File Structure

After installation:
```
.claude/                           # or ~/.claude/ for global
├── commands/
│   └── audit.md                  # Stage-aware audit command
└── production-criteria.md        # 6 stages + what matters at each
```

## Philosophy

**Stage-Appropriate Development:**
- Don't add tests when you're iterating rapidly (Stage 2)
- Don't skip tests when you're scaling (Stage 4)
- Don't optimize costs before you have scale (Stage 5)
- Each stage has different priorities

**Intelligent Scaling:**
- Simple codebases: focused, comprehensive audits
- Large codebases: module-by-module evaluation with cross-cutting concerns
- Per-module readiness scores show where to focus effort

**DRY Design:**
- Shared production criteria for all audits
- Size-aware evaluation strategy
- User choice of tracking method (beads or TodoWrite)

## Testing

This project includes comprehensive testing using [promptfoo](https://www.promptfoo.dev/):

```bash
# Install dependencies
npm install

# Set API key
export ANTHROPIC_API_KEY="your-key-here"

# Run tests
npm test

# View results in web UI
npm run test:ui
```

See [TESTING.md](TESTING.md) for detailed testing documentation.

## Contributing

Found a bug or have a suggestion? Open an issue or PR!

## License

MIT
