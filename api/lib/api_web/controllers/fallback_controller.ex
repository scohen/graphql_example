defmodule ApiWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use ApiWeb, :controller
  alias ApiWeb.Error

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> json(%{"message" => "Not Found"})
  end

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(:unauthorized)
    |> json(%{"message" => "Not Authorized"})
  end

  def call(conn, {:error, %Error{} = err}) do
    conn
    |> put_status(err.http_status_code)
    |> json(%{errors: [err]})
  end

  def call(conn, {:error, status, errors}) when is_list(errors) do
    conn
    |> put_status(status)
    |> json(%{errors: errors})
  end
end
