# Hook Formulas — The First Slide

The hook is what stops the scroll. Every other slide in the carousel exists to deliver the promise the hook made.

**Sources synthesized:**
- Open Carrusel system prompt (verbatim 3-archetype rule)
- IconicTechs slide 1 architecture
- Mirra MCP word-count constraint
- LeadGenJay 5-phase HOOK definition
- Giulia Guerrieri 7-prompt set (verbatim Threads.com post, 43K views)
- God of Prompt persona prompt (Claude Opus 4)

---

## 1. The Iron Rule — Always 3 Hooks, Never 1

When asked to "optimize the hook" or "improve slide 1", or whenever you write a new carousel:

**Generate 3 alternative hooks. Present all 3 to the user. Let them pick.**

Verbatim from Open Carrusel system prompt:

```
## Hook optimization
When asked to "optimize the hook" or "improve slide 1":
1. Generate 3 alternative hooks:
   - Question hook: provocative question that creates curiosity
   - Statistic hook: surprising number or data point
   - Bold statement hook: contrarian or unexpected claim
2. Create each as a separate slide update option
3. Let the user pick their favorite
```

**Why 3 not 1:** Different hooks resonate with different audiences. The user knows their audience better than you do. Your job is to provide range.

---

## 2. The 3 Archetypes (Detailed)

### 2.1 Question Hook

**Purpose:** Create curiosity. The reader has to swipe to find the answer.

**Structure:** Open-ended question that addresses a specific anxiety or aspiration of the ICP.

**Examples:**
- "Why do 67% of LinkedIn carousels fail?"
- "What if you could write 30 carousels in a weekend?"
- "Is your AI workflow actually saving time?"

