# Production Readiness Criteria

This document defines what makes a codebase production-ready based on company stage. Used by the `/repo-readiness` command.

## Company Stages

Not all companies follow this linearly - choose the stage that best matches your current reality. Teams may pivot, plateau, or skip stages entirely.

**Note:** The metrics below (revenue, team size, customers) are approximate guidelines, not hard-and-fast rules. Team size refers to the entire company, not just engineers. Use the "Key Signal" column to help identify your stage.

| Stage | Revenue | Team Size | Customers | Key Signal |
|-------|---------|-----------|-----------|------------|
| **1. Exploratory** | $0 | 1-3 | 0 | Building prototypes to learn |
| **2. Early Validation** | <$10K MRR | 2-5 | 1-5 | First paying customers |
| **3. Proven Concept** | $10K-$100K MRR | 5-15 | 10-50 | Repeatable sales process |
| **4. Early Scaling** | $100K-$1M MRR | 15-50 | 50-500 | Scaling infrastructure |
| **5. Hypergrowth** | $1M+ MRR | 50-500+ | 500-10K+ | Racing to keep up with demand |
| **6. Established** | Varies | Varies | Varies | Sustainable growth, focus on efficiency |

### What Matters at Each Stage

| Stage | Critical (Must Have) | Doesn't Matter Yet |
|-------|---------------------|-------------------|
| **1. Exploratory** | • Can run locally<br>• Git basics (optional) | Everything else - optimize for learning speed |
| **2. Early Validation** | • Git with .gitignore<br>• Basic README<br>• Can deploy somewhere<br>• Doesn't crash constantly<br>• Can fix bugs quickly | Tests, monitoring, architecture, scaling, code quality tools |
| **3. Proven Concept** | • **All P0 items** (see below)<br>• Basic error logging<br>• Simple monitoring/alerts<br>• Security basics | Comprehensive tests, advanced observability, perfect architecture |
| **4. Early Scaling** | • **All P0 + most P1 items**<br>• Good architecture<br>• Performance monitoring<br>• Automated deployments<br>• On-call rotations | Cost optimization, perfect test coverage, technical debt paydown |
| **5. Hypergrowth** | • **All P0 + all P1 + some P2**<br>• Scalability<br>• Performance optimization<br>• Advanced monitoring<br>• Incident management | Technical debt (you're accruing it intentionally), perfect code quality |
| **6. Established** | • **Everything**<br>• Security hardening<br>• Cost optimization<br>• Technical excellence<br>• Compliance | Moving fast (stability over speed now) |

## Essential Criteria

### 1. Version Control
- [ ] Git repository initialized
- [ ] `.gitignore` configured for language/framework
- [ ] Meaningful commit history (if converting from prototype)
- [ ] No secrets or sensitive data in repository

### 2. Testing
- [ ] Testing framework configured
- [ ] Unit tests for core functionality
- [ ] Integration tests for critical paths
- [ ] Test coverage reporting available
- [ ] Tests run successfully

### 3. Error Handling
- [ ] Proper error handling throughout codebase
- [ ] User-friendly error messages
- [ ] Logging configured (not just console.log/print)
- [ ] Error reporting/monitoring setup (optional but recommended)

### 4. Documentation
- [ ] README with project overview
- [ ] Setup/installation instructions
- [ ] Usage examples
- [ ] API documentation (if applicable)
- [ ] Code comments for complex logic
- [ ] Contributing guidelines (for team projects)

### 5. Configuration
- [ ] Environment variables for configuration
- [ ] `.env.example` or similar template
- [ ] No hardcoded credentials or secrets
- [ ] Separate dev/staging/prod configurations

### 6. Code Quality
- [ ] Consistent code style
- [ ] Linter configured (eslint, pylint, etc.)
- [ ] Formatter configured (prettier, black, etc.)
- [ ] No unused imports or dead code
- [ ] Reasonable function/file sizes

### 7. Security
- [ ] Dependencies scanned for vulnerabilities
- [ ] Input validation on user inputs
- [ ] Authentication/authorization if needed
- [ ] HTTPS in production (for web apps)
- [ ] Security headers configured (for web apps)

### 8. Dependencies
- [ ] Dependencies locked (package-lock.json, requirements.txt, etc.)
- [ ] Only necessary dependencies included
- [ ] Regular dependency updates plan

### 9. Build & Deploy
- [ ] Build process documented
- [ ] CI/CD pipeline (recommended)
- [ ] Deployment instructions
- [ ] Health check endpoint (for services)
- [ ] Graceful shutdown handling

### 10. Monitoring & Observability
- [ ] Application logging
- [ ] Performance monitoring (optional initially)
- [ ] Alerting configured (for critical services)
- [ ] Metrics collection (optional initially)

## Language/Framework Specific

### Web Applications (Additional)
- [ ] Responsive design
- [ ] Browser compatibility tested
- [ ] SEO basics (meta tags, etc.)
- [ ] Loading states and error boundaries
- [ ] Accessibility considerations

### APIs (Additional)
- [ ] API documentation (OpenAPI/Swagger)
- [ ] Rate limiting
- [ ] Request validation
- [ ] CORS configured properly
- [ ] Versioning strategy

### CLI Tools (Additional)
- [ ] Help text for all commands
- [ ] Input validation
- [ ] Exit codes used properly
- [ ] Installation instructions
- [ ] Cross-platform compatibility

### Libraries/Packages (Additional)
- [ ] Published to package registry
- [ ] Semantic versioning
- [ ] Changelog maintained
- [ ] TypeScript types (if applicable)
- [ ] Examples in documentation

## Priority Levels

**P0 (Must Have):** Version control, basic tests, error handling, README, environment config
**P1 (Should Have):** Comprehensive tests, logging, code quality tools, security basics, build docs
**P2 (Nice to Have):** CI/CD, monitoring, advanced security, performance optimization

## 11. AI Agent Readiness

**Stage-Appropriate Priority:**
- **Stages 1-2:** Not required (P2 or skip)
- **Stage 3:** P2 (Nice to have)
- **Stage 4+:** P1 (Should have)

Makes the codebase easier for AI coding agents (like Claude Code, Cursor, GitHub Copilot) to understand and work with effectively.

### Documentation
- [ ] Clear README with project overview and architecture
- [ ] ARCHITECTURE.md or similar explaining system design
- [ ] CONTRIBUTING.md with development workflow
- [ ] Clear module/component descriptions
- [ ] API documentation (if applicable)

### Code Clarity
- [ ] Descriptive function and variable names (avoid single letters, abbreviations)
- [ ] Consistent coding patterns and conventions
- [ ] Comments on complex logic and non-obvious decisions
- [ ] Type hints/annotations (TypeScript, Python type hints, etc.)
- [ ] Avoid overly clever code - prefer readable over clever

### Structure
- [ ] Logical file and directory organization
- [ ] Clear separation of concerns
- [ ] Consistent naming conventions across codebase
- [ ] Well-organized imports/dependencies

### Testing
- [ ] Good test coverage (helps agents understand expected behavior)
- [ ] Test names that describe what they're testing
- [ ] Example usage in tests

### Context
- [ ] .clinerules or similar for AI-specific instructions (optional)
- [ ] Clear error messages that explain what went wrong
- [ ] Comments explaining "why" not just "what"

## 12. LLM Integration Quality

**Applies only if repository uses LLM APIs** (OpenAI, Anthropic, etc.)

**Stage-Appropriate Priority:**
- **Stages 1-2:** Basic prompt testing (P1 for Stage 2)
- **Stage 3:** Evals required (P1)
- **Stage 4+:** Comprehensive evals and monitoring (P0)

### Prompt Testing (Evals)
- [ ] Evaluation framework set up (promptfoo, OpenAI evals, or custom)
- [ ] Test cases for critical prompts
- [ ] Regression tests to detect quality degradation
- [ ] LLM-as-judge assertions for semantic correctness
- [ ] Deterministic assertions where possible

### Monitoring & Observability
- [ ] Token usage tracking
- [ ] Cost monitoring and alerting
- [ ] Latency/performance tracking
- [ ] Error rate monitoring for LLM calls
- [ ] Success rate metrics

### Quality Assurance
- [ ] Prompt versioning (track changes to prompts)
- [ ] Golden test datasets
- [ ] Performance benchmarks (cost per request, latency)
- [ ] Output validation and sanitization
- [ ] Fallback handling for LLM failures

### Best Practices
- [ ] Prompts stored in files, not hardcoded
- [ ] Environment-based model selection (dev vs prod)
- [ ] Rate limiting and retry logic
- [ ] Caching where appropriate
- [ ] Security: no PII in prompts without consent

## 13. Technical Design Quality

**Applies when creating technical designs for new features**

**Stage-Appropriate Priority:**
- **Stages 1-2:** Minimal designs (P2 - nice to have written docs)
- **Stage 3:** Basic designs for complex features (P1)
- **Stage 4+:** Comprehensive designs required (P0)

Used by `/design-feature` and `/review-design` commands to ensure stage-appropriate engineering.

### Stage 1-2: Exploratory / Early Validation

**Design characteristics:**
- [ ] Minimal (1-2 pages maximum)
- [ ] Focuses on happy path only
- [ ] Leverages existing tech in codebase
- [ ] Manual testing approach is fine
- [ ] Simple deployment (one command)
- [ ] **"What NOT to Build" section present** - explicitly lists things being skipped

**Explicitly avoid:**
- ❌ Multi-page comprehensive designs
- ❌ Architecture diagrams and complex patterns
- ❌ New infrastructure or dependencies
- ❌ Automated testing requirements
- ❌ Monitoring/observability sections
- ❌ Performance optimization plans

### Stage 3: Proven Concept

**Design characteristics:**
- [ ] Moderate detail (2-3 pages)
- [ ] Covers main user flows and edge cases
- [ ] Testing strategy included (30% coverage goal, core flows only)
- [ ] Basic deployment plan (staging → production)
- [ ] Error handling approach specified
- [ ] **"What NOT to Build" section present**

**Should include:**
- [ ] Overview and technical approach
- [ ] What to build (specific features)
- [ ] Implementation steps
- [ ] Testing strategy (core flows)
- [ ] Deployment approach

**Explicitly avoid:**
- ❌ Comprehensive monitoring/observability
- ❌ Advanced architecture patterns
- ❌ Performance optimization (unless core to feature)
- ❌ Sophisticated rollout strategies
- ❌ Extensive security hardening

### Stage 4-5: Early Scaling / Hypergrowth

**Design characteristics:**
- [ ] Comprehensive (3-5 pages)
- [ ] All sections present and detailed
- [ ] Testing strategy (60-80% coverage goal)
- [ ] Monitoring and observability plan
- [ ] Security considerations addressed
- [ ] Performance requirements specified
- [ ] Rollout strategy defined
- [ ] **"What NOT to Build" section present**

**Required sections:**
- [ ] Overview and context
- [ ] Technical approach
- [ ] What to build (detailed)
- [ ] Testing strategy (comprehensive)
- [ ] Deployment plan
- [ ] Monitoring & observability
- [ ] Security considerations
- [ ] Performance approach
- [ ] Rollout strategy
- [ ] What NOT to build

**Should address:**
- [ ] Scale expectations and growth projections
- [ ] Error handling and recovery
- [ ] Database schema and indexes
- [ ] API design and versioning (if applicable)
- [ ] Caching strategy (if needed)
- [ ] Background job processing (if needed)

### Stage 6: Established

**Design characteristics:**
- [ ] Very comprehensive (5+ pages for complex features)
- [ ] All Stage 4-5 sections, plus:
- [ ] Cost analysis and optimization
- [ ] Compliance considerations (SOC2, GDPR, etc.)
- [ ] Multi-region deployment strategy (if applicable)
- [ ] Advanced monitoring (SLOs, SLIs, error budgets)
- [ ] Comprehensive security review
- [ ] Performance benchmarks and targets
- [ ] A/B testing and experimentation plan
- [ ] **"What NOT to Build" section present** (prevents gold-plating)

### Universal Design Principles (All Stages)

**Every design should:**
- [ ] **Have "What NOT to Build" section** - explicitly call out what's being skipped and why
- [ ] Use existing tech from codebase when possible
- [ ] Be implementation-ready (specific file paths, endpoints, tables)
- [ ] Explain trade-offs and decisions
- [ ] Match complexity to company stage
- [ ] Reference PRD/mocks if they exist

**Design quality markers:**
- [ ] Specific, not vague (actual file names, not "create new file")
- [ ] Actionable (engineer can start immediately)
- [ ] Complete for the stage (all required sections present)
- [ ] Honest about shortcuts (and why they're appropriate)
- [ ] Consistent with existing codebase patterns

### Common Design Anti-Patterns by Stage

**Stage 1-2 anti-patterns:**
- ❌ Designing microservices architecture
- ❌ Comprehensive test plans
- ❌ Sophisticated monitoring/alerting
- ❌ Complex deployment pipelines
- ❌ Performance optimization before measuring
- ❌ Building for scale that doesn't exist

**Stage 3 anti-patterns:**
- ❌ No testing strategy
- ❌ No deployment plan
- ❌ Introducing new architecture patterns without justification
- ❌ Over-engineering with unnecessary infrastructure
- ❌ Skipping "What NOT to Build" section

**Stage 4+ anti-patterns:**
- ❌ No monitoring/observability plan
- ❌ No security considerations
- ❌ No performance requirements
- ❌ No rollout strategy
- ❌ Underestimating scale requirements
- ❌ Missing testing strategy (or <60% coverage goal)

## 14. Task Breakdown Quality

**Applies when breaking design documents into implementation tasks**

**Complexity-Appropriate Priority:**
- **Simple designs (1-2 pages):** All concrete tasks (P0)
- **Moderate designs (3-5 pages):** Mix of concrete and epic tasks (P0)
- **Complex designs (5+ pages):** Mostly epic tasks with concrete starters (P0)

Used by `/tasks-from-design` command to create right-sized task lists from designs.

### Key Principle

**Don't over-plan distant work.** Create concrete tasks for immediate work and placeholder epics for future work that can be broken down later. Plans change as you learn, so avoid creating hundreds of detailed tasks that may become obsolete.

### Simple Designs (1-2 pages)

**Characteristics:**
- Basic features with straightforward implementation
- Few sections, minimal complexity
- Typical for Stage 1-3 features

**Task breakdown:**
- [ ] All concrete, immediately actionable tasks (5-15 tasks total)
- [ ] Each task has clear deliverable and scope
- [ ] All tasks have effort estimates (hours/days)
- [ ] Tasks cover: setup, core implementation, testing, deployment
- [ ] No epic/placeholder tasks needed

**Example:**
- "Create User model with email/password fields (2h)"
- "Add POST /api/login endpoint (3h)"
- "Create login form component (4h)"
- "Write authentication tests (3h)"
- "Deploy to staging (1h)"

### Moderate Designs (3-5 pages)

**Characteristics:**
- Multiple sections, some complexity
- Staged implementation, multiple components
- Typical for Stage 3-4 features

**Task breakdown:**
- [ ] Mix of concrete and epic tasks (10-25 tasks total)
- [ ] ~60% concrete (immediate work), ~40% epic (future breakdown)
- [ ] Concrete tasks for Week 1 and critical path
- [ ] Epic tasks for larger subsystems, complex features, or later phases
- [ ] Effort estimates only for concrete tasks
- [ ] Epic tasks clearly marked for future breakdown

**Concrete task examples:**
- "Create Profile model schema (2h)"
- "Add profile CRUD API endpoints (4h)"
- "Create ProfileView component (4h)"

**Epic task examples:**
- "Implement image upload & processing" (epic - break down when ready)
- "Build privacy controls UI" (epic - includes settings page, toggles, preview mode)
- "Comprehensive profile testing" (epic - integration + E2E tests)

### Complex Designs (5+ pages)

**Characteristics:**
- Comprehensive with many sections
- Sophisticated architecture, multiple systems
- Typical for Stage 4-6 features

**Task breakdown:**
- [ ] Mostly epic tasks with concrete starters (15-40 tasks total)
- [ ] ~30% concrete (immediate setup), ~70% epic (future breakdown)
- [ ] Concrete tasks only for: project setup, initial infrastructure, first steps
- [ ] Epic tasks for: major components, subsystems, phases, complex features
- [ ] Each epic has clear description of what needs breakdown
- [ ] Prevents creating 100+ tasks that will change before implementation

**Concrete task examples (immediate setup):**
- "Set up Stripe SDK & API keys (1h)"
- "Create database schema for payments (3h)"
- "Add Stripe webhook endpoint (2h)"
- "Set up test framework for payments (2h)"

**Epic task examples (break down later):**
- "Implement Stripe checkout flow" (epic)
- "Build subscription management system" (epic)
- "Implement webhook processing & retry logic" (epic)
- "Add fraud detection & monitoring" (epic)
- "Comprehensive payment testing" (epic)

### Universal Task Breakdown Principles

**Every task breakdown should:**
- [ ] Have concrete tasks to start immediately (never all epics)
- [ ] Use appropriate granularity for design complexity
- [ ] Include effort estimates for concrete tasks only
- [ ] Mark epic tasks clearly for future breakdown
- [ ] Group related tasks with labels/categories
- [ ] Establish dependencies only for true blockers
- [ ] Allow for course correction as learning happens

**Good concrete task characteristics:**
- [ ] Single file or component scope
- [ ] Clear, specific deliverable
- [ ] Estimated in hours (1-8h) or days (1-3d)
- [ ] Immediately actionable
- [ ] Examples: "Create User model", "Add login endpoint", "Write auth tests"

**Good epic task characteristics:**
- [ ] Complex subsystem or feature set
- [ ] Multiple related components/tasks
- [ ] Needs breakdown before implementation
- [ ] Description explains scope and breakdown needs
- [ ] Examples: "Build notification system", "Implement user dashboard", "Payment integration"

### Task Tracking Best Practices

**With beads (recommended):**
- [ ] Use `-t task` for concrete tasks
- [ ] Use `-t epic` for placeholder tasks needing breakdown
- [ ] Set priorities: `-p 0` (critical), `-p 1` (important), `-p 2` (nice-to-have)
- [ ] Add labels for grouping: `-l backend`, `-l frontend`, `-l testing`
- [ ] Use dependencies to show ordering: `bd dep add <child> <parent> --type blocks`
- [ ] Query ready work: `bd ready` or `bd list -t task --priority 0`
- [ ] Query epics needing breakdown: `bd list -t epic`

**With TodoWrite (fallback):**
- [ ] Prefix epics with `[EPIC]` marker
- [ ] Include estimates for concrete tasks only
- [ ] Group by phase or component
- [ ] Note: Tasks won't persist across sessions

### Epic Breakdown Workflow

**When to break down an epic:**
1. When you're ready to start working on it (not before)
2. After you've completed prerequisite tasks
3. When you have enough context to plan the details

**How to break down an epic:**
1. Read the epic description and original design
2. Optionally: Write a mini-design doc for just that subsystem
3. Run `/tasks-from-design` focused on that epic's scope
4. Or manually create subtasks with beads: `bd create` and link with dependencies
5. Mark original epic as blocked by new subtasks or complete it

**Benefits:**
- Plans stay relevant (no stale tasks from outdated plans)
- Adapt to learnings from earlier implementation
- Avoid over-planning distant work
- Keep task list manageable

### Common Task Breakdown Anti-Patterns

**Over-planning:**
- ❌ Creating 200+ detailed tasks for a 3-month project
- ❌ Detailed tasks for work that's 4+ weeks away
- ❌ Planning every edge case before starting
- ❌ All tasks concrete (no epics) for complex designs

**Under-planning:**
- ❌ All epics, no concrete tasks to start with
- ❌ Vague tasks: "Build the thing" "Fix issues" "Add features"
- ❌ No effort estimates on any tasks
- ❌ No grouping or organization

**Poor granularity:**
- ❌ Simple design broken into 3 giant tasks
- ❌ Complex design broken into 300 tiny tasks
- ❌ Mixing concrete and epic without clear markers
- ❌ Epic tasks without descriptions of what needs breakdown

**Relationship issues:**
- ❌ Adding dependencies for everything (over-constraining)
- ❌ No dependencies for truly blocking work (under-constraining)
- ❌ Circular dependencies
- ❌ Missing labels/grouping for related work

### Examples by Complexity

**Simple design task breakdown (User Login - 1.5 pages):**
- ✅ 10 concrete tasks, all estimated, immediately actionable
- ✅ Covers: models, endpoints, UI, validation, tests, deployment
- ✅ No epics needed - straightforward implementation

**Moderate design task breakdown (User Profiles - 3 pages):**
- ✅ 18 tasks total: 11 concrete, 7 epic
- ✅ Concrete: CRUD APIs, basic UI, tests, deployment (start now)
- ✅ Epic: Image processing, privacy controls, analytics (break down later)
- ✅ Can start implementing immediately with concrete tasks

**Complex design task breakdown (Payment System - 6 pages):**
- ✅ 28 tasks total: 8 concrete, 20 epic
- ✅ Concrete: Setup Stripe, schema, webhooks, test framework (start now)
- ✅ Epic: Checkout, subscriptions, invoicing, fraud detection (break down over time)
- ✅ Prevents creating 200+ tasks that will change during 8-week implementation
