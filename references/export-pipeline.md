# Export Pipeline — HTML to Instagram-ready PNGs

After the carousel HTML file is approved, export each slide as an individual 1080×1350px PNG image ready for direct Instagram upload.

**Source:** IconicTechs verbatim Playwright export script (Apr 2026, 10/10 production-grade).

---

## 1. The Critical Rule

**Keep the layout at 420×525 in Playwright's viewport. Do NOT set viewport to 1080×1350.**

Why: setting viewport to 1080px makes the layout reflow — fonts become tiny, padding shifts, components break. Instead, render at 420px and use `device_scale_factor: 2.5714` to scale up to 1080px output without reflowing.

Math: `1080 / 420 = 2.5714…`

---

## 2. The Verbatim Export Script (Python + Playwright)

```python
import asyncio
from pathlib import Path
from playwright.async_api import async_playwright

# CONFIGURE THESE PER CAROUSEL
INPUT_HTML = Path("/path/to/carousel.html")
OUTPUT_DIR = Path("/path/to/output/slides")
TOTAL_SLIDES = 7  # Update to match your carousel

# DO NOT CHANGE THESE
VIEW_W = 420
VIEW_H = 525
SCALE = 1080 / 420  # = 2.5714…


async def export_slides():
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

    async with async_playwright() as p:
        browser = await p.chromium.launch()
        page = await browser.new_page(
            viewport={"width": VIEW_W, "height": VIEW_H},
            device_scale_factor=SCALE,
        )

        # Load the HTML
        html_content = INPUT_HTML.read_text(encoding="utf-8")
        await page.set_content(html_content, wait_until="networkidle")

        # Wait for Google Fonts to load
        await page.wait_for_timeout(3000)

        # Hide IG frame chrome (header, dots, actions, caption)
        # Strip down to just the carousel viewport
        await page.evaluate("""() => {
            document.querySelectorAll('.ig-header,.ig-dots,.ig-actions,.ig-caption')
                .forEach(el => el.style.display = 'none');

            const frame = document.querySelector('.ig-frame');
            frame.style.cssText = 'width:420px;height:525px;max-width:none;border-radius:0;box-shadow:none;overflow:hidden;margin:0;';

            const viewport = document.querySelector('.carousel-viewport');
            viewport.style.cssText = 'width:420px;height:525px;aspect-ratio:unset;overflow:hidden;cursor:default;';

            document.body.style.cssText = 'padding:0;margin:0;display:block;overflow:hidden;';
        }""")

        await page.wait_for_timeout(500)

        # Loop through each slide
        for i in range(TOTAL_SLIDES):
            # Move the carousel-track to the i-th slide
            await page.evaluate("""(idx) => {
                const track = document.querySelector('.carousel-track');
                track.style.transition = 'none';  // disable swipe animation
                track.style.transform = 'translateX(' + (-idx * 420) + 'px)';
            }""", i)

            await page.wait_for_timeout(400)  # let it settle

            # Screenshot just the viewport area
            await page.screenshot(
                path=str(OUTPUT_DIR / f"slide_{i+1}.png"),
                clip={"x": 0, "y": 0, "width": VIEW_W, "height": VIEW_H}
            )

            print(f"Exported slide {i+1}/{TOTAL_SLIDES}")

        await browser.close()


if __name__ == "__main__":
    asyncio.run(export_slides())
```

---

## 3. Why Each Step Matters

### `device_scale_factor=2.5714`
Renders the page at high DPI: 420px input → 1080px output, **without reflowing the CSS layout**. This is the key trick.

### `clip={"x": 0, "y": 0, "width": VIEW_W, "height": VIEW_H}`
Captures only the viewport area, not the full page (which might extend past it).

### `wait_for_timeout(3000)`
Google Fonts take time to load. Without this, headings render in fallback fonts (system serif/sans), looking nothing like the design.

### `track.style.transition = 'none'`
Disables the carousel swipe animation. Without this, screenshotting between transitions captures a blurred mid-swipe state.

### Hiding `.ig-header`, `.ig-dots`, `.ig-actions`, `.ig-caption`
These are preview-only UI elements. They simulate the Instagram frame in chat, but should NOT appear in the exported PNG.

---

## 4. Common Mistakes (To Avoid)

### Mistake 1: Setting viewport to 1080×1350
**Symptom:** Fonts look tiny, padding looks off, components misaligned.
**Why:** The CSS was designed for 420px container. At 1080px, everything reflows and breaks.
**Fix:** Keep viewport at 420×525. Use `device_scale_factor`.

### Mistake 2: Using shell scripts to generate HTML
**Symptom:** Bash variables (`$BRAND_PRIMARY`) get interpolated, breaking the file.
**Why:** Bash heredocs treat `$` as a variable trigger.
**Fix:** ALWAYS use Python's `Path.write_text()` or `open().write()`. Never `cat <<EOF`.

