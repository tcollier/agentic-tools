# Design Feature Command

Generate a stage-appropriate technical design for a new feature, explicitly calling out what NOT to build and why.

**Purpose:** Interactive feature design that matches your company's stage - from minimal (Stage 1-2) to comprehensive (Stage 5-6).

## Process

### 1. Load Company Stage

- Read stage from `.claude/config.json`
- If not set:
  - Show stage descriptions from `production-criteria.md`
  - Ask user to select stage (1-6)
  - Save to `.claude/config.json` for future use
- Display current stage to user

### 2. Gather Feature Information

**Always ask first:**
- "What feature do you want to design? (Can be brief - from one sentence to detailed description)"

**Then, ask for additional documentation (stage-dependent):**

- **Stage 1-2:** Skip - don't ask for more documentation
- **Stage 3+:** Ask: "Do you have additional documentation?" with options:
  - PRD or spec document (file path in repo, or paste content)
  - UX designs/mocks (Figma/Sketch URL, or image paths)
  - User stories or acceptance criteria (paste or file path)
  - Requirements document (Google Docs, Notion, Confluence URL)
  - None - just the description is fine

**Gather provided documentation:**
- **File paths:** Use Read tool to read files from repo
- **URLs:** Use WebFetch to fetch content from:
  - Figma (design mocks)
  - Google Docs (PRDs, specs)
  - Notion pages (requirements)
  - GitHub issues/PRs (feature requests)
  - Confluence pages (specs)
- **Pasted content:** Accept directly in chat
- **Images:** Use Read tool for images in repo (UX mocks, wireframes)

### 3. Explore Codebase

Use Task tool with subagent_type="Explore" to understand:

**Technical context:**
- Languages and frameworks in use
- Architecture patterns (monolith, modules, microservices)
- Existing infrastructure available:
  - Authentication system (if any)
  - Database(s) and ORM
  - API framework
  - Frontend framework
  - Background job system (if any)
  - Caching layer (if any)
  - File storage (if any)
  - Payment processor (if any)
  - Email service (if any)

**Current practices:**
- Testing setup (frameworks, coverage)
- Deployment approach
- Logging/monitoring capabilities
- Error handling patterns
- Code organization conventions

### 4. Interactive Questioning (Gap-Filling)

Ask stage-appropriate questions to fill gaps in understanding. Number of questions depends on **both stage AND documentation provided**:

**Documentation completeness:**
- **Comprehensive** (PRD + mocks + acceptance criteria): 1-2 clarifying questions max
- **Moderate** (PRD or description with details): 3-5 questions
- **Minimal** (one sentence description): Full question set for stage

**Questions by stage:**

**Stage 1-2 (If minimal docs):**
- What's the happy path? (1-2 sentences)
- Who are the users? (if not obvious)
- Any external services needed? (payment, email, etc.)

**Stage 3 (If minimal docs):**
- What are the key user stories?
- What are the main edge cases?
- Any data that needs to persist?
- Integration points with existing features?
- Basic scale expectations? (10 users? 1000?)

**Stage 4+ (If minimal docs):**
- All Stage 3 questions, plus:
- Performance requirements? (response time, throughput)
- Security considerations? (sensitive data, auth requirements)
- Monitoring needs? (what metrics matter)
- Rollout strategy? (all at once, gradual, feature flag)
- Scale expectations? (current traffic + growth projections)

**Smart gap-filling:**
- If PRD mentions auth approach, don't ask about auth
- If mocks show UI clearly, don't ask about UI details
- Focus questions on what's missing for the stage

### 5. Generate Design Document

Create design with **stage-appropriate sections**. More sections at later stages:

**File location:** `designs/DESIGN-{feature-slug}.md`
- Create `designs/` directory if it doesn't exist
- Use kebab-case for feature slug (e.g., "User Profiles" → `user-profiles`)

**Stage 1-2 template:**
```markdown
# {Feature Name} - Technical Design

**Stage:** {Stage Name}
**Date:** {Current Date}
**Status:** Draft

## Overview

{1-2 paragraph summary of the feature and why we're building it}

## Technical Approach

### What We're Building

- {Bulleted list of what to build}
- {Focus on happy path only}
- {Minimal viable implementation}

### How It Works

{2-3 paragraphs explaining the technical implementation}

**Tech to use:**
- {List existing tech in codebase to leverage}
- {Any new dependencies needed (keep minimal)}

## What NOT to Build

At Stage {N}, we're explicitly skipping:

- ❌ **{Thing}** - {Why it doesn't matter yet}
- ❌ **{Thing}** - {Why it's over-engineering}
- ❌ **{Thing}** - {Can add later when needed}

**Why:** {1-2 sentences on stage-appropriate trade-offs}

## Implementation Steps

1. {Step 1}
2. {Step 2}
3. {Step 3}
4. {Simple deployment}

**Estimated effort:** {time estimate}

## Manual Testing Plan

{How to manually verify it works - no automated tests needed yet}

## Success Criteria

- [ ] {Functional requirement}
- [ ] {Functional requirement}
- [ ] {User can complete happy path}
```

