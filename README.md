A static personal homepage, served with [GitHub Pages](https://pages.github.com/).

## Usage

All static files live in the `public` folder — that's what gets published.

To preview locally, just open `public/index.html` in a browser, or serve it with any static file server, for example:

```bash
npx serve public
```

## Deploy

Pushes to `main` automatically build and deploy the `public` folder to GitHub Pages via the workflow in `.github/workflows/ci.yaml`.

To enable Pages for this repo (one-time setup): go to **Settings → Pages**, and under "Build and deployment" set the source to **GitHub Actions**.

## Adding photos to the walking tour

The SF walking tour page (`public/walking-tour.html`) reads its stops from
`public/data/tour-stops.json` and plots them on a map. To add a new stop:

1. Keep your original, full-resolution photos **outside this repo** (e.g. in
   Photos.app or a local folder) — this repo is public, and anything
   committed to it stays in git history forever, even if deleted later.
2. Process the ones you're ready to publish:
   ```bash
   ./scripts/process-photos.sh /path/to/raw/photos public/images/tour
   ```
   This resizes each photo to a 2000px max dimension and stamps the corner
   watermark automatically.
3. Rename the output files with a two-digit order prefix and a short slug,
   e.g. `04-golden-gate-bridge.jpg` — the number controls the order stops
   appear on the map and in the list; the slug just keeps filenames
   readable.
4. Add an entry to `public/data/tour-stops.json` for each new photo:
   ```json
   {
     "id": "golden-gate-bridge",
     "order": 4,
     "title": "Golden Gate Bridge",
     "lat": 37.8199,
     "lng": -122.4783,
     "image": "images/tour/04-golden-gate-bridge.jpg",
     "alt": "Describe what's actually in the photo, for accessibility and SEO",
     "caption": "A sentence or two about this stop."
   }
   ```
   Get `lat`/`lng` from your photo's location data (if your camera/phone
   recorded it) or by right-clicking the spot in Google Maps and copying
   the coordinates.
5. Commit both the new image(s) and the updated JSON file together.

The three sample stops (Ferry Building, Coit Tower, Lombard Street) use
placeholder images and are there to show the page working end-to-end —
delete their entries from `tour-stops.json` (and the files in
`public/images/tour/`) once you've added your own.
