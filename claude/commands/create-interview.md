# Create Interview Generator

Generate unique, stage-appropriate coding interview questions for evaluating how candidates use AI agents to write code.

**Purpose:** Create realistic, 20-30 minute coding challenges that reflect actual work at your company's current stage, along with a stage-appropriate evaluation rubric for assessing both values and skills.

## Process

### 1. Load Company Stage Configuration

Check if `.claude/config.json` exists and contains stage configuration.

**If config exists:**
- Read `companyStage` value (1-6)
- Use this stage to calibrate question complexity and scope
- Proceed to Step 2

**If config doesn't exist:**
- Display the 6-stage table
- Use AskUserQuestion tool to prompt user to select stage (1-6)
- Save to `.claude/config.json`

**Stage Options for AskUserQuestion:**

1. **Stage 1: Exploratory** - Building prototypes to learn ($0, 1-3 people)
2. **Stage 2: Early Validation** - First paying customers (<$10K MRR, 2-5 people)
3. **Stage 3: Proven Concept** - Repeatable sales process ($10K-$100K MRR, 5-15 people)
4. **Stage 4: Early Scaling** - Scaling infrastructure ($100K-$1M MRR, 15-50 people)
5. **Stage 5: Hypergrowth** - Racing to keep up with demand ($1M+ MRR, 50-500+ people)
6. **Stage 6: Established** - Sustainable growth, focus on efficiency

**Note:** Use the configured stage to adjust:
- Problem complexity
- Architecture expectations
- Testing requirements in rubric
- Production readiness expectations

### 2. Create Output Directory

Check if `interview-questions/` directory exists. If not, create it with a `.gitignore` file to prevent committing interview materials.

### 3. Prompt for Problem Category

Use AskUserQuestion to ask which type of work best matches the role:

**Options:**
1. **Web Development** - Frontend, full-stack, UI/UX focused work
2. **Backend Development** - APIs, services, data processing, infrastructure
3. **Mobile Client** - iOS, Android, or cross-platform mobile apps

This helps generate questions that match the actual work the candidate will do.

### 4. Generate Stage-Appropriate Question

Create a randomized coding challenge calibrated to the configured stage and selected category.

**Stage-Specific Calibration:**

**Stages 1-2 (Exploratory / Early Validation):**
- **Time:** 15-20 minutes
- **Scope:** Single feature, happy path focus
- **Complexity:** Simple, minimal edge cases
- **Architecture:** Straightforward, no fancy patterns
- **Testing:** Manual testing okay, automated tests not expected
- **Example:** "Build a simple form validator" or "Create a basic API client"

**Stage 3 (Proven Concept):**
- **Time:** 20-30 minutes
- **Scope:** Core functionality with basic error handling
- **Complexity:** Moderate, some edge cases
- **Architecture:** Clean but simple
- **Testing:** Basic test coverage expected
- **Example:** "Build a data transformer with validation" or "Create an API with error handling"

**Stages 4-5 (Early Scaling / Hypergrowth):**
- **Time:** 25-35 minutes
- **Scope:** Production-ready feature
- **Complexity:** Comprehensive, many edge cases
- **Architecture:** Well-structured, extensible
- **Testing:** Good test coverage required
- **Example:** "Build a rate limiter with multiple strategies" or "Create a resilient API client with retries"

**Stage 6 (Established):**
- **Time:** 30-40 minutes
- **Scope:** Enterprise-grade feature
- **Complexity:** Very comprehensive
- **Architecture:** Sophisticated, scalable
- **Testing:** Comprehensive coverage
- **Example:** "Build a distributed rate limiter" or "Create a multi-region API client with circuit breakers"

**Problem Categories by Type:**

**Web Development Problems:**
- Form handling with validation and error states
- Data table with filtering/sorting/pagination
- Real-time status dashboard
- File upload with progress tracking
- Interactive data visualization component
- Autocomplete search with debouncing
- Multi-step wizard with state management
- Responsive layout with dynamic content
- Accessibility-compliant UI component
- Client-side caching layer

