# Agentic Tools for Claude Code

Stage-aware engineering tools for Claude Code that help you build at the right level of complexity for your company's current stage.

**Four Commands:**
- `/repo-readiness` - Audit your codebase
- `/design-feature` - Generate stage-appropriate designs
- `/review-design` - Review designs for stage-appropriateness
- `/tasks-from-design` - Break designs into right-sized tasks

## Commands

### `/repo-readiness`
Evaluate your codebase against stage-appropriate criteria and create an actionable plan:
- Identifies your company stage (6 stages from Exploratory to Established)
- Intelligently handles codebases of all sizes (simple, medium, or large)
- For large codebases: breaks into modules and evaluates separately
- **Generates `AUDIT.md`** - comprehensive report with:
  - Stage-specific criteria evaluated
  - Objective findings (✅/❌) for each criterion
  - Priority-ordered action items (P0, P1, P2)
  - For large repos: per-module breakdown + repo-wide overview
- Creates actionable issues/todos:
  - Optional: Uses [beads](https://github.com/steveyegge/beads) for persistent tracking (auto-installs if you want it)
  - Fallback: Uses TodoWrite for session-local todos

### `/design-feature`
Generate stage-appropriate technical designs for new features:
- Interactive design generation that matches your company stage
- Accepts flexible input - from one sentence (Stage 1-2) to full PRD + UX mocks (Stage 5-6)
- Supports documentation: file paths, pasted content, Figma/Google Docs URLs
- Explores codebase to understand existing tech and patterns
- Asks smart gap-filling questions based on stage and provided docs
- **Generates `designs/DESIGN-{feature}.md`** with stage-appropriate sections:
  - Stage 1-2: Minimal (1-2 pages) - happy path only
  - Stage 3: Moderate (2-3 pages) - adds testing and deployment
  - Stage 4+: Comprehensive (3-5+ pages) - adds monitoring, security, performance, rollout
- **"What NOT to Build" section** - explicitly calls out over-engineering to avoid
- Saves company stage to `.claude/config.json` for reuse

### `/review-design`
Review technical designs against stage-appropriate criteria:
- Evaluates design documents for stage-appropriateness
- Accepts: file paths (`designs/DESIGN-feature.md`), pasted content, or URLs
- Explores codebase to check consistency with existing patterns
- Provides detailed review with:
  - Overall verdict: ✅ Approved / ⚠️ Needs Revision / ❌ Needs Rework
  - Stage-appropriateness score (1-10)
  - What's good (celebrates smart decisions)
  - Over-engineered aspects (what to cut and why)
  - Under-engineered gaps (what to add for this stage)
  - Specific, actionable recommendations
- Catches over-engineering before implementation wastes weeks
- Identifies critical gaps for the company's stage

### `/tasks-from-design`
Break down approved designs into right-sized implementation tasks:
- Converts design documents into actionable task lists
- Accepts: file paths (`designs/DESIGN-feature.md`) or other design sources
- **Complexity-aware granularity:**
  - Simple designs (1-2 pages): 5-15 concrete tasks, all immediately actionable
  - Moderate designs (3-5 pages): 10-25 tasks (60% concrete, 40% epic placeholders)
  - Complex designs (5+ pages): 15-40 tasks (30% concrete starters, 70% epic placeholders)
- **Epic tasks for future breakdown** - prevents over-planning distant work
  - Uses beads `-t epic` type with breakdown instructions
  - Break down when ready: keeps plans relevant as you learn
- **Effort estimates** - only for concrete tasks (hours/days)
- Optional: Uses [beads](https://github.com/steveyegge/beads) for persistent tracking (auto-installs)
- Fallback: TodoWrite with `[EPIC]` markers
- Creates dependencies, labels, and priorities for organized implementation
- **Key benefit:** Start immediately with concrete tasks, defer detailed planning until you're ready

## Installation

### Quick Install (One-Liner)

**Interactive (recommended):**
```bash
curl -fsSL https://raw.githubusercontent.com/tcollier/agentic-tools/main/claude/bin/install | bash
```

**Global install (all projects):**
```bash
curl -fsSL https://raw.githubusercontent.com/tcollier/agentic-tools/main/claude/bin/install | bash -s -- --global
```

**Project-specific install:**
```bash
curl -fsSL https://raw.githubusercontent.com/tcollier/agentic-tools/main/claude/bin/install | bash -s -- --project .
```

### Install from Cloned Repo

If you've already cloned the repository:

**Interactive:**
```bash
claude/bin/install
```

**Global:**
```bash
claude/bin/install --global
```

**Project-specific:**
```bash
claude/bin/install --project .
```

## Company Stages

The command understands 6 company stages:

| Stage | Revenue | Team Size | Customers | What Matters |
|-------|---------|-----------|-----------|--------------|
| **1. Exploratory** | $0 | 1-3 | 0 | Can run locally |
| **2. Early Validation** | <$10K MRR | 2-5 | 1-5 | Git, README, can deploy |
| **3. Proven Concept** | $10K-$100K MRR | 5-15 | 10-50 | All P0 + basic monitoring |
| **4. Early Scaling** | $100K-$1M MRR | 15-50 | 50-500 | P0 + P1 + architecture |
| **5. Hypergrowth** | $1M+ MRR | 50-500+ | 500-10K+ | Everything + performance |
| **6. Established** | Varies | Varies | Varies | Excellence + efficiency |

**Note:** These metrics are approximate guidelines, not strict rules. Team size refers to the entire company (not just engineers). Choose the stage that best matches your current reality - companies may skip stages, pivot, or grow non-linearly.

The command only flags what matters for YOUR stage, preventing both under-engineering and over-engineering.

## Module-Based Audits

For large codebases (>200 files or 4+ modules), `/repo-readiness` intelligently breaks down the evaluation:

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

The `/repo-readiness` command can optionally use [beads](https://github.com/steveyegge/beads) for persistent issue tracking:

**Benefits:**
- Issues persist across Claude Code sessions (git-backed)
- Track dependencies between issues
- Query ready work: `bd ready`
- Works across machines and branches
- Built for AI agents

**Auto-install:**
When you run `/repo-readiness` for the first time, it will offer to install beads for you. Just say yes!

**Manual install:**
```bash
curl -fsSL https://raw.githubusercontent.com/steveyegge/beads/main/scripts/install.sh | bash
bd init
```

## Example Workflows

### Workflow 1: Audit Existing Codebase

```bash
# In Claude Code
/repo-readiness

# Claude will:
# 1. Ask what stage your company is at
# 2. Assess codebase size and structure
# 3. For large codebases: identify modules
# 4. Explore the codebase (whole or by module)
# 5. Evaluate against stage-appropriate criteria
# 6. Generate AUDIT.md with findings and action plan
# 7. Create actionable issues (beads) or todos (TodoWrite)
# 8. Provide readiness score(s) and summary

# Review the comprehensive audit report:
cat AUDIT.md         # Detailed findings, criteria, and action items

# View action items with beads:
bd ready             # See what's ready to work on
bd list --priority 0 # See critical items
bd list -l module:api # See API-specific items (large repos)
```

### Workflow 2: Design New Feature

```bash
# In Claude Code
/design-feature

# For Stage 1-2 (minimal input):
# You: "Add user login"
# Claude generates 1-page design with happy path only

# For Stage 5 (comprehensive input):
# You: "Add user profiles" + provides PRD link + Figma mocks
# Claude asks 2 clarifying questions
# Claude generates 5-page design with all sections

# Result: designs/DESIGN-user-profiles.md

# Review the design:
cat designs/DESIGN-user-profiles.md

# Or review with AI:
/review-design designs/DESIGN-user-profiles.md
```

### Workflow 3: Review Design Document

```bash
# In Claude Code - review a design
/review-design designs/DESIGN-payment-flow.md

# Claude provides:
# - Stage-appropriateness score (7/10)
# - What's good: celebrates smart simplicity
# - Over-engineered: "Remove microservices - you're Stage 3"
# - Under-engineered: "Add basic error handling"
# - Specific recommendations

# Fix issues and re-review:
/review-design designs/DESIGN-payment-flow.md
```

### Workflow 4: Break Design Into Tasks

```bash
# After design is approved, create tasks
/tasks-from-design designs/DESIGN-user-profiles.md

# For simple design (1-2 pages):
# Creates 10 concrete tasks, all with estimates
# Can start implementing immediately

# For moderate design (3-5 pages):
# Creates 18 tasks: 11 concrete, 7 epic
# Start with concrete tasks
# Break down epics when ready

# For complex design (6 pages):
# Creates 28 tasks: 8 concrete starters, 20 epics
# Prevents over-planning distant work

# View concrete tasks to start:
bd ready                    # See what's immediately actionable
bd list -t task -p 0        # Critical concrete tasks

# Later, break down an epic when ready:
bd list -t epic             # See epics needing breakdown
# Then manually break down or write mini-design for that epic
```

### Complete Workflow: Design → Review → Tasks → Implement

```bash
# 1. Design the feature
/design-feature
# Result: designs/DESIGN-payment-flow.md

# 2. Review the design
/review-design designs/DESIGN-payment-flow.md
# Result: ✅ Approved (score: 8/10)

# 3. Create implementation tasks
/tasks-from-design designs/DESIGN-payment-flow.md
# Result: 28 tasks created (8 concrete, 20 epic)

# 4. Start implementing
bd ready                    # Shows: "Set up Stripe SDK (1h)"
# Implement first task...

# 5. When ready for an epic, break it down
bd list -t epic            # Shows: "Implement checkout flow" (epic)
# Create mini-design or manually break down
# Continue implementing...
```

## File Structure

After installation:
```
.claude/                           # or ~/.claude/ for global
├── commands/
│   ├── repo-readiness.md         # Stage-aware readiness evaluation
│   ├── design-feature.md         # Interactive feature design generation
│   ├── review-design.md          # Stage-aware design review
│   └── tasks-from-design.md      # Design → tasks breakdown
├── config.json                   # Your company stage (auto-created)
└── production-criteria.md        # 6 stages + what matters at each

# After using /design-feature:
designs/                           # Feature design documents
├── DESIGN-user-login.md
├── DESIGN-user-profiles.md
└── DESIGN-payment-flow.md

# After using /tasks-from-design (if using beads):
# Tasks stored in .beads/ (git-backed)
# Query with: bd list, bd ready, bd list -t epic
```

## Philosophy

**Stage-Appropriate Development:**
- Don't add tests when you're iterating rapidly (Stage 2)
- Don't skip tests when you're scaling (Stage 4)
- Don't optimize costs before you have scale (Stage 5)
- Each stage has different priorities

**Prevent Over-Engineering:**
- Stage 2 teams shouldn't build microservices
- Stage 3 teams shouldn't optimize for millions of users
- "What NOT to Build" is as important as "What to Build"
- Save weeks by explicitly calling out premature complexity

**Catch Under-Engineering:**
- Stage 4 teams need monitoring, not guesswork
- Stage 5 teams need security reviews, not hope
- Identify critical gaps before they cause outages

**Intelligent Scaling:**
- Simple codebases: focused, comprehensive audits
- Large codebases: module-by-module evaluation with cross-cutting concerns
- Per-module readiness scores show where to focus effort
- Design complexity scales with company stage

**Right-Sized Planning:**
- Simple designs → concrete tasks (start immediately)
- Complex designs → epic placeholders (break down when ready)
- Don't create 200+ tasks for 3-month projects
- Plans change as you learn - avoid over-planning distant work

**DRY Design:**
- Shared production criteria for all tools
- Size-aware evaluation strategy
- Stage awareness persists across commands
- User choice of tracking method (beads or TodoWrite)

## Contributing

Found a bug or have a suggestion? Open an issue or PR!

## License

MIT
