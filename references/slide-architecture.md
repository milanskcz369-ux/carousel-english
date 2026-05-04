# Slide Architecture — 7-Slide AND 10-Slide Structures + Reusable HTML Components

Complete reference for the structural skeleton of every carousel. Supports two arc lengths (7 and 10 slides), three aspect ratios (1:1, 4:5 std, 4:5 long), and three slide template archetypes (Hook / Value / CTA).

**Sources synthesized:**
- IconicTechs project instructions (10/10) — verbatim 7-slide sequence
- Open Carrusel system prompt — narrative arc rules
- LeadGenJay 5-phase framework — phase-to-slide mapping
- Chris AI Studio — slide energy curve
- @design.deb framework — 10-slide arc, safe zones, slide template archetypes, "confirm on slide 2"

---

## 0. Aspect ratios + safe zones (NEW from design.deb)

| Aspect | Pixel size | When to use | Preview viewport (CSS) |
|---|---|---|---|
| 1:1 | 1080×1080 | Feed-uniform, classic | 420×420 |
| **4:5 (default)** | **1080×1350** | **More screen real estate, +23% engagement vs 1:1** | **420×525** |
| 4:5 long | 1080×1440 | Most premium, max scroll-time, denser visual content | 420×560 |

**Safe zones** (per design.deb framework — content stays inside these for Instagram UI overlap protection):

| Edge | Safe distance |
|---|---|
| Top | **180px** (large — Instagram action bar covers top) |
| Bottom | **180px** (large — caption + reactions overlay) |
| Left | **50px** (small — minimal clipping) |
| Right | **120px** (medium — swipe arrow + reaction icons) |

The CSS rule: critical content (headline, CTA, key visuals) **never** within 180px of top/bottom or 120px of right edge.

```css
/* Safe-zone padding for the slide content area */
.slide-content {
  padding: 180px 120px 180px 50px; /* top right bottom left */
}
```

For 4:5 (1080×1350), the **safe content area = 1080×990 within the canvas**. Plan layouts in this zone, NOT the full canvas.

---

## 1. The Standard 7-Slide Sequence (compressed/premium)

Maps to the 4-stage viral framework: **HOOK → CONTEXT → VALUE → ACTION**.

| # | Type | Background | 4-stage | Word budget | Visual element |
|---|---|---|---|---|---|
| 1 | Hero | LIGHT_BG | **HOOK** | 8 words max | Logo lockup, optional watermark |
| 2 | Confirm | DARK_BG | **CONTEXT** *(receipt + push, NOT problem)* | 14 words | Audience-language quote pull or specific receipt number |
| 3 | Solution | Brand gradient | **VALUE** | 14 words | Quote/prompt box, optional |
| 4 | Features | LIGHT_BG | **VALUE** | 14 words/row × 3-5 | Icon-led feature list |
| 5 | Details | DARK_BG | **VALUE** | 14 words | Tag pills, sub-features |
| 6 | How-to | LIGHT_BG | **VALUE** | 14 words/step × 3-5 | Numbered steps |
| 7 | CTA | Brand gradient | **ACTION** | 14 words | CTA button, full progress bar |

## 2. The 10-Slide Sequence (design.deb max-engagement framework)

| # | Type | 4-stage | Purpose |
|---|---|---|---|
| 1 | Hook | **HOOK** | Stop the scroll |
| 2 | Confirm | **CONTEXT** | Receipt + push ("I've spent N years…") |
| 3 | Build interest | **CONTEXT** | Why this matters / story example |
| 4 | Retain (diagram) | **VALUE** | Diagram / framework intro |
| 5 | Retain (diagram) | **VALUE** | Diagram continuation |
| 6 | Practical | **VALUE** | Step / tip 1 |
| 7 | Practical | **VALUE** | Step / tip 2 |
| 8 | Practical | **VALUE** | Step / tip 3 |
| 9 | Practical | **VALUE** | Recap or bonus |
| 10 | CTA | **ACTION** | Single simple action |

**Rules** (apply to both 7 and 10):
- Hook MUST stop the scroll
- **Slide 2 is CONFIRM, not problem** — research-backed: skipping confirm loses 30-40% swipe-through
- CTA on brand gradient — no swipe arrow, progress bar at 100%
- Alternate LIGHT and DARK backgrounds for visual rhythm
- Critical content inside safe zones (Section 0)

## 3. Narrative arcs by structure (4 archetypes)

The structure picked at Step 0 (`references/viral-framework.md` Section B) overrides the generic arc. Each maps to the 10-slide framework:

### Pure Info
```
1 Hook → 2 Context → 3-6 Value (key points) → 7 Recap → 8-9 Climax → 10 CTA
```

### Storytelling
```
1 Hook → 2 Setup → 3-4 Journey → 5-7 Turning point → 8-9 Lesson → 10 CTA
```

