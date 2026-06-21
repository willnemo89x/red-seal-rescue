# Deploying the Red Seal Rescue toolkit (live + updateable)

This app is one static file (`index.html`). Hosting it = a live website.
This guide uses **GitHub Pages** (free) for an *edit → push → live* workflow.

## Data note (read once)

Each coach's data is saved in **their own browser** (`localStorage`), tied to the
site's address. Pushing a code update does **not** erase anyone's data — the
storage key is stable, so coaches just get the new version on refresh. Data is
**not** shared across devices or people; the in-app **Export / Import** buttons
are how you back up and move data between machines. (Shared/synced data across
coaches would require adding a backend — a separate project.)

---

## One-time setup

A local git repo is already initialized in this folder with the first commit.
You just need to put it on GitHub and turn on Pages.

1. **Create a free GitHub account** if you don't have one — https://github.com/signup
2. **Create a new repository:** https://github.com/new
   - Name: `red-seal-rescue` (or anything)
   - Visibility: **Private** is fine — GitHub Pages can still serve it on paid
     plans; on the **free** plan, Pages requires the repo to be **Public**.
     If you want it free + simple, choose **Public** (the code is visible, but it
     contains no secrets and no client data).
   - Do **not** add a README/.gitignore (this folder already has them).
3. **Connect and push** — copy the commands GitHub shows you under
   *"…or push an existing repository from the command line"*. They look like:
   ```bash
   git remote add origin https://github.com/YOUR-USERNAME/red-seal-rescue.git
   git branch -M main
   git push -u origin main
   ```
   Run them from this folder:
   `/Users/bill_ete/Desktop/RedSealRescue/coaching-app`
4. **Turn on Pages:** in the repo, go to **Settings → Pages**.
   - Source: **Deploy from a branch**
   - Branch: **main**, folder: **/ (root)** → **Save**
5. Wait ~1 minute. Your live site appears at:
   `https://YOUR-USERNAME.github.io/red-seal-rescue/`

That URL is what you share with coaches. Bookmark it.

---

## Pushing an update (the everyday workflow)

After any change to `index.html` (by you or by Claude):

```bash
cd "/Users/bill_ete/Desktop/RedSealRescue/coaching-app"
git add -A
git commit -m "describe what changed"
git push
```

The live site refreshes within ~1 minute. If you don't see the change, do a
hard refresh in the browser (Cmd-Shift-R on Mac).

---

## Custom domain (optional, later)

If you own a domain (e.g. `redsealrescue.ca`), you can point a subdomain like
`app.redsealrescue.ca` at the site under **Settings → Pages → Custom domain**.
Ask and I'll walk you through the DNS records.

---

## Alternatives (if you don't want GitHub)

- **Netlify Drop** (https://app.netlify.com/drop) — drag this folder onto the
  page for an instant live URL. To update, drag the new version. Easiest, but
  less of a clean "push" workflow.
- **Your own web host / Squarespace etc.** — just upload `index.html`. To update,
  re-upload it.
