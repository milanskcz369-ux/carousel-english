---
name: carousel-english
description: |
  Generate production-ready English Instagram carousels — 7 slides, 4:5 (1080×1350px),
  brand-aware HTML/CSS, anti-AI-slop. Combines IconicTechs project instructions,
  Open Carrusel narrative arc, LeadGenJay 5-phase framework, Chris AI 3-level progression,
  and taste-skill anti-slop rules. Use when user requests an English Instagram carousel,
  LinkedIn document carousel, or "make me carousel slides about X".
argument-hint: "[topic or URL or paste content] [optional: slide-count, default 7]"
metadata:
  author: Sokacz Milan
  version: "1.0.0"
  research-source: instagram-carousel-research/ (~3.5 MB, 135 markdown files)
allowed-tools: Read, Write, Edit, Bash, Glob, WebFetch
---

# Carousel English

Production-grade Instagram carousel generator. Outputs self-contained HTML at exact 1080×1350 dimensions, ready for Playwright screenshot export to PNG.

<args>$ARGUMENTS</args>

## When to Use

Trigger this skill when the user asks for:
- "Make me an Instagram carousel about X"
- "Turn this article/URL/script into a carousel"
- "LinkedIn carousel from this post"
- "Slides for an IG/LinkedIn doc post"
- Any English-language carousel/multi-slide image post

DO NOT trigger for:
- Hungarian carousel requests → use `carousel-hungarian` skill (or fall back here + run output through `stop-slop` + `humanizer`)
- Single-slide banner → use `banner-design`
- Reels/video → use `remotion-ads` or `nano-banana`
- Pitch decks 16:9 → use `slides`

## Pipeline (5 phases default, +1 optional Level 3 upgrade)

```
1. INTAKE          → ask brand details (if not provided), parse topic
2. NARRATIVE       → outline 7 slides via 5-phase framework
3. COPY            → write each slide, max 14 words, banned-words check
3.5 LEVEL DECISION → ask user: Level 1 (HTML only) / 2 (+ brand assets) /
                     3 (+ Nano Banana custom images, ~+10 min)
3.6 MOODBOARD      → IF Level 3: collect Pinterest URLs + mood description,
                     generate JSON image prompts, run Nano Banana, embed
4. HTML            → generate single HTML file (1080×1350)
5. EXPORT          → Playwright Python script → 7 PNG files
```

**Default:** Level 1. **DO NOT auto-skip the Level decision** — always ask user
which level they want before HTML generation. Level 3 adds ~10 min + ~$0.10-0.40
Nano Banana cost but gives custom imagery no one else has.

## Subcommands & References

| Phase | Reference file | When to load |
|---|---|---|
| **Format types** | `references/format-types.md` | Step 0 — pick 1 of 5 formats (Comparison / Tutorial / Native / Compilation / Story) |
| **Viral framework** | `references/viral-framework.md` | Step 0 — 4-stage mental model (HOOK→CONTEXT→VALUE→ACTION) + 4 structures + "confirm on slide 2" + engagement benchmarks |
| **Project setup** | `references/project-instructions.md` | First time setting up a brand, OR if user wants the verbatim Claude Project instructions |
| **Architecture** | `references/slide-architecture.md` | Every carousel — 7-slide AND 10-slide structures + safe zones + reusable HTML components + Save Prompt slide |
| **Hooks** | `references/hook-formulas.md` | Every carousel — 3 archetypes (question/stat/bold) + word constraints + confirm-on-slide-2 + Cover=80% rule |
| **Visual teardown** | `references/visual-teardown.md` | **Step 6.5a — NEW.** When the user uploads a reference image: extract 8-dimension Design DNA BEFORE moodboard intake. Non-negotiable for L3 carousels. |
| **Copy QA** | `references/banned-words.md` | Every carousel — anti-AI-slop pass before HTML generation |
| **Moodboard / Images** | `references/moodboard-workflow.md` | LEVEL 3 — Pinterest moodboard intake → JSON prompt → image gen (gpt-image-2 / Higgsfield / nano-banana) → embed in HTML |
| **Multi-format pack** | `references/multi-format-pack.md` | **Step 9 alternative — NEW.** 1 carousel → 4 aspect ratios (3:4 / 9:16 / 16:9 / 21:9). Use when launching cross-platform or repurposing. |
| **Export** | `references/export-pipeline.md` | Final phase — Playwright Python script (variable aspect support) + common mistakes |
| **Sources** | `references/sources/` | Verbatim transcripts and source docs (Grow With Alex video, @design.deb, etc.) |
| **Scripts** | `scripts/gen-image.sh` + `scripts/gen-image-multi-format.sh` | gpt-image-2 helpers (single + multi-aspect batch) |
| **Templates** | `templates/claude-project-instructions.md` | Paste into a Claude.ai Project to run the skill workflow inside Claude.ai (Grow With Alex flow) |

