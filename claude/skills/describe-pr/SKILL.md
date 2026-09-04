---
name: describe-pr
description: |
  INVOKE WHEN: User asks to write or update the pull request description for the current branch, or runs /describe-pr.
  COVERS: Reading the repository PR template, filling its what and why fields in Simplified Technical English, adding a collapsible AI review-notes block, and applying the body with gh pr edit.
  DO NOT INVOKE FOR: Opening a new PR, reviewing the code of a PR, replying to review comments, or writing commit messages.
license: MIT
compatibility: claude-code cursor codex gemini-cli opencode
---

# Describe PR

Fill the repository's PR template with a short what and why, add a collapsible
block of review notes for an AI reviewer, and apply the body to the open PR.

## Requirements

| Tool | Need | Source | If it is missing |
|---|---|---|---|
| `gh` | required | GitHub CLI | Stop. Tell the user to install it and run `gh auth login`. |
| `git` | required | baseline | — |
| `simple-english` skill | required | personal skill `~/.claude/skills/simple-english/` | Ask user to install this first: https://github.com/AminBlg/SimpleEnglish. |

## Step 1: Preflight

```bash
command -v gh >/dev/null || echo "gh is missing"
gh auth status
gh pr view --json number,url,title,baseRefName,isDraft,state
```

If the branch has no PR, **stop**. Report it and ask whether to open one. Never
open a PR from this skill.

## Step 2: Find the template

```bash
ls .github/PULL_REQUEST_TEMPLATE.md .github/pull_request_template.md \
   .github/PULL_REQUEST_TEMPLATE/*.md PULL_REQUEST_TEMPLATE.md \
   docs/PULL_REQUEST_TEMPLATE.md 2>/dev/null
```

Read the template. Find the two fields that mean **what** and **why**. The
headings differ per repository:

| What | Why |
|---|---|
| `## WHAT` | `## WHY` |
| `## Description` | `## Motivation` |
| `## Changes` | `## Context` / `## Background` |

Keep the template's exact heading text, level, and order. Keep every other
section (the ticket link, the checklists, `## Refs`).

If there is no template, use `## WHAT` and `## WHY`.

## Step 3: Keep what the user already filled

```bash
gh pr view --json body -q .body
```

Carry over a filled ticket link, a ticked checkbox, and a `Refs` list. Never
blank a field the user filled. Fill an obvious placeholder (`ABC-000`,
`TICKET-123`) from the branch's commits.

If the current body holds real content that maps to no template section, ask
before you overwrite it.

## Step 4: Read the diff the PR contains

Base on the **PR's own base ref**, not on `main`. A stacked PR bases on a parent
branch.

```bash
base=$(gh pr view --json baseRefName -q .baseRefName)
git log --oneline "origin/$base..HEAD"
git diff --stat "origin/$base...HEAD"
git diff "origin/$base...HEAD"
```

If `CLAUDE.md` or `AGENTS.md` asks for a body against `main` or `master` and the
base is a parent branch, describe this PR's own diff, link the parent PR
(`gh pr list --head "$base" --json number,url`), and say you did so in your reply.

## Step 5: Write what and why

**Invoke the `simple-english` skill first**, pragmatic mode. Then write both
fields under that standard.

Rules for these two fields:

- Under one paragraph each. A paragraph is prose, so 2 to 5 sentences.
- No bullet lists, no tables, no sub-headings inside either field.
- **What** states what the diff does. Name the function or the file that carries
  the change.
- **Why** states the reason the change is needed. Do not repeat the what.

## Step 6: Write the review notes

Append this block after the last template section, in this exact shape:

```
<details>
<summary> Review notes for AI </summary>

<WRITE_SUMMARY_HERE>
</details>
```

The one-paragraph limit does **not** apply inside the block. Simplified
Technical English still does. Include:

1. A file-by-file table: path, and what changed in it.
2. The contract of each new or changed function, and each changed signature.
3. Test coverage: the test name and what it holds.
4. What is out of scope, and any open question the reviewer must answer.
5. Order to review files
6. Any points to note for the review

## Step 7: Apply

Write the body to a file, then apply it. Never pass a long body inline.

```bash
gh pr edit <number> --body-file <scratchpad>/pr-<number>-body.md
```

## Step 8: Verify

Check all four, then report the PR URL.

1. `gh pr view --json body -q .body` matches the file you wrote.
2. Every section of the template is present, with its original heading text.
3. What and why are each one paragraph or less, with no list inside.
4. The `<details>` block is present, and the `</details>` tag closes it.

## Worked example

PR #412, base `feature/rate-limiter-core`, template holds `## JIRA Ticket`,
`### Checks`, `## WHAT`, `## WHY`, `## Refs`.

```md
## JIRA Ticket

- [ABC-124](https://example.atlassian.net/browse/ABC-124)

### Checks

* [x] Documentation has been updated (or it is not needed)

## WHAT

The gateway applied one global request limit to every route. `resolveLimit` now
reads the per-route limit from `limits.go` and gives it to `Allow`, and it drops
back to the global limit after a warn log when a route has no entry.
`limits.go` holds an entry for the three write routes only.

## WHY

A single global limit lets one heavy write route use the complete budget and
starve the read routes. A per-route limit keeps the budget of each route
separate. `TestLimits_RouteCoverage` fails when a new write route arrives
without an entry, so the limit stays a deliberate choice.

## Refs

- Parent PR: #409

<details>
<summary> Review notes for AI </summary>

This PR stacks on `feature/rate-limiter-core` (#409). Its diff holds two commits
and 371 insertions over 6 files.

| File | Change |
|---|---|
| `internal/ratelimit/limits.go` | New. `routeLimits` holds three entries, `routeBurst` holds the matching burst sizes. |
| `internal/ratelimit/limiter.go` | New `resolveLimit`. `Allow` takes a `logger` first parameter. |
| `internal/server/handler.go` | Passes `s.logger`. |

`resolveLimit(logger, route string) (limit int, ok bool)` returns the entry in
`routeLimits` for a known route. An unknown route returns `ok == false` after a
warn log, and the caller applies the global limit. No route is ever refused
because of a missing entry.

Tests: `TestResolveLimit` holds 7 cases. `TestLimits_RouteCoverage` fails when a
write route has no entry.

Out of scope: the route key matches byte for byte, so a trailing slash misses
the map. No Datadog counter for a fallback to the global limit.

**Open question for the reviewer:** no one confirmed the three limits against
the current traffic. If a limit is too low, the route refuses valid requests as
soon as this merges.
</details>
```

## Design notes

- Gate 4: step 8 is the verification pass, with four objective checks.
- Gate 5 N/A — single-phase, but it chains to `simple-english` at step 5.
