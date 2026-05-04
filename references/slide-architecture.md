# Slide Architecture — 7-Slide Structure & Reusable HTML Components

Complete reference for the structural skeleton of every carousel.

**Sources synthesized:**
- IconicTechs project instructions (10/10) — verbatim sequence
- Open Carrusel system prompt — narrative arc rules
- LeadGenJay 5-phase framework — phase-to-slide mapping
- Chris AI Studio — slide energy curve

---

## 1. The Standard 7-Slide Sequence

| # | Type | Background | Purpose | Word budget | Visual element |
|---|---|---|---|---|---|
| 1 | Hero | LIGHT_BG | **Hook** — bold statement | 8 words max | Logo lockup, optional watermark |
| 2 | Problem | DARK_BG | Pain point articulated | 14 words | Strikethrough pills (old tool) |
| 3 | Solution | Brand gradient | The answer | 14 words | Quote/prompt box, optional |
| 4 | Features | LIGHT_BG | What you get | 14 words/row × 3-5 rows | Icon-led feature list |
| 5 | Details | DARK_BG | Depth, specs, differentiators | 14 words | Tag pills, sub-features |
| 6 | How-to | LIGHT_BG | Numbered workflow | 14 words/step × 3-5 steps | Numbered steps with descriptions |
| 7 | CTA | Brand gradient | Action — no swipe arrow | 14 words | CTA button, full progress bar |

**Rules:**
- Hook MUST stop the scroll
- CTA on brand gradient — no swipe arrow, progress bar at 100%
- Alternate LIGHT and DARK backgrounds for visual rhythm
- Adapt the sequence to the topic — but don't break the hook→problem→payoff arc

---

## 2. The 5-Phase Framework Mapping (LeadGenJay)

Map the 5 cognitive phases of viral carousels to the 7 slides:

| Phase | Goal | Slides | What to write |
|---|---|---|---|
| **HOOK** | Stop scroll | 1 | Question / stat / bold statement |
| **BUILD INTEREST** | Hold attention through slide 3 | 2-3 | Problem articulated → solution teased |
| **RETAIN ATTENTION** | Keep them swiping past slide 4 | 4-5 | Specific value, not abstract benefits |
| **DELIVER VALUE** | Earn the save | 6 | Actionable steps they can implement today |
| **CTA** | Convert | 7 | One clear action — no menu of options |

**LeadGenJay enforcement rule (verbatim):**
> "If a draft doesn't follow this structure, rewrite it before generating."

---

## 3. Alternative Slide Counts

### 5-slide carousel (minimum, snackable)
1. Hook | LIGHT_BG
2. Problem + Solution combo | DARK_BG
3. 3-feature listicle | LIGHT_BG
4. How-to compressed | DARK_BG
5. CTA | Brand gradient

### 8-slide carousel (Open Carrusel default)
1. Hook
2-3. Setup (problem + context)
4-6. Value (one insight per slide)
7. Summary or transformation
8. CTA

### 9-slide carousel (Reddit r/promptingmagic verbatim — high-conversion)
1. Hook (viral, news-event or quote)
2-6. Pure value, one teaching per slide
7. Bust a common myth
8. Social proof / transformation result
9. Soft CTA (comment for free training/link)

### 10-slide carousel (max, only for educational deep-dives)
- Hook (1)
- Setup (2-3)
- Methodology (4-5)
- Steps (6-7)
- Examples (8)
- Summary (9)
- CTA (10)

---

## 4. Reusable HTML Components

### 4.1 Slide wrapper (container for every slide)

```html
<div class="slide" data-slide-index="0" style="
  position: relative;
  width: 420px;
  height: 525px;
  background: var(--LIGHT_BG);
  font-family: 'DM Sans', sans-serif;
  overflow: hidden;
">
  <div class="slide-content" style="
    padding: 0 36px 52px;
    height: 100%;
    display: flex;
    flex-direction: column;
    justify-content: flex-end;
  ">
    <!-- slide-specific content here -->
  </div>
  <!-- progress bar (always) -->
  <!-- swipe arrow (every slide except last) -->
</div>
```

### 4.2 Progress bar (every slide)

