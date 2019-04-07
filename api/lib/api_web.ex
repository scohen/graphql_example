defmodule ApiWeb do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, views, channels and so on.

  This can be used in your application as:

      use ApiWeb, :controller
      use ApiWeb, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define any helper function in modules
  and import those modules here.
  """

  def controller do
    quote do
      use Phoenix.Controller, namespace: ApiWeb

      import Plug.Conn
      import ApiWeb.Gettext
      alias ApiWeb.Router.Helpers, as: Routes
    end
  end

  def view do
    quote do
      use Phoenix.View,
        root: "lib/api_web/templates",
        namespace: ApiWeb

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_flash: 1, get_flash: 2, view_module: 1]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import ApiWeb.ErrorHelpers
      import ApiWeb.Gettext
      alias ApiWeb.Router.Helpers, as: Routes
    end
  end

  def router do
    quote do
      alias Api.{Auth, User}
      use Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller

      @env Mix.env()

      def verify_auth_header(conn, _opts) do
        with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
             {:ok, %{id: user_id}} <- Auth.verify_token(token),
             {:user, %User{} = user} <- {:user, User.find_one(user_id)} do
          absinthe_context = %{current_user: user}

          conn
          |> assign(:user, user)
          |> Absinthe.Plug.put_options(context: absinthe_context)
        else
          _ ->
            if is_graphiql?(@env, conn) do
              conn
            else
              conn
              |> put_status(401)
              |> put_resp_header("content-type", "application/json")
              |> json(%{"message" => "Unauthorized"})
              |> halt()
            end
        end
      end

      # This allows graphiql to load without the authorization header
      # but only in dev.
      defp is_graphiql?(:dev, %{path_info: ["graphiql"]}), do: true
      defp is_graphiql?(_, _), do: false
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import ApiWeb.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