### Problem-Solution
```
1 Hook → 2 The Problem → 3-4 Why It Happens → 5-7 The Solution → 8-9 Outcome → 10 CTA
```

### Listicle
```
1 Hook → 2 Context → 3-8 The List (one item per slide) → 9 Bonus/Recap → 10 CTA
```

For 7-slide compression of any structure: collapse 3-4 + 5-7 into 3-5, keep 1-2 + 9-10 verbatim.

## 3.5. Vault Carousel Framework (Grow With Alex) — Tension/Payoff arc

A 5th structure variant, NEW source: Grow With Alex "The Carousel Framework" PDF. **The differentiator: TENSION before PAYOFF — always.** The carousel earns the insight, never gives it away early.

| # | Role | Purpose | Visual energy | Treatment |
|---|---|---|---|---|
| 1 | **HOOK** | Stop the scroll. Provoke curiosity or tension. Must work standalone. | **HIGH** | Dramatic image, bold headline |
| 2 | **CONTEXT** | Frame the problem. Why this matters right now. | **LOW** | Clean, text-only, breathing room |
| 3 | **BUILD** | Core insight #1. One idea only. Build momentum. | **MEDIUM** | Warm, textural, alternate dark/light |
| 4 | **BUILD** | Core insight #2. One idea only. Keep building. | **MEDIUM** | Alternate from slide 3 |
| 5 | **TENSION** | The reframe. Challenge the assumption. Create the aha. | **HIGH** | Conceptual, abstract, unexpected |
| 6 | **PAYOFF** | The key takeaway. Deliver the resolution they came for. | **MEDIUM** | Clean, resolved, open |
| 7 | **CTA** | Earn the follow. Give them a reason to stay. | **LOW** | Solid brand bg, accent headline |

### Visual energy curve (NEW concept)

The Vault framework enforces a specific **energy curve across the 7 slides**:

```
Energy: HIGH → LOW → MED → MED → HIGH → MED → LOW
        Hook  Ctx   B1    B2   Ten    Pay   CTA
```

This rhythm is what makes the carousel feel like a story, not a slideshow. Match the visual treatment to the energy stage:
- **HIGH energy slides:** dramatic imagery, bold typography, high contrast
- **LOW energy slides:** clean text-only, breathing room, restraint
- **MEDIUM energy slides:** warm/textural treatment, alternating dark/light backgrounds for rhythm

### The 4 hard rules from Vault framework (NON-NEGOTIABLE)

1. **Tension before payoff. Always.** The carousel earns the insight. Never give it away early.
2. **Slide 1 is judged alone.** Must provoke enough curiosity to justify a swipe — Instagram Explore shows just slide 1 sometimes.
3. **Headlines: 6 words maximum.** (Stricter than the IconicTechs 8-word rule. Use 6 when possible, allow up to 8 only if absolutely needed.)
4. **Body text: 3 lines maximum per slide.** Plain language, no jargon (audience includes non-native English speakers).

### Visual storytelling rule (Vault)

If you use generated images on slides, **match visual energy to narrative energy**:

| Slide | Visual treatment |
|---|---|
| Hook | Most dramatic, high-contrast image. Stops scroll before anyone reads. |
| Context | NO image or very subtle. Clean breathing room makes the hook hit harder by contrast. |
| Build (3-4) | Warm, textural images. Close-ups, detail shots. Visual momentum pulling deeper. |
| Tension | Most conceptual or striking image. Should feel **different** from everything before it. |
| Payoff | Clean, resolved, open. Clarity after tension. |
| CTA | NO image. Solid brand background. Visual shift signals "this is the ask." |

This is the **inverse of the design.deb pattern** that uses imagery on most slides. Vault uses imagery **strategically** at HIGH-energy moments only (slides 1 and 5).

---

## 4. The 3 slide template archetypes

Every slide in any structure falls into one of 3 archetypes — apply the matching rule:

### Hook Slide (slide 1, sometimes slide 2)
- Display font: **64-96px**, weight 700+
- Max 8 words
- Single line OR 2-line break
- Light background usually (scroll-stop)
- Logo lockup top-left
- Confirm hook on slide 2 (receipt + push)

### Value Slide (slides 3 to N-1)
- Heading 28-34px, weight 600
- Max 14 words copy total
- ONE visual element max (diagram OR list OR quote-pull — never 2)
- Light/dark alternation
- "Little text + lots of visuals" rule (design.deb)

### CTA Slide (last slide always)
- Personal photo or logo prominent
- 1 SIMPLE action ("Save", "DM keyword", "Tag a friend") — NEVER 2+
- Display font 40-54px, weight 700
- NO swipe arrow
- Progress bar at 100%
- Brand gradient background

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
