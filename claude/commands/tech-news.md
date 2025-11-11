# Tech News Command

Generate personalized tech news digests based on your repository's dependencies. Choose to run once (synchronous) or set up automated weekly digests via GitHub Actions + Slack.

**Purpose:** Stay informed about updates, security issues, and best practices for the technologies you actually use.

## Process

### 1. Initial Mode Selection

Ask user which mode they want:

```
📰 Tech News Command

How would you like to use this command?

1) Run now - Get tech news in this chat (one-time)
2) Set up automation - Configure weekly Slack digests (guided setup)

Choose [1/2]:
```

Use `AskUserQuestion` tool with options:
- "Run now" - Execute synchronously, display in chat
- "Set up automation" - Launch guided setup wizard

---

## Mode 1: Run Now (Synchronous)

Execute immediately and display results in chat.

### Step 1: Detect Tech Stack

**Find package manifest files:**

Use `Glob` tool to search for:
- `package.json` (Node.js)
- `requirements.txt`, `pyproject.toml`, `Pipfile` (Python)
- `go.mod` (Go)
- `Gemfile` (Ruby)
- `Cargo.toml` (Rust)
- `composer.json` (PHP)
- `pom.xml`, `build.gradle` (Java)
- `*.csproj`, `packages.config` (.NET)

**Parse dependencies:**

For each found file:
- Use `Read` tool to get contents
- Extract dependency names (not versions for now)
- Focus on production dependencies (not dev/test)
- Identify frameworks first, then major libraries

**Prioritize dependencies:**
1. **Frameworks** (React, Django, Rails, Express, etc.) - highest priority
2. **Core libraries** (database drivers, auth libraries)
3. **Build tools** (Webpack, Vite, etc.)
4. **Popular packages** (lodash, axios, requests, etc.)

Take top 10-15 most significant dependencies.

**Example tech stack detection:**
```
Detected tech stack:
• Node.js (package.json found)
  - react (framework)
  - next.js (framework)
  - express (framework)
  - typescript (language)
  - prisma (database)
  - axios (http client)

• Python (requirements.txt found)
  - django (framework)
  - celery (task queue)
  - psycopg2 (database)
```

### Step 2: Search for Relevant News

For each major dependency (top 10-15), use `WebSearch` tool to find:

**Search queries per package:**

**Major releases:**
```
"[package name] release notes past month"
"[package name] version [major].0 released"
```

**Security advisories:**
```
"[package name] security advisory 2025"
"[package name] CVE past month"
"[package name] vulnerability"
```

**Breaking changes:**
```
"[package name] breaking changes upcoming"
"[package name] deprecation notice"
```

**Best practices (for frameworks only):**
```
"[package name] best practices 2025"
"[package name] migration guide"
```

**Filter and categorize results:**

For each search result:
- Check if it's recent (past month preferred, past week highlighted)
- Categorize into: Release, Security, Breaking Change, Best Practice
- Extract: title, date, summary (1-2 sentences), link
- Mark security issues with severity if available (Critical, High, Medium, Low)

**Example news items:**
```
🚀 RELEASE: React 19.0.0
Date: Nov 4, 2025
Summary: New hooks API, automatic batching improvements, concurrent rendering enhancements
Link: https://react.dev/blog/2025-11-react-19

⚠️ SECURITY: Express CVE-2025-1234 (HIGH)
Date: Nov 8, 2025
Summary: Path traversal vulnerability in static file serving. Update to 4.19.2 immediately.
Link: https://github.com/advisories/GHSA-xxxx

📦 BREAKING: TypeScript 5.5 deprecates legacy decorators
Date: Oct 28, 2025
Summary: Stage 3 decorators now default, legacy decorators require flag
Link: https://devblogs.microsoft.com/typescript/5-5

💡 PATTERN: React Server Components adoption guide
Date: Nov 1, 2025
Summary: Migration strategies and patterns for existing Next.js applications
Link: https://nextjs.org/blog/rsc-guide
```

### Step 3: Check Outdated Dependencies

**For Node.js projects:**

