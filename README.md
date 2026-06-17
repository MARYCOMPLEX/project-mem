# ai-skills

My personal collection of reusable [Claude Code](https://claude.ai/code) skills.

## Skills

| Skill | Description |
|-------|-------------|
| [project-memory](./skills/project-memory/SKILL.md) | Initialize, resume, and update AI-readable project memory for any software project |

## What This Solves

When working with open-source or unfamiliar codebases across multiple AI sessions, context is lost every time. This skill creates a structured, persistent project memory system (`CLAUDE.md` + `docs/ai/`) so that:

- **You** can pick up where you left off
- **Future AI agents** immediately understand the project
- **Debugging knowledge** is preserved and never repeated
- **Learning paths** are documented for gradual understanding

## Quick Install

### 方式一：让 Claude Code 自动安装（推荐）

直接对 Claude Code 说：

```
帮我把 github.com/MARYCOMPLEX/ai-skills 中的 project-memory skill 安装到全局
```

Claude Code 会自动克隆仓库、复制 SKILL.md 到 `~/.claude/skills/project-memory/`。

### 方式二：手动命令行安装

#### Global install (available in all projects)

```bash
curl -fsSL https://raw.githubusercontent.com/MARYCOMPLEX/ai-skills/main/install.sh | bash
```

#### Project-local install (only in current project)

```bash
curl -fsSL https://raw.githubusercontent.com/MARYCOMPLEX/ai-skills/main/install.sh | bash -s -- --project
```

### Uninstall

对 Claude Code 说：

```
帮我把 ~/.claude/skills/project-memory/ 删掉
```

或者手动：

```bash
# Remove global install
curl -fsSL https://raw.githubusercontent.com/MARYCOMPLEX/ai-skills/main/uninstall.sh | bash

# Remove project-local install
curl -fsSL https://raw.githubusercontent.com/MARYCOMPLEX/ai-skills/main/uninstall.sh | bash -s -- --project

# Remove both
curl -fsSL https://raw.githubusercontent.com/MARYCOMPLEX/ai-skills/main/uninstall.sh | bash -s -- --all
```

## Usage

Once installed, restart or reload your Claude Code session, then use the skill:

### Initialize project memory

```
/project-memory 初始化当前项目的 AI 项目记忆。我的目标是学习和使用这个开源软件，不要大规模改源码。
```

This creates `CLAUDE.md` and `docs/ai/` with structured memory files.

### Resume from project memory

```
/project-memory 恢复当前项目上下文。先阅读 CLAUDE.md 和 docs/ai/ 下的项目记忆文档，然后总结当前项目状态。
```

### Update session memory

```
/project-memory 更新本次会话记忆，把已经确认的内容、运行过的命令、遇到的问题、解决方法、未确认事项和下次建议写入 docs/ai/05-session-log.md。
```

## Output Structure

Initializing project memory creates:

```
CLAUDE.md                          # Entry file for future AI agents
docs/ai/
├── 00-project-index.md            # Project overview and navigation
├── 01-usage-runbook.md            # How to install, run, and use
├── 02-code-map.md                 # Codebase architecture and entry points
├── 03-learning-notes.md           # Concepts, glossary, learning path
├── 04-faq-and-errors.md           # Debugging knowledge base
└── 05-session-log.md              # Chronological session history
```

## Repository Structure

```
ai-skills/
├── README.md
├── install.sh                     # One-command installer
├── uninstall.sh                   # Clean removal
├── .gitignore
└── skills/
    └── project-memory/
        └── SKILL.md               # The skill definition
```

## Personal vs Project Skills

| Location | Scope | Use Case |
|----------|-------|----------|
| `~/.claude/skills/` | All projects | Skills you want everywhere |
| `./.claude/skills/` | Current project only | Project-specific skills |

The installer supports both. Choose global if you want `project-memory` available in every project; choose project-local if you only need it for one.

## FAQ

### How do I know it's installed?

After installation, check that the file exists:

```bash
cat ~/.claude/skills/project-memory/SKILL.md | head -5
```

You should see the skill frontmatter with `description:`.

### Why isn't the skill showing up?

Skills are loaded when Claude Code starts. Restart your Claude Code session or open a new terminal window.

### Does this modify my project source code?

No. The skill only creates `CLAUDE.md` and `docs/ai/` markdown files. It never touches your source code unless you explicitly ask it to.

### Can I use this with any project?

Yes. The skill is language-agnostic and framework-agnostic. It works with any codebase.

## Important Notes

- After installing, **restart Claude Code** or reload your session for the skill to be detected
- Shell scripts are compatible with **macOS, Linux, and Git Bash/WSL on Windows**
- No dependencies required — the skill is pure Markdown
- The GitHub username in URLs is `MARYCOMPLEX` — fork and replace if you want your own copy
