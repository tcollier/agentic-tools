# Tasks From Design Command

Break down a technical design document into actionable tasks with appropriate granularity based on design complexity.

**Purpose:** Convert design docs into implementation-ready tasks. Simple designs get concrete tasks; complex designs get high-level epics that can be broken down later when you're ready to implement.

## Process

### 1. Check for Task Tracker

- Run `bd info --json 2>/dev/null` to check if beads is available
- **If beads is NOT found:**
  - Ask: "Would you like to use beads for persistent task tracking? (y/n)"
  - If yes: Install beads (same process as /repo-readiness)
  - If no: Use TodoWrite (tasks won't persist across sessions)
- **If beads is found:** Use beads for task creation

### 2. Get Design Document

**Support multiple input methods:**

- **File path** (default): `/tasks-from-design designs/DESIGN-user-profiles.md`
- **Ask if not provided:** "Which design should I break down into tasks?"
- Read design document using Read tool

### 3. Analyze Design Complexity

**Count pages/sections to determine granularity:**

Estimate page count by analyzing:
- Line count (rough: 50 lines ≈ 1 page)
- Number of major sections (## headers)
- Presence of subsections (### headers)
- Complexity indicators: monitoring sections, security sections, rollout strategies

**Classify complexity:**
- **Simple** (1-2 pages): Basic design, few sections, straightforward implementation
- **Moderate** (3-5 pages): Multiple sections, some complexity, staged rollout
- **Complex** (5+ pages): Comprehensive design, many sections, sophisticated approach

**Extract key information:**
- Feature name
- Implementation steps (if present)
- Major sections/components
- Testing requirements
- Deployment approach
- Dependencies between components

### 4. Determine Task Granularity Strategy

**Based on design complexity:**

**Simple (1-2 pages):**
- Create **all concrete tasks** (5-15 tasks total)
- Each task is immediately actionable
- Add effort estimates to all tasks
- Example: "Create user model (2h)", "Add login endpoint (3h)", "Write login form (4h)"

**Moderate (3-5 pages):**
- Create **mix of concrete and epic tasks** (10-25 tasks total)
- Concrete tasks for Week 1 work and critical path
- Epic tasks for larger subsystems or future work
- ~60% concrete, ~40% epics
- Example concrete: "Set up database schema (3h)", "Add authentication middleware (4h)"
- Example epic: "Build user profile UI" (epic - break down when ready)

**Complex (5+ pages):**
- Create **mostly epic tasks with concrete starters** (15-40 tasks total)
- Concrete tasks only for immediate setup and first steps
- Epic tasks for major components, subsystems, phases
- ~30% concrete, ~70% epics
- Example concrete: "Create project structure (1h)", "Set up test framework (2h)"
- Example epic: "Implement payment integration" (epic - break down when ready)

**Key principle:** Don't create hundreds of detailed tasks for work that's weeks/months away. Create placeholders that can be decomposed later.

### 5. Create Tasks

**Task creation order:**
1. Setup/infrastructure tasks (concrete)
2. Core functionality tasks (concrete or epic based on complexity)
3. Testing tasks (concrete for simple, epic for complex)
4. Deployment tasks (concrete for simple, epic for complex)
5. Monitoring/observability tasks (usually epic for complex designs)
6. Documentation tasks (usually concrete)

**For each task, determine:**
- **Type:** Concrete (immediately actionable) or Epic (needs breakdown)
- **Priority:** Based on dependencies and critical path
  - P0: Blocking others, must be done first
  - P1: Important, should be done soon
  - P2: Nice to have, can be deferred
- **Effort estimate:** Only for concrete tasks
  - Hours for small tasks (1-8h)
  - Days for larger tasks (1-3d)
  - No estimate for epics (mark as "TBD when broken down")
- **Labels:** Group related tasks (backend, frontend, testing, deployment, etc.)
- **Dependencies:** What must be done before this task

**Epic task indicators (should be type=epic):**
- Complex subsystems ("Build notification system")
- Multiple related features ("Implement user dashboard")
- Future phases ("Add advanced analytics")
- Large testing efforts ("Comprehensive E2E testing")
- Sophisticated infrastructure ("Set up multi-region deployment")

**Concrete task indicators (should be type=task):**
- Single file or component ("Create User model")
- Specific endpoint ("Add POST /api/login endpoint")
- Clear deliverable ("Write authentication tests")
- Simple configuration ("Add environment variables")
- Documentation ("Update README with setup steps")

### 6. Create Tasks with Beads (If Available)

**For concrete tasks:**
```bash
bd create "Create User model with email/password fields (2h)" \
  -t task \
  -p 0 \
  -l backend,models \
  --description "File: src/models/User.js
Fields: email (unique), password (hashed), createdAt
Add Sequelize model with validations"
```

**For epic tasks:**
```bash
bd create "Build user profile UI" \
  -t epic \
  -p 1 \
  -l frontend \
  --description "Epic - break down when ready to implement
Components needed: ProfileView, ProfileEdit, AvatarUpload
TODO: Run 'bd breakdown <epic-id>' or /tasks-from-design on this epic when starting work"
```

**Create dependencies for ordered work:**
```bash
# If task B depends on task A
bd dep add <task-b-id> <task-a-id> --type blocks
```

**Grouping strategies:**
- Use labels to group by area: `-l backend`, `-l frontend`, `-l testing`, `-l deployment`
- Use labels for components: `-l auth`, `-l profiles`, `-l payments`
- Use priorities to indicate critical path
- Use dependencies to show ordering

### 7. Create Tasks with TodoWrite (Fallback)

**Format for TodoWrite:**

```markdown
# Simple design (all concrete):
- Setup: Create project structure (1h)
- Backend: Create User model (2h)
- Backend: Add login endpoint (3h)
- Frontend: Create login form (4h)
- Testing: Write authentication tests (3h)
- Deploy: Deploy to staging (1h)

# Complex design (mix of concrete and epics):
- Setup: Initialize database schema (2h)
- [EPIC] Build authentication system - break down when ready
- Backend: Add password hashing (2h)
- Frontend: Create login form (4h)
- [EPIC] Implement user profiles - break down when ready
- [EPIC] Add notification system - break down when ready
- Testing: Write unit tests for auth (4h)
- Deploy: Set up CI/CD pipeline (1d)
```

**Use prefixes:**
- `[EPIC]` for tasks that need breakdown
- Include effort estimates in parentheses for concrete tasks only
- Group by phase or component

### 8. Provide Summary

**With beads:**
```markdown
✅ Tasks created from design: {Feature Name}

**Breakdown summary:**
- {N} concrete tasks (immediately actionable)
- {M} epic tasks (break down when ready)
- Total: {N+M} tasks

**Priority distribution:**
- P0 (Critical): {count} tasks
- P1 (Important): {count} tasks
- P2 (Nice to have): {count} tasks

**Concrete tasks (start here):**
- bd-xxx: {Task 1 title} ({estimate})
- bd-xxx: {Task 2 title} ({estimate})
- bd-xxx: {Task 3 title} ({estimate})
[List first 5-7 concrete tasks]

**Epic tasks (break down later):**
- bd-xxx: {Epic 1 title} (epic - TBD)
- bd-xxx: {Epic 2 title} (epic - TBD)
[List all epics]

**Next steps:**
1. Start with concrete P0 tasks: `bd ready` or `bd list --priority 0 -t task`
2. When ready for an epic: Read the epic description and run `/tasks-from-design` on that subsystem
   Or manually: `bd breakdown <epic-id>` and add subtasks
3. Track progress: `bd list --status open`

**Query examples:**
- See ready work: `bd ready`
- See all backend tasks: `bd list -l backend`
- See only concrete tasks: `bd list -t task`
- See epics needing breakdown: `bd list -t epic`
```

**With TodoWrite:**
```markdown
✅ Tasks created from design: {Feature Name}

**Created {N} todos** ({X} concrete, {Y} epics)

**Start with these concrete tasks:**
1. {Task 1 title} ({estimate})
2. {Task 2 title} ({estimate})
3. {Task 3 title} ({estimate})

**Epic tasks marked with [EPIC]** - break these down when you're ready to implement them.

**Note:** TodoWrite tasks won't persist across sessions. Consider using beads for long-running projects.
```

## Task Granularity Examples

### Example 1: Simple Design (Stage 2 - "User Login")

**Design:** 1.5 pages, basic auth flow

**Tasks created (10 concrete tasks):**
```bash
bd create "Create User model with email/password (2h)" -t task -p 0 -l backend,models
bd create "Add password hashing with bcrypt (1h)" -t task -p 0 -l backend,security
bd create "Create POST /api/login endpoint (3h)" -t task -p 0 -l backend,api
bd create "Add JWT token generation (2h)" -t task -p 0 -l backend,auth
bd create "Create login form component (4h)" -t task -p 1 -l frontend
bd create "Add form validation (2h)" -t task -p 1 -l frontend
bd create "Connect form to API (2h)" -t task -p 1 -l frontend
bd create "Write authentication tests (3h)" -t task -p 1 -l testing
bd create "Add error handling (2h)" -t task -p 1 -l backend,frontend
bd create "Deploy to staging (1h)" -t task -p 2 -l deployment
```

All concrete, all estimated, can start immediately.

### Example 2: Moderate Design (Stage 3 - "User Profiles")

**Design:** 3 pages, CRUD + image upload + privacy

**Tasks created (18 tasks: 11 concrete, 7 epic):**

**Concrete (immediate work):**
```bash
bd create "Create Profile model schema (2h)" -t task -p 0 -l backend,models
bd create "Add profile CRUD API endpoints (4h)" -t task -p 0 -l backend,api
bd create "Set up file upload middleware (3h)" -t task -p 0 -l backend
bd create "Create ProfileView component (4h)" -t task -p 1 -l frontend
bd create "Create ProfileEdit form (5h)" -t task -p 1 -l frontend
bd create "Add client-side validation (2h)" -t task -p 1 -l frontend
bd create "Write profile API tests (4h)" -t task -p 1 -l testing
bd create "Add staging deployment (1h)" -t task -p 2 -l deployment
bd create "Update API documentation (2h)" -t task -p 2 -l docs
bd create "Add basic error logging (2h)" -t task -p 1 -l backend
bd create "Create migration script (1h)" -t task -p 0 -l backend,database
```

**Epic (break down later):**
```bash
bd create "Implement image upload & processing" -t epic -p 1 -l backend,media \
  --description "Epic - break down when ready. Includes: S3 integration, image resize, CDN, avatar cropping UI"

bd create "Build privacy controls UI" -t epic -p 1 -l frontend \
  --description "Epic - break down when ready. Includes: privacy settings page, visibility toggles, preview mode"

bd create "Add privacy permissions logic" -t epic -p 1 -l backend \
  --description "Epic - break down when ready. Includes: ACL checks, permission middleware, visibility filters"

bd create "Comprehensive profile testing" -t epic -p 1 -l testing \
  --description "Epic - break down when ready. Includes: integration tests, E2E user flows, privacy test cases"

bd create "Profile performance optimization" -t epic -p 2 -l backend,performance \
  --description "Epic - break down when ready. Includes: caching strategy, query optimization, lazy loading"

bd create "Profile analytics & monitoring" -t epic -p 2 -l observability \
  --description "Epic - break down when ready. Includes: usage metrics, error tracking, performance monitoring"

bd create "Profile SEO & sharing" -t epic -p 2 -l frontend \
  --description "Epic - break down when ready. Includes: meta tags, Open Graph, Twitter cards, social sharing"
```

Mix of concrete (start now) and epics (break down when ready).

### Example 3: Complex Design (Stage 5 - "Payment System")

**Design:** 6 pages, comprehensive with Stripe, webhooks, subscriptions, invoicing

**Tasks created (28 tasks: 8 concrete, 20 epic):**

**Concrete (immediate setup work):**
```bash
bd create "Set up Stripe SDK & API keys (1h)" -t task -p 0 -l backend,setup
bd create "Create database schema for payments (3h)" -t task -p 0 -l backend,database
bd create "Add Stripe webhook endpoint (2h)" -t task -p 0 -l backend,api
bd create "Set up test framework for payments (2h)" -t task -p 0 -l testing
bd create "Create payment service interface (3h)" -t task -p 0 -l backend
bd create "Add payment logging (2h)" -t task -p 1 -l backend,observability
bd create "Set up staging Stripe account (1h)" -t task -p 0 -l deployment
bd create "Document payment architecture (4h)" -t task -p 1 -l docs
```

**Epic (break down over time):**
```bash
bd create "Implement Stripe checkout flow" -t epic -p 0 -l backend,payments
bd create "Build checkout UI components" -t epic -p 0 -l frontend,payments
bd create "Implement subscription management" -t epic -p 0 -l backend,subscriptions
bd create "Build subscription dashboard UI" -t epic -p 0 -l frontend,subscriptions
bd create "Implement webhook processing" -t epic -p 0 -l backend,webhooks
bd create "Build invoice generation system" -t epic -p 1 -l backend,invoicing
bd create "Implement refund processing" -t epic -p 1 -l backend,payments
bd create "Build payment admin UI" -t epic -p 1 -l frontend,admin
bd create "Implement payment analytics" -t epic -p 1 -l backend,analytics
bd create "Add fraud detection" -t epic -p 1 -l backend,security
bd create "Comprehensive payment testing" -t epic -p 0 -l testing
bd create "Payment error handling & recovery" -t epic -p 0 -l backend
bd create "Set up payment monitoring & alerts" -t epic -p 0 -l observability
bd create "Implement PCI compliance measures" -t epic -p 0 -l security,compliance
bd create "Build payment reconciliation tools" -t epic -p 1 -l backend,finance
bd create "Payment performance optimization" -t epic -p 2 -l performance
bd create "Multi-currency support" -t epic -p 2 -l backend,i18n
bd create "Tax calculation integration" -t epic -p 2 -l backend,tax
bd create "Customer payment portal" -t epic -p 1 -l frontend
bd create "Payment migration & rollout strategy" -t epic -p 0 -l deployment
```

Mostly epics - break down each one when you're ready to work on it. This prevents creating 200+ detailed tasks that might change.

## Guidelines

**Creating effective task breakdowns:**

- **Right-size for complexity:** Simple designs get detailed tasks; complex designs get high-level epics
- **Actionable first tasks:** Always create some concrete tasks to start immediately
- **Defer detail:** Don't plan every detail for work that's 4 weeks away - things will change
- **Clear epic descriptions:** Each epic should explain what needs to be broken down
- **Use dependencies wisely:** Only add dependencies for true blocking relationships
- **Label consistently:** Use same labels across tasks for easy filtering
- **Estimate conservatively:** Only estimate concrete tasks, and pad for unknowns

**When to create epics vs concrete tasks:**

- **Epic:** "Build user dashboard" (multiple components, days of work, many subtasks)
- **Concrete:** "Create UserCard component" (single file, hours of work, clear scope)
- **Epic:** "Implement notification system" (multiple services, infrastructure, complexity)
- **Concrete:** "Add email notification for password reset" (single feature, clear deliverable)

**Epic breakdown workflow:**

1. Start with concrete tasks from task list
2. When ready to tackle an epic:
   - Read the epic description
   - Optionally: Write a mini-design doc for that subsystem
   - Run `/tasks-from-design` on just that epic (or manually break down with beads)
   - Mark epic as in-progress or blocked-by subtasks
3. As you implement, learn new things that might change the plan
4. Remaining epics stay high-level until you're ready for them

## Goal

Create a task breakdown that:
1. ✅ Has concrete tasks to start work immediately
2. ✅ Doesn't over-plan distant work that will change
3. ✅ Clearly marks what needs future breakdown
4. ✅ Uses appropriate granularity for design complexity
5. ✅ Makes progress trackable without being overwhelming
6. ✅ Allows for course correction as you learn
