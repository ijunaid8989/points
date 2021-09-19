defmodule Remote.UsersTest do
  use ExUnit.Case, async: true
  use Remote.DataCase, async: true

  alias Remote.Users

  test "this will add a new points value correctly" do
    params = %{points: 8}

    assert {:ok, %Users{}} = Users.add(params)
  end

  test "this should return error for point out of range i.e below 0" do
    params = %{points: -1}

    {:error, changeset} = Users.add(params)

    expected_error =
      {"must be greater than or equal to %{number}",
       [validation: :number, kind: :greater_than_or_equal_to, number: 0]}

    assert %Ecto.Changeset{errors: [points: ^expected_error]} = changeset
  end

  test "this should return error for point out of range i.e above 100" do
    params = %{points: 101}

    {:error, changeset} = Users.add(params)

    expected_error = {
      "must be less than or equal to %{number}",
      [validation: :number, kind: :less_than_or_equal_to, number: 100]
    }

    assert %Ecto.Changeset{errors: [points: ^expected_error]} = changeset
  end
end
