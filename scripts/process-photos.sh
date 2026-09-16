#!/usr/bin/env bash
# Resize and watermark photos before adding them to the site.
#
# Usage:
#   ./scripts/process-photos.sh <input_dir> [output_dir]
#
# Reads every .jpg/.jpeg/.png in <input_dir>, resizes so the long edge is
# at most 2000px (never upscales), stamps the corner watermark from
# public/images/watermark.png in the bottom-right, and writes the result
# to [output_dir] (defaults to <input_dir>/web).

set -euo pipefail

INPUT_DIR="${1:?Usage: $0 <input_dir> [output_dir]}"
OUTPUT_DIR="${2:-$INPUT_DIR/web}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WATERMARK="$SCRIPT_DIR/../public/images/watermark.png"
MAX_SIZE="2000x2000>"
MARGIN="+30+30"

if command -v magick >/dev/null 2>&1; then
  IM="magick"
elif command -v convert >/dev/null 2>&1; then
  IM="convert"
else
  echo "ImageMagick not found. Install it with: brew install imagemagick" >&2
  exit 1
fi

if [ ! -f "$WATERMARK" ]; then
  echo "Watermark not found at $WATERMARK" >&2
  exit 1
fi

mkdir -p "$OUTPUT_DIR"

shopt -s nullglob nocaseglob
files=("$INPUT_DIR"/*.jpg "$INPUT_DIR"/*.jpeg "$INPUT_DIR"/*.png)

if [ ${#files[@]} -eq 0 ]; then
  echo "No .jpg/.jpeg/.png files found in $INPUT_DIR" >&2
  exit 1
fi

for f in "${files[@]}"; do
  name="$(basename "$f")"
  echo "Processing $name..."
  "$IM" "$f" -resize "$MAX_SIZE" \
    "$WATERMARK" -gravity southeast -geometry "$MARGIN" -composite \
    "$OUTPUT_DIR/$name"
done

echo "Done. Resized + watermarked images are in: $OUTPUT_DIR"
