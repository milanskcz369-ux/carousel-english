# Moodboard → Nano Banana → Embed Workflow (Level 3)

The optional Level 3 upgrade — Pinterest moodboard intake → JSON image prompts → Nano Banana custom images → base64 embed in carousel HTML.

**Source:** Chris AI Studio "Pro Level" workflow (Medium, Apr 2026, 10/10 rated) + Nano Banana 2 (Gemini 3 Pro Image) integration via local `nano-banana` skill.

---

## ⚡ Companion skill (May 2026 update) — `json-prompt-generator`

JSON prompt generation is now **delegated to the dedicated `json-prompt-generator` skill** (Grow With Alex bundle, installed at `~/.claude/skills/json-prompt-generator/`). It accepts reference images and produces structured JSON prompts for Nano Banana 2, ChatGPT Image 2, Midjourney, and Higgsfield using a richer schema (scene / style / technical / materials / environment / composition / quality).

**When Section C below says "generate JSON prompts," call the companion skill** and feed it:
- The Pinterest reference URLs (or attached images) collected in Section B
- The 1-sentence mood description
- The list of target slides + each slide's negative-space zone

Section C still ships an **inline-schema fallback** (Chris AI Studio verbatim) for environments where the companion skill is unavailable. If `~/.claude/skills/json-prompt-generator/SKILL.md` exists, prefer the companion. Otherwise, use the inline schema in Section C.

---

## A. When to trigger Level 3

The skill MUST ask the user if they want Level 3 before HTML generation (see SKILL.md Step 6.5). The user opts in or stays at Level 1.

### Strong signals to recommend Level 3

- Topic involves visual/lifestyle/showcase content (NOT data/framework-only)
- Brand has ≥2-3 carousels/week cadence (image library compounds over weeks)
- Carousel has a strong visual analogy on slide 5 (e.g., "single-lane road", "ladder", "bridge")
- User explicitly mentions: "premium feel", "viral", "stand out from feed", "Bali aesthetic", "magazine-quality"
- Hero slide topic is mood-driven (story, journey, transformation)

### Strong signals to STAY at Level 1

- Pure framework / data / numbers carousel (multipliers, percentages, lists)
- Quick turnaround (under 15 min total budget)
- User says "minimal", "clean", "type-only", "Resend-style" or similar restraint signals
- Tight cost budget (Nano Banana: ~$0.10-0.40 per carousel via Gemini 3 Pro Image API)
- Brand voice is technical/dev-tooling — extra imagery undermines "I built this myself" credibility

### Decision tree pseudocode

```
IF user_explicit_request("Level 3" | "with images" | "Nano Banana"):
    → Level 3
ELSE IF topic_data_heavy AND no_visual_analogy:
    → Level 1 (recommend, do not push L3)
ELSE IF visual_signals_present(topic) OR brand_signals_premium:
    → Ask user with Level 3 highlighted as recommendation
ELSE:
    → Ask user with Level 1 as default
```

---

## B. Pinterest moodboard intake — verbatim user-facing flow

When Level 3 selected, run **exactly this 4-question intake**. Do not improvise — these questions are research-backed and produce reliably good JSON prompts.

### Question 1 — Pinterest URLs

```
Drop 3-5 Pinterest pin URLs (or attach reference images directly) that match
the visual mood you want. Pinterest is best because it's where premium
designers actually moodboard. Other sources OK: Behance, Are.na, dribble,
specific brand websites.

If you have NO references: describe 3 brand sites whose feed you'd want
your carousel to live next to (e.g., "Linear, Resend, Sentry").
```

### Question 2 — Mood description (1 sentence)

```
Describe the visual mood in ONE sentence. Be specific. Use sensory + temporal
+ atmospheric words. Example: "calm premium navy night with sky-blue dust
particles and editorial restraint."

Bad examples: "modern", "clean", "professional" (too generic — model defaults
to AI-slop).
Good examples: "warm bali sunset with desaturated pastels and grain texture",
"neon-lit financial district at dawn, steely blues, sharp shadows",
"editorial print magazine cover, 70s typography, deep claret + cream".
```

