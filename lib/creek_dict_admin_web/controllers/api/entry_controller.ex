defmodule CreekDictAdminWeb.Api.EntryController do
  use CreekDictAdminWeb, :controller

  alias CreekDictAdmin.Entries.Entry
  alias CreekDictAdmin.Repo

  def index(conn, %{"q" => query}) do
    data =
      Entry
      |> Entry.search_creek_and_english_words(query)
      |> Repo.all()

    json(conn, %{data: data})
  end
end
