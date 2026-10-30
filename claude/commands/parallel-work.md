# Parallel Work Command

Parallelize large code changes by splitting them into independent chunks and implementing them concurrently with subagents in isolated git worktrees.

**Purpose:** Accelerate multi-file, multi-component changes by running subagents in parallel, each working in its own worktree so they never conflict during implementation. The coordinator merges the results at the end.

## When to Use

Use parallel work when a task has **all** of these properties:

- **Multiple independent chunks:** The work can be split into pieces that don't modify the same files
- **No sequential dependencies:** Chunk B doesn't need the output of Chunk A to start
- **Sufficient size:** Each chunk is substantial enough to justify subagent overhead (not just a one-line change)

**Good candidates:**
- Adding the same kind of feature across multiple modules (e.g., adding logging to 5 services)
- Implementing separate API endpoints that don't share new code
- Writing tests for independent modules
- Refactoring patterns across unrelated files (e.g., migrating 4 different callers to a new API)
- Applying a mechanical change across isolated subsystems

**Poor candidates:**
- Changes where later files depend on types/interfaces defined in earlier ones
- A single function or file that needs careful sequential reasoning
- Work where the chunks share new state, types, or helper functions that don't exist yet

## Process

### 1. Analyze the Task

Before parallelizing, understand the full scope:

- Read enough of the codebase to identify the change boundaries
- List every file that will be modified or created
- Identify shared dependencies between the changes

### 2. Plan the Chunks

Split the work into independent chunks. For each chunk, define:

- **What to implement:** Specific, concrete description of the changes
- **Which files to touch:** Explicit list of files this chunk will modify or create
- **Context needed:** Any existing code patterns, types, or conventions the subagent needs to know

**Critical rule:** No two chunks may modify the same file. If two chunks need to change the same file, either:
- Merge them into one chunk
- Have the coordinator handle the shared file after the parallel work completes

Present the plan to the user for approval before launching subagents.

### 3. Launch Concurrent Subagents

Launch all subagents in a **single message** so they run concurrently. Use the Agent tool with `isolation: "worktree"` for each chunk:

```
Agent({
  name: "chunk-1-descriptive-name",
  description: "Short description of chunk 1",
  prompt: "<detailed instructions including file list and context>",
  isolation: "worktree",
  model: "sonnet"  // follow subagent model recommendations from CLAUDE.md
})
```

**Subagent prompt requirements:**

Each subagent prompt must be self-contained (the subagent has no conversation context). Include:

1. **Goal:** What to implement and why
2. **File list:** Exact files to modify/create, with paths
3. **Patterns:** Relevant code conventions, naming patterns, import styles observed in the repo
4. **Constraints:** What NOT to change, boundaries of the chunk
5. **Commit instruction:** Commit the changes with a descriptive conventional-commit message when done

### 4. Wait for Completion

All subagents run in the background. You will be notified as each one completes. Do not poll or fabricate results.

While waiting, you can:
- Tell the user the agents are running
- Handle unrelated follow-up questions
- Work on any non-parallel parts of the task (shared files, documentation, etc.)

### 5. Merge Results

After all subagents complete, merge their worktree branches into the current branch:

**Step 5.1: Review what each subagent produced**

Check each returned worktree branch to understand what changed:

```bash
git log main..<worktree-branch> --oneline
git diff main..<worktree-branch> --stat
```

**Step 5.2: Merge branches sequentially**

```bash
git merge <worktree-branch-1> --no-edit
git merge <worktree-branch-2> --no-edit
# ... repeat for each branch
```

**Step 5.3: Handle merge conflicts**

If a merge conflict arises (which shouldn't happen if chunks were properly isolated):

- Read the conflicting files
- Resolve the conflict, preserving both sides of the change
- `git add` the resolved files and `git commit`
- Inform the user about the conflict and how it was resolved

**Step 5.4: Verify the merged result**

After all merges:

- Run the project's build/compile step if one exists
- Run the project's test suite if one exists
- Fix any integration issues (e.g., missing imports that cross chunk boundaries)

### 6. Report Results

Provide a summary:

```
## Parallel Work Summary

**Chunks completed:** N/N
**Merge conflicts:** None | <details>

### Chunk 1: <name>
- <what was done>
- Files: <list>

### Chunk 2: <name>
- <what was done>
- Files: <list>

### Post-Merge
- Build: ✅ | ❌ <fix details>
- Tests: ✅ | ❌ <fix details>
```

## Example

**Task:** "Add structured logging to all four API services"

**Chunk plan:**
| Chunk | Files | Description |
|-------|-------|-------------|
| 1 | `services/auth/` | Add structured logging to auth service |
| 2 | `services/billing/` | Add structured logging to billing service |
| 3 | `services/users/` | Add structured logging to users service |
| 4 | `services/notifications/` | Add structured logging to notifications service |

**Launch:** 4 Agent calls in a single message, each with `isolation: "worktree"`

**Merge:** Sequential merge of 4 branches, verify build, run tests

## Guidelines

1. **Always get approval:** Present the chunk plan before launching subagents
2. **Err on fewer chunks:** 2-4 well-scoped chunks beat 8 tiny ones — subagent overhead is real
3. **No file overlap:** This is the single most important constraint; violating it guarantees merge conflicts
4. **Self-contained prompts:** Subagents have no context from this conversation; tell them everything
5. **Verify after merge:** The chunks may compile individually but fail together (missing imports, type mismatches)
6. **Handle the shared parts yourself:** If multiple chunks need a new shared type or utility, create it on the current branch before or after the parallel work
7. **Don't parallelize small tasks:** If the total work is under ~30 minutes of sequential effort, parallelizing adds more overhead than it saves
