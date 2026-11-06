# Review Teammate PR Command

Deeply review a pull request authored by another engineer or bot — covering both product direction and technical correctness — and report findings to you for approval before posting any comments.

**Purpose:** Go beyond surface-level code review. Understand *why* the change exists, whether it moves the product/tech in the right direction, and whether the implementation is sound. Report everything to you first; never post comments without your explicit approval.

## Input

Accepts a PR URL, PR number + repo, or branch name:

```
/review-teammate-pr https://github.com/squareup/cash-server/pull/12345
/review-teammate-pr squareup/cash-server#12345
```

## Process

### 1. Gather PR Basics

Read the PR metadata and diff:

```bash
gh pr view <pr> --json title,body,author,labels,milestone,baseRefName,headRefName,files,reviews,comments
gh pr diff <pr>
```

Note:
- The PR title and body
- The author (engineer or bot)
- All linked issues, tickets, or documents mentioned in the body
- The full file list and diff

### 2. Research the "Why" (Parallel Track A)

This is the most important and often most time-consuming step. Launch this as a subagent so it can run concurrently with the technical review.

**Goal:** Understand the product/business motivation behind this change and assess whether it moves things in the right direction.

**Research sources (check in order, stop when you have enough context):**

1. **PR description and linked issues:** Read any linked Linear issues, GitHub issues, or Jira tickets. Follow links to parent epics or initiatives.
2. **Linear context:** If a Linear issue is linked (or identifiable from the branch name pattern like `team-123`), read the issue, its parent project/initiative, and any comments or status updates.
3. **Google Docs/Sheets:** If the PR or linked issues reference design docs, PRDs, or specs, read them for the intended product direction.
4. **Slack/Buzz conversations:** If the PR or issues link to Slack threads or Buzz posts, read them for discussion context and decisions.
5. **Git history:** Check recent commits in the affected area to understand the trajectory of changes.

**Produce a "Why" summary:**
- What product/business goal does this PR serve?
- Is this the right approach to that goal, or is there a better path?
- Does this align with the team's current direction (based on linked initiative/project)?
- For small/obvious PRs (typo fixes, dependency bumps), a one-line "Why" is fine — but still ask the question.

### 3. Technical Review (Parallel Track B)

Launch this concurrently with the "Why" research. Read the full diff and the surrounding code in the repo.

#### 3a. General Code Quality

- **Correctness:** Logic errors, off-by-one, race conditions, null/nil handling, error propagation
- **Naming and clarity:** Are new names descriptive and consistent with the codebase?
- **Test coverage:** Are the important paths tested? Are edge cases covered? Are tests testing behavior, not implementation?
- **Error handling:** Are errors handled and surfaced appropriately?
- **Performance:** Any obvious N+1 queries, unbounded loops, missing indexes, or memory issues?
- **Security:** Input validation, auth checks, injection risks, secret handling

#### 3b. UI Changes (if applicable)

If the PR modifies UI components, templates, styles, or layouts:

- **Style consistency:** Compare the new UI against sibling/nearby components in the same codebase. Flag inconsistencies in spacing, typography, color, border radius, etc.
- **Design fidelity:** If a mockup or design doc is linked (Figma, Google Doc, image), compare the implementation against it pixel by pixel. Flag deviations.
- **Layout robustness:** Look for potential layout bugs:
  - Text overflow/truncation with long strings
  - Missing responsive breakpoints
  - Empty state rendering
  - RTL/i18n issues if the codebase supports it
  - Z-index stacking issues
  - Keyboard/focus handling for interactive elements
- **Accessibility:** Missing alt text, aria labels, color contrast, focus indicators

#### 3c. API Changes (if applicable)

If the PR introduces or modifies API endpoints, RPC definitions, or public interfaces:

- **Naming:** Does the endpoint/method name match conventions used by neighboring endpoints? Is the naming clear and RESTful (or consistent with the project's RPC style)?
- **Request/response shape:** Are field names consistent with existing patterns? Are types appropriate? Are optional vs. required fields correct?
- **Versioning:** Does this break backward compatibility? If so, is there a migration path?
- **Validation:** Are inputs validated? Are error responses structured consistently?
- **Documentation:** Are new endpoints documented (OpenAPI, proto comments, etc.)?

### 4. Compile and Prioritize Findings

After both parallel tracks complete, compile all findings into a single prioritized report.

**Priority levels:**

- **P0 — Must Fix:** Correctness bugs, security issues, data loss risks, broken API contracts. The PR should not merge without addressing these.
- **P1 — Should Fix:** Product direction concerns, significant style inconsistencies, missing test coverage for critical paths, API design issues that will be hard to change later.
- **P2 — Consider:** Minor style nits, optional refactoring suggestions, test improvements, documentation gaps.
- **P3 — Informational:** Observations, questions for the author, things to watch in follow-up PRs.

### 5. Report to You

Present the findings directly in the conversation. **Do not post any comments to the PR yet.**

Format:

```
## PR Review: <title>
**PR:** <link>
**Author:** <name>
**Files changed:** <count>

---

### Why This Change Exists

<1-3 paragraph summary of the product/business context>

**Direction assessment:** ✅ Right direction | ⚠️ Questionable | ❌ Wrong direction
<brief explanation>

---

### Findings

#### P0 — Must Fix
1. **<file>:<line> — <summary>**
   <explanation with code context>

#### P1 — Should Fix
1. **<file>:<line> — <summary>**
   <explanation>

#### P2 — Consider
1. **<summary>**
   <explanation>

#### P3 — Informational
1. **<summary>**
   <explanation>

---

### Suggested Comments

For each P0 and P1 finding, here is the comment I would post:

**<file>:<line>**
> <draft comment text>

---

### Overall Assessment

<1-2 sentence summary: approve, request changes, or needs discussion>
```

### 6. Await Approval Before Posting

After presenting the report, ask:

> Which comments would you like me to post to the PR? You can say "all", list specific numbers, or "none".

**Only after the user explicitly approves**, post the selected comments as inline PR review comments using:

```bash
gh api repos/{owner}/{repo}/pulls/{pr}/reviews --method POST \
  --field body="<overall summary>" \
  --field event="COMMENT" \
  --field comments="[{\"path\":\"<file>\",\"line\":<line>,\"body\":\"<comment>\"}]"
```

If the user asks for changes to a comment before posting, revise it and confirm before posting.

## Guidelines

1. **Never post without approval:** This is the single most important rule. All feedback goes to you first.
2. **Always research the "why":** Even for small PRs. A one-liner fix that addresses the wrong problem is worse than no fix.
3. **Be specific in findings:** Include file paths, line numbers, and code context. Vague feedback is not actionable.
4. **Prioritize ruthlessly:** A review with 2 P0s and 3 P1s is more useful than one with 30 P2 nits.
5. **Respect the author:** Draft comments should be constructive, specific, and framed as suggestions or questions — not commands. Use "Consider..." or "What do you think about..." for P2 items.
6. **UI reviews are visual:** Don't just read the code — reason about what it renders. Compare against nearby components and any linked designs.
7. **API reviews are contractual:** An API is a promise. Focus on whether the promise is clear, consistent, and something we want to keep.
8. **Parallelize the research:** The "Why" research and technical review are independent. Run them concurrently to save time.
