# Banned Words & Patterns — Anti-AI-Slop Pass

Run every line of carousel copy through this filter BEFORE generating HTML.

**Sources:**
- LeadGenJay's 28-word banned list (verbatim, premium prompt)
- Reddit r/ClaudeAI carousel community consensus
- `taste-skill` LLM bias overrides
- `stop-slop` skill heuristics

---

## 1. The 28-Word Banned List (LeadGenJay verbatim)

These words are NEVER allowed in carousel copy. They are AI tells. Replace with concrete alternatives.

| Banned word | Why | Replace with |
|---|---|---|
| **delve** | AI cliché since 2023 | "look at", "examine" |
| **leverage** | Corporate fluff | "use", "apply" |
| **navigate** | Buzzwordy | "handle", "deal with", "work through" |
| **harness** | Generic | "use", "tap into" |
| **elevate** | Marketing-speak | "improve", "lift" |
| **tapestry** | Pretentious | (just delete the metaphor) |
| **robust** | Empty adjective | be specific: "tested", "stable" |
| **seamless** | Marketing | "smooth", "without friction" |
| **streamline** | Corporate | "speed up", "simplify" |
| **synergy** / **synergize** | Banned since 2010 | "work together" |
| **paradigm** / **paradigm shift** | Buzzword | "approach", "method" |
| **disrupt** / **disruptive** | Tech-bro cliché | "change", "replace" |
| **transformative** | Empty | "useful", "real" |
| **unlock** | Overused metaphor | "find", "access" |
| **empower** | Corporate | "help", "give" |
| **cultivate** | Pretentious | "build", "grow" |
| **foster** | Corporate | "build", "create" |
| **embark** | Theatrical | "start" |
| **endeavor** | Pompous | "try", "work" |
| **realm** | Pretentious | "area", "field" |
| **landscape** (when figurative) | Cliché | "field", "market" |
| **journey** (when figurative) | Cliché | "path", "process" |
| **ecosystem** | Tech-bro | "system", "set of tools" |
| **next-level** | Empty hype | be specific |
| **game-changer** | Empty hype | be specific about what changed |
| **revolutionary** | Empty hype | be specific |
| **cutting-edge** | Empty hype | "newest", or just delete |
| **state-of-the-art** | Empty hype | "newest", or just delete |

---

## 2. Sentence-Pattern Blacklist

These openers and structures are AI tells. Never start a carousel slide with them:

### Banned sentence starters

❌ "In today's fast-paced world..."
❌ "In an ever-evolving landscape..."
❌ "Now more than ever..."
❌ "It's no secret that..."
❌ "Have you ever wondered..."
❌ "Did you know that..."
❌ "Picture this:"
❌ "Imagine if..."
❌ "Let's dive into..."
❌ "Buckle up..."
❌ "We've all been there..."
❌ "The truth is..."

### Banned closing patterns

❌ "And the rest, as they say, is history."
❌ "The possibilities are endless."
❌ "The sky's the limit."
❌ "Only time will tell."
❌ "It's a journey, not a destination."

### Banned transitional phrases

❌ "On the other hand..." (use "but" or "however")
❌ "It's worth noting that..." (just say it)
❌ "Furthermore..." (use "also" or "and")
❌ "In conclusion..." (don't announce; just conclude)
❌ "Last but not least..." (just say "finally" or skip)

---

## 3. Em-Dash Overuse Detection

AI loves em-dashes (—). Humans use them sparingly.

**Rule:** Max 1 em-dash per slide. If you find 2+, replace with periods, commas, or parentheses.

**Example:**
❌ "AI tools — like Claude — are changing — for the better — how creators — work."
✅ "AI tools like Claude are changing how creators work."

---

## 4. Adjective Stacking

AI piles adjectives. Humans pick one.

**Rule:** Max 1 adjective per noun. If you find 2+, drop the weaker one.

❌ "A powerful, transformative, comprehensive, scalable AI solution"
✅ "A scalable AI solution" (or "A practical AI solution")

---

## 5. Filler Phrases (Delete Without Replacing)

These add words without adding meaning. Cut them entirely.

- "It is important to note that..."
- "It's interesting to consider..."
- "One could argue that..."
- "It goes without saying..."
- "At the end of the day..."
- "When all is said and done..."
- "More often than not..."

---

## 6. Numbers vs. Vague Quantifiers

Always prefer specific numbers over vague qualifiers.

| Vague | Specific |
|---|---|
| "Most" | "67%" or "8 out of 10" |
| "Many" | "thousands of" with source |
| "Several" | "5", "12" |
| "Often" | "weekly", "every Tuesday" |
| "Sometimes" | "1 in 4 times" |
| "Recently" | "last month", "April 2026" |
| "A lot" | concrete number |

If you don't have a real number, REMOVE the quantifier rather than fake one.

---

## 7. Pronouns & Voice

### Use:
- "You" (direct address — feels personal)
- "I" (only on Hero slide if it's a personal brand)
- Imperative ("Start", "Stop", "Try")

### Avoid:
- "We" (corporate, vague)
- "Our team" (irrelevant on a carousel)
- "Companies" / "businesses" (too vague — name the ICP)
- Passive voice ("It is recommended that..." → "Try this:")

---

## 8. The Anti-Slop Checklist (Run on Every Slide)

Before approving a slide, verify:

- [ ] No banned words (Section 1)?
- [ ] No banned sentence starters (Section 2)?
- [ ] ≤1 em-dash?
- [ ] ≤1 adjective per noun?
- [ ] No filler phrases (Section 5)?
- [ ] Specific numbers where claimed?
- [ ] "You" voice or specific imperative?
- [ ] No "We"/"Our" if not personal brand?
- [ ] Reads like a human wrote it (read it aloud)?

If any check fails, rewrite the slide.

---

## 9. Replacement Patterns (Common Cases)

### Pattern A: "leverage" → concrete verb
❌ "Leverage AI to streamline your workflow."
✅ "Use Claude to write 7 captions in 5 minutes."

### Pattern B: Filler intro → just say it
❌ "It's important to note that LinkedIn carousels perform 3x better."
✅ "LinkedIn carousels perform 3x better."

### Pattern C: Vague quantifier → specific number
❌ "Most creators struggle with consistency."
✅ "8 out of 10 creators post less than once a week."

### Pattern D: Buzzword stack → one concrete claim
❌ "Unlock transformative, paradigm-shifting AI tools."
✅ "These 3 Claude prompts saved me 6 hours last week."

### Pattern E: Em-dash overuse → periods
❌ "AI is fast — really fast — but only — if — you use it right."
✅ "AI is fast. But only if you use it right."

---

## 10. Why This Matters

The Reddit r/ClaudeAI consensus is brutal:
> *"We don't want more AI on social, we want less."* — top comment, multiple threads

Carousels that read AI-generated get scrolled past. Carousels that sound human get saved and shared. The 28-word banned list is the #1 most repeated lesson from the LeadGenJay premium prompt — it's the difference between a $19/wk SaaS template and a $2,200 production carousel.

For Hungarian carousels, the equivalent banned list is in the `stop-slop` skill (separate). The Hungarian version includes additional patterns:
- "leverage-eli" / "leverage-elés" (loanword forced into Hungarian)
- "robosztus megoldás" (corporate Hungarian)
- "felforgató" (Hungarian "disruptive")
- "A mai felgyorsult világban..." (Hungarian "in today's fast-paced world")
- "Manapság egyre fontosabbá válik..." (cliché Hungarian opener)

Run Hungarian copy through both `stop-slop` AND `humanizer` skills.