**Backend Development Problems:**
- REST API with CRUD operations
- Webhook receiver with signature validation
- Rate limiter with configurable strategies
- Background job processor with retry logic
- Data aggregation pipeline
- API client with automatic retries
- Cache invalidation strategy
- Event stream processor
- Multi-tenant data isolation
- Circuit breaker implementation

**Mobile Client Problems:**
- Offline-first data sync
- Image caching and lazy loading
- Pull-to-refresh with state management
- Deep linking handler
- Push notification manager
- Local database with sync
- Network request queue with retry
- Biometric authentication flow
- App state persistence
- Error handling and user feedback

**Output File:** `interview-questions/question-[YYYYMMDD-HHMMSS].md`

**Question File Format:**
```markdown
# Coding Challenge: [Descriptive Title]

**Time Target:** [Stage-appropriate time]
**Date Generated:** [ISO timestamp]
**Company Stage:** Stage [N]: [Stage Name]

## Context

[1-2 paragraphs of realistic business context matching the company stage]

[For Stage 1-2: Lean startup context, MVP focus, learning and iteration]
[For Stage 3: Growing business, need reliability, serving real customers]
[For Stage 4-5: Scaling infrastructure, performance matters, many users]
[For Stage 6: Enterprise scale, reliability critical, complex requirements]

## Your Task

[Clear description of what to build, scoped appropriately for the stage]

## Requirements

[4-6 specific functional requirements as bullet points, complexity matching stage]

## Acceptance Criteria

[3-5 testable acceptance criteria, stage-appropriate]

[For Stage 1-2: Happy path focus, basic functionality]
[For Stage 3: Core flows + basic error handling]
[For Stage 4-5: Comprehensive with error handling, edge cases]
[For Stage 6: Production-grade with monitoring, resilience]

## Technical Constraints

[2-4 constraints that keep scope reasonable]

[Examples:
- "No database required, use in-memory storage"
- "Focus on core logic, UI styling not required"
- "Simulate external services, don't make real API calls"
- "Time box to [stage-appropriate time]"]

## What Success Looks Like

[Brief description of a working solution appropriate for the stage]

## Notes

- Use any language/framework you're comfortable with
- Use AI coding assistants - that's the point!
- Focus on working code over perfection
- Ask questions if requirements are unclear
- [Stage-specific note about what matters: Stage 1-2 "Ship something working", Stage 3 "Balance quality and speed", Stage 4+ "Production-ready with good practices"]
```

### 5. Generate Stage-Appropriate Rubric

Create an interviewer-only rubric file tailored to the configured stage.

**Output File:** `interview-questions/rubric-[YYYYMMDD-HHMMSS].md`

