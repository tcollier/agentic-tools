# Beads Extensions

This directory contains extensions and utilities for the [beads](https://github.com/steveyegge/beads) issue tracker.

## generate-beads-summary.sh

Generates a `BEADS.md` file summarizing all issues grouped by status - perfect for stakeholders who aren't git/commandline savvy.

### Prerequisites

- `bd` command installed and in PATH ([installation instructions](https://github.com/steveyegge/beads#installation))
- `jq` for JSON processing (`brew install jq` on macOS)
- Must be run from within a beads repository (where `bd init` has been run)

### Usage

```bash
# Generate BEADS.md in current directory
./generate-beads-summary.sh

# Generate to custom location
./generate-beads-summary.sh /path/to/output.md
```

### Output Format

The generated markdown file includes:

- **Overview**: Statistics showing total, open, in-progress, blocked, and closed issues
- **Open Issues**: Full details with description
- **In Progress**: Current work with assignees
- **Blocked Issues**: Issues waiting on dependencies
- **Ready to Work On**: Issues with no open blockers
- **Recently Closed**: Last 20 completed issues

### Git Hook Integration

To ensure BEADS.md is always up-to-date, add this to your pre-commit hook:

```bash
# .git/hooks/pre-commit
#!/bin/bash

# Sync beads database to JSONL
bd sync --flush-only

# Generate BEADS.md summary
~/Development/github.com/tcollier/agentic-tools/ext/beads/generate-beads-summary.sh

# Stage both files
git add .beads/beads.jsonl BEADS.md
```

Make the hook executable:
```bash
chmod +x .git/hooks/pre-commit
```

Now every commit will automatically update BEADS.md with the latest issue status.

### Example Output

```markdown
# BEADS Issues Summary

Generated: 2025-01-15 14:30:00

## Overview

- **Total Issues**: 42
- **Open**: 12
- **In Progress**: 5
- **Blocked**: 2
- **Closed**: 23

## Open Issues

### bd-a1b2: Implement user authentication

**Priority**: P1 | **Type**: feature

Add OAuth2 authentication flow with JWT tokens.

...
```

### Troubleshooting

**Error: bd command not found**
- Install beads: `curl -fsSL https://raw.githubusercontent.com/steveyegge/beads/main/scripts/install.sh | bash`
- Or use npm: `npm install -g @beads/bd`
- Or build from source: See [beads installation docs](https://github.com/steveyegge/beads#installation)

**Error: jq command not found**
- macOS: `brew install jq`
- Ubuntu/Debian: `sudo apt-get install jq`
- Other: See [jq installation](https://stedolan.github.io/jq/download/)

**Error: Not in a beads repository**
- Run `bd init` in your project directory first

## Future Extensions

Potential additions to this directory:

- GitHub Actions workflow to auto-generate BEADS.md
- Slack/Discord notification integration
- Custom report generators (by priority, by assignee, etc.)
- Dashboard HTML generator

## Contributing

If you create useful beads extensions, consider contributing them back to the main beads repository via [contribution guidelines](https://github.com/steveyegge/beads/blob/main/CONTRIBUTING.md).
