defmodule Users do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  schema "users" do
    field :points, :integer

    timestamps(type: :utc_datetime_usec, default: DateTime.utc_now())
  end

  def update() do
    update(Users, set: [points: fragment("floor(random()*100)")])
    |> Remote.Repo.update_all([])
  end

  def changeset(model, params \\ :invalid) do
    model
    |> cast(params, [:points])
    |> validate_required([:points])
    |> validate_number(:points, greater_than_or_equal_to: 0, less_than_or_equal_to: 100)
  end
end