If `package.json` exists:
```bash
npm outdated --json 2>/dev/null
```

Parse JSON output to get:
- Package name
- Current version
- Latest version
- Type (dependencies vs devDependencies)

**For Python projects:**

If `requirements.txt` or `pyproject.toml` exists:
```bash
pip list --outdated --format=json 2>/dev/null
```

Parse JSON output similarly.

**For Go projects:**

If `go.mod` exists:
```bash
go list -u -m all 2>/dev/null | grep '\['
```

**For Ruby projects:**

If `Gemfile` exists:
```bash
bundle outdated --parseable 2>/dev/null
```

**Highlight security updates:**

Cross-reference outdated packages with security advisories found in Step 2.
Mark with ⚠️ if a security fix is available.

**Example outdated dependencies:**
```
📦 Outdated Dependencies (4):

• react: 18.2.0 → 19.0.0
• typescript: 5.3.2 → 5.5.1
• express: 4.18.2 → 4.19.2 ⚠️ Security update
• axios: 1.5.0 → 1.6.2
```

### Step 4: Format and Display

Output formatted markdown in chat:

```markdown
📰 Tech News Digest - [Date]

**Repository:** [repo name]
**Tech Stack:** [languages/frameworks detected]

━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 🚀 NEW RELEASES ([count])

**[Package] [Version]**
[Summary in 1-2 sentences]
→ [Link]

[Repeat for each release...]

━━━━━━━━━━━━━━━━━━━━━━━━━━━

## ⚠️ SECURITY ADVISORIES ([count])

**[Package] [CVE] ([Severity])**
[Summary with recommended action]
→ [Link]

[Repeat for each advisory...]

━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 📦 BREAKING CHANGES & DEPRECATIONS ([count])

**[Package]: [Change title]**
[Summary and migration info]
→ [Link]

[Repeat...]

━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 💡 NOTABLE PATTERNS & BEST PRACTICES ([count])

**[Topic]**
[Summary]
→ [Link]

[Repeat...]

━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 🔍 DEPENDENCY STATUS

[If no outdated packages:]
✓ All dependencies are up to date!

[If outdated packages exist:]
**Outdated packages ([count]):**

• [package]: [current] → [latest]
• [package]: [current] → [latest] ⚠️ Security update

━━━━━━━━━━━━━━━━━━━━━━━━━━━

💡 Run /tech-news again anytime for fresh updates
💡 Want automated weekly digests? Run /tech-news and choose "Set up automation"
```

**If no news found:**
```
📰 Tech News Digest - [Date]

**Repository:** [repo name]
**Tech Stack:** [tech detected]

━━━━━━━━━━━━━━━━━━━━━━━━━━━

No significant news found for your tech stack in the past month.

This could mean:
• Your dependencies are stable (good!)
• News sources may not have recent announcements
• Try again in a few days

✓ All dependencies are up to date

━━━━━━━━━━━━━━━━━━━━━━━━━━━

💡 Run /tech-news again later for updates
```

---

## Mode 2: Set Up Automation (Guided Wizard)

Launch interactive setup wizard to configure GitHub Actions + Slack.

### Setup Step 1: Welcome & Prerequisites

Display welcome message and check prerequisites:

```
🤖 Let's set up automated weekly tech news digests!

This will:
✓ Create a GitHub Actions workflow
✓ Set up Slack integration (optional but recommended)
✓ Run every Monday at 7am (customizable)
✓ Post curated news based on your dependencies

Prerequisites:
• This repo must be on GitHub
• You need admin access to add GitHub secrets
• (Optional) A Slack workspace for posting

Continue? [y/n]:
```

Use `AskUserQuestion` with yes/no.

If no, exit with message:
```
Setup canceled. Run /tech-news again when ready!
```

### Setup Step 2: Check Repository Status

Verify repository is on GitHub:

