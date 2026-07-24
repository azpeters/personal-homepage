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
