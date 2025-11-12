# AI Coding Interview System

A system for generating unique, AI-focused coding interview questions that evaluate how candidates use AI coding assistants to solve real-world problems.

## Overview

The interview is a 30-35 minute coding exercise designed to assess:

1. **How candidates collaborate with AI agents** to write code
2. **Company values alignment**: Bias to Action, Collaboration, Ownership
3. **Stage-appropriate technical skills** for a Growth-stage B2B SaaS company
4. **Self-awareness and code quality judgment**

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

## Question Types

Questions rotate through realistic scenarios for a Growth-stage B2B SaaS company:

- **API Integration**: Webhooks, third-party clients, retry logic
- **CLI Tooling**: Migration scripts, bulk operations, admin utilities
- **Backend Services**: Rate limiting, background jobs, multi-tenancy
- **Developer Experience**: Logging, error handling, health checks

All questions are calibrated to take:
- 20-30 minutes for average developer with AI
- 10-15 minutes for exceptional candidates

## Evaluation Rubric

The universal rubric assesses:

### Values (Company-Aligned)
- **Bias to Action**: Ships iteratively, avoids over-planning
- **Collaboration**: Communicates clearly, explains tradeoffs
- **Ownership**: Handles edge cases, takes responsibility for quality
- **Technical Judgment**: Stage-appropriate decisions

### Skills (Universal)
- **AI Agent Collaboration**: Effective prompting and iteration
- **Problem Decomposition**: Breaks down problems, prioritizes
- **Code Quality**: Readable, well-structured code
- **Edge Case Handling**: Validation, error handling
- **Testing Mindset**: Verification strategy, testable code
- **Architecture Decisions**: Appropriate abstractions
- **Production Awareness**: Logging, monitoring, operational concerns

## Why This Works

1. **Unique every time**: Prevents candidates from preparing for specific questions
2. **Realistic context**: Problems feel like actual work at the company
3. **AI-native**: Evaluates modern development skills (using AI tools)
4. **Self-awareness**: Code review discussion reveals judgment and collaboration
5. **Universal rubric**: Same evaluation criteria across all question variants
6. **Stage-appropriate**: Matches Growth-stage complexity expectations

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

**Strong Hire:**
- Exceeds in 3+ values
- Strong in most skills
- Complete, working solution in <20 minutes
- Demonstrates excellent AI collaboration

**Hire:**
- Meets all values
- Adequate-to-strong in most skills
- Working solution within time limit
- Effective use of AI tools

**No Hire:**
- Missing key values
- Weak in multiple critical skills
- Incomplete solution or poor quality
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

1. **Update company values**: Edit `claude/commands/create-interview.md` to reflect your values
2. **Adjust problem domains**: Modify the problem domain list for your tech stack
3. **Change time targets**: Update difficulty calibration for your needs
4. **Add skills**: Extend the skills rubric for role-specific assessment

## Philosophy

This interview system assumes:
- Modern developers use AI coding assistants
- How they use AI is as important as raw coding ability
- Real-world problems are better than algorithm puzzles
- Self-awareness and collaboration matter more than perfection
- Stage-appropriate complexity is key (not too simple, not over-engineered)
