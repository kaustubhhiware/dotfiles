---
name: atomic-commits
description: |
  INVOKE WHEN: User asks how to split the current branch's changes into atomic commits, or runs /atomic-commits.
  COVERS: Base-branch detection, grouping changed files into commits that build alone, commit wording copied from the branch's own history.
  DO NOT INVOKE FOR: Staging or creating the commits, rewriting history (rebase, squash, amend, fixup), or writing one message for work already staged.
license: MIT
compatibility: claude-code cursor codex gemini-cli opencode
---

# Atomic Commits

Group the changes on this branch into commits where each commit builds and passes
tests alone.

## Read-only contract

Run **read** git commands only: `log`, `diff`, `status`, `show`, `rev-parse`,
`merge-base`, `branch`, `symbolic-ref`.

Never run `add`, `commit`, `rebase`, `reset`, `stash`, `restore`, `checkout`,
`switch`, or `push`. The output is one message. The user stages the commits.

## Step 1: Find the base

```bash
git symbolic-ref --short refs/remotes/origin/HEAD 2>/dev/null | sed 's|^origin/||'
git branch -r --list 'origin/main' 'origin/master'
```

If the repository has an open PR for this branch and `gh` is available, prefer the
PR's base. A stacked PR bases on a parent branch, not on `main`:

```bash
gh pr view --json baseRefName -q .baseRefName 2>/dev/null
```

Say which base you used in the output.

## Step 2: Read the changes

```bash
base=<base-branch>
git log --oneline "$base..HEAD"
git diff --stat "$base...HEAD"
git status --short
git diff "$base...HEAD"
```

Read the diff, not the stat alone. A file name does not tell you whether two files
are coupled.

## Step 3: Copy the commit convention

```bash
git log --oneline -15 "$base..HEAD"   # this branch first
git log --oneline -15 "$base"          # then the base branch
```

Copy the exact format you find (`[TICKET] type: message`, `type(scope): message`,
or plain prose). Take the ticket ID from the branch's own commits. A branch name
can hold a different ticket than the commits do — the commits win.

## Step 4: Group the files

A commit is atomic when it compiles, lints, and passes its tests alone, and when
one sentence states its purpose.

**These couplings force files into the same commit:**

| Coupling | Why |
|---|---|
| A changed or renamed signature | Every call site fails to compile without it |
| A new required struct field or parameter | Every constructor fails to compile |
| A test that asserts new behaviour | The test fails without the code |
| A generated file | It must match its source |
| A migration and its fixture | Tests load both (check `CLAUDE.md` / `AGENTS.md`) |
| A new lint-visible parameter | An unused parameter fails the linter alone |

**These split cleanly:**

- A new file that nothing calls yet, including a pure data or constants file.
- Documentation.
- Independent fixes in unrelated packages.
- A refactor that keeps every signature.

Order the commits so each one builds on the one before it. Put a data or
constants commit before the commit that reads it.

## Step 5: Verify before you answer

Check all four. Fix the grouping if one fails.

1. Every changed file appears in exactly one commit. The total matches
   `git diff --name-only "$base...HEAD"` plus `git status --short`.
2. For each commit, you can name what breaks if you split it further. If you
   cannot name a break, split it.
3. For each commit, you can state its purpose in one sentence. If you need "and",
   split it.
4. Any file that must split across two commits is flagged. That needs
   `git add -p`, which is interactive, so say the cost and offer the cheaper
   whole-file option.

## Step 6: Output format

Output this and nothing else. No preamble.

```md
## Base: <base> — <N> files, <M> commits

### Commit 1 — `<exact commit message>`

- `path/to/file.go`
- `path/to/file_test.go`

Cannot split: <one sentence>

### Commit 2 — `<exact commit message>`

...

## Notes

- <a file that needs `git add -p`, an ordering constraint, or "none">
```

## Worked example

Branch with 6 changed files. `git log` on the branch shows
`[ABC-123] feat: add the token bucket limiter`, so the format is
`[TICKET] type: message`.

The diff shows `Allow` gained a `logger` first parameter, a new `resolveLimit`
function reads two new package-level maps, and a doc page changed.

```md
## Base: main — 6 files, 2 commits

### Commit 1 — `[ABC-123] feat: add the per-route rate limits`

- `internal/ratelimit/limits.go`
- `internal/ratelimit/limits_test.go`

Cannot split: the test reads both maps, so it fails without the data file.

### Commit 2 — `[ABC-123] feat: apply the per-route limit in the limiter`

- `internal/ratelimit/limiter.go`
- `internal/ratelimit/limiter_test.go`
- `internal/server/handler.go`
- `docs/rate-limiting.md`

Cannot split: `Allow` takes a new first parameter, so the two call sites in
`handler.go` and `limiter_test.go` must change with it. A commit that adds the
parameter before `resolveLimit` uses it also fails the `unparam` linter.

## Notes

- The doc page holds one row for commit 1 and one section for commit 2. To split
  it you need `git add -p`, which is interactive. The whole page in commit 2
  costs you one stale table row in commit 1.
```

## Design notes

- Gate 4: step 5 is the verification pass, with four objective checks.
- Gate 5 N/A — single-phase.
