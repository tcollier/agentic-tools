# AI Coding Interview System

A system for generating unique, stage-appropriate, AI-focused coding interview questions that evaluate how candidates use AI coding assistants to solve real-world problems.

## Overview

The interview is a coding exercise designed to assess:

1. **How candidates collaborate with AI agents** to write code
2. **Company values alignment**: Bias to Action, Collaboration, Ownership
3. **Stage-appropriate technical skills** calibrated to your company's current stage
4. **Self-awareness and code quality judgment**

**Key Innovation:** Questions and evaluation criteria are automatically calibrated to your company stage (1-6), ensuring you assess candidates with appropriate expectations.

## Interview Format

### Part 1: Vibe Coding (15-20 minutes)
- Candidate uses AI coding assistant to solve the challenge
- Interviewer observes process, prompting, iteration, and debugging
- Focus is on *how they work* not just *what they produce*

### Part 2: Code Review Discussion (10-15 minutes)
- Candidate reviews their own code
- Discusses strengths, weaknesses, and improvements
- Articulates tradeoffs and production considerations
- Demonstrates self-awareness and technical judgment

## Usage

### Generating Interview Materials

Run the slash command to generate a unique question:

```bash
/create-interview
```

This creates two files:
- `question-[timestamp].md` - Share with candidate
- `rubric-[timestamp].md` - Interviewer use only

### Conducting the Interview

1. **Before interview**: Generate materials using `/create-interview`
2. **Start of interview**: Share `question-[timestamp].md` with candidate
3. **During Part 1**: Observe using values/skills from rubric
4. **During Part 2**: Ask candidate to review their code
5. **After interview**: Score using rubric criteria

## Stage Calibration

Questions are automatically calibrated based on your company stage:

**Stage 1-2 (Exploratory / Early Validation):**
- Time: 15-20 minutes
- Complexity: Simple, happy path focus
- Testing: Manual testing okay
- Example: "Build a simple form validator"

**Stage 3 (Proven Concept):**
- Time: 20-30 minutes
- Complexity: Moderate with basic error handling
- Testing: Basic test coverage expected
- Example: "Create an API with validation"

**Stage 4-5 (Early Scaling / Hypergrowth):**
- Time: 25-35 minutes
- Complexity: Production-ready with edge cases
- Testing: Good test coverage required
- Example: "Build a rate limiter with retry logic"

**Stage 6 (Established):**
- Time: 30-40 minutes
- Complexity: Enterprise-grade
- Testing: Comprehensive coverage
- Example: "Create a distributed rate limiter"

## Question Categories

Questions match the type of work candidates will do:

- **Web Development**: Forms, data tables, dashboards, file uploads, state management
- **Backend Development**: APIs, webhooks, rate limiting, background jobs, caching
- **Mobile Client**: Offline sync, image caching, push notifications, local storage

## Evaluation Rubric

The stage-calibrated rubric assesses:

### Values (Company-Aligned)
- **Bias to Action**: Ships iteratively, avoids over-planning
- **Collaboration**: Communicates clearly, explains tradeoffs
- **Ownership**: Handles edge cases, takes responsibility for quality
- **Technical Judgment**: Stage-appropriate decisions

### Skills (Stage-Calibrated)
- **AI Agent Collaboration**: Effective prompting and iteration
- **Problem Decomposition**: Breaks down problems, prioritizes
- **Code Quality**: Readable, well-structured (expectations vary by stage)
- **Edge Case Handling**: Validation, error handling (depth varies by stage)
- **Testing Mindset**: Verification strategy (manual okay for Stage 1-2, comprehensive for Stage 6)
- **Architecture Decisions**: Appropriate abstractions (simple for early stages, sophisticated for later)
- **Production Awareness**: Logging, monitoring (not expected Stage 1-2, required Stage 4+)

## Why This Works

1. **Stage-calibrated**: Questions and rubrics match your company's current reality
2. **Unique every time**: Prevents candidates from preparing for specific questions
3. **Realistic context**: Problems feel like actual work at your company
4. **AI-native**: Evaluates modern development skills (using AI tools)
5. **Self-awareness**: Code review discussion reveals judgment and collaboration
6. **Consistent evaluation**: Same calibrated criteria across all candidates
7. **Prevents mismatches**: Won't reject Stage 2 candidates for not writing "production code" or accept Stage 6 candidates who ignore scale

## File Organization

```
interview-questions/
├── .gitignore           # Prevents committing questions (keeps them fresh)
├── README.md            # This file
├── question-*.md        # Generated questions (gitignored)
└── rubric-*.md          # Generated rubrics (gitignored)
```

Questions and rubrics are gitignored to prevent:
- Leaking interview questions to candidates
- Candidates preparing for specific problems
- Building up stale question inventory

## Scoring Guidelines

**Strong Hire (stage-calibrated):**
- Exceeds in 3+ values
- Strong in most skills for this stage
- Complete solution in stage-appropriate time
- Code quality matches or exceeds stage expectations
- Demonstrates excellent AI collaboration

**Hire:**
- Meets all values
- Adequate-to-strong in most skills for this stage
- Working solution within time limit
- Code quality acceptable for this stage
- Effective use of AI tools

**No Hire:**
- Missing key values
- Weak in multiple critical skills
- Incomplete solution or poor quality for this stage
- Ineffective AI collaboration

## Tips for Interviewers

### During Part 1 (Vibe Coding)
- Let candidate drive, don't interrupt
- Observe how they prompt the AI
- Note how they debug and iterate
- Watch for time management and prioritization

### During Part 2 (Code Review)
Ask open-ended questions:
- "Walk me through your solution - what works well?"
- "What would you change before submitting this as a PR?"
- "What edge cases or production concerns should we address?"
- "How would you test this?"

### Key Signals
**Green flags:**
- Gets to working code quickly
- Clear communication and reasoning
- Catches AI mistakes
- Proactively identifies improvements

**Red flags:**
- Over-engineering or analysis paralysis
- Doesn't test or verify code
- Defensive about code quality
- Ignores obvious edge cases

## Customization

To adapt this system:

1. **Set your stage**: Run `/configure-agents` to set your company stage (affects interview calibration too)
2. **Update company values**: Edit `claude/commands/create-interview.md` to reflect your specific values
3. **Adjust problem categories**: Modify web/backend/mobile problem lists for your domain
4. **Add skills**: Extend the skills rubric for role-specific assessment
5. **Adjust stage calibration**: Fine-tune time/complexity expectations per stage if needed

## Philosophy

This interview system assumes:
- Modern developers use AI coding assistants effectively
- How they use AI is as important as raw coding ability
- Real-world problems are better than algorithm puzzles
- Self-awareness and collaboration matter more than perfection
- **Stage-appropriate expectations are critical**: What's "good code" at Stage 2 differs dramatically from Stage 6
- Evaluating candidates against the wrong stage criteria leads to bad hiring decisions
