#!/usr/bin/env bash
# Syncs the logo images of the case studies into images/ so that the overview
# page can serve them locally. The images are fetched from the published OER
# sites (GitHub Pages).
#
# Run manually with: ./scripts/update-oer-images.sh
set -euo pipefail

cd "$(dirname "$0")/.."

# local file | published logo URL
while IFS='|' read -r file url; do
  [ -n "$file" ] || continue

  tmp_file="$(mktemp)"
  if ! curl -fsSL --retry 3 --retry-delay 2 --max-time 60 "$url" -o "$tmp_file"; then
    echo "::error::Could not download $url" >&2
    rm -f "$tmp_file"
    exit 1
  fi

  if [ -f "images/$file" ] && cmp -s "$tmp_file" "images/$file"; then
    echo "unchanged: images/$file"
  else
    cp "$tmp_file" "images/$file"
    echo "updated:   images/$file"
  fi

  rm -f "$tmp_file"
done <<'IMAGES'
Text1.png|https://quadriga-dk.github.io/Text-Fallstudie-1/_static/Text1.png
Text2.png|https://quadriga-dk.github.io/Text-Fallstudie-2/_static/Text2Logo.png
Text3.png|https://quadriga-dk.github.io/Text-Fallstudie-3/_static/Text3.png
Bild1.png|https://quadriga-dk.github.io/Bewegtes-Bild-Fallstudie-1/_static/Bild1.png
Bild2.png|https://quadriga-dk.github.io/Bewegtes-Bild-Fallstudie-2/_static/Bild2Logo.png
Bild3.png|https://quadriga-dk.github.io/Bewegtes-Bild-Fallstudie-3/_static/Bild3.png
Bild4.png|https://quadriga-dk.github.io/Bewegtes-Bild-Fallstudie-4/_static/Bild4.png
Tabelle1.png|https://quadriga-dk.github.io/Tabelle-Fallstudie-1/_static/Tabelle1.png
Tabelle2.png|https://quadriga-dk.github.io/Tabelle-Fallstudie-2/_static/Tabelle2Logo.png
Tabelle3.png|https://quadriga-dk.github.io/Tabelle-Fallstudie-3/_static/logoTabelle3.png
Tabelle4.png|https://quadriga-dk.github.io/Tabelle-Fallstudie-4/_static/Tabelle4.png
IMAGES