```bash
# Check for git repo
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "✗ Not a git repository"
  exit 1
fi

# Check for GitHub remote
REMOTE_URL=$(git remote get-url origin 2>/dev/null)
if [[ ! "$REMOTE_URL" =~ github\.com ]]; then
  echo "✗ Repository is not on GitHub"
  echo "  Remote: $REMOTE_URL"
  echo "  This workflow requires GitHub Actions"
  exit 1
fi

# Extract repo info
REPO_PATH=$(echo "$REMOTE_URL" | sed -n 's/.*github\.com[:/]\([^/]*\/[^.]*\).*/\1/p')
echo "✓ Git repository detected"
echo "✓ Remote: github.com/$REPO_PATH"
```

**Create workflows directory if needed:**
```bash
mkdir -p .github/workflows
echo "✓ Workflows directory ready"
```

### Setup Step 3: Schedule Configuration

Ask user for schedule preference:

Use `AskUserQuestion` with options:
- "Every Monday at 7am (recommended)"
- "Every weekday at 9am"
- "Custom schedule"

Map to cron strings:
- Monday 7am: `'0 7 * * 1'`
- Weekday 9am: `'0 9 * * 1-5'`
- Custom: Ask user to provide cron string

**Example:**
```
When should the digest run?

Options:
1) Every Monday at 7am UTC (recommended)
2) Every weekday at 9am UTC
3) Custom schedule

Note: Times are in UTC. To convert your local time:
• PST/PDT: Add 8/7 hours
• EST/EDT: Add 5/4 hours
• CET/CEST: Subtract 1/2 hours

Choose [1/2/3]:
```

Store selected cron string for workflow file.

### Setup Step 4: Slack Integration

Ask if user wants Slack integration:

```
📱 Slack Integration Setup

Would you like to post digests to Slack?

Benefits:
• Get news delivered to your team channel
• Clickable links and formatted messages
• Historical archive in Slack

Skip this if:
• You don't use Slack
• You prefer GitHub Actions logs
• You want to set it up later

Set up Slack integration? [y/n]:
```

**If yes:**

Guide user through getting webhook:

```
Great! Let's get your Slack webhook URL.

📋 Step-by-step instructions:

1. Open your browser and go to:
   https://api.slack.com/messaging/webhooks

2. Click "Create your Slack app" (or use existing app)

3. Choose "From scratch"
   - App Name: "Tech News Bot"
   - Workspace: [Your workspace]

4. Click "Incoming Webhooks"

5. Toggle "Activate Incoming Webhooks" to ON

6. Click "Add New Webhook to Workspace"

7. Select a channel (e.g., #tech-news or #engineering)

8. Copy the webhook URL
   Format: https://hooks.slack.com/services/T00000000/B00000000/XXXX...

Press ENTER when you have the webhook URL...
```

Wait for user confirmation, then ask for webhook URL:

```
Paste your Slack webhook URL:
```

Accept text input, validate format:

```bash
# Validate webhook URL format
if [[ ! "$WEBHOOK_URL" =~ ^https://hooks\.slack\.com/services/ ]]; then
  echo "⚠️ Invalid webhook URL format"
  echo "Expected: https://hooks.slack.com/services/..."
  echo "Received: $WEBHOOK_URL"
  echo ""
  echo "Skip Slack setup? [y/n]:"
fi
```

**Test Slack connection:**

```
✓ Webhook URL received

Testing Slack connection...
```

```bash
# Send test message
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" -X POST \
  -H 'Content-type: application/json' \
  --data '{"text":"🤖 Test message from tech-news setup! If you see this, the integration works!"}' \
  "$WEBHOOK_URL")

if [ "$HTTP_CODE" = "200" ]; then
  echo "✓ Test message sent successfully!"
else
  echo "✗ Failed to send test message (HTTP $HTTP_CODE)"
fi
```

Ask for confirmation:

```
Check your Slack channel. Did you receive the test message? [y/n]:
```

If no:
```
⚠️ Slack test failed or message not received.

Options:
1) Try a different webhook URL
2) Skip Slack for now (set up later)

Choose [1/2]:
```

**If user skips Slack entirely:**

```
⚠️ Skipping Slack integration

Digests will be logged in GitHub Actions output instead.
You can add Slack later by setting the SLACK_WEBHOOK_URL secret.

Continue with GitHub Actions setup? [y/n]:
```

