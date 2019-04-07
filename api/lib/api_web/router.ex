defmodule ApiWeb.Router do
  use ApiWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :has_auth_header do
    plug :verify_auth_header
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/v1", ApiWeb do
    pipe_through :api

    post "/sign_in/", SignInController, :sign_in
  end

  scope path: "/" do
    pipe_through [:has_auth_header]

    forward "/graphql", Absinthe.Plug,
      schema: ApiWeb.Schema,
      json_codec: Jason

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: ApiWeb.Schema,
      interface: :playground,
      json_codec: Jason
  end

  # Other scopes may use custom stacks.
  # scope "/api", ApiWeb do
  #   pipe_through :api
  # end
end
