defmodule ApiWeb.Schema do
  use Absinthe.Schema

  alias ApiWeb.Schema.User

  import_types User.Types

  query do
    field :viewer, :user do
      resolve(fn
        _, %{context: %{current_user: user}} ->
          {:ok, user}

        _, _ ->
          {:error, "Access Denied"}
      end)
    end

    field :user, :user do
      arg(:id, non_null(:id))
      resolve(&User.Resolver.find_user/3)
    end
  end

  # mutation do
  # end
end
