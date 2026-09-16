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


## Adding photos to the "Spirits of San Francisco" page

`public/spirits-of-san-francisco.html` is a personal photo companion to Gary
Kamiya's *Spirits of San Francisco*. It reads its places from
`public/data/spirits-places.json` and plots them on a map — each place can
have one or more photos. To add a new place:

1. Keep your original, full-resolution photos **outside this repo** (e.g. in
   Photos.app or a local folder) — this repo is public, and anything
   committed to it stays in git history forever, even if deleted later.
2. Process the ones you're ready to publish:
   ```bash
   ./scripts/process-photos.sh /path/to/raw/photos public/images/spirits
   ```
   This resizes each photo to a 2000px max dimension and stamps the corner
   watermark automatically.
3. Rename the output files with a two-digit order prefix and a short slug,
   e.g. `04-golden-gate-park.jpg` (and `04-golden-gate-park-2.jpg` for a
   second photo of the same place) — the number controls where the place
   falls in the list; the slug just keeps filenames readable.
4. Add an entry to `public/data/spirits-places.json` for each new place:
   ```json
   {
     "id": "golden-gate-park",
     "order": 4,
     "title": "Golden Gate Park",
     "chapter": "Which chapter or section of the book this is from",
     "lat": 37.7694,
     "lng": -122.4862,
     "images": [
       { "src": "images/spirits/04-golden-gate-park.jpg", "alt": "Describe what's actually in the photo" },
       { "src": "images/spirits/04-golden-gate-park-2.jpg", "alt": "Describe the second photo" }
     ],
     "caption": "A sentence or two about this place and what Kamiya wrote about it."
   }
   ```
   `images` can hold as many photos as you want for that place. Get
   `lat`/`lng` from your photo's location data (if your camera/phone
   recorded it) or by right-clicking the spot in Google Maps and copying
   the coordinates.
5. Commit the new image(s) and the updated JSON file together.

The three sample places (Ferry Building, Coit Tower, Lombard Street) use
placeholder images and are there to show the page working end-to-end —
delete their entries from `spirits-places.json` (and the files in
`public/images/spirits/`) once you've added your own.

Once you have real permission or a licensing arrangement in place to use
scans/photos of the book's own illustrations, `images` is where those would
go too, alongside your own photos for that place.

### The book link

The Bookshop.org link in the page is not yet an affiliate link — when you
set one up, swap the URL in `public/spirits-of-san-francisco.html` for your
tracked affiliate link (and consider adding `rel="sponsored"` alongside
`rel="noopener"` on that link, which search engines expect for paid/affiliate
links).