**Bad examples (avoid):**
- "Want to grow your brand?" (too generic)
- "Did you know that..." (passive, doesn't engage)
- "Have you ever wondered..." (nostalgic, not urgent)

**When to use:** Education-focused content, problem-aware audience, B2B.

### 2.2 Statistic Hook

**Purpose:** Establish credibility instantly. Numbers feel objective.

**Structure:** Specific number + concrete subject + implied stakes.

**Examples:**
- "5,100 restaurants quit Google reviews in 2026."
- "73% of SMBs use AI. Only 6.6% do it well."
- "$8K/month from 1 carousel a week. Here's how."

**Bad examples (avoid):**
- "Studies show..." (no source = no credibility)
- "Most companies fail at..." (vague — most = ?)
- "AI is growing fast" (not a statistic, just a vibe)

**When to use:** B2B, data-driven audiences, when you have a real source. Cite the source on slide 2 or in caption.

### 2.3 Bold Statement Hook

**Purpose:** Pattern interrupt. Make the reader say "wait, what?"

**Structure:** Contrarian claim or unexpected reframe.

**Examples:**
- "Stop writing carousels. Generate them."
- "Canva is dead for AI creators."
- "Your morning routine is ruining your output."

**Bad examples (avoid):**
- "AI is the future" (everyone agrees → no pattern interrupt)
- "Hard work pays off" (cliché)
- "I love my job" (positive but not contrarian)

**When to use:** Established audience, brand with personality, opinion-driven niches.

---

## 3. Word Constraints (Strict — NEW Vault rules added)

| Element | Max words/lines | Source |
|---|---|---|
| Hook (slide 1) | **6 words** preferred, 8 absolute max | **Vault Framework** (Grow With Alex) — stricter than IconicTechs |
| Body slides (2-7) | 14 words OR **3 lines max** | Mirra MCP + Vault Framework — apply whichever hits first |
| Tag/label | 2-3 words | IconicTechs reusable component |
| CTA button | 4-5 words | IconicTechs final slide |

### The 6-word headline rule (Vault)

> *"Headlines: 6 words maximum. Plain language. No jargon. Your audience includes non-native English speakers."* — Grow With Alex, Vault Carousel Framework

The 6-word constraint is even stricter than the 8-word IconicTechs rule. **Default to 6, allow 8 only if absolutely needed**, never go to 9+.

### The 3-line body rule (Vault)

> *"Body text: 3 lines maximum per slide."*

Counts as **3 visual lines on the rendered slide**, NOT 3 sentences. If your sentence wraps to 4 lines on a 1080×1350 slide, it's too long — rewrite.

### Plain language rule (Vault)

Audience includes non-native English speakers. Jargon kills swipe-through.

**Replace:**
- "leverage" → "use"
- "synergize" → "combine"
- "ideate" → "come up with"
- "deep dive into" → "explore"
- "circle back" → "return to"

See `references/banned-words.md` for the full list.

**Mirra MCP verbatim:** *"each slide max 14 words" improves output quality.*

The 8-word hook constraint is what allows 64-96px typography to fit on a 4:5 slide. Any longer and you have to drop the font size, which kills scroll-stopping power.

---

## 4. Hook Typography

```css
.slide-1 h1 {
  font-family: 'Fraunces', 'Playfair Display', serif; /* OR a distinctive sans like Outfit / Cabinet Grotesk */
  font-size: 64px;       /* mobile minimum */
  /* up to 96px */       /* desktop / fewer words */
  font-weight: 700;
  line-height: 1.05;     /* tight — every word weighs */
  letter-spacing: -1.5px; /* tight tracking for impact */
  color: var(--BRAND_DARK);
  max-width: 100%;
}
```

**Sizing decision tree:**
- 4-5 words → 96px (max impact)
- 6-7 words → 80px
- 8 words → 64px (still scroll-stopping)
- 9+ words → STOP, rewrite to ≤8

---

## 5. Hook Generation Prompt (use inside Claude)

When you (Claude) need to generate hooks for a topic, use this internal prompt:

```
You are a viral Instagram hook writer.

ICP: [the user's target audience — be specific]
TOPIC: [the carousel topic]
BRAND VOICE: [from brand context — adjectives like "warm, conversational, no corporate"]

Generate 3 hooks (each max 8 words):
1. QUESTION HOOK — provocative, curiosity-creating
2. STATISTIC HOOK — surprising number/data point (cite source if possible)
3. BOLD STATEMENT HOOK — contrarian, unexpected

For each hook, also include:
- Why it works (1 sentence — which pain/desire/bias does it hit)
- Slide 2 setup (what naturally follows on the next slide to deliver the promise)

DO NOT use these banned words: delve, leverage, navigate, harness, elevate,
tapestry, robust, seamless, navigate, in today's fast-paced world,
in this article, let's dive into.

DO NOT start with: "Want to...", "Did you know...", "Have you ever..."
```

---

## 6. Specialty Hook Patterns (advanced)

### 6.1 Pain-Point Hook (LeadGenJay)
Direct articulation of a specific pain.
- "Your IG carousels feel generic. Here's why."
- "5 hours wasted on Canva every week."

### 6.2 Before-After Hook
Drama through contrast.
- "From 0 to 8K followers in 90 days."
- "12 hours → 12 minutes. Same carousel."

### 6.3 News-Event Hook (r/promptingmagic verbatim)
Hijack a current event or celebrity quote for relevance.
- "What [Famous Founder] just said about AI workflow."
- "After Anthropic shipped Claude Design, this changed."

### 6.4 Myth-Busting Hook
"You're doing X wrong" framing.
- "You're using AI carousels wrong. Here's the fix."
- "Stop following carousel templates. Build your own."

### 6.5 Mistake List Hook
Negative listicle teaser.
- "5 carousel mistakes I made (so you won't)."
- "3 reasons your carousels flop."

---

## 7. Hook QA Checklist

Before approving a hook, verify:

- [ ] Max 8 words?
- [ ] Specific to the ICP (not generic "entrepreneurs" or "creators")?
- [ ] No banned words (see `references/banned-words.md`)?
- [ ] Pattern interrupt (not what 90% of carousels open with)?
- [ ] Promise deliverable in 6 slides? (don't promise what you can't pay off)
- [ ] Typography fits at 64px+ on 4:5?
- [ ] Reading age appropriate (target: 8th grade unless the audience demands higher)?

If any checkbox fails, regenerate.

---

## 8. Hooks That Failed (Real Examples from Research)

These were submitted to Claude but rejected — instructive to see why:

❌ **"Unlock the power of AI-driven content creation today!"**
- 9 words (over budget)
- "Unlock", "power", "today" all clichés
- No specificity (what content? what AI?)

❌ **"In today's fast-paced world, AI is changing everything."**
- Sentence-pattern banned ("In today's fast-paced world")
- "Changing everything" = vague
- No call to action or promise

❌ **"Discover the secrets that top creators don't want you to know."**
- 11 words
- "Secrets that... don't want you to know" = clickbait pattern, low credibility
- Generic to any niche

✅ **"5,100 Hungarian restaurants ignore Google reviews."**
- 7 words
- Specific number, specific subject
- Implied promise ("here's how to fix it")
- Statistic hook archetype

✅ **"Stop writing carousels. Generate them."**
- 6 words
- Pattern interrupt (most creators write manually)
- Clear contrarian frame
- Bold statement hook archetype

✅ **"Why do 67% of LinkedIn carousels fail?"**
- 8 words
- Specific number cited
- Implied promise (the answer is in slides 2-7)
- Question hook archetype

---

## 9. Giulia Guerrieri's 7-Prompt Set (Threads.com verbatim)

For full pre-condition framework — load Claude with brand foundation BEFORE running these prompts:
- Ideal client (one persona)
- Voice descriptors (3-5 adjectives)
- Transformation story (their before → after)
- Content pillars (4-5 themes)

Then her 7 prompts cycle through:
1. **Ideation** — pick the angle
2. **Structure** — Hook → Problem → Cost → Shift → System → Proof → CTA
3. **Hook** — "if I don't read this, I'll stay stuck" framing
4. **Tension** — articulate the cost of not acting
5. **Reframe** — shift the reader's belief
6. **Conversion** — the soft sell on slide 7
7. **Repurposing** — same content for LinkedIn / Threads / X

Full verbatim post archived at: `~/Marketinges/instagram-carousel-research/twitter/02_posts_full/www_threads_com__iamgiuliaguerrieri_post_DVbCf1vDrwd_claude-prompts-i-use-to-create-viral-carousels.md`

---

## 10. The Confirm-on-Slide-2 Rule (NEW — design.deb framework)

**Slide 2 is NOT the body. Slide 2 is the second hook — the "confirm".**

If you skip the confirm and dive straight to "the problem is X," you lose 30-40% of the swipe-through. Slide 2 has ONE job: amplify the slide-1 hook with **a receipt** and **a push** to keep swiping.

### The 3 required ingredients of a confirm slide

1. **Specific number / receipt** — years, followers, revenue, time saved, slides shipped
2. **First-person stake** — "I've", "We've", "My team", "I run"
3. **Future-promise tease** — "Here's what" / "Here's everything I wish" / "Here's the system"

### Verbatim examples (design.deb pattern)

**Bad slide 2 (most carousels — diving into problem):**
> *"Most creators chase 30 fresh ideas a week. Burnout in 90 days."*
- Skips the receipt. Reader bails.

**Good slide 2 (confirm + push):**
> *"I've spent 7+ years creating carousels — 154K followers in the process. Here's everything I wish I knew before I started."*
- Specific receipt (7 years, 154K), first-person ("I've"), future-promise ("Here's everything I wish").

**Good slide 2 — operator variant:**
> *"6.59M subs ran on the one doc I built. Here's the system that lets it ship without me."*

**Good slide 2 — diagnostic variant:**
> *"30+ founder businesses I've audited. Same wall every time. Here's the test."*

### When the topic doesn't have a personal receipt

If the user has no specific number to flex (new brand, no portfolio):
- Use audience-language quote pull from research/Reddit (verbatim, attributed)
- Or use industry stat as receipt: *"70% of founder brands stall at $300K. Same reason every time. Here's the test."*

### Decision tree

When generating slide 2, ask:

1. Does the user have a **specific receipt number** they can flex? → use Pattern A (personal)
2. If no, do we have a **research-backed industry stat**? → use Pattern B (stat as receipt)
3. If no, do we have a **verbatim audience quote** from Reddit/comments? → use Pattern C (quote pull)

Never write a slide 2 that lacks a receipt. The "confirm" rule is non-negotiable.

### The slide-2 word budget

- Body: **max 18-22 words** (slightly higher than the 14-word standard for value slides — confirm needs space for receipt)
- Tag/kicker: same as other slides (`02 / CONFIRM` or `02 / CONTEXT`)
- ONE visual element max (quote-pull, screenshot, OR specific number — not all three)
