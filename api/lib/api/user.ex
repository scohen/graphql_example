defmodule Api.User do
  alias Api.Repo
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]

  schema "users" do
    field :email, :string
    field :name, :string
    field :password_hash, :string

    timestamps()
  end

  @type t :: %__MODULE__{}

  def create(email_address, name, password) do
    %__MODULE__{}
    |> changeset(%{email: email_address, name: name, password: password})
    |> Repo.insert()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(hash_password(attrs), [:email, :name, :password_hash])
    |> validate_required([:email, :name, :password_hash])
    |> validate_format(:email, ~r/@/, message: "needs to be a valid email address")
    |> unique_constraint(:email, message: "is already taken")
  end

  def find_one(user_id) do
    Repo.get(__MODULE__, user_id)
  end

  def find_by_email(email_address) do
    from(u in __MODULE__, where: u.email == ^email_address)
    |> Repo.one()
  end

  def password_valid?(%__MODULE__{} = user, plaintext_password) do
    case Argon2.check_pass(user, plaintext_password, hash_key: :password_hash) do
      {:ok, _} -> true
      {:error, _} -> false
    end
  end

  defp hash_password(%{password: plaintext_password} = attrs) do
    attrs
    |> Map.delete(:password)
    |> Map.put(:password_hash, Argon2.hash_pwd_salt(plaintext_password))
  end

  defp hash_password(attrs), do: Map.delete(attrs, :password_hash)
end
