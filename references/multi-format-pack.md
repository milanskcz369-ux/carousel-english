# Multi-Format Pack — 1 carousel → 4 platform assets

One of the highest-leverage moves Grow With Alex demonstrates with ChatGPT Image 2 is **reusing the same JSON prompt across multiple aspect ratios** to produce a full platform pack from a single carousel design.

**Source:** `references/sources/grow-with-alex-chatgpt-image-2-transcript.md` lines 80-87 ("if you wanted a thumbnail, if you wanted a story for Instagram, a banner for YouTube, now you can basically get all different aspect ratios, full layouts, one prompt").

---

## A. The 4 native aspect ratios

| Format | Aspect | Pixel size (gpt-image-2 native) | IG-ready upscale | Use case |
|---|---|---|---|---|
| **Carousel slide** | 4:5 (3:4 acceptable) | 1024×1280 | 1080×1350 | IG / LinkedIn doc post |
| **Story / Reel cover** | 9:16 | 768×1408 (or 1024×1820 high) | 1080×1920 | IG/TikTok story, Reel covers |
| **Thumbnail / blog hero** | 16:9 | 1408×768 | 1920×1080 | YouTube thumb, blog featured |
| **Banner / Twitter / LinkedIn** | 21:9 | 1568×672 (closest) or 1792×768 | 2400×1200+ | YouTube channel banner, Twitter header |

**Single-prompt strategy:** the brand visual language (palette, typography, mood, image treatment) STAYS THE SAME across all 4 aspects. Only the composition / framing adjusts to the canvas.

---

## B. The composition shift per aspect

When the same JSON prompt is rendered at different aspects, the **negative-space zone changes** because the canvas shape changes. Pre-bake this into the prompt by providing aspect-aware composition notes:

| Aspect | Subject placement | Negative space zone | Text overlay zone |
|---|---|---|---|
| **4:5 carousel** | Subject occupies upper-right 2/3 OR top 60% | Bottom-left 1/3 OR bottom 40% | Headline bottom-left, swipe arrow bottom-right |
| **9:16 story** | Subject centered, takes 60% height | Top 20% + bottom 25% | Hook top, CTA + brand chrome bottom |
| **16:9 thumbnail** | Subject left-aligned, takes 50% width | Right 40-50% | Massive headline right, brand chrome bottom-left |
| **21:9 banner** | Subject thin strip OR off-center anchor | Center 60% | Logomark center, tagline beneath, CTA right |

Add this as a `composition.aspect_variants` extension to the json-prompt-generator schema (companion-skill compatible):

```json
"composition": {
  "perspective": "...",
  "framing": "...",
  "subject_placement": "Subject occupies upper-right 2/3 of frame at 4:5; for 9:16 shift to centered with subject taking 60% height; for 16:9 push subject to left half; for 21:9 anchor subject off-center-left",
  "ui_elements": "...",
  "negative_space_zone_per_aspect": {
    "4:5": "bottom-left",
    "9:16": "top + bottom strips",
    "16:9": "right half",
    "21:9": "right third"
  }
}
```

---

## C. Cost & time per format pack

Per the Grow With Alex demo (lines 314-339 in transcript), gpt-image-2 quality knobs:

| Quality | Cost per 1024×1280 (4:5) | When to use |
|---|---|---|
| **low** | ~$0.011 | Concept testing, iteration |
| **medium** | ~$0.042 | Final preview before commit |
| **high** | ~$0.167 | Production export |

**Strategy (verbatim from Alex, line 315-323):**
> *"Play around with low and medium. So you can test and get kind of a visual reference, and then you can even go back to Claude and to, you know, in terms of resolution, go 1K or 2K. You don't need to go to 4K."*

**Multi-format pack pricing (high quality, production grade):**

| Asset | Quantity | Cost |
|---|---|---|
| 4:5 carousel slides | 7-10 (one per slide) | ~$1.17-$1.67 |
| 9:16 story/reel cover | 1-3 (cover + key moments) | ~$0.17-$0.50 |
| 16:9 thumbnail | 1-2 (A/B test variants) | ~$0.17-$0.33 |
| 21:9 banner | 1 | ~$0.17 |
| **Total pack** | **10-16 images** | **~$1.68-$2.67** |

Budget for medium-quality dev iterations (~$0.04 each): a full ~30-iteration dev cycle adds ~$1.20.

---

## D. The batch generator script (`scripts/gen-image-multi-format.sh`)

A complementary tool: takes ONE JSON prompt + a list of target aspects, generates all assets in one batch.

Usage:

```bash
./scripts/gen-image-multi-format.sh \
  --prompt-file path/to/slide_1_prompt.json \
  --aspects "4:5,9:16,16:9,21:9" \
  --quality high \
  --out-dir ./multi-format-pack/
```

Output:

```
multi-format-pack/
├── 4x5_carousel.png       (1024×1280)
├── 9x16_story.png         (1024×1820 → upscale-ready)
├── 16x9_thumbnail.png     (1408×768 → upscale-ready)
└── 21x9_banner.png        (1792×768 → upscale-ready)
```

Cost calc printed at end. Failed aspects retried once with 2s backoff.

See `scripts/gen-image-multi-format.sh` for the canonical script.

---

## E. When to use the multi-format pack vs single-format

| Scenario | Recommend |
|---|---|
| First carousel for a new topic | **Single 4:5 only** — test the design first |
| Topic is going viral / hero piece | **Full pack** — IG + Story + YouTube + Twitter cross-post |
| Brand launch / product launch | **Full pack + 2x A/B thumbnails** — saturate all surfaces |
| Repurposing a 6-month-old carousel | **Full pack** — extract more shelf life from proven content |
| Daily/cadence content (e.g., 3x/week) | **Single 4:5 + 1 story cover** — speed > saturation |

The decision should be a Step 0.5 check in the carousel workflow: "Multi-platform pack? (yes / no / just story cover)" — see `SKILL.md` Step 0 update.

---

## F. The "share individually" mode (companion to multi-format)

When using Higgsfield or manual paste-generate workflow (no API automation), the companion skill should output the JSON prompts **ONE AT A TIME**, not as a batch dump. Verbatim Grow With Alex command (line 290-294):

> *"What you want to do is say individually. So, edit it all in one go for me. Can you share them with me individually? And you will start getting all of these prompts like this."*

This lets the user paste → generate → preview → paste-next, instead of getting a wall of JSON they have to manually copy chunk-by-chunk.

**To trigger in carousel-english workflow:**
- After the 7-slide concept is approved, ask: *"Generate JSON prompts in batch (all at once for API automation) OR individually (one per response, for Higgsfield/manual paste)?"*
- Default: **individually** if no API key set OR if user opts into Higgsfield path
- Default: **batch** if `OPENAI_API_KEY` set AND no Higgsfield preference

---

## G. Sources

- Grow With Alex transcript lines 80-87 (aspect ratio range), 290-294 (share individually), 314-339 (quality/cost knobs)
- gpt-image-2 official pricing (OpenAI Image API May 2026 docs)
- `references/moodboard-workflow.md` Section C (JSON prompt generator delegation)
- `scripts/gen-image-multi-format.sh` (the canonical batch script)