### Setup Step 5: Create GitHub Actions Workflow

```
Creating GitHub Actions workflow...
```

Generate workflow file content based on user's choices:

```yaml
name: Weekly Tech News Digest

on:
  schedule:
    - cron: '[USER_SELECTED_CRON]'  # e.g., '0 7 * * 1'
  workflow_dispatch:  # Allow manual triggers

jobs:
  send-tech-news:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v4
        with:
          fetch-depth: 1

      # Set up Node.js if package.json exists
      - name: Set up Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'
        if: hashFiles('package.json') != ''

      # Set up Python if Python files exist
      - name: Set up Python
        uses: actions/setup-python@v5
        with:
          python-version: '3.11'
        if: hashFiles('requirements.txt') != '' || hashFiles('pyproject.toml') != ''

      # Set up Go if go.mod exists
      - name: Set up Go
        uses: actions/setup-go@v5
        with:
          go-version: '1.21'
        if: hashFiles('go.mod') != ''

      - name: Generate and send tech news digest
        uses: anthropics/claude-code-action@v1
        with:
          anthropic_api_key: ${{ secrets.ANTHROPIC_API_KEY }}
          direct_prompt: |
            Run the /tech-news command in "Run now" mode (option 1).
            This will generate a curated tech news digest based on the
            repository's dependencies and post it to Slack if configured.
        env:
          SLACK_WEBHOOK_URL: ${{ secrets.SLACK_WEBHOOK_URL }}
```

Write file using `Write` tool:

```
✓ Created: .github/workflows/tech-news.yml

The workflow will:
• Run [schedule description] (e.g., "every Monday at 7am UTC")
• Detect your tech stack automatically
• Search for relevant news (releases, security, breaking changes)
• Check for outdated dependencies
• Post to Slack [if configured] or log to GitHub Actions
```

### Setup Step 6: GitHub Secrets Configuration

Guide user through adding secrets:

```
🔐 GitHub Secrets Setup

You need to add secrets to your GitHub repository for the workflow to run.

Required secrets:
1. ANTHROPIC_API_KEY - Your Claude API key (required)

Optional secrets:
2. SLACK_WEBHOOK_URL - Your Slack webhook (only if using Slack)

━━━━━━━━━━━━━━━━━━━━━━━━━━━

📋 Detailed Setup Instructions:

STEP 1: Get your Anthropic API key

1. Go to: https://console.anthropic.com/settings/keys
2. Click "Create Key"
3. Copy the API key (starts with "sk-ant-...")
4. Keep it safe - you'll paste it in the next step

STEP 2: Add secrets to GitHub

1. Open your browser and go to:
   https://github.com/[REPO_PATH]/settings/secrets/actions

2. Click "New repository secret"

3. Add first secret:
   Name: ANTHROPIC_API_KEY
   Value: [Paste your API key from Step 1]
   Click "Add secret"
```

If Slack was configured:

```
4. Click "New repository secret" again

5. Add second secret:
   Name: SLACK_WEBHOOK_URL
   Value: [WEBHOOK_URL]
   Click "Add secret"
```

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━

Press ENTER once you've added the secret(s)...
```

Wait for user, then verify:

```
Verifying setup...

✓ Workflow file created (.github/workflows/tech-news.yml)
✓ Workflow YAML is valid
✓ GitHub repository detected

⚠️ Note: Unable to verify GitHub secrets from local environment
  This is normal - secrets are only accessible in GitHub Actions.

Please confirm you've added the required secrets:
- ANTHROPIC_API_KEY [Required]
- SLACK_WEBHOOK_URL [Optional - only if using Slack]

Secrets added successfully? [y/n]:
```

If no:
```
⚠️ Workflow won't run without secrets!

The workflow file is created, but you need to add secrets before it can run.

Reminder:
https://github.com/[REPO_PATH]/settings/secrets/actions

Continue anyway? [y/n]:
```

### Setup Step 7: Commit Workflow File

Ask user how to handle the commit:

```
📝 Commit the Workflow File

