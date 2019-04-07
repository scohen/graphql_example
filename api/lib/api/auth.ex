defmodule Api.Auth do
  @moduledoc """
  The Auth context.
  """

  @type signed_challenge :: String.t()
  @type token :: String.t()

  alias Phoenix.Token

  alias Api.User

  @token_salt Application.get_env(:api, :token_salt)

  @spec token_for_login(String.t(), String.t()) ::
          {:ok, token} | {:error, :user_not_found} | {:error, :invalid_password}
  def token_for_login(email, password) do
    with {:user, %User{} = user} <- {:user, User.find_by_email(email)},
         {:password?, true} <- {:password?, User.password_valid?(user, password)} do
      {:ok, create_token(user)}
    else
      {:user, _} -> {:error, :user_not_found}
      {:password?, false} -> {:error, :invalid_password}
    end
  end

  def sign(challenge, secret) do
    :sha256
    |> :crypto.hmac(secret, challenge)
    |> Base.encode16(case: :lower)
  end

  def create_token(%User{id: id}) do
    Token.sign(ApiWeb.Endpoint, @token_salt, %{id: id, type: "user"}, max_age: :infinity)
  end

  def verify_token(token) do
    Token.verify(ApiWeb.Endpoint, @token_salt, token, max_age: :infinity)
  end
end
