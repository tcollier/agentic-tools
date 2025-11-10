# Audit Command

Perform a stage-appropriate technical audit of this codebase, producing a concrete action plan for improvements.

**Purpose:** This command evaluates the codebase and creates an implementation-ready action plan.

## Process

0. **Check for beads issue tracker (recommended):**
   - Run `bd info --json 2>/dev/null` to check if beads is available and initialized
   - **If beads is NOT found:**
     - Explain benefits: "I recommend using beads for persistent issue tracking. Benefits:
       - Issues persist across sessions (git-backed)
       - Track dependencies between issues
       - Query ready work automatically
       - Works across machines and branches"
     - Ask: "Would you like me to install beads? (y/n)"
     - **If user says yes:**
       - Run: `curl -fsSL https://raw.githubusercontent.com/steveyegge/beads/main/scripts/install.sh | bash`
       - Run: `bd init --quiet` (auto-installs git hooks, no prompts)
       - Continue using beads
     - **If user says no:**
       - Note: "OK, I'll use TodoWrite for action items (they won't persist across sessions)"
       - Continue using TodoWrite
   - **If beads is found:** Great! Use it for creating issues

1. **Read the criteria:** First, read `.claude/production-criteria.md` to understand company stages and evaluation standards.

2. **Identify company stage:** Ask the user which stage their company is at:
   - 1. Exploratory
   - 2. Early Validation
   - 3. Proven Concept
   - 4. Early Scaling
   - 5. Hypergrowth
   - 6. Established

   Show the stage descriptions from the criteria doc to help them choose.