The workflow file needs to be committed and pushed to GitHub to become active.

Options:
1) Commit and push now (I'll do it for you)
2) Show me the commands (I'll run them myself)
3) Exit and let me commit manually later

Choose [1/2/3]:
```

**Option 1: Commit automatically**

```bash
git add .github/workflows/tech-news.yml
git commit -m "Add automated weekly tech news digest workflow

- Runs every [schedule description]
- Posts to Slack [if configured]
- Detects tech stack and searches for relevant news
- Generated by /tech-news command"
git push origin $(git branch --show-current)
```

Show output:
```
Committing workflow file...
✓ File staged
✓ Commit created
✓ Pushing to GitHub...
✓ Pushed successfully!

The workflow is now active on GitHub.
```

**Option 2: Show commands**

```
To commit and activate the workflow, run these commands:

  git add .github/workflows/tech-news.yml
  git commit -m "Add weekly tech news digest workflow"
  git push origin main

After pushing, the workflow will be active.
```

**Option 3: Exit**

```
Workflow file created but not committed.

To activate later:
1. Review: .github/workflows/tech-news.yml
2. Commit and push the file
3. Ensure GitHub secrets are configured

Run /tech-news anytime to test or reconfigure.
```

### Setup Step 8: Test the Workflow

If workflow was committed successfully, offer to test:

```
🧪 Test the Workflow

The workflow is now live on GitHub!

Would you like to trigger a test run now? [y/n]:
```

**If yes:**

```
Great! Let's test it.

Opening your GitHub Actions page...

Instructions:
1. Go to: https://github.com/[REPO_PATH]/actions/workflows/tech-news.yml

2. Click the "Run workflow" button (on the right side)

3. Ensure branch is set to: [current branch]

4. Click the green "Run workflow" button

5. Wait ~30-60 seconds for the workflow to complete

6. Click on the workflow run to see logs
```

If Slack is configured:
```
7. Check your Slack channel for the digest!
```

```
The workflow will automatically run on your schedule: [schedule].

Press ENTER when done testing...
```

### Setup Step 9: Setup Complete

Final success message:

```
✅ Setup Complete!

Your weekly tech news digest is fully configured! 🎉

━━━━━━━━━━━━━━━━━━━━━━━━━━━

📋 Configuration Summary:

• Schedule: [schedule description] (UTC)
• Output: [Slack channel name OR "GitHub Actions logs"]
• Workflow: .github/workflows/tech-news.yml
• Tech Stack: Auto-detected from repository
• News Sources: Releases, security advisories, breaking changes, best practices

━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔧 How to Modify:

Change schedule:
  Edit .github/workflows/tech-news.yml (line 3)
  Cron syntax: minute hour day month weekday

Update Slack webhook:
  GitHub → Settings → Secrets → Edit SLACK_WEBHOOK_URL

Disable workflow:
  GitHub → Settings → Actions → Disable "Weekly Tech News Digest"

━━━━━━━━━━━━━━━━━━━━━━━━━━━

📬 Usage:

Automatic: Runs on schedule, posts to [Slack/GitHub Actions]

Manual trigger:
• GitHub: Actions → "Weekly Tech News Digest" → "Run workflow"
• Claude Code: /tech-news → "Run now" for one-time digest

━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎓 Next Steps:

1. [If tested] Check workflow logs to ensure it ran successfully
2. [If Slack] Verify test digest appeared in your Slack channel
3. Wait for your first scheduled run [schedule]
4. Enjoy staying up-to-date with zero effort!

Questions or issues? Check the logs in GitHub Actions.

Happy learning! 🚀
```

---

## Utilities (Used by Both Modes)

### Detect Tech Stack Function

**Pseudocode:**
```
function detect_tech_stack():
  tech_stack = []
  dependencies = {}

  # Check for each ecosystem
  if exists("package.json"):
    tech_stack.append("Node.js")
    deps = parse_package_json()
    dependencies["npm"] = prioritize_deps(deps)

  if exists("requirements.txt") or exists("pyproject.toml"):
    tech_stack.append("Python")
    deps = parse_python_deps()
    dependencies["pip"] = prioritize_deps(deps)

  # ... repeat for Go, Ruby, Rust, PHP, Java, .NET

  return tech_stack, dependencies

