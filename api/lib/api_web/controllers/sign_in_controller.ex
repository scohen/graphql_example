defmodule ApiWeb.SignInController do
  use ApiWeb, :controller

  alias Api.Auth
  alias ApiWeb.Error

  action_fallback ApiWeb.FallbackController

  def sign_in(conn, %{"email" => email, "password" => password}) do
    case Auth.token_for_login(email, password) do
      {:ok, token} ->
        conn
        |> put_status(200)
        |> json(%{"token" => token})

      {:error, :user_not_found} ->
        {:error, Error.new(404, :unknown_email, :email)}

      {:error, :invalid_password} ->
        {:error, Error.new(401, :bad_password, :password)}
    end
  end

  def sign_in(_conn, _) do
    {:error, Error.new(422, :invalid_parameters)}
  end
end
