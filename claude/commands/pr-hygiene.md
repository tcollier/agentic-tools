# PR Hygiene Command

Ensure pull requests created by AI agents follow best practices: draft by default, CI verification, and automated fix iteration.

**Purpose:** Enforce consistent PR hygiene when agents create or update pull requests on your behalf. This command can be invoked explicitly or its principles referenced in CLAUDE.md for always-on behavior.

## Rules

These rules apply whenever an agent creates or updates a pull request:

### 1. Always Create Draft PRs

**Default behavior:** Create all PRs as drafts using `gh pr create --draft`.

**Only create a non-draft (ready for review) PR when:**
- The user explicitly says "ready for review", "not a draft", or similar
- The user explicitly asks to mark it ready

**Rationale:** Draft PRs signal that work may still be in progress and prevents premature review notifications to teammates.

**Implementation:**
```bash
# Default: always use --draft
gh pr create --draft --title "..." --body "..."

# Only when explicitly instructed to skip draft:
gh pr create --title "..." --body "..."
```

### 2. Verify CI After Creating or Updating a PR

After creating a PR or pushing new commits to a PR branch, always verify that CI passes.

**Step 2.1: Wait for checks to start**
```bash
# Give CI a moment to register, then poll for status
gh pr checks <pr-number> --watch --fail-fast
```

If `gh pr checks --watch` is not available or times out, fall back to polling:
```bash
# Poll until checks complete (up to 15 minutes)
gh pr checks <pr-number>
```

**Step 2.2: Evaluate results**
- If all checks pass: report success and move on
- If any check fails: proceed to Step 3 (Fix Iteration)
- If checks are pending after 15 minutes: inform the user and suggest they monitor manually

### 3. Iterate on CI Failures

When CI fails after creating or updating a PR, attempt to fix the failures automatically.

**Step 3.1: Diagnose the failure**
```bash
# Get details on which checks failed
gh pr checks <pr-number>

# For each failed check, get the logs
gh run view <run-id> --log-failed
```

**Step 3.2: Analyze and fix**
- Read the failure logs to understand the root cause
- Identify whether the failure is:
  - **Code issue:** Fix the code (test failure, lint error, type error, build error)
  - **Flaky test:** Re-run the check once; if it fails again, investigate
  - **Infrastructure issue:** Inform the user (e.g., CI runner unavailable, quota exceeded)
  - **Unrelated failure:** Inform the user if the failure predates your changes

**Step 3.3: Push the fix**
- Commit the fix with a descriptive message (e.g., `fix: resolve lint errors in auth module`)
- Push to the PR branch
- Return to Step 2 to verify the fix resolved the CI failure

**Step 3.4: Limit iterations**
- Attempt at most **3 fix iterations** before stopping
- If CI still fails after 3 attempts, report to the user:
  - What failed
  - What was attempted
  - Suggested next steps for manual resolution

### 4. Report Final Status

After the PR is created and CI is verified (or iteration limit reached), provide a summary:

```
## PR Summary

**PR:** <link>
**Status:** Draft | Ready for review
**CI:** ✅ Passing | ❌ Failing (after N fix attempts)

### Changes
- <brief description of changes>

### CI Status
- <check name>: ✅ | ❌ <failure reason if applicable>

### Next Steps
- <what the user should do next>
```

## Usage

### As a slash command

Invoke after making changes to create a PR with hygiene checks:

```
/pr-hygiene
```

The command will:
1. Create a draft PR for the current branch
2. Watch CI checks
3. Fix any failures (up to 3 iterations)
4. Report final status

### As always-on behavior

Add the following to your global `~/.claude/CLAUDE.md` or project `.claude/CLAUDE.md`:

```markdown
## PR Hygiene

When creating or updating pull requests:
- Always create PRs as drafts (`--draft`) unless explicitly told otherwise
- After creating or pushing to a PR, verify CI passes (`gh pr checks --watch`)
- If CI fails, diagnose and fix the issue (up to 3 iterations) before reporting the PR as done
```

## Guidelines

1. **Draft by default:** Never create a ready-for-review PR unless the user explicitly asks
2. **Always verify CI:** A PR is not "done" until CI passes or failures are reported
3. **Fix automatically:** Attempt to resolve CI failures before asking the user for help
4. **Know when to stop:** Don't loop endlessly; 3 fix attempts is the maximum
5. **Be transparent:** Always report what happened, what was fixed, and what still needs attention
6. **Respect existing checks:** Don't skip, disable, or work around CI checks
7. **Atomic fixes:** Each fix attempt should be a separate commit with a clear message

## Examples

**Example 1: Clean PR creation**
```
Agent creates draft PR → CI passes → Reports success
```

**Example 2: CI failure with auto-fix**
```
Agent creates draft PR → CI fails (lint error) → Agent fixes lint → 
Pushes fix → CI passes → Reports success with fix details
```

**Example 3: Persistent failure**
```
Agent creates draft PR → CI fails (test) → Agent fixes test → 
CI fails (different test) → Agent fixes → CI fails (infra issue) → 
Reports failure after 3 attempts with diagnosis
```
