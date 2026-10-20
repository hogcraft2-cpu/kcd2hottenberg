# Live collaboration setup

The map's live-collaboration controls use Supabase Realtime. The normal map still works without it.

## Setup

1. Create a Supabase project.
2. Open the SQL Editor and run [supabase-setup.sql](./supabase-setup.sql).
3. In the map, enter your project's **Project URL** and **anon/publishable key**, then click **Połącz live**. All crew members must use the same URL, key, and room ID.
4. Open the map link normally; the browser saves the entered settings locally.

## Security note

The included SQL is intentionally simple and allows anyone with the project URL and anon key to read and change all room rows. Room names are not passwords. Use it only for non-sensitive game notes and expect that a public client can be vandalized. Never put a Supabase `service_role` key in the page. For private teams, add Supabase Auth and membership-based Row Level Security before sharing the project.

## Current limitations

- Live updates are shared JSON snapshots; concurrent edits can overwrite each other if two people change the map at nearly the same time.
- This enables live sharing of the map's custom annotations, not extraction of KCD Roleplay's private/internal map data or automatic copying of all its POIs.
- The existing fan-made map tiles remain the base layer. Confirm the upstream project's tile/license terms before relying on it for public production use.