**Stage 3 template (adds Testing, Deployment):**
```markdown
{... same sections as Stage 1-2 ...}

## Testing Strategy

**What to test:**
- {Core flows only - 30% coverage target}
- {Critical edge cases}

**What NOT to test:**
- ❌ Edge cases that rarely happen
- ❌ UI tests (manual testing is fine)
- ❌ Load/performance tests (not needed yet)

## Deployment Plan

{Basic deployment approach - staging then prod}

{... rest same as Stage 1-2 ...}
```

**Stage 4+ template (adds Monitoring, Security, Performance, Rollout):**
```markdown
{... same sections as Stage 3 ...}

## Monitoring & Observability

**Metrics to track:**
- {Key business metrics}
- {Error rates}
- {Performance metrics}

**Logging:**
- {What events to log}
- {Log levels}

**Alerts:**
- {What should alert on-call}

## Security Considerations

**Authentication/Authorization:**
- {Who can access this feature}
- {Permission model}

**Data sensitivity:**
- {PII handling if applicable}
- {Sensitive data protections}

**Input validation:**
- {What inputs need validation}
- {Sanitization approach}

## Performance Considerations

**Expected load:**
- {Traffic expectations}
- {Data volume}

**Optimizations:**
- {Caching strategy if needed}
- {Database indexes needed}
- {Query optimization considerations}

**What NOT to optimize:**
- ❌ {Premature optimizations to skip}

## Rollout Strategy

**Approach:** {All at once | Gradual | Feature flag | A/B test}

**Phases:**
1. {Rollout phase 1}
2. {Rollout phase 2}

**Rollback plan:**
- {How to rollback if issues}

{... rest same as Stage 3 ...}
```

**Key principles:**
- Reference PRD/mocks if provided (link to files/URLs)
- Use tech that already exists in codebase when possible
- Be specific about file paths, endpoints, database tables
- **"What NOT to Build" section is mandatory** - this is the secret sauce
- Celebrate appropriate simplicity for early stages
- Flag necessary complexity for later stages

### 6. Save Design

- Create `designs/` directory if needed
- Write design to `designs/DESIGN-{feature-slug}.md`
- Output summary to chat with file path

### 7. Provide Summary

```markdown
✅ Feature design complete!

**Created:** `designs/DESIGN-{feature-name}.md`
**Stage:** {Stage Name}
**Complexity:** {Minimal | Moderate | Comprehensive}

**Key decisions:**
- {Decision 1}
- {Decision 2}
- {Decision 3}

**Explicitly NOT building** (stage-appropriate):
- {Thing 1 - why}
- {Thing 2 - why}

**Next steps:**
1. Review the design: `cat designs/DESIGN-{feature-name}.md`
2. Get feedback: `/review-design designs/DESIGN-{feature-name}.md`
3. Start implementation following the plan
```

## Examples of Stage-Appropriate Designs

**Stage 2 - "User Login":**
- Input: "Add user login"
- Questions: 3 questions (happy path, external auth?, persist sessions?)
- Output: 1-page design
  - Just email/password form + JWT
  - NOT building: OAuth, 2FA, password reset, session management, rate limiting
  - Manual testing only

**Stage 3 - "User Profiles":**
- Input: Brief description + user stories
- Questions: 5 questions (data fields, privacy, edit permissions, images?)
- Output: 2-page design
  - Profile CRUD + basic image upload
  - Test core flows (30% coverage)
  - Basic deployment plan
  - NOT building: Image optimization, caching, admin tools, audit logs

**Stage 5 - "User Profiles":**
- Input: Full PRD + Figma mocks
- Questions: 2 questions (clarifying performance + rollout)
- Output: 5-page design
  - Comprehensive approach with monitoring, security, performance
  - 80% test coverage including E2E
  - Gradual rollout with feature flag
  - Performance optimizations (CDN, caching, image processing)
  - NOT building: Real-time collaboration, custom image editor, ML-based recommendations

## Guidelines

- **Stage-appropriate:** Match complexity to stage, not to "best practices"
- **Specific:** Use actual tech from codebase, real file paths, concrete examples
- **Balanced:** Celebrate what NOT to build as much as what to build
- **Actionable:** Design should be implementation-ready
- **Honest:** Call out when we're taking shortcuts and why that's smart

## Goal

Generate a design that:
1. ✅ Can be implemented immediately
2. ✅ Matches company stage (not too simple, not too complex)
3. ✅ Uses existing codebase patterns and tech
4. ✅ Explicitly prevents over-engineering
5. ✅ Gives clear implementation path
