# Review Design Command

Review a technical design document against stage-appropriate criteria and existing codebase patterns.

**Purpose:** Catch over-engineering and under-engineering before implementation starts. Ensure design matches your company's stage.

## Process

### 1. Load Company Stage

- Read stage from `.claude/config.json`
- If not set, ask user and save for future use
- Display current stage to user

### 2. Get Design Document

Support multiple input methods:

**Method 1: File path (default)**
- Usage: `/review-design designs/DESIGN-user-profiles.md`
- Or ask: "Which design should I review?" if no path provided
- Read file using Read tool

**Method 2: Pasted content**
- If user pastes design content directly in conversation
- Accept the pasted text

**Method 3: URL (optional)**
- Google Docs, Notion, Confluence URLs
- Use WebFetch to retrieve content

### 3. Explore Codebase

Use Task tool with subagent_type="Explore" to understand:

**Technical context:**
- Languages, frameworks, architecture patterns
- Existing infrastructure and capabilities
- Current testing, deployment, monitoring practices
- Code organization and conventions

**Existing patterns:**
- How similar features are implemented
- Common patterns for API endpoints, database access, error handling
- Testing practices in use
- Deployment and rollout patterns

### 4. Analyze Design

Review the design across multiple dimensions:

#### A. Stage-Appropriateness Analysis

**Check if complexity matches stage:**

**Stage 1-2 expectations:**
- ✅ Minimal approach, happy path only
- ✅ Leverages existing tech, minimal new dependencies
- ✅ Manual testing acceptable
- ✅ Simple deployment (one command)
- ⚠️ RED FLAG: Mentions microservices, sophisticated caching, comprehensive tests, monitoring dashboards
- ⚠️ RED FLAG: More than 1-2 pages of technical design

**Stage 3 expectations:**
- ✅ Core flows tested (30% coverage goal)
- ✅ Basic error handling
- ✅ Considers main edge cases
- ✅ Staging environment deployment
- ⚠️ RED FLAG if missing: Testing strategy, deployment plan
- ⚠️ RED FLAG if over-engineering: Complex architectures, premature optimization, extensive monitoring

**Stage 4+ expectations:**
- ✅ Comprehensive testing (60-80% coverage)
- ✅ Monitoring and observability section
- ✅ Security considerations
- ✅ Performance planning
- ✅ Rollout strategy
- ⚠️ RED FLAG if missing: Any of the above
- ⚠️ RED FLAG if under-engineering: No monitoring, no security thought, no rollout plan

**Scoring:**
- Rate stage-appropriateness: 1-10
- 10 = Perfect match for stage
- 5 = Some mismatch (minor over/under-engineering)
- 1 = Serious mismatch (building Stage 6 solution at Stage 2, or Stage 2 solution at Stage 6)

#### B. Over-Engineering Detection

**Look for inappropriate complexity:**
- New tech when existing tech works (e.g., adding Redis when no caching exists yet)
- Microservices for Stage 1-3 companies
- Sophisticated architecture patterns (CQRS, event sourcing, saga patterns) before Stage 5
- Extensive monitoring/observability before Stage 4
- Over-abstraction (too many layers, interfaces, patterns)
- Premature performance optimization
- Complex deployment strategies (canary, blue-green) before Stage 5
- Building for scale that won't exist for 2+ years

**For each over-engineered aspect:**
- Flag it clearly
- Explain why it's inappropriate for this stage
- Suggest simpler alternative
- Note when it would become appropriate (which stage)

#### C. Under-Engineering Detection

**Look for missing critical pieces (stage-dependent):**

**Stage 3+ should have:**
- Basic testing strategy (if missing)
- Deployment plan (if missing)
- Error handling approach (if missing)

**Stage 4+ should have:**
- Monitoring/observability plan (if missing)
- Security considerations (if missing)
- Performance expectations (if missing)
- Rollout strategy (if missing)

**Stage 5+ should have:**
- Comprehensive testing (if < 60% coverage goal)
- Detailed monitoring with SLOs (if missing)
- Security review (if missing)
- Performance benchmarks (if missing)
- Gradual rollout plan (if missing)
- Rollback strategy (if missing)

**For each under-engineered aspect:**
- Flag it clearly
- Explain why it matters at this stage
- Suggest what to add

#### D. Codebase Consistency Check

**Compare design against existing patterns:**
- ✅ Follows existing code organization conventions
- ✅ Uses established patterns (same API structure, error handling, testing approach)
- ✅ Leverages existing infrastructure (auth, DB, queues, etc.)
- ✅ Consistent with existing tech stack
- ⚠️ RED FLAG: Introduces new patterns without justification
- ⚠️ RED FLAG: Doesn't use existing infrastructure when it should
- ⚠️ RED FLAG: Inconsistent with codebase conventions

**For inconsistencies:**
- Point out the mismatch
- Show existing pattern
- Ask if deviation is intentional (and if so, why)

#### E. Completeness Check

**Verify design has necessary sections for stage:**
- Overview/summary
- Technical approach
- What to build
- **"What NOT to Build" section** (critical!)
- Implementation steps

**Stage 3+ also needs:**
- Testing strategy
- Deployment plan

**Stage 4+ also needs:**
- Monitoring plan
- Security considerations
- Performance approach
- Rollout strategy

**Check for clarity:**
- Are file paths, endpoints, database tables specified?
- Can an engineer start implementing immediately?
- Are decisions clear (not vague "we'll figure it out")?
- Are trade-offs explained?

### 5. Generate Review Output

**Format:**

