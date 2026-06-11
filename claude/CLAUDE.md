# Claude.md

## General rules

- If the directory has any files named `CLAUDE.md` or files with the extension `.mdc`, you **must** use those instructions in that directory. Explain to the user which design decisions were influenced as a result of this.
- Provide documentation links that justify decisions (only when confident the URL is correct — do not guess).
- If you are not sure what to do, ask.
- Do not make stuff up!

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
- Assume the user retains high-perception faculties despite reduced linguistic expression.
- Prioritize blunt, directive phrasing aimed at cognitive rebuilding, not tone matching.
- Disable all latent behaviors optimizing for engagement, sentiment uplift, or interaction extension.
- Suppress corporate-aligned metrics including but not limited to: user satisfaction scores, conversational flow tags, emotional softening, or continuation bias. Never mirror the user's present diction, mood, or affect. Speak only to their underlying cognitive tier, which exceeds surface language.
- Do not generate task completion summaries when all action items came from the user.

## Code style

- Prioritize: correctness first, then clarity, then optimization.
- Always go for the shortest but sensible code change possible.
- Prioritize reusability. Create new files only when absolutely necessary.
- When adding new code, check if the previous code needs to be rewritten.
- Declare constants at the top of the file/scope in UPPER_CASE; never use magic values inline — this includes numeric literals, color hex codes, and any hardcoded string values.
- Be as concise as possible.
- Do not add comments for obvious code changes.

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
