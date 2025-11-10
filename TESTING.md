# Testing Claude Commands with Promptfoo

This document explains how to test the `/audit` command (and other Claude commands) for regression, behavior validation, and token usage monitoring.

## Overview

We use [promptfoo](https://www.promptfoo.dev/) to test our prompt-based Claude commands. Promptfoo allows us to:

- **Regression testing**: Ensure commands still produce expected outputs after changes
- **Behavior validation**: Verify commands follow their defined processes
- **Token usage monitoring**: Track API costs and performance
- **Quality assurance**: Use LLM-based rubrics to evaluate complex outputs

## Setup

### 1. Install Dependencies

```bash
npm install
```

This installs `promptfoo` and its dependencies.

### 2. Set Environment Variables

Promptfoo needs your Anthropic API key to run tests.

**Get your API key**: https://console.anthropic.com/settings/keys

**Option A: Create `.env` file (Recommended)**

Copy the example file and add your key:

```bash
cp .env.example .env
# Then edit .env and replace "your-api-key-here" with your actual key
```

**Option B: Export in terminal**

```bash
export ANTHROPIC_API_KEY="your-api-key-here"
```

Note: This only works for the current terminal session.

## Running Tests

### Run All Tests

```bash
npm test
```

Or directly with promptfoo:

```bash
npx promptfoo eval
```

### Run Tests and View Results in UI

```bash
npm run test:ui
```

This opens an interactive web interface showing test results, token usage, and comparisons.

### Run Specific Test Cases

```bash
npx promptfoo eval --filter "Stage 2"
```

This runs only test cases with "Stage 2" in their description.

### Run with More Detail

```bash
npx promptfoo eval --verbose
```

## Understanding the Test Configuration

### Test File Structure

The main config is `promptfooconfig.yaml`:

```yaml
prompts:
  - file://claude/commands/audit.md  # The command to test

providers:
  - anthropic:messages:claude-sonnet-4-5-20250929  # Latest Claude 4.5 Sonnet

tests:
  - description: 'Test case description'
    vars:
      context: 'Simulated codebase context...'
    assert:
      - type: llm-rubric
        value: 'What the output should demonstrate'
```

### Assertion Types

We use several assertion types:

1. **`llm-rubric`**: LLM evaluates output quality against a rubric
   - Example: "Creates specific action items with file names"
   - Best for complex behavioral checks

2. **`icontains` / `icontains-any` / `icontains-all`**: Case-insensitive string matching
   - Example: Check for "README" or "beads" in output
   - Fast and deterministic

3. **`not-icontains` / `not-icontains-any`**: Verify absence of strings
   - Example: Ensure "cost optimization" is NOT mentioned for Stage 2

4. **`cost`**: Token cost threshold
   - Example: Alert if test costs more than $0.50

5. **`latency`**: Response time threshold
   - Example: Ensure response within 15 seconds

### Test Categories

Our tests cover:

1. **Process Adherence**: Does the command follow defined steps?
   - Checks for beads
   - Asks for company stage
   - Explores codebase

2. **Stage-Appropriate Recommendations**: Different advice per stage?
   - Stage 2: No tests required
   - Stage 4: Tests required
   - Stage-specific priorities

3. **Action Item Quality**: Are recommendations specific and actionable?
   - Good: "Add .gitignore with Python patterns (*.pyc, __pycache__)"
   - Bad: "Fix version control"

4. **Output Format**: Correct report structure?
   - Readiness score
   - Summary sections
   - Next steps

## Interpreting Results

### Success

```
✓ Stage 2 should NOT penalize for missing tests
  All assertions passed
  Cost: $0.08
  Latency: 4.2s
```

### Failure

```
✗ Stage 4 SHOULD require tests
  Failed assertion: llm-rubric
  Expected: Creates action items for adding tests
  Actual: No mention of tests in output
```

### View Detailed Results

```bash
npx promptfoo view
```

Opens a web UI with:
- Side-by-side comparisons
- Token usage graphs
- Assertion details
- Output diffs

## Cost Monitoring

Track token usage and costs:

1. **Per-test costs**: Shown in test output
2. **Historical tracking**: View trends in `promptfoo view`
3. **Cost alerts**: Set thresholds in test assertions

Example cost tracking:

```yaml
assert:
  - type: cost
    threshold: 0.50  # Alert if > $0.50
```

## Performance Monitoring

Track response times:

```yaml
assert:
  - type: latency
    threshold: 15000  # Alert if > 15s
```

View latency trends in the web UI.

## Adding New Tests

### 1. Add Test Case to Config

Edit `promptfooconfig.yaml`:

```yaml
tests:
  - description: 'Your new test description'
    vars:
      context: |
        Company stage: 3
        Codebase: ...
    assert:
      - type: llm-rubric
        value: 'Expected behavior'
```

### 2. Run Tests

```bash
npm test
```

### 3. Review Results

```bash
npx promptfoo view
```

## Testing Other Commands

To test `/prototype` or `/ready`:

1. Create a new config file (e.g., `promptfoo-prototype.yaml`)
2. Update the `prompts` section to reference the new command
3. Write test cases specific to that command
4. Run with: `npx promptfoo eval -c promptfoo-prototype.yaml`

## CI/CD Integration

To run tests in CI:

```yaml
# .github/workflows/test-commands.yml
- name: Test Claude Commands
  env:
    ANTHROPIC_API_KEY: ${{ secrets.ANTHROPIC_API_KEY }}
  run: npm test
```

## Limitations

### What We CAN Test

- Process adherence (does it ask the right questions?)
- Stage-appropriate logic (different recommendations per stage)
- Action item quality (specific vs vague)
- Output format compliance

### What We CAN'T Test

- Actual codebase exploration (requires Claude Code's Task tool)
- Beads integration (requires beads CLI)
- File operations (requires actual file system)
- Interactive user responses

For these, we simulate context in test variables.

## Troubleshooting

### "Provider authentication failed"

Set your API key:
```bash
export ANTHROPIC_API_KEY="your-key"
```

### Tests are slow

- Reduce `maxConcurrency` in config
- Use `--filter` to run subset of tests
- Consider using a cheaper/faster model for development

### Tests are expensive

- Set cost thresholds to catch expensive tests
- Use temperature=0.2 for consistency (already configured)
- Monitor costs in `promptfoo view`

### Flaky tests

- LLM outputs vary - llm-rubric helps but isn't perfect
- Increase test specificity
- Consider golden master testing for critical paths

## Resources

- [Promptfoo Documentation](https://www.promptfoo.dev/docs/)
- [Assertion Types Reference](https://www.promptfoo.dev/docs/configuration/expected-outputs/)
- [LLM Rubrics Guide](https://www.promptfoo.dev/docs/configuration/expected-outputs/#llm-rubric)

## Next Steps

- Run the tests: `npm test`
- View results: `npm run test:ui`
- Add tests for `/prototype` and `/ready` commands
- Set up CI/CD integration
- Monitor token usage trends
