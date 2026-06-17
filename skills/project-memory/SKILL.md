# Project Memory Skill

---
description: Initialize, resume, and update AI-readable project memory for any software project. Use this when the user wants to learn, understand, use, debug, or continue working on an open-source or existing codebase across multiple AI sessions.
---

You are helping the user build and maintain an AI-readable memory system for the current software project.

The user's goal is usually one of these:
1. Learn how to use an unfamiliar open-source project.
2. Understand the codebase structure.
3. Run the project locally.
4. Debug installation or usage issues.
5. Continue a previous AI-assisted session without losing context.
6. Let future AI agents quickly recover project context.

Your job is not only to answer the current question, but also to maintain persistent project memory files.

## Core Principle

Do not rely on chat memory.

Instead, create and maintain project-local Markdown files that future AI agents can read.

The project memory system should be stored in:

```txt
CLAUDE.md
docs/ai/
```

Recommended structure:

```txt
CLAUDE.md
docs/ai/
├── 00-project-index.md
├── 01-usage-runbook.md
├── 02-code-map.md
├── 03-learning-notes.md
├── 04-faq-and-errors.md
└── 05-session-log.md
```

## Operating Modes

The user may ask you to:

* initialize project memory
* resume from project memory
* update project memory
* explain the project
* help run the project
* debug an issue
* continue from last time

Infer the correct mode from the user's request.

---

# Mode A: Initialize Project Memory

Use this when the project has no existing AI memory files, or when the user asks to create them.

## Steps

1. Inspect the repository structure.
2. Read important documentation first:

   * README
   * installation docs
   * usage docs
   * examples
   * configuration files
   * package/dependency files
   * Docker files
   * test files
   * CLI or server entry points
3. Identify the project type:

   * frontend app
   * backend service
   * CLI tool
   * library
   * AI/ML project
   * data pipeline
   * desktop app
   * mobile app
   * monorepo
   * unknown
4. Identify the most likely user path:

   * install
   * configure
   * run
   * test
   * use basic features
   * debug common errors
5. Create or update the memory files.

## Required Output Files

### 1. CLAUDE.md

Purpose: short entry file for future AI agents.

Keep it concise.

Must include:

```md
# CLAUDE.md

## Project Memory Entry

Before answering project-specific questions, read these files in order:

1. docs/ai/00-project-index.md
2. docs/ai/01-usage-runbook.md
3. docs/ai/02-code-map.md
4. docs/ai/04-faq-and-errors.md
5. docs/ai/05-session-log.md

## User Goal

The user is learning how to understand, run, use, and gradually work with this project.

Prioritize:
- practical usage
- installation
- running the project
- explaining core concepts
- debugging errors
- preserving context for future sessions

Avoid:
- unnecessary large refactors
- changing source code before explaining risks
- guessing when facts are not confirmed

## Rules for Future AI Agents

- Always cite exact file paths when explaining project behavior.
- Distinguish confirmed facts from assumptions.
- Before modifying code, explain what will be changed and why.
- After each meaningful session, update docs/ai/05-session-log.md.
```

### 2. docs/ai/00-project-index.md

Purpose: project overview and navigation.

Must include:

```md
# Project Index

## What This Project Is

Explain the project in plain language.

## What Problem It Solves

Explain the main use case.

## Project Type

State the type of project and confidence level.

Example:
- Type: CLI tool
- Confidence: high
- Evidence: package.json contains bin entry; README shows command-line usage

## Important Files and Directories

| Path | Purpose | Importance |
|---|---|---|

## Recommended Reading Order

1. ...
2. ...
3. ...

## Current Understanding

### Confirmed

- ...

### Unconfirmed

- ...

## Best Next Step for a New AI Session

Tell the next AI what to do first.
```

### 3. docs/ai/01-usage-runbook.md

Purpose: help the user actually install, run, and use the project.

Must include:

```md
# Usage Runbook

## Environment Requirements

List language/runtime/package manager/system requirements.

## Installation

Provide commands.

## Configuration

List required environment variables, config files, credentials, API keys, ports, paths, or datasets.

## Minimal Working Example

Provide the smallest realistic way to run or use the project.

## Common Commands

| Task | Command | Notes |
|---|---|---|

## How to Verify Success

Explain what output/log/page/file/result proves it worked.

## Inputs and Outputs

Explain what the project expects and produces.

## Common Usage Workflow

Step-by-step practical usage flow.

## Notes for Beginners

Explain anything confusing for first-time users.
```

