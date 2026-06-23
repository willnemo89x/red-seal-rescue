-- ============================================================================
-- Red Seal Rescue — Phase 1 database schema (Supabase / Postgres)
-- ----------------------------------------------------------------------------
-- Migration strategy: LOW RISK. We keep the app's exact data model and store the
-- whole "DB" object (clients, exams, plans, sessions, custom questions) as ONE
-- JSON document per coach. This gives real accounts, multi-device sync, and no
-- data loss — without rewriting the app's data layer. (We can normalize into
-- relational tables later if we ever need cross-coach queries.)
--
-- How to run: Supabase Dashboard → SQL Editor → paste this whole file → Run.
-- ============================================================================

-- One JSON document of app state per authenticated coach.
create table if not exists public.coach_state (
  user_id    uuid primary key references auth.users(id) on delete cascade,
  data       jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

-- Row-Level Security: a coach can only ever touch their OWN row.
alter table public.coach_state enable row level security;

create policy "read own state"
  on public.coach_state for select
  using (auth.uid() = user_id);

create policy "insert own state"
  on public.coach_state for insert
  with check (auth.uid() = user_id);

create policy "update own state"
  on public.coach_state for update
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

-- Keep updated_at fresh on every write (used for last-write-wins / conflict checks).
create or replace function public.touch_updated_at()
returns trigger language plpgsql as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists coach_state_touch on public.coach_state;
create trigger coach_state_touch
  before update on public.coach_state
  for each row execute function public.touch_updated_at();

-- ----------------------------------------------------------------------------
-- Notes
-- • The anon key the app uses is SAFE to ship in client code — RLS above is what
--   actually protects the data (each coach sees only their row).
-- • No secrets live here. This file is safe to commit.
-- ----------------------------------------------------------------------------