### Question 3 — Image roles (which slides get images)

Recommend 2-3 slides max. NEVER 7. Default targets, in priority order:

1. **Slide 1 (Hero)** — atmosphere/mood image. Highest impact-per-image.
2. **Slide 5 (Why/Analogy)** — ONLY if the analogy is visual (road, bridge, ladder, traffic, water, etc.). Skip if analogy is abstract.
3. **Slide 7 (CTA)** — subtle decorative element, NOT a competing visual. Optional.

```
I recommend imagery on slides 1, 5, and 7 (3 strategic visuals max).
Confirm or specify other slides:
- [Y] Slide 1 — Hero atmosphere
- [Y/N] Slide 5 — Visual analogy ([describe analogy])
- [Y/N] Slide 7 — CTA decorative element
- [Y/N] Other slide(s)? Specify.

Reminder: data-heavy slides (problem-list, decisions-table, audit-steps) stay
type-only. Image generation models render text poorly, and full image-led
carousels read as AI-slop on the IG feed.
```

### Question 4 — Negative space requirement

```
Each generated image must leave clear negative space for text overlay. Tell me
where the text will land per slide:
- Slide 1: text bottom-left ⇒ image leaves bottom-left empty (top-right hero)
- Slide 5: text top, analogy visual bottom (or vice-versa)
- Slide 7: text center-left, decoration right edge

Default: text always on the LEFT, image hero/decoration on the RIGHT.
Confirm or specify per slide.
```

---

## C. JSON image prompt generator

After collecting Pinterest references + mood + slide roles, generate one JSON prompt per target slide.

### C.0. PREFERRED — delegate to `json-prompt-generator` companion skill

