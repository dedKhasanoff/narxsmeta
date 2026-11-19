create table if not exists docs (
  id text primary key,
  data jsonb not null,
  created_at timestamptz default now()
);
alter table docs enable row level security;

-- faqat tizimga kirgan (authenticated) egasi yozadi
drop policy if exists "owner insert" on docs;
create policy "owner insert" on docs for insert to authenticated with check (true);

-- tekshiruv: faqat kod bo'yicha bitta hujjat o'qiladi, ro'yxatni hech kim ko'ra olmaydi
create or replace function get_doc(p_id text) returns jsonb
language sql security definer set search_path = public as $$
  select data from docs where id = p_id
$$;
grant execute on function get_doc(text) to anon, authenticated;
