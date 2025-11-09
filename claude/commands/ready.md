# Ready Command

Execute the audit action plan to make this codebase ready for the current company stage.

**Purpose:** This command is a convenience wrapper that runs `/audit` (if needed) and then implements the action plan.

## Process

1. **Check for existing audit:** Look at the current todo list
   - If todos exist and look like audit items: Ask user if they want to use existing plan or re-run audit
   - If no todos or they don't look like audit items: Run `/audit` to create the plan

2. **Run audit if needed:** Use the SlashCommand tool to execute `/audit`
   - This will identify the stage, explore the codebase, and create concrete action items

3. **Review the plan:** Show the user the todo list and confirm they want to proceed

4. **Execute systematically:** Work through each pending todo item:
   - Mark item as in_progress before starting
   - Implement the specific change (follow the todo exactly)
   - Mark item as completed when done
   - Move to next item

5. **Verify after changes:** After implementing all items:
   - Check that the application still runs (if applicable)
   - Run any tests (if they were added)
   - Verify basic functionality works

6. **Summary:** Provide a brief summary of what was implemented

## Approach

- **Faithful to plan:** Execute each todo as written by the audit
- **Incremental:** Complete one item fully before moving to next
- **Verify as you go:** Ensure nothing breaks after each change
- **Stage-appropriate:** The todos are already filtered for the stage, just implement them
- **Communicate progress:** Keep user informed as you work through items

## Communication

- Confirm the plan before starting implementation
- Explain what you're doing for each todo item
- Celebrate what's been intentionally skipped (from audit report)
- Show summary at the end

## Example Flow

```
User: /ready

Claude: I'll make your codebase ready for your current stage. First, let me run an audit...
[Runs /audit via SlashCommand]

Claude: The audit identified you're at Stage 2 (Early Validation). I've created 5 action items:
1. Add .gitignore for Python project
2. Create README.md with setup instructions
3. Add .env.example template
4. Create basic deployment instructions
5. Add error logging

Should I proceed with implementing these? (y/n)

User: y

Claude: Starting implementation...

[Marks item 1 as in_progress]
Adding .gitignore with Python patterns...
[Creates .gitignore file]
✅ Item 1 complete

[Marks item 2 as in_progress]
Creating README.md...
[Creates README.md]
✅ Item 2 complete

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

**Goal:** Seamlessly move from audit → implementation with minimal user intervention.