If `~/.claude/skills/json-prompt-generator/` is installed (it ships in this carousel-english bundle's recommended companion stack — see `SKILL.md` Companion Skills section), invoke it directly.

**How to call it from inside this skill:**

```
For each target slide (e.g., slide 1, 5, 7):
  1. Attach the Pinterest reference image(s) that match this slide's role
  2. Give the companion skill this context as the user message:

     "Carousel: <topic>. Slide N role: <hero atmosphere | analogy | decorative>.
      Mood: <one-sentence mood from B-Q2>.
      Negative space: <zone from B-Q4>.
      Aspect: 4:5 (1080×1350).
      Brand accent hex: <BRAND_PRIMARY>.
      Avoid: text inside the image, AI-stock-photo people, generic faces, logos.
      Generate ONE JSON prompt for Nano Banana 2 (Gemini 3 Pro Image)."

  3. Companion returns a JSON block with: scene / style / technical / materials /
     environment / composition / quality sections.
  4. Forward the `scene.description` + key `style` + `quality.include` keywords
     into the Nano Banana CLI command in Section D.
```

**Why prefer the companion:** richer schema (more granular than Chris AI Studio's flat schema), built-in negative prompts (`quality.avoid`), explicit camera/material/atmosphere fields that translate cleanly into Nano Banana's strengths.

**Cross-slide consistency:** when generating the SET of slides (e.g., 1 + 5 + 7), invoke the companion ONCE per slide BUT hold all generations in the same Claude conversation so the style hints stay aligned. Re-paste the mood sentence + same Pinterest references for each call.

### C.1. FALLBACK — Chris AI Studio inline master prompt

Use this only if the companion skill is unavailable. Run **this exact Claude prompt** to generate JSON prompts for each target image.

#### Master prompt (Chris AI Studio verbatim, lightly adapted for Nano Banana 2)

```
You are an Instagram carousel art director. I provide:
- 3-5 Pinterest reference images (visual mood)
- 1 sentence mood description
- A list of slides that need imagery + the negative-space zones for text overlay

For each target slide, generate an optimized JSON image prompt for Nano Banana 2
(Gemini 3 Pro Image). Each prompt must:

1. Match the mood, color temperature, lighting, and grain/texture of the
   reference images
2. Maintain compositional consistency across all slide images (same
   palette, same lighting direction, same style — they should look like
   a SET, not random)
3. Leave clear negative space in the specified zones for text overlay
4. Output at 1080×1350 (4:5 carousel native size)
5. Use NO TEXT in the image itself — text stays in the HTML overlay
6. Include subtle brand-color accent integration where appropriate
   (carousel accent: [INSERT_HEX])

For each target slide, output JSON in this exact schema:

{
  "slide": 1,
  "role": "hero atmosphere" | "analogy visual" | "decorative element",
  "prompt": "<the actual Nano Banana prompt — concrete, sensory, no filler>",
  "aspect_ratio": "4:5",
  "style_hints": [
    "<keyword 1 — e.g. 'cinematic'>",
    "<keyword 2 — e.g. 'low-key lighting'>",
    "<keyword 3 — e.g. 'film grain'>"
  ],
  "negative_space_zone": "bottom-left" | "top-left" | "right-edge" | "center",
  "color_temperature": "warm" | "cool" | "neutral",
  "do_not_include": [
    "no text",
    "no people's faces",
    "no logos",
    "<any other carousel-specific exclusions>"
  ]
}

Ship one JSON object per target slide. End your response with a
single-line summary: "Generated N JSON prompts for slides [list]."
```

#### Example output (Bernath Roland Sentry navy carousel, slides 1 + 5 + 7)

```json
[
  {
    "slide": 1,
    "role": "hero atmosphere",
    "prompt": "Atmospheric dust particles drifting through deep midnight blue, subtle sky-blue glow rising from upper-right corner, cinematic low-key lighting, film grain texture, no horizon, pure abstract mood, editorial premium quality",
    "aspect_ratio": "4:5",
    "style_hints": ["cinematic", "low-key", "particle haze", "film grain", "editorial"],
    "negative_space_zone": "bottom-left",
    "color_temperature": "cool",
    "do_not_include": ["no text", "no people", "no logos", "no horizon line"]
  },
  {
    "slide": 5,
    "role": "analogy visual",
    "prompt": "Aerial overhead shot of a single-lane road cutting through dark midnight landscape, navy-blue color grade, headlight trails as soft light streaks, cinematic minimalism, no buildings, vast empty space, premium magazine photography quality",
    "aspect_ratio": "4:5",
    "style_hints": ["aerial", "minimalism", "light trails", "cinematic", "navy grade"],
    "negative_space_zone": "top-left",
    "color_temperature": "cool",
    "do_not_include": ["no text", "no signage", "no buildings", "no people", "no daytime sky"]
  },
  {
    "slide": 7,
    "role": "decorative element",
    "prompt": "Soft sky-blue particle glow against deep navy void, subtle radial light source on right edge, sparse luminous dust, signal-quality clarity, no defined shapes, abstract atmosphere only",
    "aspect_ratio": "4:5",
    "style_hints": ["radial glow", "particle dust", "abstract", "signal light"],
    "negative_space_zone": "center-left",
    "color_temperature": "cool",
    "do_not_include": ["no text", "no defined objects", "no people"]
  }
]
```

---

## D. Nano Banana CLI command patterns

The local `nano-banana` skill wraps Gemini 3 Pro Image (Nano Banana 2) via the Gemini CLI. Run one command per slide using the `prompt` field from the JSON.

### Command structure

```bash
gemini --yolo "/generate '<prompt-text>' --aspect=4:5 --output=<filepath>"
```

### Per-slide commands (continuing the Bernath example)

```bash
# Slide 1 — Hero atmosphere
gemini --yolo "/generate 'Atmospheric dust particles drifting through deep midnight blue, subtle sky-blue glow rising from upper-right corner, cinematic low-key lighting, film grain texture, no horizon, pure abstract mood, editorial premium quality' --aspect=4:5 --output=./images/slide_1_hero.png"

# Slide 5 — Analogy visual (single-lane road overhead)
gemini --yolo "/generate 'Aerial overhead shot of a single-lane road cutting through dark midnight landscape, navy-blue color grade, headlight trails as soft light streaks, cinematic minimalism, no buildings, vast empty space, premium magazine photography quality' --aspect=4:5 --output=./images/slide_5_analogy.png"

# Slide 7 — CTA decorative
gemini --yolo "/generate 'Soft sky-blue particle glow against deep navy void, subtle radial light source on right edge, sparse luminous dust, signal-quality clarity, no defined shapes, abstract atmosphere only' --aspect=4:5 --output=./images/slide_7_cta.png"
```

### Iteration / regeneration

If the first generation doesn't match the moodboard, use `/edit` instead of regenerating:

```bash
gemini --yolo "/edit ./images/slide_1_hero.png 'Increase grain texture, deepen the navy by 20%, push the sky-blue glow further into upper-right corner, NO horizon visible'"
```

For consistency across the set, **regenerate all 3 in one batch with shared style hints in every prompt** — that's how Chris AI Studio gets the "looks like a set" feel.

### Cost expectation (Gemini 3 Pro Image API, May 2026)

- Per generation: ~$0.04
- 3 slides × 2 iterations average = 6 generations per carousel
- Per-carousel cost: ~$0.10-0.40 depending on iteration count
- Batch optimization: generate 20-30 in one session for image library, drop per-carousel cost to <$0.05

---

## E. Per-slide image-to-mood mapping (research-validated)

The Chris AI Studio Level 3 prompt-engineering rule (verbatim):

> *"Use high-energy images for the hook and tension slides. Use calmer images for payoff and CTA sections."*

### Energy mapping per slide role

| Slide | Energy level | Why |
|---|---|---|
| 1 — Hero | HIGH atmosphere | Scroll-stop moment, set the brand vibe |
| 2 — Problem | MED-HIGH tension | Visual unease (if image used at all — usually skip) |
| 3 — Reframe | MED neutral | Diagram clarity > photo (usually skip image) |
| 4 — Detail/Data | NO image | Type-only, data ledger |
| 5 — Why/Analogy | MED calm | Visual analogy at conceptual peak |
| 6 — How-to | NO image | Actionable steps, type-only |
| 7 — CTA | LOW calm | Subtle decoration, not competing |

**Default recommendation:** image only on slides 1 + 5 + 7 (3 max). Slide 2 occasionally, only if topic carries strong visual tension.

---

## F. Embed pattern in carousel HTML

The generated PNGs need to live INSIDE the HTML for portability and Playwright export reliability.

### Option A — Base64 inline (RECOMMENDED for export)

Convert each PNG to a `data:image/png;base64,…` URI and embed:

```bash
# Convert PNG to base64 inline URI
base64 -i ./images/slide_1_hero.png | tr -d '\n' > ./images/slide_1_hero.b64
```

In the HTML:

```html
<div class="slide slide-hero" style="background-image: url('data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAA…');background-size:cover;background-position:center">
```

**Why base64:** Playwright export with external image paths is unreliable. Base64 makes the HTML 100% self-contained — works in browser preview AND Playwright screenshot.

### Option B — Local file:// reference (faster development)

```html
<div class="slide slide-hero" style="background-image: url('./images/slide_1_hero.png');background-size:cover">
```

**Caveat:** When running Playwright export, the script must `cd` to the carousel folder, OR pass `--path-base` to Playwright's `set_content`. Easier to just use base64.

### Option C — CSS background with overlay

For text over image, ALWAYS add a darkening or color-tinted overlay so text remains 4.5:1 contrast minimum:

```css
.slide-hero {
  background-image:
    linear-gradient(180deg, rgba(10,22,40,0) 0%, rgba(10,22,40,0.85) 70%, rgba(10,22,40,0.95) 100%),
    url('data:image/png;base64,…');
  background-size: cover;
  background-position: center;
}
```

The gradient overlay ensures text in the bottom-left readable even if the generated image has bright spots. The exact gradient stops match the negative-space-zone declared in the JSON prompt.

---

## G. Common pitfalls — research-backed warnings

### G1. The "AI slop" trap

> Reddit r/ClaudeCode consensus: *"The pure image-gen carousel is AI slop. Brand consistency drifts across slides 1-7. Slide 1 and Slide 4 look like they belong to different brands."*

**Fix:** Maximum 3 image slides per carousel. Type-only carousels with strategic 1-2 image moments outperform full image-led carousels.

### G2. Text-rendered-in-image

Image generation models (Gemini 3 Pro / Nano Banana / Flux) render text poorly — letters blur, kern wrong, sometimes hallucinate words.

**Rule:** ALL text stays in HTML overlay. The generated image gets `"do_not_include": ["no text"]` in every JSON prompt.

### G3. Cross-slide style drift

Generating slide 1 image then slide 5 separately = different palettes, lighting, grain. Reads inconsistent.

**Fix (Chris AI Studio):** Generate all images in one Claude+Nano Banana session with shared style hints in every prompt. Pinterest reference images stay in context throughout.

### G4. Missing negative space

If the image fills the frame, text becomes unreadable. The model needs to be told WHERE to leave space.

**Fix:** Always include `negative_space_zone` in JSON prompt + reinforce in the prompt-text itself ("leaves bottom-left empty for text overlay").

### G5. Stock-photo-style outputs

Generic office shots, generic founder faces, generic "team meeting" stock = instant AI-slop signal.

**Fix:** Ban "people", "team", "office", "meeting" from the prompts unless there's a specific creative reason. Default to abstract, atmospheric, or environmental imagery.

### G6. Skipping the moodboard

Without Pinterest references, the JSON prompt generator produces generic outputs. The model defaults to its training-data center, which is exactly the AI-slop look.

**Hard rule:** Pinterest moodboard (or equivalent reference set) is REQUIRED for Level 3. If user has no references, route them back to Level 1 + offer to help build a moodboard later.

---

## H. End-to-end Level 3 example (timing)

Total budget: ~15 min on top of Level 1's ~5 min. Cost: ~$0.10-0.40.

| Step | Time | Output |
|---|---|---|
| Pinterest moodboard intake (B) | 2 min | 3-5 reference URLs + mood sentence |
| Slide-role decision (B-Q3) | 1 min | List of 2-3 target slides |
| JSON prompt generation (C) | 2 min | 2-3 JSON objects |
| Nano Banana batch generate (D) | 3-5 min | 2-3 PNGs in `./images/` |
| Quality review + iteration (D) | 3 min | Optional `/edit` regenerations |
| Base64 conversion + HTML embed (F) | 2 min | Updated `carousel.html` |
| Playwright re-export | 1 min | 7 final PNGs |

**Note:** First-time setup (`gemini` CLI auth, `nano-banana` skill verification) is one-time, ~5 min, not in budget.

---

## I. Sources

- Chris AI Studio "No Canva, No Designer" Medium article (Apr 21, 2026): https://medium.com/@christianaistudio/no-canva-no-designer-just-claude-and-nano-banana-for-instagram-carousels-that-actually-pop-3dcf47d0ffc6
- Local `nano-banana` skill: `~/.claude/skills/nano-banana/SKILL.md`
- Research synthesis: `~/Marketinges/instagram-carousel-research/analysis/MASTER_SYNTHESIS_V2.md`
- Reddit consensus on AI-slop carousels: r/ClaudeCode discussion archived in `~/Marketinges/instagram-carousel-research/reddit_blogs/03_reddit_threads.md`
