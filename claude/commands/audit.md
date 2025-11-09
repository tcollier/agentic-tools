# Audit Command

Perform a stage-appropriate technical audit of this codebase, producing a concrete action plan for improvements.

**Purpose:** This command evaluates the codebase and creates an implementation-ready action plan. Use `/ready` to execute the plan, or implement items manually.

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

3. **Explore the codebase:** Use the Task tool with subagent_type="Explore" and thoroughness="medium" to understand the codebase structure, tech stack, and current state.

4. **Evaluate against stage criteria:** Focus on what matters for their stage:
   - ✅ What's already in place (from "Critical" for their stage)
   - ❌ What's missing (from "Critical" for their stage)
   - ⚠️ What needs improvement
   - ✨ What they have that doesn't matter yet (potential over-engineering)

5. **Create concrete action plan:**

   **If using beads:**
   - Create issues with `bd create` for each action item
   - Set appropriate priority: `-p 0` (critical), `-p 1` (important), `-p 2` (nice to have)
   - Set type: `-t task` for most items, `-t bug` for fixes
   - Add labels for categorization: `-l backend,security,docs` etc
   - Create dependencies for ordered work: `bd dep add <child> <parent> --type blocks`
   - Return issue IDs in the summary

   **If using TodoWrite:**
   - Create todos with TodoWrite (note: won't persist across sessions)
   - Use standard todo format

   **All action items must be:**
   - **Specific:** "Add .gitignore for Python project" NOT "Fix version control"
   - **Actionable:** Clear what file to create/edit and what to add
   - **Prioritized:** Critical items first, then important, defer what doesn't matter
   - **Stage-appropriate:** Only include what matters for their current stage

6. **Generate summary report:** After creating action items, provide a brief summary report

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

**With beads:**
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
- Run `/ready` to auto-implement the action plan
- Or implement manually: `bd show <issue-id>` for details
```

**With TodoWrite:**
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
Run `/ready` to implement the action plan, or execute todos manually.
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
