defmodule CreekDictAdminWeb.Router do
  use CreekDictAdminWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CreekDictAdminWeb do
    pipe_through :browser

    get "/", SessionController, :new
    resources "/entries", EntryController
    resources "/registrations", UserController, only: [:new, :create]

    get "/sign-in", SessionController, :new
    post "/sign-in", SessionController, :create
    delete "/sign-in", SessionController, :delete
  end

  # Other scopes may use custom stacks.
  scope "/api", CreekDictAdminWeb.Api, as: :api do
    pipe_through :api

    resources "/search", EntryController, only: [:index]
  end
end
