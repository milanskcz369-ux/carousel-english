# Visual Teardown — Reference DNA extraction step (Step 6.5a)

The "visual teardown" is the **first thing Claude must do** when a reference image is supplied, BEFORE drafting any slide concept or JSON prompt. Skipping it produces generic carousels that don't actually inherit the reference's design DNA.

**Source:** Grow With Alex "ChatGPT Image 2 + Claude. Social Media CHEAT CODE." workflow (May 2026) — `references/sources/grow-with-alex-chatgpt-image-2-transcript.md` lines 274-294.

---

## A. When to run it

Visual teardown runs:
- ✅ **Every time** the user uploads a reference image (Pinterest pin, IG screenshot, brand site grab, etc.)
- ✅ Before Step 6.5 moodboard intake JSON-prompt generation
- ✅ Before the slide-by-slide concept design
- ⏭ SKIP only when: brand context is already locked in `brand-profile.json` AND user is regenerating an existing carousel

The teardown is **for Claude to internalize the visual language** — it then feeds the design DNA into every subsequent JSON prompt for consistency across slides.

---

## B. The 8 dimensions to extract

For every reference image, Claude must extract these 8 visual properties as a structured teardown block (paste this as Claude's first response after image upload):

| # | Dimension | What to extract | Example |
|---|---|---|---|
| **1** | **Frame / Format** | Portrait vs landscape, aspect ratio, edge treatment | "portrait 4:5, bleed-to-edge, no internal border" |
| **2** | **Color palette** | Dominant + accent + text colors, hex if derivable | "deep navy `#0a1628` canvas, sky-blue `#4d8fff` accent, white text" |
| **3** | **Typography system** | Display font family + body font family + scale + weight | "display: condensed sans Anton-style 140-180px, weight 400; body: clean sans 14-16px, weight 400-700" |
| **4** | **Hierarchy / Composition** | Where the eye lands, anchor point, grid system | "left-aligned, headline anchored bottom-left third, image hero upper-right" |
| **5** | **Image treatment** | Photo vs illustration, lighting, grain, color grade | "low-key cinematic photo, single rim light, fine film grain, amber-on-black grade" |
| **6** | **Decorative elements** | Lines, dots, arrows, chevrons, badges, frames | "3-chevron swipe indicator bottom-right, small 26px circle swipe arrow inline with headline" |
| **7** | **Brand chrome** | Logo placement, handle, tags, slide counter style | "tag top-left in mono-uppercase letter-spacing 2px, handle bottom-left in regular weight, slide counter '01' in accent color before tag" |
| **8** | **Mood / Energy** | Atmosphere word + energy level | "intense, monumental, dormant power, atmosphere-led not subject-led" |

---

## C. The output schema (Claude paste-template)

After image upload, Claude responds with this block FIRST, then asks for the user's topic/subject before continuing:

```
## Visual Teardown — Reference DNA

**Frame:** [aspect ratio + edge treatment]
**Palette:** [dominant + accent + text, hex where derivable]
**Typography:** [display family + body family + scale + weight]
**Hierarchy:** [eye path + anchor + grid notes]
**Image treatment:** [photo/illustration + lighting + grain + grade]
**Decoration:** [lines / dots / arrows / chevrons / badges]
**Brand chrome:** [logo / handle / tags / counter style]
**Mood:** [atmosphere word + energy descriptor]

**Design DNA name (1-2 words):** [e.g., "Garuda Empire" / "Editorial Premium" / "Brutalist Mono"]

Ready for Step 2 — share your topic / subject in one sentence and I'll draft the carousel concept.
```

The **Design DNA name** is critical — it becomes the shorthand reference for every subsequent JSON prompt's `quality.reference_standard` field, keeping all slides locked to the same visual language.

---

## D. Examples (verbatim teardowns from real carousels)

### Example 1 — @design.deb "LEARN DESIGN" eagle reference (Garuda Empire system)

```
**Frame:** portrait 4:5, full-bleed, no border
**Palette:** pure black `#000000` canvas, amber `#FFB800` accent, white `#FFFFFF` + metallic gradient (white → #888) on supporting type
**Typography:** display: Anton-style condensed 140-180px weight 400; sub: Outfit 800 56-80px; body: Outfit 400 14-16px; tag: DM Mono 500 uppercase 10-11px letter-spacing 2px
**Hierarchy:** eye lands on amber power-word mid-frame, supporting text wraps below in metallic gradient, image hero fills upper 60-70%
**Image treatment:** hyperrealistic close-up photography, low-key cinematic lighting, single amber rim light, fine film grain, deep blacks
**Decoration:** 3-chevron swipe indicator bottom-right (opacity gradient 0.55 → 0.78 → 1.0), inline 26px circle swipe arrow next to setup line, 7-dot progress indicator bottom-center
**Brand chrome:** tag top-left ("01 / BALI WORKFLOW"), handle bottom-left ("@bernathroland"), progress dots bottom-center, swipe arrows bottom-right
**Mood:** intense, monumental, dormant power, single-subject focus

**Design DNA name:** Garuda Empire
```

### Example 2 — Stripe-style minimal financial premium

```
**Frame:** portrait 4:5, generous outer padding (~60px), subtle hairline border
**Palette:** off-white `#fafaf7` canvas, charcoal `#1a1a1a` text, single muted blue `#5b6e9b` accent
**Typography:** display: light serif (Inter Display or Söhne 300) 48-64px; body: light sans 14px line-height 1.6; no condensed type
**Hierarchy:** centered hero, generous negative space top + bottom, body text 60% width centered
**Image treatment:** product photography on seamless white, soft diffused lighting, slightly desaturated, no grain
**Decoration:** thin horizontal hairline dividers (1px charcoal at 12% opacity), no chevrons
**Brand chrome:** logomark top-center, tag none, slide counter bottom-center in subtle mono 9px
**Mood:** calm, financial-grade, restraint, "boring is the point"

**Design DNA name:** Stripe Light
```

### Example 3 — Brutalist editorial print

```
**Frame:** portrait 4:5, 0px outer padding (full-bleed grid)
**Palette:** newsprint cream `#f1ece2` canvas, ink black `#0d0d0d`, single magenta hit `#ff2655` for accent
**Typography:** display: Druk Wide / Editorial Old 96px weight 900; body: Söhne Mono 12px; serif for callouts; sentence-mixing weights for emphasis
**Hierarchy:** brutalist asymmetric — headline takes 60% width on left, image bleeds right edge, body text creeps into corners
**Image treatment:** halftoned screen-print effect, 30% noise, posterized to 6 colors
**Decoration:** thick 4px ink rules, sentence numbering ("§01 ¶02") in mono, marginalia
**Brand chrome:** masthead bar top with logo + issue number + date, handle bottom-right in mono, no tags
**Mood:** raw, intentional, broadsheet, anti-corporate

**Design DNA name:** Brutalist Print
```

---

## E. Why this step is non-negotiable

Without visual teardown, Claude defaults to:
- Generic "modern minimal" suggestion (the training-data center)
- Loose interpretation of "what I think you meant"
- JSON prompts that don't match the reference's actual DNA
- Slide-to-slide consistency drift (slide 1 has Anton, slide 5 has Inter)

The teardown **locks the DNA in writing** so every subsequent JSON prompt explicitly inherits it via the `quality.reference_standard` and `composition.ui_elements` fields. Claude reads its own teardown back to itself when generating each prompt.

---

## F. Pairing with json-prompt-generator companion skill

When invoking `json-prompt-generator` (Section C.0 of `moodboard-workflow.md`), prepend the teardown as context:

```
Reference DNA (do not deviate):
[paste the 8-dimension block from Section C above]

Carousel: [topic]
Slide N role: [hero atmosphere | analogy | decorative]
Mood: [one-sentence mood from B-Q2]
Negative space: [zone from B-Q4]
Aspect: 4:5 (1080×1350) [or other from multi-format-pack.md]
Brand accent hex: [BRAND_PRIMARY]
Avoid: text inside the image, AI-stock-photo people, generic faces, logos.

Generate ONE JSON prompt for [gpt-image-2 / nano-banana-2].
```

The companion's `quality.reference_standard` field then cites the Design DNA name explicitly (e.g., `"reference_standard": "Garuda Empire system — see visual-teardown block"`).

---

## G. Sources

- Grow With Alex "ChatGPT Image 2 + Claude. Social Media CHEAT CODE." (YouTube, 2026-05) — `references/sources/grow-with-alex-chatgpt-image-2-transcript.md` lines 274-294 (visual teardown step), lines 282-285 ("portrait frames, etc., carousel concept, it will start then designing")
- @design.deb visual reference catalog — `references/assets/` folder
- The Bali Workflow / Garuda Empire test carousel — `~/Marketinges/CONTENT ROLAND 2026/CONTENT STRATEGY/08_PRODUCED_CONTENT/carousels-en/2026-05_bali-workflow-garuda-empire/README.md`
