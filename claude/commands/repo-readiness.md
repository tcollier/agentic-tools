# Repo Readiness Command

Evaluate your repository's readiness for your current company stage, producing a concrete action plan for improvements.

**Purpose:** This command assesses your codebase against stage-appropriate production criteria and creates an implementation-ready action plan.

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

3. **Assess codebase size and structure:** Quickly survey the repository to determine evaluation strategy:
   - Run `find . -type f -name "*.js" -o -name "*.ts" -o -name "*.py" -o -name "*.go" -o -name "*.java" -o -name "*.rb" -o -name "*.php" | wc -l` to count code files
   - Check for monorepo structure (packages/*, apps/*, services/*)
   - Identify distinct tech stacks or domains

   **Size classification:**
   - **Simple** (<50 files, single purpose): Evaluate as a whole
   - **Medium** (50-200 files, or 2-3 modules): Evaluate as a whole with extra attention to structure
   - **Large** (>200 files, or 4+ distinct modules): Break into modules and evaluate separately

4. **Identify modules (for Large codebases only):**

   For large codebases, identify logical boundaries:
   - **Monorepo packages:** Each package/* or apps/* directory
   - **Tech stack boundaries:** Separate backend (api/, server/) from frontend (web/, client/) from mobile (ios/, android/)
   - **Service boundaries:** For microservices, each service/* directory
   - **Domain boundaries:** If organized by feature (auth/, billing/, notifications/)

   List the modules you'll evaluate separately. Example:
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

8. **Generate AUDIT.md file:** Create a comprehensive audit document at the repository root

   **For Simple/Medium codebases:**

   Create `AUDIT.md` with the following structure:
   ```markdown
   # Repository Readiness Audit

   **Stage:** [Stage Name]
   **Date:** [Current Date]
   **Overall Readiness:** [X/10]

   ## Stage-Appropriate Criteria

   For Stage [N] ([Stage Name]), the following criteria apply:

   ### Critical (Must Have)
   - [List P0 criteria from production-criteria.md]

   ### Important (Should Have)
   - [List P1 criteria]

   ### Nice to Have
   - [List P2 criteria]

   ### Intentionally Excluded
   - [List what doesn't matter at this stage]

   ## Findings

   ### Version Control
   - ✅ Git repository initialized
   - ❌ `.gitignore` missing Python patterns (see AUDIT-001)
   - ✅ No secrets in repository

   ### Documentation
   - ❌ README.md missing (see AUDIT-002)
   - ❌ No setup instructions (see AUDIT-003)

   [Continue for all criteria categories...]

   ## Priority Action Items

   ### P0 - Critical (Must Fix)

   **AUDIT-001:** Add .gitignore with Python patterns
   - File: `.gitignore`
   - Add patterns: `*.pyc`, `__pycache__/`, `.env`, `venv/`
   - Criterion: Version Control

   **AUDIT-002:** Create README.md with project overview
   - File: `README.md`
   - Include: project description, setup instructions, usage examples
   - Criterion: Documentation

   ### P1 - Important (Should Fix Soon)

   [Ordered list of P1 items...]

   ### P2 - Nice to Have (Consider Later)

   [Ordered list of P2 items...]

   ## What Doesn't Matter Yet

   At Stage [N], you should intentionally skip:
   - [List items to ignore]

   ## Next Steps

   1. Focus on P0 items first
   2. [Beads-specific or TodoWrite-specific instructions]
   3. Re-run `/repo-readiness` after implementing changes to track progress
   ```

   **For Large codebases (module-based):**

   Create `AUDIT.md` with the following structure:
   ```markdown
   # Repository Readiness Audit

   **Stage:** [Stage Name]
   **Date:** [Current Date]
   **Overall Readiness:** [X/10]

   ## Repository Overview

   ### Module Readiness Summary

   | Module | Readiness | P0 Items | P1 Items | Status |
   |--------|-----------|----------|----------|---------|
   | Backend API | 7/10 | 2 | 5 | Good - minor gaps |
   | Web Frontend | 5/10 | 5 | 8 | Needs attention |
   | Mobile App | 4/10 | 7 | 6 | Critical gaps |
   | Shared Libs | 8/10 | 1 | 2 | Excellent |

   ### Repository-Wide Priority Items

   Top critical issues across all modules:

   **P0-001 [Frontend]:** Add error boundaries to React components
   **P0-002 [Mobile]:** Implement offline error handling
   **P0-003 [API]:** Add rate limiting to public endpoints
   **P0-004 [Frontend]:** Add loading states for async operations
   **P0-005 [Cross-cutting]:** Set up centralized logging

   [List top 10-15 P0 items across all modules]

   ### Cross-Cutting Concerns

   Issues affecting multiple modules:
   - **Logging:** No centralized logging (affects all modules)
   - **Monitoring:** No observability tooling (affects API, Frontend, Mobile)
   - **CI/CD:** No automated deployment pipeline

   ## Stage-Appropriate Criteria

   [Same as simple repo structure]

   ## Module: Backend API

   **Technology:** Python/FastAPI
   **Location:** `src/api/`
   **Readiness:** 7/10

   ### Findings

   #### Version Control
   - ✅ Module has proper structure
   - ✅ No secrets in code

   #### Testing
   - ✅ Unit tests present (85% coverage)
   - ❌ Missing integration tests (see API-001)

   [Continue for all criteria...]

   ### Priority Action Items

   #### P0 - Critical

   **API-001:** Add integration tests for authentication flow
   - Files: `tests/integration/test_auth.py`
   - Test: login, logout, token refresh, password reset
   - Criterion: Testing

   #### P1 - Important

   [P1 items for this module...]

   ## Module: Web Frontend

   [Same structure as Backend API section...]

   ## Module: Mobile App

   [Same structure...]

   ## Module: Shared Libraries

   [Same structure...]

   ## What Doesn't Matter Yet

   [Same as simple repo structure]

   ## Next Steps

   1. Address repository-wide P0 items first (see Repository-Wide Priority Items)
   2. Focus on modules with lowest readiness scores (Mobile App, Web Frontend)
   3. [Beads-specific or TodoWrite-specific instructions]
   4. Re-run `/repo-readiness` after implementing changes to track progress
   ```

9. **Provide summary in chat:** After creating AUDIT.md and action items, provide a brief summary

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

## Chat Summary

After creating AUDIT.md and action items (beads or TodoWrite), provide a brief summary in chat to confirm completion:

**With beads (Simple/Medium codebase):**
```markdown
✅ Repository readiness audit complete!

**Created:**
- `AUDIT.md` - Comprehensive audit report with findings and action items
- [count] beads issues ([X] P0, [Y] P1, [Z] P2)

**Overall Readiness:** [X/10]

**Top Priorities (P0):**
- bd-a1b2: [Brief description]
- bd-f14c: [Brief description]
- [List top 3-5 P0 items]

**Next Steps:**
1. Review `AUDIT.md` for detailed findings
2. Run `bd ready` to see ready work
3. Run `bd list --priority 0` for all critical items
```

**With beads (Large codebase - module breakdown):**
```markdown
✅ Repository readiness audit complete!

**Created:**
- `AUDIT.md` - Comprehensive multi-module audit with repo-wide overview
- [count] beads issues across [N] modules ([X] P0, [Y] P1, [Z] P2)

**Overall Readiness:** [X/10]

**Module Summary:**
- Backend API: 7/10 (2 P0, 5 P1)
- Web Frontend: 5/10 (5 P0, 8 P1) ⚠️ Needs attention
- Mobile App: 4/10 (7 P0, 6 P1) ⚠️ Critical gaps
- Shared Libs: 8/10 (1 P0, 2 P1)

**Top Repository-Wide Priorities:**
- P0-001 [Frontend]: Add error boundaries
- P0-002 [Mobile]: Implement offline error handling
- P0-003 [API]: Add rate limiting
- P0-004 [Cross-cutting]: Set up centralized logging
- [List top 5-7 P0 items]

**Next Steps:**
1. Review `AUDIT.md` for detailed per-module findings and repo-wide overview
2. Focus on modules with lowest scores (Mobile App, Web Frontend)
3. Run `bd ready` or `bd list -l cross-cutting --priority 0` for top items
```

**With TodoWrite (Simple/Medium codebase):**
```markdown
✅ Repository readiness audit complete!

**Created:**
- `AUDIT.md` - Comprehensive audit report with findings and action items
- [count] todos ([X] P0, [Y] P1, [Z] P2)

**Overall Readiness:** [X/10]

**Top Priorities (P0):**
1. [Brief description]
2. [Brief description]
3. [Brief description]

**Next Steps:**
1. Review `AUDIT.md` for detailed findings
2. Execute todos manually (note: won't persist across sessions)
3. Consider installing beads for persistent tracking

Note: TodoWrite items won't persist. Consider running the beads installer when prompted.
```

**With TodoWrite (Large codebase):**
```markdown
✅ Repository readiness audit complete!

**Created:**
- `AUDIT.md` - Comprehensive multi-module audit with repo-wide overview
- [count] todos across [N] modules ([X] P0, [Y] P1, [Z] P2)

**Overall Readiness:** [X/10]

**Module Summary:**
- Backend API: 7/10 ([X] items)
- Web Frontend: 5/10 ([Y] items) ⚠️ Needs attention
- Mobile App: 4/10 ([Z] items) ⚠️ Critical gaps
- Shared Libs: 8/10 ([W] items)

**Top Repository-Wide Priorities:**
1. [Frontend] Add error boundaries
2. [Mobile] Implement offline error handling
3. [API] Add rate limiting
4. [Cross-cutting] Set up centralized logging

**Next Steps:**
1. Review `AUDIT.md` for detailed per-module findings and repo-wide overview
2. Execute todos manually by module (prefixed with [Module])
3. Consider installing beads for better multi-module tracking

Note: TodoWrite items won't persist. Consider running the beads installer for better tracking.
```

## Approach

- **Stage-appropriate:** Judge against the stage, not against perfection
- **Objective:** Focus on facts, not opinions
- **Specific:** Cite file paths and line numbers
- **Actionable:** Give clear recommendations, not just problems
- **Balanced:** Note both what to add AND what to intentionally skip
- **Celebrate trade-offs:** Praise intentional simplicity for early stages

## Stage-Specific Examples

**Stage 2 (Early Validation) Evaluation:**
- Don't penalize for missing tests
- Do penalize for missing README or inability to deploy
- Celebrate simple architecture
- Flag any over-engineering

**Stage 4 (Early Scaling) Evaluation:**
- Do penalize for missing tests and monitoring
- Do penalize for architectural issues
- Don't penalize for technical debt
- Don't penalize for missing cost optimization

**Goal:** Tell them exactly what they need to fix NOW vs. what they should intentionally ignore.