3. **Assess codebase size and structure:** Quickly survey the repository to determine audit strategy:
   - Run `find . -type f -name "*.js" -o -name "*.ts" -o -name "*.py" -o -name "*.go" -o -name "*.java" -o -name "*.rb" -o -name "*.php" | wc -l` to count code files
   - Check for monorepo structure (packages/*, apps/*, services/*)
   - Identify distinct tech stacks or domains

   **Size classification:**
   - **Simple** (<50 files, single purpose): Audit as a whole
   - **Medium** (50-200 files, or 2-3 modules): Audit as a whole with extra attention to structure
   - **Large** (>200 files, or 4+ distinct modules): Break into modules and audit separately

4. **Identify modules (for Large codebases only):**

   For large codebases, identify logical boundaries:
   - **Monorepo packages:** Each package/* or apps/* directory
   - **Tech stack boundaries:** Separate backend (api/, server/) from frontend (web/, client/) from mobile (ios/, android/)
   - **Service boundaries:** For microservices, each service/* directory
   - **Domain boundaries:** If organized by feature (auth/, billing/, notifications/)

   List the modules you'll audit separately. Example:
   ```
   Modules identified:
   1. Backend API (src/api) - Python FastAPI
   2. Web Frontend (src/web) - React + TypeScript
   3. Mobile App (src/mobile) - React Native
   4. Shared Libraries (src/shared) - TypeScript utilities
   ```

5. **Explore the codebase:**

   **For Simple/Medium codebases:**
   - Use the Task tool with subagent_type="Explore" and thoroughness="medium" to understand the entire codebase structure, tech stack, and current state

   **For Large codebases (module-by-module):**
   - For each module identified in step 4:
     - Use the Task tool with subagent_type="Explore" and thoroughness="medium" to understand that specific module
     - Focus on: module purpose, tech stack, dependencies on other modules, current state
     - Note module-specific gaps and strengths
   - After all modules are explored, identify cross-cutting concerns (shared infrastructure, common patterns, etc.)

6. **Evaluate against stage criteria:** Focus on what matters for their stage:
   - ✅ What's already in place (from "Critical" for their stage)
   - ❌ What's missing (from "Critical" for their stage)
   - ⚠️ What needs improvement
   - ✨ What they have that doesn't matter yet (potential over-engineering)

7. **Create concrete action plan:**

   **For Simple/Medium codebases:**
   - Create action items for the entire codebase

   **For Large codebases:**
   - Create module-specific action items (tag with module name in labels/description)
   - Create cross-cutting action items (infrastructure, shared concerns)
   - Group related items that span modules

   **If using beads:**
   - Create issues with `bd create` for each action item
   - Set appropriate priority: `-p 0` (critical), `-p 1` (important), `-p 2` (nice to have)
   - Set type: `-t task` for most items, `-t bug` for fixes
   - Add labels for categorization: `-l backend,security,docs` etc
   - **For large codebases:** Add module labels: `-l module:api`, `-l module:web`, `-l cross-cutting`
   - Create dependencies for ordered work: `bd dep add <child> <parent> --type blocks`
   - Return issue IDs in the summary

   **If using TodoWrite:**
   - Create todos with TodoWrite (note: won't persist across sessions)
   - Use standard todo format
   - **For large codebases:** Prefix todos with module name: "[API] Add error logging", "[Web] Add loading states"

   **All action items must be:**
   - **Specific:** "Add .gitignore for Python project" NOT "Fix version control"
   - **Actionable:** Clear what file to create/edit and what to add
   - **Prioritized:** Critical items first, then important, defer what doesn't matter
   - **Stage-appropriate:** Only include what matters for their current stage
   - **Module-scoped (for large codebases):** Clearly indicate which module each item belongs to

8. **Generate summary report:** After creating action items, provide a brief summary report

## Beads Issues (Recommended)

**IMPORTANT:** When using beads, create specific, actionable issues. Examples:

**Good (Specific):**
```bash
bd create "Add .gitignore with Python patterns (*.pyc, __pycache__, .env, venv/)" -p 0 -t task -l git,setup
bd create "Create README.md with project description, setup instructions, and usage examples" -p 0 -t task -l docs
bd create "Add requirements.txt with pinned versions (using pip freeze)" -p 1 -t task -l dependencies
bd create "Create .env.example template with DATABASE_URL, API_KEY placeholders" -p 1 -t task -l config,security
```

**Bad (Too vague):**
```bash
bd create "Fix version control" -p 1
bd create "Add documentation" -p 2
```

**For ordered work, add dependencies:**
```bash
# Create parent issue
bd create "Set up Python project structure" -p 0 -t epic --json
# Returns: {"id": "bd-a1b2", ...}

# Create child tasks that depend on it
bd create "Add .gitignore" -p 0 -t task
bd create "Create README.md" -p 0 -t task
bd create "Add requirements.txt" -p 1 -t task

# Add blocking dependencies if order matters
bd dep add bd-<child> bd-a1b2 --type blocks
```

## TodoWrite Action Items (Fallback)

**IMPORTANT:** When using TodoWrite, create specific, actionable todos. Examples:

**Good (Specific):**
- "Add .gitignore with Python patterns (*.pyc, __pycache__, .env, venv/)"
- "Create README.md with project description, setup instructions, and usage examples"
- "Add requirements.txt with pinned versions (using pip freeze)"
- "Create .env.example template with DATABASE_URL, API_KEY placeholders"

**Bad (Too vague):**
- "Fix version control"
- "Add documentation"
- "Improve configuration"

## Summary Report

After creating action items, provide a brief summary:

**With beads (Simple/Medium codebase):**
```markdown
# Audit Summary - [Stage Name]

## Readiness: [X/10]
- ✅ [Y] critical items complete
- ❌ [Z] items need attention

## What's Working
[2-3 key strengths for the stage]

## Action Items Created
- P0 (Critical): [count] issues - [list IDs: bd-a1b2, bd-f14c]
- P1 (Important): [count] issues - [list IDs: bd-3e7a, bd-b5c9]

Use `bd ready` to see ready work, or `bd list --priority 0` for critical items.

## What Doesn't Matter Yet
[Explicitly list 3-5 things to ignore for this stage]
- Example: Tests (Stage 2 - iterate fast)
- Example: Cost optimization (Stage 4 - not at scale)

## Next Steps
- Run `bd ready` to see what's ready to work on
- Or implement manually: `bd show <issue-id>` for details
```

**With beads (Large codebase - module breakdown):**
```markdown
# Audit Summary - [Stage Name]

## Codebase Structure
Analyzed [N] modules:
1. **Backend API** (src/api) - Python/FastAPI - Readiness: 7/10
2. **Web Frontend** (src/web) - React/TypeScript - Readiness: 5/10
3. **Mobile App** (src/mobile) - React Native - Readiness: 4/10
4. **Shared Libraries** (src/shared) - TypeScript - Readiness: 8/10

## Overall Readiness: [X/10]
- ✅ [Y] critical items complete
- ❌ [Z] items need attention across all modules

## Module Highlights

### Backend API (Readiness: 7/10)
- ✅ Good: Tests, error handling, API docs
- ❌ Missing: Monitoring, rate limiting

### Web Frontend (Readiness: 5/10)
- ✅ Good: Component structure, TypeScript
- ❌ Missing: Error boundaries, loading states, tests

### Mobile App (Readiness: 4/10)
- ✅ Good: Navigation setup
- ❌ Missing: Offline support, error handling, tests

### Shared Libraries (Readiness: 8/10)
- ✅ Good: Well-documented, tested, typed
- ❌ Missing: Changelog

## Action Items Created
- P0 (Critical): [count] issues
  - module:api: [bd-a1b2, bd-f14c]
  - module:web: [bd-3e7a, bd-b5c9]
  - cross-cutting: [bd-x1y2]
- P1 (Important): [count] issues

Use `bd list -l module:api` to see API-specific items, or `bd list -l cross-cutting` for infrastructure work.

## What Doesn't Matter Yet
[Stage-appropriate exclusions]

## Next Steps
- Run `bd ready` to see what's ready to work on
- Or implement by module: `bd list -l module:api --priority 0`
```

**With TodoWrite (Simple/Medium codebase):**
```markdown
# Audit Summary - [Stage Name]

## Readiness: [X/10]
- ✅ [Y] critical items complete
- ❌ [Z] items need attention

## What's Working
[2-3 key strengths for the stage]

## Gaps to Address
[High-level overview - details are in todos]
- Critical: [count] items
- Important: [count] items

Note: TodoWrite items won't persist across sessions. Consider installing beads for better tracking.

## What Doesn't Matter Yet
[Explicitly list 3-5 things to ignore for this stage]
- Example: Tests (Stage 2 - iterate fast)
- Example: Cost optimization (Stage 4 - not at scale)

## Next Steps
Execute todos manually.
```

**With TodoWrite (Large codebase):**
```markdown
# Audit Summary - [Stage Name]

## Codebase Structure
Analyzed [N] modules with individual readiness scores

## Overall Readiness: [X/10]
- ✅ [Y] critical items complete
- ❌ [Z] items need attention across all modules

## Module Breakdown
- **Backend API** (7/10) - [X] items
- **Web Frontend** (5/10) - [Y] items
- **Mobile App** (4/10) - [Z] items
- **Cross-cutting** - [W] items

## Gaps to Address
Todos are prefixed with module names: [API], [Web], [Mobile], [Cross-cutting]
- Critical: [count] items
- Important: [count] items

Note: TodoWrite items won't persist across sessions. Consider installing beads for better module tracking.

## Next Steps
Execute todos manually by module.
```

## Approach

- **Stage-appropriate:** Judge against the stage, not against perfection
- **Objective:** Focus on facts, not opinions
- **Specific:** Cite file paths and line numbers
- **Actionable:** Give clear recommendations, not just problems
- **Balanced:** Note both what to add AND what to intentionally skip
- **Celebrate trade-offs:** Praise intentional simplicity for early stages

## Stage-Specific Examples

**Stage 2 (Early Validation) Audit:**
- Don't penalize for missing tests
- Do penalize for missing README or inability to deploy
- Celebrate simple architecture
- Flag any over-engineering

**Stage 4 (Early Scaling) Audit:**
- Do penalize for missing tests and monitoring
- Do penalize for architectural issues
- Don't penalize for technical debt
- Don't penalize for missing cost optimization

**Goal:** Tell them exactly what they need to fix NOW vs. what they should intentionally ignore.