**Rubric File Format:**
```markdown
# Interview Evaluation Rubric

**Evaluation Guide** - Interviewer Only
**Date Generated:** [ISO timestamp]
**Company Stage:** Stage [N]: [Stage Name]

*This rubric is calibrated for a Stage [N] company. Expectations are adjusted to match what's appropriate at this stage.*

## Interview Structure

### Part 1: Vibe Coding (15-20 minutes)
Observe the candidate writing code with an AI agent. Pay attention to:
- How they prompt and iterate with the AI
- How they debug and verify the code
- How they manage time and prioritize

### Part 2: Code Review Discussion (10-15 minutes)
Ask the candidate to review their own code:
- "Walk me through your solution - what works well?"
- "What would you change before submitting this as a PR?"
- "What edge cases or production concerns might we need to address?"
- "How would you test this?"

## Values Assessment

### 1. Bias to Action
**What to look for:**
- [ ] Ships iteratively rather than over-planning
- [ ] Comfortable with imperfection, focuses on MVP
- [ ] Makes progress even with incomplete information
- [ ] Balances speed with thoughtfulness

**Stage [N] Context:**
[For Stage 1-2: "Very high bias to action expected - ship fast, learn, iterate"]
[For Stage 3: "Balance shipping with some planning, basic quality standards"]
[For Stage 4-5: "Still ship quickly but with good engineering practices"]
[For Stage 6: "Measured pace, thorough planning, high quality bar"]

**Red flags:**
- Over-engineering for unlikely scenarios [especially at Stages 1-3]
- Analysis paralysis or excessive planning before coding
- Perfectionism blocking progress [especially at Stages 1-4]

**Green flags:**
- Gets something working quickly, then iterates
- Makes reasonable assumptions and documents them
- Timely delivery of working solution

### 2. Collaboration
**What to look for:**
- [ ] Communicates thought process clearly
- [ ] Asks clarifying questions when needed
- [ ] Explains tradeoffs and decisions
- [ ] Receptive to feedback in code review discussion

**Red flags:**
- Works in silence without explaining approach
- Defensive about code choices
- Doesn't ask questions even when requirements unclear

**Green flags:**
- Thinks out loud, easy to follow reasoning
- Articulates "why" behind decisions
- Acknowledges limitations and asks for input

### 3. Ownership
**What to look for:**
- [ ] Considers edge cases and error handling
- [ ] Thinks about completeness, not just happy path
- [ ] Takes responsibility for code quality
- [ ] Identifies gaps and limitations proactively

**Stage [N] Context:**
[For Stage 1-2: "Basic error handling okay, deep edge case handling not expected"]
[For Stage 3: "Should think about errors, doesn't need to handle everything"]
[For Stage 4-5: "Strong error handling and edge case awareness expected"]
[For Stage 6: "Comprehensive error handling and resilience required"]

**Red flags:**
- Ignores error handling or validation
- "Good enough" attitude without quality concerns
- Blames AI for poor code quality

**Green flags:**
- Addresses edge cases unprompted
- Self-identifies improvements needed
- Shows pride in work quality

### 4. Technical Judgment (Stage-Appropriate)
**What to look for:**
- [ ] Appropriate complexity for Stage [N]
- [ ] Avoids both over-engineering and under-engineering
- [ ] Pragmatic tradeoffs given time constraints
- [ ] Production awareness without premature optimization

**Stage [N] Context:**
[For Stage 1-2: "Keep it simple - no abstractions, no architecture patterns"]
[For Stage 3: "Clean code, basic structure, simple patterns"]
[For Stage 4-5: "Good architecture, considers scale, proper abstractions"]
[For Stage 6: "Enterprise-grade, sophisticated patterns, scalability"]

**Red flags:**
- Overly complex abstractions for simple problem [Stages 1-3]
- No consideration of production concerns [Stages 4+]
- Ignores obvious simplifications
- [Stage-specific anti-patterns]

**Green flags:**
- Right-sized solution for the problem and stage
- Mentions observability, logging, monitoring [if Stage 4+]
- Balances simplicity with extensibility

## Skills Assessment

### 1. AI Agent Collaboration
**What to look for:**
- [ ] Effective prompting (clear, specific instructions)
- [ ] Good iteration loops (test, refine, improve)
- [ ] Knows when to accept vs. reject AI suggestions
- [ ] Debugs AI-generated code effectively

**Scoring:**
- **Strong:** Efficient prompting, quick iterations, catches AI mistakes
- **Adequate:** Gets to working solution with some struggle
- **Weak:** Poor prompts, accepts buggy code, doesn't verify

### 2. Problem Decomposition
**What to look for:**
- [ ] Breaks problem into logical pieces
- [ ] Prioritizes core functionality first
- [ ] Identifies MVP vs. nice-to-haves
- [ ] Manages scope within time constraint

**Scoring:**
- **Strong:** Clear plan, builds incrementally, ships complete solution
- **Adequate:** Some organization, mostly complete solution
- **Weak:** Scattered approach, incomplete solution

### 3. Code Quality
**What to look for:**
- [ ] Readable, well-structured code
- [ ] Appropriate naming and organization
- [ ] Clear logic flow
- [ ] Minimal comments needed (code is self-documenting)

**Stage [N] Expectations:**
[For Stage 1-2: "Working code > perfect code, readability nice-to-have"]
[For Stage 3: "Readable code expected, doesn't need to be perfect"]
[For Stage 4-5: "High quality, well-structured, professional code"]
[For Stage 6: "Excellent quality, could ship to production as-is"]

**Scoring:**
- **Strong:** Clean, professional-quality code [for stage]
- **Adequate:** Readable but could be improved
- **Weak:** Messy, hard to follow, poor naming

### 4. Edge Case Handling
**What to look for:**
- [ ] Input validation
- [ ] Error handling and recovery
- [ ] Boundary conditions considered
- [ ] Defensive programming practices

**Stage [N] Expectations:**
[For Stage 1-2: "Basic happy path focus, minimal edge cases okay"]
[For Stage 3: "Core error handling present, some edge cases"]
[For Stage 4-5: "Comprehensive error handling, most edge cases"]
[For Stage 6: "Exhaustive error handling, all edge cases"]

**Scoring:**
- **Strong:** [Stage-appropriate] error handling, validates inputs
- **Adequate:** Basic error handling present
- **Weak:** Happy path only, crashes on bad input

### 5. Testing Mindset
**What to look for:**
- [ ] Manually tests solution
- [ ] Considers test cases
- [ ] Thinks about verification strategy
- [ ] Code is testable (clear inputs/outputs)

**Stage [N] Expectations:**
[For Stage 1-2: "Manual testing sufficient, automated tests nice bonus"]
[For Stage 3: "Should mention tests or test manually thoroughly"]
[For Stage 4-5: "Writes some tests or has strong testing strategy"]
[For Stage 6: "Comprehensive test coverage expected"]

**Scoring:**
- **Strong:** Tests thoroughly, identifies test cases, writes testable code
- **Adequate:** Some testing, basic verification
- **Weak:** Doesn't test or verify solution

### 6. Architecture Decisions
**What to look for:**
- [ ] Appropriate abstractions (not too many, not too few)
- [ ] Logical separation of concerns
- [ ] Extensibility where it matters
- [ ] Avoids premature optimization

**Stage [N] Expectations:**
[For Stage 1-2: "Minimal architecture, keep it simple"]
[For Stage 3: "Basic structure, simple patterns"]
[For Stage 4-5: "Good architecture, proper abstractions"]
[For Stage 6: "Sophisticated architecture, scalable patterns"]

**Scoring:**
- **Strong:** Well-structured, extensible, appropriate abstractions [for stage]
- **Adequate:** Reasonable structure, could be better organized
- **Weak:** Monolithic or overly complex structure [for stage]

### 7. Production Awareness
**What to look for:**
- [ ] Mentions logging or observability [if Stage 3+]
- [ ] Considers operational concerns
- [ ] Thinks about monitoring/debugging
- [ ] Awareness of deployment considerations

**Stage [N] Expectations:**
[For Stage 1-2: "Not expected - focus on working code"]
[For Stage 3: "Basic awareness, mentions logging"]
[For Stage 4-5: "Strong awareness, includes logging/monitoring"]
[For Stage 6: "Deep awareness, production-grade practices"]

**Scoring:**
- **Strong:** [If expected] Includes logging, discusses monitoring/debugging approach
- **Adequate:** Mentions production concerns
- **Weak:** No consideration of production environment [if expected at this stage]

## Overall Assessment

**Scoring Guide for Stage [N]:**

**Strong Hire:**
- Exceeds in 3+ values
- Strong in most skills [for stage]
- Complete solution in [stage-appropriate time]
- Code quality matches [stage expectations]
- [Stage-specific criterion: e.g., "Ships fast" for Stage 1-2, "Production-ready" for Stage 4+]

**Hire:**
- Meets all values
- Adequate-to-strong in most skills [for stage]
- Working solution within time limit
- Code quality acceptable [for stage]

**No Hire:**
- Missing key values
- Weak in multiple critical skills
- Incomplete solution or poor quality [for stage]
- Ineffective AI collaboration

**Key Questions:**
1. Would this person ship quality code quickly [at our stage]?
2. Would they collaborate well with the team?
3. Do they show ownership and good judgment [for our stage]?
4. Can they effectively use AI tools to be productive?

**Remember:** Calibrate expectations to Stage [N]. [Stage-specific reminder about what matters]

[For Stage 1-2: "Value speed and learning over perfect code"]
[For Stage 3: "Balance shipping with quality"]
[For Stage 4-5: "Expect professional, production-ready work"]
[For Stage 6: "Expect enterprise-grade, highly polished work"]

## Notes Section

[Space for interviewer to capture specific observations, quotes, or examples]

**Stage [N] Specific Observations:**
- Did they over-engineer or under-engineer for this stage?
- Did they understand the stage-appropriate tradeoffs?
- How would they fit with our current team and stage needs?
```

