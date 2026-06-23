# Phase 1 setup — your 5 minutes (then I take over)

This adds **coach accounts + cloud sync** to the app so data follows a coach
across devices and never gets lost. The app stays **offline-first**: the browser
copy keeps working even if the network is down; the cloud just syncs on top.

I can't create accounts, so these few steps are yours. When you're done, send me
the two values at the bottom and I'll wire up login + sync and verify it.

## 1. Create a free Supabase project
1. Go to https://supabase.com → **Start your project** → sign in with GitHub.
2. **New project**. Name it `red-seal-rescue`. Choose a region near your coaches
   (e.g. Canada Central). Set a database password (save it somewhere; you won't
   need it day-to-day). Create.

## 2. Create the table
1. In the project, open **SQL Editor** → **New query**.
2. Open `supabase/schema.sql` from this folder, copy its entire contents, paste
   into the editor, and click **Run**. You should see "Success".

## 3. Turn on email login (magic links)
1. **Authentication → Providers → Email**: make sure it's enabled.
2. (Default magic-link / OTP email is fine for the demo — no SMTP setup needed to
   start. We can add a custom sender later.)

## 4. Grab the two values to send me
**Project Settings → API**:
- **Project URL** — looks like `https://abcdxyz.supabase.co`
- **anon public** key — a long string under "Project API keys"

> The **anon** key is safe to share and to ship in the app — Row-Level Security
> (set up by the schema) is what protects each coach's data. **Do not** send the
> `service_role` key or your database password.

---

### Send me:
```
SUPABASE_URL  = https://YOUR-PROJECT.supabase.co
SUPABASE_ANON = eyJ... (the anon public key)
```

Once I have those, I'll: add a "Sign in to sync" flow, sync your data to the
cloud on save, pull it on login (multi-device), and migrate any data already in
your browser — all behind a flag so the live app keeps working the whole time.