## Step-by-step Workflow

### Step 0 — Format + Structure + Aspect + Slide count (NEW)

Before brand intake, **ASK THE USER 4 QUICK CHOICES** (combine into a single message — do not interrogate one-by-one):

> "Before I start, 4 quick choices (or describe your topic in 1 sentence and I'll pick all four):
>
> **1. Format** (what kind of content)
>    1. Comparison — two things side-by-side
>    2. Tutorial — step-by-step how-to
>    3. Native — personal photo + story
>    4. Compilation — list / collection
>    5. Story — knowledge share with arc
>
> **2. Structure** (the slide arc skeleton — see `references/viral-framework.md`)
>    1. Pure Info — straight value, no fluff
>    2. Storytelling — journey + lesson
>    3. Problem-Solution — agitate + deliver answer
>    4. Listicle — list-based, save-bait
>
> **3. Aspect ratio**
>    - 1:1 (1080×1080) — feed-uniform
>    - 4:5 (1080×1350) — DEFAULT, more screen real estate
>    - 4:5 long (1080×1440) — most premium / most scroll-time
>
> **4. Slide count**
>    - 7 slides — compressed, premium
>    - 10 slides — design.deb framework, max engagement"

If user describes topic only → auto-pick using rules in `references/format-types.md` (decision tree) and `references/viral-framework.md` Section E.

**Default if user skips entirely:** Tutorial format · Pure Info structure · 4:5 (1080×1350) · 7 slides.

**Apply 4-stage viral framework to ALL choices:**
```
HOOK (slide 1)
  → CONTEXT (slide 2 — confirm hook with receipt)
  → VALUE (slides 3 to N-1 — frameworks/steps/lists)
  → ACTION (last slide — single primary CTA)
```

The "confirm on slide 2" rule is non-negotiable in every format/structure — see `references/viral-framework.md` Section D.

### Step 1 — Intake (skip if brand details already in CLAUDE.md or project context)

If no brand context, ask 7 questions (verbatim from `references/project-instructions.md` Step 1):
1. Brand name (shown on first + last slides)
2. Instagram handle (IG frame header + caption)
3. Primary brand color (hex code, or describe → I pick)
4. Logo (SVG path, brand initial, or skip)
5. Font preference (serif heading + sans body / all sans / specific Google Fonts)
6. Tone (professional / casual / playful / bold / minimal / etc.)
7. Images (profile photo, screenshots, product images)

If user provides URL or brand assets → derive colors and style from those, skip questions.

### Step 2 — Color derivation