function prioritize_deps(deps):
  # Identify frameworks first
  frameworks = filter_frameworks(deps)
  libraries = filter_libraries(deps)
  tools = filter_tools(deps)

  # Return top 10-15 most significant
  return frameworks + libraries[:5] + tools[:3]
```

### Search News Function

**Pseudocode:**
```
function search_news_for_package(package_name):
  news_items = []

  # Search for releases
  results = websearch(f"{package_name} release notes past month")
  news_items.extend(parse_results(results, category="release"))

  # Search for security
  results = websearch(f"{package_name} security advisory 2025")
  news_items.extend(parse_results(results, category="security"))

  # Search for breaking changes
  results = websearch(f"{package_name} breaking changes")
  news_items.extend(parse_results(results, category="breaking"))

  return deduplicate(news_items)
```

### Format for Slack Function

**Slack Block Kit JSON structure:**

```json
{
  "text": "Tech News Digest - 2025-11-11",
  "blocks": [
    {
      "type": "header",
      "text": {
        "type": "plain_text",
        "text": "📰 Tech News Digest",
        "emoji": true
      }
    },
    {
      "type": "section",
      "text": {
        "type": "mrkdwn",
        "text": "*Repository:* agentic-tools\n*Tech Stack:* Node.js, Python, React, Django"
      }
    },
    {
      "type": "divider"
    },
    {
      "type": "section",
      "text": {
        "type": "mrkdwn",
        "text": "*🚀 NEW RELEASES*\n\n*React 19.0.0*\nNew hooks API, performance improvements\n<https://react.dev/blog|Read more>"
      }
    }
  ]
}
```

**Post to Slack:**

```bash
curl -X POST \
  -H 'Content-type: application/json' \
  --data "$SLACK_JSON" \
  "$SLACK_WEBHOOK_URL"
```

---

## Error Handling

**Common errors and responses:**

**No package files found:**
```
⚠️ No package manifest files found

Couldn't detect any dependencies (no package.json, requirements.txt, etc.)

This command works best for projects with:
• Node.js (package.json)
• Python (requirements.txt, pyproject.toml)
• Go (go.mod)
• Ruby (Gemfile)
• And other popular ecosystems

Try running this in a project directory with dependencies.
```

**WebSearch fails:**
```
⚠️ Unable to search for news

Web search is temporarily unavailable.
This could be due to rate limiting or connectivity issues.

Try again in a few minutes.
```

**Git not found (setup mode):**
```
✗ Git not found

This command requires git to check repository status.
Please ensure git is installed and this is a git repository.
```

**Not on GitHub (setup mode):**
```
✗ Repository not on GitHub

This automation setup requires GitHub Actions.

Your remote: [remote URL]

Alternatives:
• Push this repository to GitHub
• Use "Run now" mode for manual digests
• Set up your own cron job with Slack webhooks
```

---

## Guidelines

**Tech stack detection:**
- Be flexible with file formats
- Prioritize frameworks over utilities
- Include version management tools (like nvm, pyenv)
- Don't overwhelm with 100+ dependencies

**News curation:**
- Focus on actionable news (what should user do?)
- Highlight security issues prominently
- Don't repeat the same news for similar packages
- Skip minor patch releases unless security-related

**Slack formatting:**
- Use emojis sparingly for categories
- Keep messages scannable (not walls of text)
- Include links for everything
- Group similar items together

**Guided setup:**
- Be patient and clear at each step
- Provide exact URLs and commands
- Validate user input when possible
- Offer escape hatches ("skip this step")

## Goal

Provide a flexible, user-friendly tech news command that:
1. ✅ Works immediately (run now mode)
2. ✅ Guides through complex setup (automation mode)
3. ✅ Delivers personalized, relevant news
4. ✅ Highlights security issues prominently
5. ✅ Integrates seamlessly with GitHub + Slack
6. ✅ Requires minimal maintenance once set up