### Mistake 3: Not waiting 3000ms for fonts
**Symptom:** Headings look like Times New Roman or Helvetica, not the brand fonts.
**Why:** Playwright's `networkidle` doesn't account for CSS font-family fallback rendering.
**Fix:** `await page.wait_for_timeout(3000)` after `set_content`.

### Mistake 4: Not hiding IG frame chrome
**Symptom:** PNG export contains the IG header (avatar, handle), dots, like/comment icons, caption.
**Why:** The preview wrapper is for in-chat display, not export.
**Fix:** Run the JS to hide them BEFORE screenshotting.

### Mistake 5: External images (not base64)
**Symptom:** PNG exports show broken image icons.
**Why:** Playwright's headless Chromium may not load external images reliably, especially after `networkidle`.
**Fix:** ALL images must be embedded as `data:image/jpeg;base64,...` in the HTML.

### Mistake 6: Not awaiting font.ready
**Alternative for Mistake 3:** Use `await page.evaluate("() => document.fonts.ready")` instead of fixed timeout.
This waits until ALL fonts have actually loaded, not a fixed 3 seconds.

---

## 5. Setup Requirements

```bash
# Python 3.9+
pip install playwright
playwright install chromium  # downloads ~150MB headless browser
```

If running in Claude Code, the Chromium download is one-time. Subsequent runs are fast.

---

## 6. Output Verification

After running, verify:

```bash
ls -la /path/to/output/slides/
# Should show:
# slide_1.png  (1080×1350)
# slide_2.png  (1080×1350)
# ...
# slide_7.png  (1080×1350)
```

Spot-check 2-3 PNGs:
- `file slide_1.png` → should report "1080 x 1350" dimensions
- Open visually → fonts should match the brand, no IG chrome visible, no animations frozen mid-swipe

---

## 7. Alternative: Single-Slide Export Mode

If the user wants to iterate on ONE slide without re-exporting all 7:

```python
async def export_single_slide(slide_index: int):
    # ... same setup ...
    for i in [slide_index - 1]:  # only the requested slide
        # ... screenshot logic ...
```

Useful for: "Slide 4 looks off, just re-export that one."

---

## 8. Batch Mode (Multiple Carousels)

For agencies producing 10+ carousels per week:

```python
import os

CAROUSEL_DIRS = [d for d in Path('/carousels').iterdir() if d.is_dir()]

async def export_batch():
    for carousel_dir in CAROUSEL_DIRS:
        html_path = carousel_dir / "carousel.html"
        output_path = carousel_dir / "slides"
        if html_path.exists() and not output_path.exists():
            # ... run export for this carousel ...
            print(f"Exported {carousel_dir.name}")
```

Run as a cron job for fully automated pipelines.

---

## 9. Resolution Verification (deviceScaleFactor proof)

After export, the actual PNG dimensions should be **2160×2700** (retina-grade):
- 420 × 2.5714 = 1080.0 (CSS pixels)
- × 2 (browser CSS-to-physical pixel ratio at deviceScaleFactor=2) = 2160 physical pixels
- → BUT Playwright's screenshot output respects `device_scale_factor` directly: 1080×1350

So either way, the user gets 1080×1350 resolution PNGs which is exactly what Instagram requires for 4:5 carousels.

---

## 10. Alternative Export Paths (If Playwright Unavailable)

### Option A: Puppeteer (Node.js)
Same logic, JS instead of Python. Used by `Hainrixz/open-carrusel` project.

### Option B: html2canvas (browser-side)
Run in the user's browser with a "Download" button. Lower quality, no headless control. Not recommended for production.

### Option C: Selenium + Chrome
Heavier than Playwright. Avoid unless legacy constraints.

### Option D: html-to-image (npm package)
Used by `itchernetski/threads-carousel-claude-skill` GitHub repo. Browser-based, lighter than Playwright.

For this skill, Playwright Python is the default. It's the same pipeline IconicTechs documented and the open-carrusel reference architecture uses (Puppeteer is its Node equivalent).

---

## 11. Caption Generation (Bonus)

After exporting PNGs, ask Claude to generate the IG caption:

```
For the carousel I just exported (slides about [TOPIC]), write:

1. Caption (max 2200 chars, but aim for 800-1500):
   - Hook in first line (matches slide 1 hook tone)
   - 3-5 short paragraphs of context/value
   - Soft CTA at the end

2. First comment (typically holds 5-10 hashtags + secondary CTA):
   - 5-10 niche hashtags (50% small, 30% medium, 20% large)
   - Optional secondary CTA ("Save for later" / "Comment WORD for X")

3. Alt text (for accessibility):
   - 1-2 sentences describing what the carousel shows
```

Save as `caption.md` next to the PNG files.