### 6. Confirm Generation

Output a summary showing the two files created and next steps:

```
✅ Interview materials generated!

**Company Stage:** Stage [N]: [Stage Name]
**Problem Category:** [Web/Backend/Mobile]

**Question (share with candidate):**
interview-questions/question-[timestamp].md

**Rubric (interviewer only):**
interview-questions/rubric-[timestamp].md

**Question calibrated for Stage [N]:**
- Time: [Stage-appropriate time]
- Complexity: [Stage-appropriate complexity]
- Testing expectations: [Stage-appropriate]
- Production awareness: [Stage-appropriate]

**Next steps:**
1. Review the question to ensure it's appropriate
2. Share question file with candidate at start of interview
3. Use rubric file to evaluate during Parts 1 & 2
4. Remember: Rubric is calibrated for Stage [N] expectations
```

## Examples

**Example invocation (first time):**
```
User: /create-interview
```

**System response:**
```
No stage configuration found. Let's set up your company stage.

[Displays 6-stage table]

User selects: 4. Early Scaling

✓ Stage saved to .claude/config.json

Which type of work best matches this role?
1. Web Development
2. Backend Development
3. Mobile Client

User selects: Backend Development

Generating Stage 4 (Early Scaling) backend interview question...

✓ Interview materials generated!
```