```html
<div style="
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  padding: 16px 28px 20px;
  display: flex;
  align-items: center;
  gap: 12px;
">
  <div style="
    flex: 1;
    height: 3px;
    background: rgba(0,0,0,0.08);
    border-radius: 2px;
    overflow: hidden;
  ">
    <div style="
      height: 100%;
      width: 14.28%;  /* (slideIndex + 1) / totalSlides * 100 */
      background: var(--BRAND_PRIMARY);
      border-radius: 2px;
    "></div>
  </div>
  <span style="
    font-size: 11px;
    font-weight: 500;
    color: rgba(0,0,0,0.3);
  ">1/7</span>
</div>
```

For dark slides, swap colors:
- Track: `rgba(255,255,255,0.12)`
- Fill: `#fff`
- Counter: `rgba(255,255,255,0.4)`

### 4.3 Swipe arrow (every slide except last)

```html
<div style="
  position: absolute;
  right: 0;
  top: 0;
  bottom: 0;
  width: 48px;
  background: linear-gradient(to right, transparent, rgba(0,0,0,0.06));
  display: flex;
  align-items: center;
  justify-content: flex-end;
  padding-right: 12px;
">
  <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="rgba(0,0,0,0.25)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
    <path d="M9 18l6-6-6-6"/>
  </svg>
</div>
```

For dark slides:
- Background gradient end: `rgba(255,255,255,0.08)`
- Stroke: `rgba(255,255,255,0.35)`

### 4.4 Strikethrough pills (Slide 2 — Problem)

```html
<span style="
  font-size: 11px;
  padding: 5px 12px;
  border: 1px solid rgba(255,255,255,0.1);
  border-radius: 20px;
  color: #6B6560;
  text-decoration: line-through;
">Old tool</span>
```

### 4.5 Tag pills (Slides 4-5 — Features/Details)

```html
<span style="
  font-size: 11px;
  padding: 5px 12px;
  background: rgba(255,255,255,0.06);
  border-radius: 20px;
  color: var(--BRAND_LIGHT);
">Label</span>
```

### 4.6 Prompt / Quote box (Slide 3 — Solution)

```html
<div style="
  padding: 16px;
  background: rgba(0,0,0,0.15);
  border-radius: 12px;
  border: 1px solid rgba(255,255,255,0.08);
">
  <p style="font-size: 13px; color: rgba(255,255,255,0.5);">Label</p>
  <p style="font-size: 15px; color: #fff; font-style: italic;">"Quote text"</p>
</div>
```

### 4.7 Feature list row (Slide 4 — Features)

```html
<div style="
  display: flex;
  align-items: flex-start;
  gap: 14px;
  padding: 10px 0;
  border-bottom: 1px solid var(--LIGHT_BORDER);
">
  <span style="color: var(--BRAND_PRIMARY); font-size: 15px;">{icon}</span>
  <div>
    <span style="font-size: 14px; font-weight: 600;">{Label}</span>
    <span style="font-size: 12px; color: #8A8580;">{Description}</span>
  </div>
</div>
```

### 4.8 Numbered steps (Slide 6 — How-to)

```html
<div style="
  display: flex;
  align-items: flex-start;
  gap: 16px;
  padding: 14px 0;
  border-bottom: 1px solid var(--LIGHT_BORDER);
">
  <span style="
    font-size: 26px;
    font-weight: 300;
    color: var(--BRAND_PRIMARY);
    min-width: 34px;
  ">01</span>
  <div>
    <span style="font-size: 14px; font-weight: 600;">{Step title}</span>
    <span style="font-size: 12px; color: #8A8580;">{Step description}</span>
  </div>
</div>
```

### 4.9 CTA button (Slide 7 — final only)

```html
<div style="
  display: inline-flex;
  align-items: center;
  gap: 8px;
  padding: 12px 28px;
  background: var(--LIGHT_BG);
  color: var(--BRAND_DARK);
  font-weight: 600;
  font-size: 14px;
  border-radius: 28px;
">
  {CTA text}
</div>
```

---

## 5. Hero slide (Slide 1) — Special Layout

The hook slide is the ONLY slide where typography is 64-96px (vs 28-34px elsewhere). Layout is centered, not bottom-aligned:

