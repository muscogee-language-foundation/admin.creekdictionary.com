defmodule CreekDictAdminWeb.EntryController do
  use CreekDictAdminWeb, :controller

  alias CreekDictAdmin.{Entries, Accounts}
  alias CreekDictAdmin.Entries.Entry

  plug :check_auth when action in [:index, :new, :create, :show, :edit, :update, :delete]

  defp check_auth(conn, _params) do
    if user_id = get_session(conn, :current_user_id) do
      current_user = Accounts.get_user!(user_id)

      conn
      |> assign(:current_user, current_user)
    else
      conn
      |> put_flash(:error, "You need to be signed in to access that page")
      |> redirect(to: Routes.session_path(conn, :new))
      |> halt()
    end
  end

  def index(conn, _params) do
    entry = Entries.list_entry()
    render(conn, "index.html", entry: entry)
  end

  def new(conn, _params) do
    changeset = Entries.change_entry(%Entry{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"entry" => entry_params}) do
    case Entries.create_entry(entry_params) do
      {:ok, _entry} ->
        conn
        |> put_flash(:info, "Entry created successfully.")
        |> redirect(to: Routes.entry_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    entry = Entries.get_entry!(id)
    render(conn, "show.html", entry: entry)
  end

  def edit(conn, %{"id" => id}) do
    entry = Entries.get_entry!(id)
    changeset = Entries.change_entry(entry)
    render(conn, "edit.html", entry: entry, changeset: changeset)
  end

  def update(conn, %{"id" => id, "entry" => entry_params}) do
    entry = Entries.get_entry!(id)

    case Entries.update_entry(entry, entry_params) do
      {:ok, _entry} ->
        conn
        |> put_flash(:info, "Entry updated successfully.")
        |> redirect(to: Routes.entry_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", entry: entry, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    entry = Entries.get_entry!(id)
    {:ok, _entry} = Entries.delete_entry(entry)

    conn
    |> put_flash(:info, "Entry deleted successfully.")
    |> redirect(to: Routes.entry_path(conn, :index))
  end
end
