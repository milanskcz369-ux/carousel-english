# carousel-english

Production-grade Instagram carousel generator as a Claude Code skill. Outputs self-contained HTML at exact 1080×1350px (4:5), ready for Playwright screenshot export to PNG.

Built on synthesis of ~3.5 MB of research (135 markdown files, 12 production blogs, 16 Reddit threads, 5 YouTube transcripts, 50+ X/LinkedIn threads, 15 GitHub repos). Combines IconicTechs project instructions, Open Carrusel narrative arc, LeadGenJay 5-phase framework, Chris AI Studio 3-level progression, and taste-skill anti-AI-slop rules.

---

## What it does

```
Topic + brand → 7-slide carousel narrative → HTML → 7 PNGs (1080×1350)
       └─ optional Level 3 ─→ Pinterest moodboard → JSON prompts → Nano Banana → embed
```

**Default Level 1:** Pure HTML/CSS, type-and-code, ~5 min, $0.
**Optional Level 3:** + 2-4 Nano Banana custom images on strategic slides, +15 min, ~$0.10–0.40.

## Quick example

```
You:    "Make me a 7-slide IG carousel about morning habits for solopreneurs"
Skill:  [asks 7 brand questions]
You:    "Brand: Acme. Color: deep teal. Modern/clean fonts. Bold tone. Skip images."
Skill:  [generates 3 hook alternatives, you pick one]
        [outlines 7-slide narrative arc]
        [writes copy with banned-words check]
        [asks: Level 1 / 2 / 3?]
You:    "L1"
Skill:  [generates carousel.html]
        [generates export.py Playwright script]
        [runs it → 7 PNGs ready to post]
```

## Install

### Option 1 — Add to your Claude Code skills folder

```bash
git clone https://github.com/<user>/carousel-english.git ~/.claude/skills/carousel-english
```

Then in Claude Code, reference the skill by name (`carousel-english`) or trigger it implicitly with prompts like *"make me a carousel about X"*.

### Option 2 — Download as ZIP

[Download ZIP](https://github.com/<user>/carousel-english/archive/refs/heads/main.zip), extract to `~/.claude/skills/carousel-english/`.

## File structure

```
carousel-english/
├── SKILL.md                                — main skill entry, 9-step workflow
└── references/
    ├── project-instructions.md             — verbatim ~5000-word IconicTechs Claude Project prompt
    ├── slide-architecture.md               — 7-slide structure + reusable HTML components
    ├── hook-formulas.md                    — 3 archetypes (question/stat/bold) + word constraints
    ├── banned-words.md                     — LeadGenJay 28-word list + sentence patterns
    ├── moodboard-workflow.md               — Level 3: Pinterest → JSON prompts → Nano Banana
    └── export-pipeline.md                  — Playwright Python script + 6 common mistakes
```

Total: ~92 KB across 7 markdown files, ~2200 lines.

## The 9-step workflow

1. **Intake** — 7 brand questions (or skip with defaults)
2. **Color derivation** — 6 tokens from a single primary brand color
3. **Typography** — pick 1 of 7 Google Font pairings
4. **Narrative** — 7-slide arc (Hero → Problem → Solution → Features → Details → How-to → CTA)
5. **Hook generation** — 3 alternatives (question / statistic / bold statement), max 8 words each
6. **Copy** — slide bodies, max 14 words each, banned-words pass
7. **Level decision** *(optional Level 3 upgrade)* — L1/L2/L3 + Pinterest moodboard intake if L3
8. **HTML generation** — single self-contained file, 420×525 preview wrapper
9. **Export** — Playwright screenshots → 7 PNGs at 1080×1350

## Hard rules baked in

- Max 14 words per slide (Mirra MCP rule, proven quality lift)
- Hook max 8 words (`64-96px bold`, scroll-stop)
- 7 slides ideal, range 5-10 (Chris AI Studio: +23% engagement vs <5)
- 4:5 (1080×1350) aspect (more screen real estate than 1:1)
- Light/dark slide alternation for visual rhythm
- Banned words: *delve, leverage, navigate, harness, elevate, tapestry, robust, seamless* + 20 more
- Banned visual patterns: Inter font, purple/lila gradient, centered hero, drop shadows, generic 3-col cards
- All images base64-embedded (no external URLs — Playwright export reliability)

## Companion skills (recommended)

- **`nano-banana`** — Level 3 image generation (Gemini CLI)
- **`taste-skill`** — additional anti-slop review (set DESIGN_VARIANCE=6, MOTION_INTENSITY=0)
- **`stop-slop` + `humanizer`** — for Hungarian or non-EN copy
- **`apify-content-analytics`** — performance feedback loop after publishing

## Research backing

This skill is the synthesis of:

- **12 production blogs** (IconicTechs 10/10, Chris AI Studio 10/10, Mirra, AImaker, etc.)
- **16 Reddit threads** (r/ClaudeAI, r/ClaudeCode consensus on what makes carousels work vs AI-slop)
- **5 YouTube transcripts** (Krish Unk, Emil Systems, AI Innovators, 9X Pro, Automatable)
- **50+ ranked X/LinkedIn threads** (Charlie Hills 933 reactions, Axelle Malek 625 reactions, Giulia Guerrieri 43K views)
- **15 GitHub repos** (Hainrixz/open-carrusel 209 stars as reference architecture)
- **11 Claude Skills** (community + Anthropic official)

Full sources documented inline in each reference file.

## Examples gallery

Coming soon — showcase folder with screenshots of carousels built using this skill in different design directions:

- **Resend Developer Terminal** (pure black + orange accent, hairline borders)
- **Linear Editorial** (`#010102` canvas, lavender CTA only)
- **Cursor Warm Cream** (`#f7f7f4` canvas, weight-400 display)
- **Sentry Navy + Sky** (`#0a1628` warm navy, sky-blue accent, atmospheric radial glow)
- **Stripe Light** (weight-300 financial-grade premium)

## License

MIT — see [LICENSE](LICENSE).

## Credits

- **IconicTechs** ([blog](https://www.iconictechs.com/create-instagram-carousel-using-claude-ai/)) — verbatim ~5000-word Project Instructions
- **Chris AI Studio** ([Medium](https://medium.com/@christianaistudio/no-canva-no-designer-just-claude-and-nano-banana-for-instagram-carousels-that-actually-pop-3dcf47d0ffc6)) — 3-level progression + Nano Banana JSON workflow
- **Hainrixz/open-carrusel** ([GitHub](https://github.com/Hainrixz/open-carrusel)) — reference architecture
- **LeadGenJay** ([leadgenjay.com](https://leadgenjay.com/skills/carousel-post)) — 5-phase framework + banned words list
- **VoltAgent/awesome-design-md** ([GitHub](https://github.com/VoltAgent/awesome-design-md)) — 67 brand DESIGN.md collection used for design directions