**Example invocation (with existing config):**
```
User: /create-interview
```

**System response:**
```
Using configured stage: 4. Early Scaling

Which type of work best matches this role?
1. Web Development
2. Backend Development
3. Mobile Client

User selects: Web Development

Generating Stage 4 web development question...

✓ Interview materials generated!
```

## Guidelines

1. **Stage calibration**: All aspects of the question and rubric must match the configured stage
2. **Randomization**: Each question should be meaningfully different within the category
3. **Time calibration**: Adjust time expectations based on stage (15-20 min for Stage 1-2, up to 30-40 min for Stage 6)
4. **Complexity matching**: Ensure all questions in same stage have equivalent difficulty
5. **Category relevance**: Questions should feel authentic to the selected work category
6. **Stage-appropriate rubric**: Evaluation criteria must match what's reasonable for the stage
7. **Consistent expectations**: Both question and rubric should align on complexity and scope
8. **File organization**: Use timestamps in filenames to keep materials organized

## Goal

Create interview materials that effectively evaluate how candidates:
1. Use AI coding assistants to ship working code at appropriate velocity for the stage
2. Demonstrate company values (Bias to Action, Collaboration, Ownership)
3. Make stage-appropriate technical decisions
4. Think critically about their own code and articulate tradeoffs

**Stage-appropriate expectations prevent:**
- Rejecting Stage 1-2 candidates for not writing "production-ready" code
- Accepting Stage 6 candidates who don't consider scale, reliability, and maintainability
- Inconsistent evaluation across interviewers
- Unrealistic expectations that don't match company needs
