# claude-agents

A collection of specialized Claude Code agents that extend your AI assistant with focused, context-aware behaviors — automatically triggered by how you naturally phrase your requests. Drop them into `~/.claude/agents/` and Claude will route the right tasks to the right agent without you having to think about it.

---

## Quickstart

Install all agents with one command:

```bash
curl -fsSL https://raw.githubusercontent.com/Codemode001/claude-agents/main/install.sh | bash
```

Or clone and run locally:

```bash
git clone https://github.com/Codemode001/claude-agents.git
cd claude-agents
chmod +x install.sh
./install.sh
```

---

## Install a specific agent

```bash
curl -fsSL https://raw.githubusercontent.com/Codemode001/claude-agents/main/install.sh | bash -s bug-surgeon
```

Or if you've cloned the repo:

```bash
./install.sh bug-surgeon
```

---

## Agents

| Agent | What it does | Example triggers |
|---|---|---|
| **bug-surgeon** | Diagnoses and surgically fixes bugs with minimal footprint — traces the error, forms a hypothesis, applies the smallest correct change. | `"there's a bug in X"`, `"fix this"`, `"getting this error"`, `"why is this failing"` |
| **code-explainer** | Explains what code does at two levels: a plain-English summary and a detailed step-by-step walkthrough. | `"explain this"`, `"what does X do"`, `"how does this work"`, `"walk me through this"` |
| **codebase-explorer** | Maps an unfamiliar codebase and produces a structured onboarding document covering architecture, key files, and data flow. | `"explore this project"`, `"what does this repo do"`, `"help me get oriented"`, `"I haven't worked on this in months"` |
| **refactor-planner** | Produces a safe, sequenced refactor plan without touching any code — reads the module, its callers, and project conventions first. | `"plan a refactor"`, `"this module is a mess"`, `"how should I clean this up"`, `"how would you restructure this"` |
| **standup-writer** | Pulls your recent git commits, groups them into themes, and writes a paste-ready standup update. | `"write my standup"`, `"what did I do today"`, `"summarize yesterday"`, `"daily update"` |
| **ticket-planner** | Turns a ticket, user story, or feature request into a concrete technical implementation plan grounded in your actual codebase. | `"how should I build this"`, `"break this down"`, `"spec this out"`, `"what's the approach for this"` |

---

## How it works

These are [Claude Code](https://claude.ai/code) agents — markdown files that live in `~/.claude/agents/`. When you open a Claude Code session, the agent descriptions are loaded and Claude automatically routes your requests to the most appropriate agent based on how you phrase them. No commands, no slash syntax required — just talk naturally and the right agent activates.

Each agent has a focused system prompt that shapes its methodology, output format, and constraints. They're designed to be surgical and non-destructive: they won't refactor code you didn't ask to refactor, rename things you didn't ask to rename, or add features beyond what you requested.

---

## Customizing for your project

After installing, open any agent file in `~/.claude/agents/` and add your own project-specific context directly in the system prompt. Good things to add:

- Your tech stack (language, framework, database)
- Key architectural patterns (e.g. how your pipeline is structured, how modules communicate)
- File naming conventions or directory layout
- Known gotchas or constraints (e.g. "this project uses CommonJS, not ESM")
- Any project-specific terminology the agent should understand

The agents are intentionally generic out of the box — personalizing them to your codebase makes them significantly more useful.

---

## Notes

- Memory paths use `$HOME` and work on both Mac and Linux.
- Agents persist learned context across sessions in `$HOME/.claude/agent-memory/<agent-name>/`.
- Requires [Claude Code](https://claude.ai/code) CLI or desktop app.
