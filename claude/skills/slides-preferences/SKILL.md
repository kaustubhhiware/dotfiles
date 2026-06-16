---
name: slides-preferences
description: Kaustubh Hiware's personal slide preferences and recurring patterns. Load alongside frontend-slides when building or modifying presentations. Covers identity, component patterns, file conventions, image rules, and decorative vocabulary not defined in frontend-slides.
---

# Slides Preferences

This skill is an addendum to [`frontend-slides`](https://github.com/zarazhangrui/frontend-slides). It does not replace it — load both. These rules override or extend `frontend-slides` defaults wherever they conflict.

---

## File Organization

- `index.html` — markup only, no inline CSS or JS blocks
- `styles.css` — all styles (never `talk.css` or any other name)
- `main.js` — all JavaScript (or inline at bottom of HTML if trivial)
- `./images/` — all images (never `./assets/` or `./img/`)
- Favicon required on every deck.
- Google Analytics tag (`G-XXX`) required on all publicly hosted decks — place in `<head>`.

---

## Slide Footer (Every Slide)

Every slide has two footer elements on the same baseline — same font, size, weight, color, and vertical position:

```html
<div class="slide-event">JSConf · 2026.06.15</div>
<div class="slide-number">01</div>
```

```css
.slide-event, .slide-number {
    position: absolute;
    bottom: 52px;
    font-weight: 300;
    font-size: 20px;
    letter-spacing: 0.1em;
    color: var(--chalk-faint); /* or --ink-faint */
}
.slide-event  { left: 76px; }
.slide-number { right: 76px; }
```

- Slide number format: **zero-padded two digits** — `01`, `02`, `03`. Never `1/12` or `1 of 12`.
- Event name format: matches the identity block — `Event Name · YYYY.MM.DD`.

---

## Identity Block (Title & Closing Slides)

Every deck's title slide must show:
- **Speaker name**: `Kaustubh Hiware` — displayed alone, no job title, no role label, no "Conference Talk" eyebrow.
- **Event footer**: `Event Name · YYYY.MM.DD` (middle dot separator, date as `2026.06.15`).

```html
<p class="title-meta">
  <span>Kaustubh Hiware</span>
  <span class="meta-dot">·</span>
  <span>JSConf · 2026.06.15</span>
</p>
```

---

## Last Slide = Title Reprise

The last slide is a structural mirror of the first:
- Same layout class (`layout-title` / `layout-closing`)
- Same decorative circles (`deco-circles`)
- Same name + event/date footer above the restart button
- Plus: `↩ Restart` button (bottom-center) and `All slides` link (bottom-right)

Do not design a different closing slide. If in doubt: copy the title slide structure, add restart + all-slides.

---

## Restart Button

On the **last slide only**. Bottom-center of stage.

```html
<button class="restart-btn reveal" onclick="deck.show(0)">↩ Restart</button>
```

```css
.restart-btn {
    position: absolute;
    bottom: 90px;
    left: 50%;
    transform: translateX(-50%);
    background: transparent;
    border: 2px solid var(--accent);
    border-radius: 999px;
    padding: 18px 56px;
    color: var(--accent);
    font-size: 22px;
    font-weight: 600;
    letter-spacing: 0.15em;
    text-transform: uppercase;
    cursor: pointer;
    animation: restart-pulse 2s ease-out infinite;
}

.restart-btn:hover {
    background: var(--accent);
    color: var(--bg);
    animation: none;
}

@keyframes restart-pulse {
    0%   { box-shadow: 0 0 0 0 rgba(var(--accent-rgb), 0.55); }
    70%  { box-shadow: 0 0 0 28px rgba(var(--accent-rgb), 0); }
    100% { box-shadow: 0 0 0 0 rgba(var(--accent-rgb), 0); }
}
```

The pulse animation is non-negotiable — it exists because it makes the button obvious to the presenter without being distracting to the audience.

---

## All Slides Button

On the **first and last slide** of every deck.

```html
<a href="../index.html" class="all-slides-btn">All slides</a>
```

```css
.all-slides-btn {
    position: absolute;
    bottom: 120px;
    right: 76px;
    border: 1.5px solid rgba(var(--accent-rgb), 0.4);
    border-radius: 999px;
    padding: 14px 40px;
    font-size: 18px;
    font-weight: 600;
    letter-spacing: 0.12em;
    text-transform: uppercase;
    color: var(--accent);
    text-decoration: none;
}

.all-slides-btn:hover {
    background: var(--accent);
    color: var(--bg);
    border-color: var(--accent);
}
```

---

## Section Labels (Arc-Labels)

Present on almost every non-title slide. Acts as a section breadcrumb above the slide title.

```html
<div class="arc-label reveal d1">
  <span class="arc-label-text">Section Name</span>
  <span class="section-line"></span>
</div>
```

- `section-line` (60px wide, 1px high horizontal rule in accent color) must only appear **immediately after** `arc-label-text`. Remove any orphaned `section-line` spans.
- When a section spans multiple slides, number the label: `"Presenting Data · 1/4"`, `"Presenting Data · 2/4"`.
- Style: weight 600, `27px`, `letter-spacing: 0.22em`, uppercase, accent color.

---

## Decorative Vocabulary

These elements belong in specific locations. Do not scatter them across content slides.

### Concentric circles (`.deco-circles`)

**Title slide and closing slide only.** Positioned off the right edge.

```html
<div class="deco-circles">
  <div class="deco-circle c1"></div>  <!-- 520×520, faint border only -->
  <div class="deco-circle c2"></div>  <!-- 340×340, dim border only -->
  <div class="deco-circle c3"></div>  <!-- 110×110, filled at ~8% opacity -->
</div>
```

### Ghost background number (`.arc-bg-number`)

Large decorative number on arc/sequential slides. Right-side, vertically centered, behind content.

```css
.arc-bg-number {
    position: absolute;
    right: 80px;
    top: 50%;
    transform: translateY(-50%);
    font-size: 380px;
    font-weight: 900;
    opacity: 0.04;
    color: var(--accent);
    line-height: 1;
    pointer-events: none;
    user-select: none;
}
```

### Left accent bar

`6px` wide, full-height, left edge, accent color gradient, `z-index: 2`. Present on all content slides.

### Brand mark on title slide

```html
<div class="title-bracket-deco">&lt; 🎤 &gt;</div>
```

Style: `132px` display serif, accent color, `opacity: 0.75`. This is the deck's visual signature — keep it.

### Atmospheric layers

Both dark and light themes require:
1. A `<canvas class="matrix-canvas">` rendered behind all slides at `opacity: 0.07–0.09` — creates animated ambient texture.
2. A `slide::before` pseudo-element with a repeating CSS grid pattern at `~3% opacity` — creates subconscious depth.

These are nearly invisible at normal viewing distance. Do not remove them to simplify code.

---

## Navigation — Additional Requirements

Beyond `frontend-slides` defaults, every deck needs:

- **URL hash persistence**: `history.pushState` on every slide change (`#1`, `#2`, …). `popstate` listener for browser back/forward. Hash read on init so deep-links work.
- **Progress bar**: `3px` fixed bar at the bottom of the **viewport** (outside the 1920×1080 stage). Fills as slides advance. `transition: width 0.4s var(--ease-expo)`. Accent color at `opacity: 0.55`.

```css
.progress-bar {
    position: fixed; bottom: 0; left: 0;
    height: 3px;
    background: var(--accent);
    transition: width 0.4s var(--ease-expo);
    z-index: 2000;
    opacity: 0.55;
}
```

---

## Outline / Section Divider Slides

For talks with distinct sections, the same outline slide repeats at every section transition — full list, one item `.active` at a time:

```html
<ol class="outline-list">
  <li class="outline-item active reveal d2">
    <span class="outline-num">01</span>Types of Public Speaking
  </li>
  <li class="outline-item reveal d3">
    <span class="outline-num">02</span>Structure
  </li>
  …
</ol>
```

Inactive items use `var(--ink-faint)`. Active item uses full `var(--ink)`. A `.ghost-num` element (400px serif, `rgba(accent, 0.06)`) shows the current section index in the background.

---

## Typography Constraints

- **Handwriting accent font**: use `Kalam`. `Caveat` is rejected — do not suggest or use it.
- **Minimum body weight**: 300. Do not go below — ultra-light weights bleed on projectors.
- When in doubt between 300 and 400 body weight, prefer 400.
- Display type always uses the deck's serif face at weight 700–900.
- Body / supporting text always uses the deck's sans-serif at weight 300.
- Labels and tags: `text-transform: uppercase`, `letter-spacing: 0.18–0.22em`.
- `<em>` inside headings maps to accent color in addition to italic.

---

## Image Handling

- **Never crop**. Use `object-fit: contain`, not `cover`, unless the user explicitly asks for a full-bleed photo slide.
- Fit images to their horizontal container at full width. Reduce height, not width.
- **No gray caption boxes**. Captions are plain text below the image, same background as the slide.
- **Preload images** in `<head>`:
  ```html
  <link rel="preload" as="image" href="./images/photo.jpg">
  ```
- Convert large PNG images to JPEG for performance. Keep QR codes and logos as PNG.
- Do not add `reveal` animation classes to images — they interfere with preloading.

---

## CSS Conventions

- **CSS variables for everything** — colors, fonts, spacing, radii at `:root`. No magic values inline.
- **No inline styles** on HTML elements.
- Audit for dead CSS and duplicate rule blocks after any major edit.
- `var(--ease-expo)` is `cubic-bezier(0.16, 1, 0.3, 1)` — define it at `:root`.

---

## Color Philosophy

Colors are context-driven, not aesthetic defaults. When choosing a color scheme for a new deck, ask about real-world context: outfit, venue lighting, event brand, audience. A new context may warrant a new palette entirely.

---

## Markdown Conversion

When the user provides a markdown file to convert into slides:

- **Never rewrite the user's words.** Use the exact sentences, phrases, and wording from the source file — verbatim. Do not paraphrase, condense, or "improve" the copy.
- It is fine to generate `arc-label-text` (section breadcrumbs) since those are navigation chrome, not content.
- Slide splits are defined by `---` in the markdown. Each `---` = one slide boundary. Do not merge, re-split, or second-guess the user's slide breaks.
- Choosing the layout template for each slide is yours to decide — the words inside are not.