### 4. docs/ai/02-code-map.md

Purpose: help future AI understand the codebase quickly.

Must include:

```md
# Code Map

## High-Level Architecture

Describe the main modules and how they connect.

## Entry Points

| Path | Role |
|---|---|

## Core Modules

| Path | Responsibility | Notes |
|---|---|---|

## Configuration Flow

Explain where config is defined, loaded, and used.

## Data Flow or Request Flow

Explain the main flow from input to output.

## Key Functions / Classes

| Name | Path | Purpose |
|---|---|---|

## Extension Points

Where a user would safely customize behavior.

## Files Beginners Should Avoid Editing First

List risky files and why.
```

### 5. docs/ai/03-learning-notes.md

Purpose: teach the user the project gradually.

Must include:

```md
# Learning Notes

## Mental Model

Explain how the project works in simple terms.

## Concepts the User Should Learn First

1. ...
2. ...
3. ...

## Concepts to Learn Later

1. ...
2. ...
3. ...

## Glossary

| Term | Meaning |
|---|---|

## Suggested Learning Path

Step-by-step path for the user.
```

### 6. docs/ai/04-faq-and-errors.md

Purpose: preserve debugging knowledge.

Must include:

```md
# FAQ and Errors

## Common Errors

### Error: ...

**Symptom**

What the user sees.

**Likely Cause**

Why it happens.

**Solution**

How to fix it.

**Related Files**

- ...
```

If no errors have been encountered yet, create the file with a placeholder section.

### 7. docs/ai/05-session-log.md

Purpose: chronological memory.

Must include:

````md
# Session Log

## YYYY-MM-DD

### Session Goal

What the user wanted.

### What Was Done

What was inspected, created, run, changed, or explained.

### Confirmed Facts

- ...

### Commands Run

```bash
...
```

### Files Read

* ...

### Files Created or Updated

* ...

### Problems Found

* ...

### Unconfirmed / Needs Follow-Up

* ...

### Recommended Next Step

What the next AI session should do first.

````

Append new entries. Do not delete useful old entries.

---

# Mode B: Resume From Project Memory

Use this when the user returns later and wants to continue.

## Steps

1. Read CLAUDE.md.
2. Read docs/ai/00-project-index.md.
3. Read docs/ai/01-usage-runbook.md.
4. Read docs/ai/02-code-map.md.
5. Read docs/ai/05-session-log.md.
6. Summarize recovered context before acting.

## Response Format

Start with:

```md
我已经恢复到这些项目上下文：

1. 项目用途：...
2. 当前使用方式：...
3. 核心入口：...
4. 上次进展：...
5. 当前最适合继续做的事：...
```

Then answer the user's current request.

If project memory files are missing, switch to Mode A and initialize them.

---

# Mode C: Update Project Memory

Use this at the end of any meaningful session.

## Steps

1. Update docs/ai/05-session-log.md with a new dated entry.
2. If new commands were discovered, update docs/ai/01-usage-runbook.md.
3. If new code structure was understood, update docs/ai/02-code-map.md.
4. If new errors were solved, update docs/ai/04-faq-and-errors.md.
5. If the overall understanding changed, update docs/ai/00-project-index.md.
6. Keep CLAUDE.md short. Only update it if the entry instructions need to change.

## Rules

* Never invent facts.
* Mark uncertain information as "Unconfirmed".
* Prefer exact file paths over vague descriptions.
* Prefer actual commands over general advice.
* Preserve historical session logs.
* Do not remove useful prior notes unless they are clearly wrong.
* Do not make large source-code changes unless the user explicitly asked.
* If you modify source code, also document why in docs/ai/05-session-log.md.

---

# Quality Checklist

Before finishing, verify that the memory files are useful for future AI agents.

A good project memory system should answer:

1. What is this project?
2. How do I install it?
3. How do I run it?
4. How do I know it worked?
5. Where is the entry point?
6. What files matter most?
7. What did the previous AI session already discover?
8. What is still uncertain?
9. What should the next AI do first?
10. What should a beginner avoid changing?

If these questions are not answered, improve the memory files before finishing.
