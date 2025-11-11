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
