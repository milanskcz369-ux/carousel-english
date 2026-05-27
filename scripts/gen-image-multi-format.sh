#!/usr/bin/env bash
# gen-image-multi-format.sh
# ---------------------------------------------------------------------------
# Generate the same gpt-image-2 prompt across multiple aspect ratios.
#
# Use: 1 JSON prompt -> 4 platform assets (carousel + story + thumb + banner).
# Read references/multi-format-pack.md for context.
#
# Usage:
#   ./gen-image-multi-format.sh \
#       --prompt-file path/to/slide_1_prompt.json \
#       --aspects "4:5,9:16,16:9,21:9" \
#       --quality high \
#       --out-dir ./multi-format-pack/
#
# Requires: OPENAI_API_KEY set in env (or auto-loaded from ~/.zshrc).
# Notes:
#   - Reads the prompt-file as a JSON-prompt-generator schema. Pulls
#     `prompt.scene.description` as the actual text sent to gpt-image-2.
#   - gpt-image-2 native sizes used per OpenAI Image API (May 2026):
#       4:5     -> 1024x1280
#       9:16    -> 1024x1820  (closest to 9:16)
#       16:9    -> 1408x768
#       21:9    -> 1792x768   (closest to 21:9)
#   - Quality: low / medium / high (cost: ~$0.011 / ~$0.042 / ~$0.167 per image)
# ---------------------------------------------------------------------------

set -euo pipefail

# Defaults
PROMPT_FILE=""
ASPECTS="4:5,9:16,16:9,21:9"
QUALITY="high"
OUT_DIR="./multi-format-pack"

# Parse args
while [[ $# -gt 0 ]]; do
    case $1 in
        --prompt-file) PROMPT_FILE="$2"; shift 2 ;;
        --aspects)     ASPECTS="$2"; shift 2 ;;
        --quality)     QUALITY="$2"; shift 2 ;;
        --out-dir)     OUT_DIR="$2"; shift 2 ;;
        --help|-h)
            grep "^#" "$0" | head -25
            exit 0
            ;;
        *) echo "Unknown arg: $1" >&2; exit 1 ;;
    esac
done

if [[ -z "$PROMPT_FILE" ]]; then
    echo "Error: --prompt-file required" >&2
    grep "^# Usage" -A 6 "$0"
    exit 1
fi

if [[ ! -f "$PROMPT_FILE" ]]; then
    echo "Error: prompt file not found: $PROMPT_FILE" >&2
    exit 1
fi

# Load OPENAI_API_KEY from ~/.zshrc if not set
if [[ -z "${OPENAI_API_KEY:-}" ]]; then
    OPENAI_API_KEY=$(grep "^export OPENAI_API_KEY=" ~/.zshrc 2>/dev/null \
        | sed 's/^export OPENAI_API_KEY=//; s/^"//; s/"$//' || true)
fi
if [[ -z "${OPENAI_API_KEY:-}" ]]; then
    echo "Error: OPENAI_API_KEY not set and not in ~/.zshrc" >&2
    exit 1
fi
export OPENAI_API_KEY

mkdir -p "$OUT_DIR"

# Map aspect -> (size, output-suffix, friendly-name)
declare -A SIZE_MAP=(
    [4:5]="1024x1280"
    [9:16]="1024x1820"
    [16:9]="1408x768"
    [21:9]="1792x768"
)
declare -A NAME_MAP=(
    [4:5]="carousel"
    [9:16]="story"
    [16:9]="thumbnail"
    [21:9]="banner"
)
declare -A COST_HIGH=(
    [low]="0.011"
    [medium]="0.042"
    [high]="0.167"
)

cost_per_img="${COST_HIGH[$QUALITY]:-0.167}"
total_cost=0

echo "=== gen-image-multi-format ==="
echo "Prompt file: $PROMPT_FILE"
echo "Aspects: $ASPECTS"
echo "Quality: $QUALITY (~\$$cost_per_img per image)"
echo "Output: $OUT_DIR"
echo ""

# Iterate aspects (comma-separated)
IFS=',' read -ra ASPECT_ARRAY <<< "$ASPECTS"
for aspect in "${ASPECT_ARRAY[@]}"; do
    aspect=$(echo "$aspect" | xargs)  # trim whitespace
    size="${SIZE_MAP[$aspect]:-}"
    name="${NAME_MAP[$aspect]:-aspect_$aspect}"
    if [[ -z "$size" ]]; then
        echo "Skip unknown aspect: $aspect" >&2
        continue
    fi

    safe_aspect="${aspect//:/x}"   # 4:5 -> 4x5
    out_path="$OUT_DIR/${safe_aspect}_${name}.png"

    echo "Generating $aspect ($size) -> $out_path ..."

    # Run via Python for clean JSON encode/decode (matching gen-image.sh pattern)
    python3 <<PYEOF
import json, base64, urllib.request, sys, os
from pathlib import Path

api_key = os.environ["OPENAI_API_KEY"]
prompt_file = Path("$PROMPT_FILE")
out_path = Path("$out_path")
size = "$size"
quality = "$QUALITY"

# Load JSON prompt schema, extract scene.description as the actual text
data = json.loads(prompt_file.read_text())
# Allow either {"prompt": {...}} (companion-skill schema) or flat
if "prompt" in data and isinstance(data["prompt"], dict):
    prompt_text = data["prompt"].get("scene", {}).get("description") or json.dumps(data["prompt"])
else:
    prompt_text = data.get("scene", {}).get("description") or json.dumps(data)

req = urllib.request.Request(
    "https://api.openai.com/v1/images/generations",
    method="POST",
    headers={
        "Authorization": f"Bearer {api_key}",
        "Content-Type": "application/json",
    },
    data=json.dumps({
        "model": "gpt-image-2",
        "prompt": prompt_text,
        "size": size,
        "quality": quality,
        "n": 1,
    }).encode("utf-8"),
)
try:
    with urllib.request.urlopen(req, timeout=240) as r:
        body = json.load(r)
except urllib.error.HTTPError as e:
    print(f"HTTPError for $aspect: {e.code} {e.reason}", file=sys.stderr)
    print(e.read().decode("utf-8"), file=sys.stderr)
    sys.exit(2)

b64 = body["data"][0]["b64_json"]
png = base64.b64decode(b64)
out_path.parent.mkdir(parents=True, exist_ok=True)
out_path.write_bytes(png)
print(f"OK $aspect -> {out_path} ({len(png):,} bytes)")
PYEOF

    if [[ $? -eq 0 ]]; then
        total_cost=$(echo "$total_cost + $cost_per_img" | bc -l)
    else
        echo "  retrying $aspect in 2s..."
        sleep 2
        # one retry — same command
        ./"$0" --prompt-file "$PROMPT_FILE" --aspects "$aspect" --quality "$QUALITY" --out-dir "$OUT_DIR" || true
    fi
done

printf "\n=== DONE ===\n"
printf "Estimated cost: \$%.3f\n" "$total_cost"
ls -la "$OUT_DIR"
