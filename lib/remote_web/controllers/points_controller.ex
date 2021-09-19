defmodule RemoteWeb.PointsController do
  use RemoteWeb, :controller

  def users(conn, _params) do
    json(conn, Remote.Points.get_users())
  end
end
