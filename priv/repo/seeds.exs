alias Remote.Repo

datetime = DateTime.utc_now()

Enum.map(1..1_000_000, fn _x -> %{points: 0, inserted_at: datetime, updated_at: datetime} end)
|> Enum.chunk_every(6000)
|> Enum.each(fn rows ->
  Ecto.Multi.new()
  |> Ecto.Multi.insert_all(:insert_all, Users, rows)
  |> Remote.Repo.transaction()
end)
