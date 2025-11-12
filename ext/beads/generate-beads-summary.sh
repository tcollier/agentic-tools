#!/bin/bash
# generate-beads-summary.sh
# Generates a BEADS.md file summarizing all issues grouped by status

set -e

OUTPUT_FILE="${1:-BEADS.md}"

# Check if bd is available
if ! command -v bd &> /dev/null; then
    echo "Error: bd command not found. Please install beads first."
    exit 1
fi

# Check if jq is available
if ! command -v jq &> /dev/null; then
    echo "Error: jq command not found. Please install jq for JSON processing."
    exit 1
fi

# Check if we're in a beads repository
if ! bd info &> /dev/null; then
    echo "Error: Not in a beads repository. Run 'bd init' first."
    exit 1
fi

echo "Generating $OUTPUT_FILE..."

# Generate the markdown file
{
    echo "# BEADS Issues Summary"
    echo
    echo "Generated: $(date '+%Y-%m-%d %H:%M:%S')"
    echo

    # Get statistics
    TOTAL=$(bd list --json 2>/dev/null | jq 'length')
    OPEN=$(bd list --status open --json 2>/dev/null | jq 'length')
    IN_PROGRESS=$(bd list --status in_progress --json 2>/dev/null | jq 'length')
    BLOCKED=$(bd list --status blocked --json 2>/dev/null | jq 'length')
    CLOSED=$(bd list --status closed --json 2>/dev/null | jq 'length')

    echo "## Overview"
    echo
    echo "- **Total Issues**: $TOTAL"
    echo "- **Open**: $OPEN"
    echo "- **In Progress**: $IN_PROGRESS"
    echo "- **Blocked**: $BLOCKED"
    echo "- **Closed**: $CLOSED"
    echo

    # Open Issues
    echo "## Open Issues"
    echo
    OPEN_ISSUES=$(bd list --status open --json 2>/dev/null)
    if [ "$(echo "$OPEN_ISSUES" | jq 'length')" -gt 0 ]; then
        # Table view
        echo "| Status | ID | Title | Priority | Type |"
        echo "|--------|----|----|----------|------|"
        echo "$OPEN_ISSUES" | jq -r '.[] | "| 🟢 | \(.id) | \(.title) | P\(.priority) | \(.type) |"'
        echo

        # Collapsible detailed view
        echo "<details>"
        echo "<summary>View detailed descriptions</summary>"
        echo
        echo "$OPEN_ISSUES" | jq -r '.[] | "### \(.id): \(.title)\n\n**Priority**: P\(.priority) | **Type**: \(.type)\n\n\(if .description != "" then .description else "(No description)" end)\n"'
        echo "</details>"
        echo
    else
        echo "*No open issues*"
        echo
    fi

    # In Progress Issues
    echo "## In Progress"
    echo
    IN_PROGRESS_ISSUES=$(bd list --status in_progress --json 2>/dev/null)
    if [ "$(echo "$IN_PROGRESS_ISSUES" | jq 'length')" -gt 0 ]; then
        # Table view
        echo "| Status | ID | Title | Priority | Type |"
        echo "|--------|----|----|----------|------|"
        echo "$IN_PROGRESS_ISSUES" | jq -r '.[] | "| 🔄 | \(.id) | \(.title) | P\(.priority) | \(.type) |"'
        echo

        # Collapsible detailed view
        echo "<details>"
        echo "<summary>View detailed descriptions</summary>"
        echo
        echo "$IN_PROGRESS_ISSUES" | jq -r '.[] | "### \(.id): \(.title)\n\n**Priority**: P\(.priority) | **Type**: \(.type) | **Assignee**: \(.assignee // "Unassigned")\n\n\(if .description != "" then .description else "(No description)" end)\n"'
        echo "</details>"
        echo
    else
        echo "*No issues in progress*"
        echo
    fi

    # Blocked Issues
    echo "## Blocked"
    echo
    BLOCKED_ISSUES=$(bd list --status blocked --json 2>/dev/null)
    if [ "$(echo "$BLOCKED_ISSUES" | jq 'length')" -gt 0 ]; then
        # Table view
        echo "| Status | ID | Title | Priority | Type |"
        echo "|--------|----|----|----------|------|"
        echo "$BLOCKED_ISSUES" | jq -r '.[] | "| 🚫 | \(.id) | \(.title) | P\(.priority) | \(.type) |"'
        echo

        # Collapsible detailed view
        echo "<details>"
        echo "<summary>View detailed descriptions</summary>"
        echo
        echo "$BLOCKED_ISSUES" | jq -r '.[] | "### \(.id): \(.title)\n\n**Priority**: P\(.priority) | **Type**: \(.type)\n\n\(if .description != "" then .description else "(No description)" end)\n"'
        echo "</details>"
        echo
    else
        echo "*No blocked issues*"
        echo
    fi

    # Ready Work
    echo "## Ready to Work On"
    echo
    echo "*Issues with no open blockers*"
    echo
    READY_ISSUES=$(bd ready --json 2>/dev/null)
    if [ "$(echo "$READY_ISSUES" | jq 'length')" -gt 0 ]; then
        echo "$READY_ISSUES" | jq -r '.[] | "- **\(.id)**: \(.title) (P\(.priority), \(.type))"'
        echo
    else
        echo "*No ready work*"
        echo
    fi

    # Recently Closed Issues (last 20)
    echo "## Recently Closed"
    echo
    CLOSED_ISSUES=$(bd list --status closed --json 2>/dev/null)
    if [ "$(echo "$CLOSED_ISSUES" | jq 'length')" -gt 0 ]; then
        RECENT_CLOSED=$(echo "$CLOSED_ISSUES" | jq -c 'sort_by(.closed_at) | reverse | limit(20; .[])')

        # Table view
        echo "| Status | ID | Title | Priority | Type |"
        echo "|--------|----|----|----------|------|"
        echo "$RECENT_CLOSED" | jq -r '"| ✅ | \(.id) | \(.title) | P\(.priority) | \(.type) |"'
        echo

        # Collapsible detailed view
        echo "<details>"
        echo "<summary>View detailed descriptions</summary>"
        echo
        echo "$RECENT_CLOSED" | jq -r '"### \(.id): \(.title)\n\n**Priority**: P\(.priority) | **Type**: \(.type) | **Closed**: \(.closed_at // "unknown")\n\n\(if .description != "" then .description else "(No description)" end)\n"'
        echo "</details>"
        echo

        TOTAL_CLOSED=$(echo "$CLOSED_ISSUES" | jq 'length')
        if [ "$TOTAL_CLOSED" -gt 20 ]; then
            echo "*Showing 20 of $TOTAL_CLOSED closed issues*"
            echo
        fi
    else
        echo "*No closed issues*"
        echo
    fi

    echo "---"
    echo
    echo "*This file is automatically generated. Do not edit manually.*"

} > "$OUTPUT_FILE"

echo "✓ Generated $OUTPUT_FILE"
