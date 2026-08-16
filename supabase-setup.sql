-- Esichia: tabella sessioni — da eseguire nel SQL Editor del progetto ESISTENTE
-- esercizi-ignaziani (eixlasungrkchzgbokab). Non tocca le tabelle già presenti.
create table public.esichia_sessioni (
  id bigint generated always as identity primary key,
  user_id text not null,
  giorno date not null,
  mattino boolean not null default false,
  pomeriggio boolean not null default false,
  sera boolean not null default false,
  created_at timestamptz not null default now(),
  unique (user_id, giorno)
);

-- RLS attiva con accesso anon in lettura/scrittura sulla sola tabella delle sessioni.
-- Nota: chiunque abbia URL + anon key può scrivere qui. Per un log di preghiera
-- personale è un rischio accettato; niente dati sensibili in questa tabella.
alter table public.esichia_sessioni enable row level security;
create policy "esichia_anon_tutto" on public.esichia_sessioni
  for all to anon using (true) with check (true);
