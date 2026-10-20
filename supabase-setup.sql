-- KCD2 Kuttenberg live map collaboration
-- WARNING: this policy makes map data readable/writable by anyone with the Supabase URL
-- and anon key. Use only for non-sensitive game-map notes. The room name is NOT access control.
create table if not exists public.kcd2_maps (
  room_id text primary key check (char_length(room_id) between 1 and 80),
  shapes jsonb not null default '[]'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.kcd2_maps enable row level security;

grant select, insert, update on public.kcd2_maps to anon, authenticated;

drop policy if exists "Public can read KCD2 maps" on public.kcd2_maps;
create policy "Public can read KCD2 maps"
  on public.kcd2_maps for select
  to anon, authenticated
  using (true);

drop policy if exists "Public can create KCD2 maps" on public.kcd2_maps;
create policy "Public can create KCD2 maps"
  on public.kcd2_maps for insert
  to anon, authenticated
  with check (true);

drop policy if exists "Public can update KCD2 maps" on public.kcd2_maps;
create policy "Public can update KCD2 maps"
  on public.kcd2_maps for update
  to anon, authenticated
  using (true)
  with check (true);

-- Enable row-change broadcasts for Supabase Realtime.
do $$
begin
  if not exists (
    select 1
    from pg_publication_tables
    where pubname = 'supabase_realtime'
      and schemaname = 'public'
      and tablename = 'kcd2_maps'
  ) then
    alter publication supabase_realtime add table public.kcd2_maps;
  end if;
end $$;
