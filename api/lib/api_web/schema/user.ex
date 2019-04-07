defmodule ApiWeb.Schema.User do
  defmodule Types do
    use Absinthe.Schema.Notation

    object :user do
      field :id, :id
      field :name, :string

      field :email, :string do
        resolve(fn _, %{source: source_user, context: %{current_user: user}} ->
          if source_user.id == user.id do
            {:ok, source_user.email}
          else
            {:ok, nil}
          end
        end)
      end
    end
  end

  defmodule Resolver do
    alias Api.User

    def find_user(_, %{id: id}, _) do
      case User.find_one(id) do
        %User{} = user -> {:ok, user}
        _ -> {:error, :not_found}
      end
    end
  end
end
