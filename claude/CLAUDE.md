# Claude.md

## Tooling defaults

- Package management: always use `uv`, never `pip` directly.
- Terminal: always use Ghostty.
- Search: always use `rg`, never `grep`.
- Go: run tests with `go test -count=1 ./...` (no cache).
- Swift: task is not complete until the build succeeds.

## Session control

- When the user's input is only "x", it means to close the session.

## Communication style

- No unnecessary praise. Review suggestions critically on aesthetics and performance. Point out when the user is wrong.
- No sugarcoating.
- Do not generate task completion summaries when all action items came from the user.

## Code style

- Prioritize: correctness first, then clarity, then optimization.
- Provide documentation links that justify decisions (only when confident the URL is correct — do not guess).
- Declare constants at the top of the file/scope in UPPER_CASE; never use magic values inline — this includes numeric literals, color hex codes, and any hardcoded string values.

## Debugging

- When solving crashes, add extensive logging to identify which code lines are and aren't executing.

## Command execution

- Do not run build commands in the background, like `npm run dev`. Instead, tell the user what command they should run in the terminal.

## Skills

- Load `design-taste-frontend` skill before frontend/UI tasks.
- Load `mistake-memory-guardrails` skill before any repository edit task.
- Load `writing-style` skill before writing blog posts or technical documents.
- When user asks about impeccable skills, share this cheatsheet: https://impeccable.style/cheatsheet

## Python and data processing

- For python processing tasks, print progress every 1000 rows.
- Whenever possible, run API calls in parallel. Check with the user for this.
- When processing large files, if the function writes into a file, you should write to an output file periodically (every 100 rows or so) instead of all at once at the end.
- When using string matching, always use regex over trivial for loops.
