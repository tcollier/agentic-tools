# Create Interview Generator

Generate unique, stage-appropriate coding interview questions for evaluating how candidates use AI agents to write code.

**Purpose:** Create realistic, 20-30 minute coding challenges that reflect actual work at a Growth-stage B2B SaaS company, along with a universal evaluation rubric for assessing both values and skills.

## Process

### 1. Create Output Directory

Check if `interview-questions/` directory exists. If not, create it with a `.gitignore` file to prevent committing interview materials.

### 2. Generate Unique Question

Create a randomized coding challenge that:

**Requirements:**
- Takes 20-30 minutes for average developer with AI agent (10-15 min for exceptional candidates)
- Feels authentic to Growth-stage B2B SaaS company (backend APIs, CLI tools, integrations)
- Tests real-world scenarios: API integration, CLI tooling, backend services, or developer experience
- Includes clear requirements, acceptance criteria, and technical constraints
- Has roughly equivalent complexity regardless of domain chosen
- Is unique each time (randomize problem domains, specifics, and contexts)

**Problem Domains** (rotate through these):

1. **API Integration**
   - Webhook receivers with signature validation
   - Third-party API clients with retry logic
   - Event streaming consumers
   - Multi-provider fallback systems
   - API response caching layers

2. **CLI Tooling**
   - Data migration scripts with rollback
   - Bulk operation utilities
   - Multi-environment deployment tools
   - Configuration validation CLIs
   - Admin utilities for support teams

3. **Backend Services**
   - Rate limiting with different tiers
   - Background job processors with DLQ
   - Multi-tenant data isolation
   - Feature flag evaluation systems
   - Circuit breaker implementations

4. **Developer Experience**
   - Structured logging with correlation IDs
   - Graceful degradation patterns
   - Health check endpoints
   - SDK error handling wrappers
   - Development environment bootstrapping

**Output File:** `interview-questions/question-[YYYYMMDD-HHMMSS].md`

**Question File Format:**
```markdown
# Coding Challenge: [Descriptive Title]

**Time Target:** 20-30 minutes
**Date Generated:** [ISO timestamp]

## Context

[1-2 paragraphs of realistic business context for a Growth-stage B2B SaaS company]

## Your Task

[Clear description of what to build]

## Requirements

[4-6 specific functional requirements as bullet points]

## Acceptance Criteria

[3-5 testable acceptance criteria]

## Technical Constraints

[2-4 constraints that keep scope reasonable, e.g., "No database required, use in-memory storage", "Focus on core logic, UI not required"]

## What Success Looks Like

[Brief description of a working solution]

## Notes

- Use any language/framework you're comfortable with
- Use AI coding assistants - that's the point!
- Focus on working code over perfection
- Ask questions if requirements are unclear
```

### 3. Generate Universal Rubric

Create an interviewer-only rubric file that works for all question variants.

**Output File:** `interview-questions/rubric-[YYYYMMDD-HHMMSS].md`

**Rubric File Format:**
```markdown
# Interview Evaluation Rubric

**Evaluation Guide** - Interviewer Only
**Date Generated:** [ISO timestamp]

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

**Red flags:**
- Over-engineering for unlikely scenarios
- Analysis paralysis or excessive planning before coding
- Perfectionism blocking progress

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
- [ ] Appropriate complexity for a Growth-stage company
- [ ] Avoids both over-engineering and under-engineering
- [ ] Pragmatic tradeoffs given time constraints
- [ ] Production awareness without premature optimization

**Red flags:**
- Overly complex abstractions for simple problem
- No consideration of production concerns
- Ignores obvious simplifications

**Green flags:**
- Right-sized solution for the problem
- Mentions observability, logging, monitoring
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

**Scoring:**
- **Strong:** Clean, professional-quality code
- **Adequate:** Readable but could be improved
- **Weak:** Messy, hard to follow, poor naming

### 4. Edge Case Handling
**What to look for:**
- [ ] Input validation
- [ ] Error handling and recovery
- [ ] Boundary conditions considered
- [ ] Defensive programming practices

**Scoring:**
- **Strong:** Comprehensive error handling, validates inputs
- **Adequate:** Basic error handling present
- **Weak:** Happy path only, crashes on bad input

### 5. Testing Mindset
**What to look for:**
- [ ] Manually tests solution
- [ ] Considers test cases
- [ ] Thinks about verification strategy
- [ ] Code is testable (clear inputs/outputs)

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

**Scoring:**
- **Strong:** Well-structured, extensible, appropriate abstractions
- **Adequate:** Reasonable structure, could be better organized
- **Weak:** Monolithic or overly complex structure

### 7. Production Awareness
**What to look for:**
- [ ] Mentions logging or observability
- [ ] Considers operational concerns
- [ ] Thinks about monitoring/debugging
- [ ] Awareness of deployment considerations

**Scoring:**
- **Strong:** Includes logging, discusses monitoring/debugging approach
- **Adequate:** Mentions production concerns
- **Weak:** No consideration of production environment

## Overall Assessment

**Scoring Guide:**
- **Strong Hire:** Exceeds in 3+ values, strong in most skills, complete solution in <20 min
- **Hire:** Meets all values, adequate-to-strong in most skills, working solution in time
- **No Hire:** Missing values or weak in multiple critical skills, incomplete solution

**Key Questions:**
1. Would this person ship quality code quickly?
2. Would they collaborate well with the team?
3. Do they show ownership and good judgment?
4. Can they effectively use AI tools to be productive?

## Notes Section

[Space for interviewer to capture specific observations, quotes, or examples]
```

### 4. Confirm Generation

Output a summary showing the two files created and next steps:

```
✅ Interview materials generated!

**Question (share with candidate):**
interview-questions/question-[timestamp].md

**Rubric (interviewer only):**
interview-questions/rubric-[timestamp].md

**Next steps:**
1. Review the question to ensure it's appropriate
2. Share question file with candidate at start of interview
3. Use rubric file to evaluate during Parts 1 & 2
```

## Examples

**Example invocation:**
```
User: /create-interview
```

**Example output files:**

**question-20251111-143022.md**
- Title: "Build a Webhook Retry System"
- Context: B2B SaaS company receiving webhooks from customers
- Task: Implement retry logic with exponential backoff
- Requirements: Signature validation, configurable retries, dead letter queue
- Constraints: In-memory storage, no database needed

**rubric-20251111-143022.md**
- Complete evaluation rubric (same content every time)
- Values: Bias to Action, Collaboration, Ownership, Technical Judgment
- Skills: AI Collaboration, Problem Decomposition, Code Quality, Edge Cases, Testing, Architecture, Production Awareness

## Guidelines

1. **Randomization:** Each question should be meaningfully different - vary the domain, business context, technical requirements
2. **Calibration:** All questions should target same difficulty/time (20-30 min)
3. **Realism:** Questions should feel like actual work tasks at a Growth-stage B2B SaaS company
4. **Scope Management:** Use technical constraints to keep problems focused and achievable
5. **Universal Rubric:** The same rubric file works for every question - don't customize it per question
6. **File Organization:** Use timestamps in filenames to keep materials organized and prevent overwrites
7. **Stage-Appropriate:** Questions should match Growth-stage complexity (not MVP-simple, not enterprise-complex)

## Goal

Create interview materials that effectively evaluate how candidates:
1. Use AI coding assistants to ship working code quickly
2. Demonstrate company values (Bias to Action, Collaboration, Ownership)
3. Make stage-appropriate technical decisions
4. Think critically about their own code and articulate tradeoffs
