# Ready Command

Execute the audit action plan to make this codebase ready for the current company stage.

**Purpose:** This command is a convenience wrapper that runs `/audit` (if needed) and then implements the action plan.

## Process

1. **Detect issue tracking system:**
   - Run `bd info --json 2>/dev/null` to check if beads is available
   - **If beads is available:** Use `bd ready --json` to get ready work
   - **If not:** Check TodoWrite list for pending items

2. **Check for existing audit:**

   **With beads:**
   - Run `bd ready --json` to get ready work
   - If issues exist: Ask user if they want to use existing plan or re-run audit
   - If no ready issues: Run `/audit` to create the plan

   **With TodoWrite:**
   - Check current todo list
   - If todos exist and look like audit items: Ask user if they want to use existing plan or re-run audit
   - If no todos or they don't look like audit items: Run `/audit` to create the plan

3. **Run audit if needed:** Use the SlashCommand tool to execute `/audit`
   - This will identify the stage, explore the codebase, and create concrete action items
   - Audit will detect and use beads if available

4. **Review the plan:** Show the user the action items and confirm they want to proceed

5. **Execute systematically:**

   **With beads:**
   - Get ready work: `bd ready --json`
   - For each issue:
     - Update status: `bd update <id> --status in_progress --json`
     - Implement the change (follow issue description exactly)
     - Close issue: `bd close <id> --reason "Implemented" --json`
     - Move to next ready issue

   **With TodoWrite:**
   - For each pending todo:
     - Mark item as in_progress before starting
     - Implement the specific change (follow the todo exactly)
     - Mark item as completed when done
     - Move to next item

6. **Verify after changes:** After implementing all items:
   - Check that the application still runs (if applicable)
   - Run any tests (if they were added)
   - Verify basic functionality works

7. **Summary:** Provide a brief summary of what was implemented

## Approach

- **Faithful to plan:** Execute each item as written by the audit
- **Incremental:** Complete one item fully before moving to next
- **Verify as you go:** Ensure nothing breaks after each change
- **Stage-appropriate:** The items are already filtered for the stage, just implement them
- **Communicate progress:** Keep user informed as you work through items

## Communication

- Confirm the plan before starting implementation
- Explain what you're doing for each action item
- Celebrate what's been intentionally skipped (from audit report)
- Show summary at the end

## Example Flow

**With beads:**
```
User: /ready

Claude: Checking for existing action plan...
[Runs: bd ready --json]

Found 5 ready issues from previous audit:
- bd-a1b2: Add .gitignore for Python project (P0)
- bd-f14c: Create README.md with setup instructions (P0)
- bd-3e7a: Add .env.example template (P1)
- bd-b5c9: Create basic deployment instructions (P1)
- bd-d7f2: Add error logging (P1)

Should I implement these? (y/n)

User: y

Claude: Starting implementation...

[Runs: bd update bd-a1b2 --status in_progress --json]
Working on bd-a1b2: Add .gitignore for Python project...
[Creates .gitignore file]
[Runs: bd close bd-a1b2 --reason "Implemented" --json]
✅ bd-a1b2 complete

[Runs: bd update bd-f14c --status in_progress --json]
Working on bd-f14c: Create README.md...
[Creates README.md]
[Runs: bd close bd-f14c --reason "Implemented" --json]
✅ bd-f14c complete

...

Claude: All 5 issues complete! Your codebase is now ready for Stage 2 (Early Validation).

What we added:
✅ Version control setup
✅ Documentation
✅ Environment configuration

What we intentionally skipped (doesn't matter yet):
⏭️ Tests - focus on iterating quickly
⏭️ CI/CD - manual deployment is fine
⏭️ Monitoring - logs are sufficient for now

View remaining work: bd ready
```

**With TodoWrite (fallback):**
```
User: /ready

Claude: I'll make your codebase ready for your current stage. First, let me run an audit...
[Runs /audit via SlashCommand]

Claude: The audit identified you're at Stage 2 (Early Validation). I've created 5 action items in TodoWrite:
1. Add .gitignore for Python project
2. Create README.md with setup instructions
3. Add .env.example template
4. Create basic deployment instructions
5. Add error logging

Note: TodoWrite items won't persist across sessions. Consider installing beads for better tracking.

Should I proceed with implementing these? (y/n)

User: y

Claude: Starting implementation...

[Marks todo 1 as in_progress]
Adding .gitignore with Python patterns...
[Creates .gitignore file]
✅ Todo 1 complete

[Marks todo 2 as in_progress]
Creating README.md...
[Creates README.md]
✅ Todo 2 complete

...

Claude: All 5 items complete! Your codebase is now ready for Stage 2 (Early Validation).

What we added:
✅ Version control setup
✅ Documentation
✅ Environment configuration

What we intentionally skipped (doesn't matter yet):
⏭️ Tests - focus on iterating quickly
⏭️ CI/CD - manual deployment is fine
⏭️ Monitoring - logs are sufficient for now
```

**Goal:** Seamlessly move from audit → implementation with minimal user intervention, using beads for persistence when available.
