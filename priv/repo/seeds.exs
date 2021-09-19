datetime = DateTime.truncate(DateTime.utc_now(), :second)

Enum.map(1..1_000_000, fn _x -> %{points: 0, inserted_at: datetime, updated_at: datetime} end)
|> Enum.chunk_every(21845)
|> Enum.each(fn rows ->
  Ecto.Multi.new()
  |> Ecto.Multi.insert_all(:insert_all, Remote.Users, rows)
  |> Remote.Repo.transaction()
end)