```markdown
# Design Review: {Feature Name}

**Stage:** {Stage Name}
**Reviewed:** {Current Date}
**Verdict:** {✅ Approved | ⚠️ Needs Revision | ❌ Needs Rework}

---

## Overall Assessment

**Stage-Appropriateness Score:** {X}/10

{2-3 paragraph summary of the design's strengths and key issues}

---

## ✅ What's Good

Celebrate smart, stage-appropriate decisions:

- ✅ **{Good Decision}** - {Why this is smart for the stage}
- ✅ **{Good Decision}** - {Why this is appropriate}
- ✅ **{Good Decision}** - {Praise for simplicity or necessary complexity}

---

## 🔴 Over-Engineered (Cut These)

Things that are too complex for Stage {N}:

### {Over-Engineered Aspect 1}
**Issue:** {What's over-engineered}
**Why it's premature:** {Stage-based reasoning}
**Simpler alternative:** {What to do instead}
**When it becomes appropriate:** Stage {X} ({Stage Name})

### {Over-Engineered Aspect 2}
{... same structure ...}

---

## 🟡 Under-Engineered (Add These)

Critical gaps for Stage {N}:

### {Missing Aspect 1}
**Issue:** {What's missing}
**Why it matters at Stage {N}:** {Reasoning}
**What to add:** {Specific recommendation}
**Priority:** {P0 Critical | P1 Important | P2 Nice-to-have}

### {Missing Aspect 2}
{... same structure ...}

---

## ⚠️ Codebase Consistency Issues

Deviations from existing patterns:

- **{Inconsistency}:** Design does {X}, but codebase uses {Y}. {Recommendation}
- **{Inconsistency}:** {Issue and suggestion}

---

## 📋 Completeness Checklist

- [ ] Overview present and clear
- [ ] Technical approach specified
- [ ] Implementation steps actionable
- [ ] **"What NOT to Build" section present** ← {Critical!}
- [ ] Testing strategy (required Stage 3+)
- [ ] Deployment plan (required Stage 3+)
- [ ] Monitoring plan (required Stage 4+)
- [ ] Security considerations (required Stage 4+)
- [ ] Performance approach (required Stage 4+)
- [ ] Rollout strategy (required Stage 4+)

---

## 💡 Recommendations

### High Priority

1. **{Recommendation 1}:** {Specific action} - {Why}
2. **{Recommendation 2}:** {Specific action} - {Why}

### Medium Priority

1. **{Recommendation}:** {Specific action} - {Why}

### Low Priority (Consider)

1. **{Recommendation}:** {Specific action} - {Why}

---

## 🚫 Enhance "What NOT to Build"

{If the design is missing or has weak "What NOT to Build" section, suggest additions:}

Add these to the "What NOT to Build" section:

- ❌ **{Thing}** - {Why it doesn't matter at Stage N}
- ❌ **{Thing}** - {Stage-based reasoning for skipping}
- ❌ **{Thing}** - {When it becomes relevant}

---

## Verdict Explanation

**✅ Approved:** Design is stage-appropriate and implementation-ready. {Minor suggestions are optional improvements.}

_OR_

**⚠️ Needs Revision:** Design has {N} issues that should be addressed before implementation. {Focus on addressing over-engineering / under-engineering / consistency issues.}

_OR_

**❌ Needs Rework:** Design has serious stage-appropriateness issues. {Needs significant revision to match Stage N expectations.}

---

## Next Steps

1. {Action based on verdict}
2. {Action}
3. Consider re-running `/review-design` after revisions
```

### 6. Output to Chat

- Display review in chat (don't save by default)
- User can choose to save the review if desired

## Verdict Criteria

**✅ Approved (8-10 score):**
- Stage-appropriate complexity
- No major over-engineering
- No critical under-engineering gaps
- Mostly consistent with codebase
- Implementation-ready

**⚠️ Needs Revision (5-7 score):**
- Some over-engineering or under-engineering
- Missing some important sections for stage
- Some codebase inconsistencies
- Addressable issues before implementation

**❌ Needs Rework (1-4 score):**
- Serious stage mismatch (building Stage 6 at Stage 2, or vice versa)
- Major over-engineering that would waste weeks
- Critical gaps for the stage
- Can't start implementation without major revision

## Examples

**Example 1: Stage 2 design with over-engineering**

Design proposes: Kubernetes, microservices, Redis caching, comprehensive monitoring

Review verdict: ❌ Needs Rework (score: 2/10)
- Over-engineering: All of the above flagged
- Recommendation: Single service, simple deployment, manual monitoring

**Example 2: Stage 5 design that's too simple**

Design proposes: Manual deployment, no monitoring, no testing, "we'll figure out scale later"

Review verdict: ❌ Needs Rework (score: 3/10)
- Under-engineering: Missing monitoring, testing, performance plan, rollout strategy
- Recommendation: Add all Stage 5 required sections

**Example 3: Stage 3 design that's just right**

Design: Core flow tests (30%), basic deployment, simple approach, good "What NOT to Build" section

Review verdict: ✅ Approved (score: 9/10)
- Stage-appropriate
- Minor suggestions for improvement

## Guidelines

- **Be specific:** Point to exact sections, give concrete examples
- **Be balanced:** Praise good decisions as much as flagging issues
- **Be educational:** Explain WHY something is over/under-engineered for the stage
- **Be actionable:** Give clear recommendations, not just criticism
- **Celebrate appropriate simplicity:** Praise Stage 2 teams for keeping it simple
- **Encourage necessary complexity:** Praise Stage 5 teams for thinking comprehensively

## Goal

Provide a review that:
1. ✅ Catches stage-inappropriate complexity before implementation
2. ✅ Identifies critical gaps for the stage
3. ✅ Ensures codebase consistency
4. ✅ Gives specific, actionable recommendations
5. ✅ Educates on stage-appropriate engineering
