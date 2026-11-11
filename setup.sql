-- 單字砲台排行榜資料表
create table if not exists public.scores (
  id bigint generated always as identity primary key,
  name text not null check (char_length(name) between 1 and 12),
  score int not null check (score between 0 and 1000000),
  words int not null check (words between 0 and 10000),
  time_sec int not null check (time_sec between 0 and 36000),
  acc int not null check (acc between 0 and 100),
  hint int not null default 1 check (hint between 0 and 2),
  created_at timestamptz not null default now()
);
alter table public.scores enable row level security;
drop policy if exists "anyone can read" on public.scores;
drop policy if exists "anyone can add" on public.scores;
create policy "anyone can read" on public.scores for select to anon using (true);
create policy "anyone can add"  on public.scores for insert to anon with check (true);
create index if not exists scores_score_idx on public.scores (score desc);
create index if not exists scores_time_idx on public.scores (time_sec desc);
grant usage on schema public to anon;
grant select, insert on public.scores to anon;
alter table public.scores add column if not exists message text check (message is null or char_length(message) <= 40);
