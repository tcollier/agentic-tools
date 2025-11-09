# Audit Command

Perform a stage-appropriate technical audit of this codebase, producing a concrete action plan for improvements.

**Purpose:** This command evaluates the codebase and creates an implementation-ready action plan. Use `/ready` to execute the plan, or implement items manually.

## Process

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

5. **Create concrete action plan:** Use TodoWrite to create implementation-ready action items. Each todo must be:
   - **Specific:** "Add .gitignore for Python project" NOT "Fix version control"
   - **Actionable:** Clear what file to create/edit and what to add
   - **Prioritized:** Critical items first, then important, defer what doesn't matter
   - **Stage-appropriate:** Only include what matters for their current stage

6. **Generate summary report:** After creating todos, provide a brief summary report

## TodoWrite Action Items

**IMPORTANT:** Create specific, actionable todos. Examples:

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

After creating TodoWrite items, provide a brief summary:

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