```html
<div class="slide hero" style="
  position: relative;
  width: 420px;
  height: 525px;
  background: var(--LIGHT_BG);
  font-family: 'Plus Jakarta Sans', sans-serif;
  overflow: hidden;
">
  <div style="
    padding: 0 36px;
    height: 100%;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: flex-start;
  ">
    <!-- logo lockup at top -->
    <div style="position: absolute; top: 36px; left: 36px;">
      <span style="
        font-size: 14px;
        font-weight: 600;
        color: var(--BRAND_DARK);
      ">{BrandName}</span>
    </div>
    <!-- hook text -->
    <h1 style="
      font-family: 'Fraunces', serif;
      font-size: 64px;
      font-weight: 700;
      line-height: 1.05;
      letter-spacing: -1.5px;
      color: var(--BRAND_DARK);
      max-width: 100%;
    ">{Hook text — max 8 words}</h1>
  </div>
  <!-- progress bar 1/7 -->
  <!-- swipe arrow -->
</div>
```

---

## 6. CTA slide (Slide 7) — Special Layout

No swipe arrow. Full progress bar (100%). Brand gradient background. Centered layout.

```html
<div class="slide cta" style="
  position: relative;
  width: 420px;
  height: 525px;
  background: linear-gradient(165deg,
    var(--BRAND_DARK) 0%,
    var(--BRAND_PRIMARY) 50%,
    var(--BRAND_LIGHT) 100%);
  color: #fff;
  font-family: 'Plus Jakarta Sans', sans-serif;
  overflow: hidden;
">
  <div style="
    padding: 0 36px 52px;
    height: 100%;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    text-align: center;
  ">
    <!-- logo -->
    <div style="margin-bottom: 24px;">
      {Logo SVG or initial in circle}
    </div>
    <!-- tagline -->
    <h2 style="
      font-size: 28px;
      font-weight: 700;
      line-height: 1.2;
      margin-bottom: 12px;
    ">{Tagline}</h2>
    <p style="
      font-size: 14px;
      opacity: 0.85;
      margin-bottom: 32px;
    ">{Sub-tagline}</p>
    <!-- CTA button -->
    <div style="
      display: inline-flex;
      align-items: center;
      gap: 8px;
      padding: 12px 28px;
      background: var(--LIGHT_BG);
      color: var(--BRAND_DARK);
      font-weight: 600;
      font-size: 14px;
      border-radius: 28px;
    ">
      {CTA text} →
    </div>
    <!-- handle -->
    <div style="
      position: absolute;
      bottom: 36px;
      font-size: 12px;
      opacity: 0.7;
    ">@{handle}</div>
  </div>
  <!-- progress bar 7/7, NO swipe arrow -->
</div>
```

---

## 7. Carousel Track Wrapper (for preview & export)

```html
<div class="ig-frame" style="
  width: 420px;
  margin: 0 auto;
  background: #fff;
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 4px 20px rgba(0,0,0,0.08);
">
  <!-- IG header (hidden during export) -->
  <div class="ig-header" style="...">@handle</div>

  <!-- carousel viewport -->
  <div class="carousel-viewport" style="
    width: 420px;
    height: 525px;
    overflow: hidden;
    position: relative;
  ">
    <div class="carousel-track" style="
      display: flex;
      transition: transform 0.3s ease;
    ">
      <!-- slide 1 -->
      <!-- slide 2 -->
      <!-- ... -->
      <!-- slide 7 -->
    </div>
  </div>

  <!-- IG dots (hidden during export) -->
  <div class="ig-dots" style="...">• • • • • • •</div>

  <!-- IG actions: heart, comment, share, bookmark (hidden during export) -->
  <div class="ig-actions" style="...">...</div>

  <!-- IG caption (hidden during export) -->
  <div class="ig-caption" style="...">@handle Carousel description...</div>
</div>
```

The `ig-header`, `ig-dots`, `ig-actions`, `ig-caption` elements are hidden via JS during Playwright export (see `references/export-pipeline.md`).

---

## 8. Layout Best Practices

- **Content padding**: `0 36px` standard
- **Bottom-aligned slides** (problem/features/details/how-to): `padding: 0 36px 52px` to clear progress bar
- **Hero/CTA slides**: `justify-content: center`
- **Content-heavy slides**: `justify-content: flex-end` (text at bottom, breathing room above)
- **Critical content** in center 80% of slide (mobile-first thumb-stop, accounts for IG UI overlay)
- **Content NEVER overlaps** progress bar or swipe arrow