From single primary brand color, derive 6 tokens (verbatim rule):
- `BRAND_PRIMARY` = user's color
- `BRAND_LIGHT` = primary lightened ~20%
- `BRAND_DARK` = primary darkened ~30%
- `LIGHT_BG` = warm/cool tinted off-white (NEVER pure #fff)
- `LIGHT_BORDER` = ~1 shade darker than LIGHT_BG
- `DARK_BG` = near-black with brand temperature tint

Brand gradient: `linear-gradient(165deg, BRAND_DARK 0%, BRAND_PRIMARY 50%, BRAND_LIGHT 100%)`

Full derivation rules: see `references/project-instructions.md` Section 2.

### Step 3 — Typography

Pick heading + body font from these 7 pairings (Google Fonts):

| Vibe | Heading | Body |
|---|---|---|
| Editorial / premium | Playfair Display | DM Sans |
| Modern / clean | Plus Jakarta Sans 700 | Plus Jakarta Sans 400 |
| Warm / approachable | Lora | Nunito Sans |
| Technical / sharp | Space Grotesk | Space Grotesk |
| Bold / expressive | Fraunces | Outfit |
| Classic / trustworthy | Libre Baskerville | Work Sans |
| Rounded / friendly | Bricolage Grotesque | Bricolage Grotesque |

Font scale (fixed across brands):
- Headings: 28-34px, weight 600, letter-spacing -0.3 to -0.5px, line-height 1.1-1.15
- Body: 14px, weight 400, line-height 1.5-1.55
- Tags/labels: 10px, weight 600, letter-spacing 2px, uppercase
- Step numbers: heading font, 26px, weight 300
- Small text: 11-12px

**Hook slide override:** 64-96px bold heading, max 8 words.

### Step 4 — Narrative arc (7-slide OR 10-slide based on Step 0 choice)

Apply slide arc per the structure picked in Step 0 — full templates in `references/slide-architecture.md` (Section "Narrative arcs by structure").

#### 7-slide arc (premium / compressed) — IconicTechs + Open Carrusel default

| # | Type | Background | 4-stage |
|---|---|---|---|
| 1 | Hero | LIGHT_BG | **HOOK** — bold statement, logo lockup |
| 2 | Confirm | DARK_BG | **CONTEXT** — receipt + push (NOT problem statement) |
| 3 | Solution | Brand gradient | **VALUE** — the answer / framework intro |
| 4 | Features | LIGHT_BG | **VALUE** — what you get |
| 5 | Details | DARK_BG | **VALUE** — depth, specs, differentiators |
| 6 | How-to | LIGHT_BG | **VALUE** — numbered workflow |
| 7 | CTA | Brand gradient | **ACTION** — single CTA. NO arrow. Progress 100%. |

#### 10-slide arc (design.deb framework / max engagement)

| # | Type | 4-stage | Notes |
|---|---|---|---|
| 1 | Hook | **HOOK** | Stop the scroll |
| 2 | Confirm | **CONTEXT** | Receipt + push ("I've spent N years…") |
| 3 | Build interest | **CONTEXT** | Why this matters / the example |
| 4 | Retain | **VALUE** | Diagram / framework intro |
| 5 | Retain | **VALUE** | Diagram continuation |
| 6-9 | Practical | **VALUE** | Steps / tips / details (1 idea per slide) |
| 10 | CTA | **ACTION** | Single simple action |

Pick based on Step 0 slide count choice. **Both arcs use the 4-stage HOOK→CONTEXT→VALUE→ACTION mental model**.

Rules (apply to both arcs):
- Hook MUST stop the scroll
- **Slide 2 is CONFIRM, not problem** — receipt + push (research: "confirm on slide 2" rule, +30% swipe-through)
- CTA on brand gradient — no swipe arrow, progress bar 100%
- Alternate light/dark backgrounds for visual rhythm
- Critical content within safe zones: 50px L, 120px R, 180px T, 180px B (Instagram UI overlap protection)
- Slide template archetypes (per slide):
  - **Hook slide:** display font 64-96px, max 8 words, scroll-stop
  - **Value slide:** little text + lots of visuals, max 14 words copy, ONE visual element
  - **CTA slide:** personal photo / logo + 1 simple action, NO swipe arrow

### Step 5 — Hook generation (always 3 alternatives, never 1)

Generate 3 hooks per carousel — see `references/hook-formulas.md`:
1. **Question hook** — provocative question creating curiosity
2. **Statistic hook** — surprising number or data point
3. **Bold statement hook** — contrarian or unexpected claim

All 3 must be max 8 words. Present them to user, let them pick.

### Step 6 — Copy generation

Write copy for slides 2-7 with these constraints:
- Max 14 words per slide (Mirra MCP rule, proven quality lift)
- Tone: warm, real, conversational. NO corporate language.
- Run output through `references/banned-words.md` check — 28 banned words (delve, leverage, navigate, harness, elevate, tapestry, etc.) + sentence-pattern blacklist
- Visual suggestion per slide (icon, chart, image idea)

### Step 6.5 — Level decision + Moodboard (optional Level 3 upgrade)

Before HTML generation, **ASK THE USER** which level they want — do not assume Level 1.

**Verbatim question to ask:**

> "I'll build the carousel at Level 1 (pure HTML/CSS, type-and-code, ~5 min, $0) by default.
>
> Do you want to upgrade to:
> - **Level 2** (+ your brand logo + 1 hero image you provide, ~+5 min)
> - **Level 3** (+ 2-4 Nano Banana custom images for hero / mood / analogy slides, ~+15 min, ~$0.10-0.40)?
>
> Reply 'L1', 'L2', or 'L3' — or skip to keep default."

#### If Level 3 selected — moodboard intake flow

Run the full `references/moodboard-workflow.md` flow. Summary:

1. **Ask user for Pinterest moodboard:** "Drop 3-5 Pinterest URLs (or attach reference images) that match the mood you want."
2. **Mood description (1 sentence):** "Describe the visual mood in one sentence (e.g., 'calm premium navy night with sky-blue dust particles')."
3. **Image roles (which slides need imagery):** the skill recommends **2-3 slides max** for image upgrade, NEVER all 7 (research warning: full image-led carousel = AI slop). Default targets:
   - Slide 1 (Hero): atmosphere/mood image
   - Slide 5 (Why): analogy visualization (if the analogy is visual — e.g., road, bridge, ladder)
   - Slide 7 (CTA): subtle decorative element
4. **Generate JSON image prompts** (Chris AI Studio pattern — see `references/moodboard-workflow.md` Section B):
   - For each target slide, produce a JSON prompt with `prompt`, `aspect_ratio`, `style_hints`, `negative_space_zones`
5. **Run Nano Banana** (see `references/moodboard-workflow.md` Section C for verbatim Gemini CLI commands).
6. **Embed images** as `data:image/png;base64,…` URIs in the HTML (NOT external URLs — research: Playwright export breaks on external).

**Critical research-backed rules:**
- Data-heavy slides (problem-list, decisions-table, audit-steps) → **NO image, type-only**.
- Image generation models render **text poorly** — text stays in HTML overlay, NOT inside the generated image.
- Pinterest moodboard reference is **non-optional** — without it the JSON prompts are generic and the carousel converges to AI-slop.

### Step 7 — HTML generation

Generate ONE self-contained HTML file with:
- 7 slide divs in horizontal carousel-track
- Each slide 420×525px in preview wrapper (KEEP THIS WIDTH — export depends on it)
- Embedded progress bar in every slide (positioned bottom, 28px horizontal padding, 20px bottom)
- Embedded swipe arrow on every slide EXCEPT slide 7 (right edge, 48px wide, gradient fade)
- All images base64-encoded as `data:image/jpeg;base64,...` URIs (NO external URLs)
- Google Fonts `<link>` in head
- Reusable component snippets — see `references/slide-architecture.md` Section 4

**Critical export rule:** the `.ig-frame` MUST be exactly 420px wide. The carousel viewport inside is 4:5 aspect (420×525px). Don't change this width.

### Step 8 — Anti-slop visual review

Before committing the HTML, run a `taste-skill`-equivalent check:
- ❌ Inter font → use Geist, Outfit, Cabinet Grotesk, or Satoshi instead
- ❌ Purple/lila gradient → BANNED ("AI Purple/Blue" aesthetic)
- ❌ Centered Hero/H1 → use Split Screen / Left Aligned / Asymmetric White-space
- ❌ Generic card containers (when VISUAL_DENSITY > 7) → use border-t, divide-y, or negative space
- ❌ Uniform rounded corners → vary or use sharp corners on certain elements

If ANY of these are present, rewrite the HTML.

### Step 9 — Export pipeline

Generate Playwright Python script (verbatim template in `references/export-pipeline.md`):
- Viewport: 420×525 (NOT 1080×1350 — would reflow layout)
- `device_scale_factor: 2.5714` → renders at 1080px output
- `wait_for_timeout(3000)` for Google Fonts to load
- Hide IG frame chrome (header/dots/actions/caption) before screenshot
- Disable carousel transition animation
- Loop through slides via `track.style.transform = 'translateX(...)'`
- Save as `slide_1.png` ... `slide_7.png` in user-specified directory

Run the script, verify all 7 PNGs exist, report file paths to user.

## Best Practices (research consensus)

✅ **7 slides ideal** (range 5-10) — Chris AI Studio: 23% engagement boost vs <5
✅ **4:5 (1080×1350)** — more screen real estate than 1:1
✅ **Add music before posting** — Instagram pushes carousel into Reels feed (Chris AI Studio)
✅ **Save brand system as Claude Skill** — load once, reuse forever (Charlie Hills meta-prompt)
✅ **Batch 20-30 Nano Banana images** in one session — build library of 60-100 over time
✅ **Light/dark alternation** — visual rhythm sustains attention

## Common Pitfalls (Reddit consensus)

❌ **Pure image-gen carousel = AI slop.** Brand consistency drifts across slides 1-7. Always use deterministic HTML/CSS rendering, NOT cross-slide image generation.
❌ **Setting viewport to 1080×1350 in Playwright** → layout reflows, fonts become tiny. Keep viewport at 420×525, use device_scale_factor.
❌ **Shell scripts for HTML generation** → `$` signs get interpolated. Always use Python Path.write_text().
❌ **Not waiting 3000ms for fonts** → headings render in fallback fonts.
❌ **Not hiding IG chrome** → exports include header and caption.
❌ **Claude.ai web alone** → no filesystem, can't watermark, can't batch export. Need Claude Code (CLI) for full pipeline.

## 3-Level Progression (Chris AI Studio)

User can opt into 3 levels of fidelity:

**Level 1 — Pure Claude HTML (default):**
- 5-min setup. Just the HTML/CSS slides, no images.
- Pros: instant, free, brand-consistent
- Output: 7 PNGs, text-only design

**Level 2 — + Brand System:**
- Upload brand doc (colors, fonts, voice) to Claude Project
- Pros: every carousel automatically branded
- Setup time: +10 min one-time

**Level 3 — + Nano Banana custom images:**
- Pinterest reference images → Claude generates JSON prompts → Nano Banana renders 1080×1350 backgrounds
- Pros: viral-grade visual identity, no one else has these images
- Cost: ~$0.10-0.40 per carousel (Gemini API)
- Setup: see `references/project-instructions.md` Section "Image generation workflow"

Default to Level 1 unless user requests Level 2/3.

## Examples

### Example 1: Topic-only request
**User:** "Make me a 7-slide IG carousel about morning habits for solopreneurs"

**Skill response:**
1. Skip intake (no brand context yet) → ask 7 brand questions
2. Generate 3 hook alternatives, present to user
3. Generate 7-slide narrative
4. Write HTML
5. Run anti-slop check
6. Generate Playwright export script
7. Run script → output 7 PNGs

### Example 2: URL-to-carousel
**User:** "Turn https://example.com/blog/ai-tips into a 8-slide carousel in our brand"

**Skill response:**
1. WebFetch the URL → extract key points
2. Use existing brand context (CLAUDE.md or recent project)
3. Plan 8-slide narrative based on extracted content
4. Generate hooks, copy, HTML, export

### Example 3: Paste-content
**User:** [pastes 800-word newsletter]

**Skill response:**
1. Identify the 5-7 key arguments
2. Map to slide arc (Hook → Problem → Solution → Features → How-to → CTA)
3. Compress each section to <14 words
4. Generate carousel

## Output Convention

Save outputs to: `./carousels/<carousel-slug>-<YYYYMMDD>/`
- `carousel.html` — single self-contained HTML file
- `export.py` — Playwright export script
- `slides/slide_1.png` ... `slide_7.png` — final IG-ready PNGs
- `caption.md` — IG caption + hashtags + first comment

If user is in `~/.claude/skills/` or another non-project directory, ask where to save.

## Companion Skills

This skill plays well with:
- **`json-prompt-generator`** (Grow With Alex bundle) — **NEW.** When Level 3 imagery is on, this skill is the preferred way to turn Pinterest references into structured JSON prompts for Nano Banana 2 / ChatGPT Image 2 / Midjourney / Higgsfield. Richer schema than the inline Chris AI Studio one (scene / style / technical / materials / environment / composition / quality). Install path: `~/.claude/skills/json-prompt-generator/`. Detailed call signature: `references/moodboard-workflow.md` Section C.0.
- `nano-banana` — for Level 3 image generation (Gemini CLI / Gemini 3 Pro Image)
- `taste-skill` — for additional anti-slop review (run BEFORE this skill, set DESIGN_VARIANCE=6, MOTION_INTENSITY=0)
- `frontend-design` — for distinctive HTML if anti-slop check fails
- `apify-content-analytics` — for performance feedback loop after publishing
- `market-social` — for 30-day content calendar (carousel topics)
- `web-artifacts-builder` — if user wants interactive React preview instead of static HTML

**Skill chain for a Level 3 carousel:**
```
taste-skill (DV=6, MI=0)
  → carousel-english (this skill)
      → json-prompt-generator (Section C.0 of moodboard-workflow.md)
          → nano-banana (CLI in Section D)
              → carousel-english (resume — embed PNGs as base64)
                  → export-pipeline.md (Playwright PNG export)
                      → apify-content-analytics (after publishing)
```

For Hungarian output: run final HTML/copy through `stop-slop` + `humanizer` skills, OR use the `carousel-hungarian` skill (if installed).

## Research Backing

This skill synthesizes ~3.5 MB of research (135 markdown files) located at `~/Marketinges/instagram-carousel-research/`:
- 12 production blogs (IconicTechs 10/10, Chris AI Studio 10/10, Mirra, AImaker, etc.)
- 16 Reddit threads (r/ClaudeAI, r/ClaudeCode consensus)
- 5 YouTube transcripts (Krish Unk, Emil Systems, AI Innovators, 9X Pro, Automatable)
- 50+ ranked X/LinkedIn threads (Charlie Hills 933 reactions, Axelle Malek 625 reactions, Giulia Guerrieri 43K views)
- 15 GitHub repos (Hainrixz/open-carrusel 209 stars as reference architecture)
- 11 Claude Skills (community + Anthropic official)

Full research synthesis: `~/Marketinges/instagram-carousel-research/analysis/MASTER_SYNTHESIS_V2.md`
