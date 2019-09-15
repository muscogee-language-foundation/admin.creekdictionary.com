defmodule CreekDictAdminWeb.EntryControllerTest do
  use CreekDictAdminWeb.ConnCase

  alias CreekDictAdmin.Entries

  @create_attrs %{creek_word: "some creek_word", english_definition: "some english_definition", english_word: "some english_word", tags: "some tags"}
  @update_attrs %{creek_word: "some updated creek_word", english_definition: "some updated english_definition", english_word: "some updated english_word", tags: "some updated tags"}
  @invalid_attrs %{creek_word: nil, english_definition: nil, english_word: nil, tags: nil}

  def fixture(:entry) do
    {:ok, entry} = Entries.create_entry(@create_attrs)
    entry
  end

  describe "index" do
    test "lists all entry", %{conn: conn} do
      conn = get(conn, Routes.entry_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Entry"
    end
  end

  describe "new entry" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.entry_path(conn, :new))
      assert html_response(conn, 200) =~ "New Entry"
    end
  end

  describe "create entry" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.entry_path(conn, :create), entry: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.entry_path(conn, :show, id)

      conn = get(conn, Routes.entry_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Entry"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.entry_path(conn, :create), entry: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Entry"
    end
  end

  describe "edit entry" do
    setup [:create_entry]

    test "renders form for editing chosen entry", %{conn: conn, entry: entry} do
      conn = get(conn, Routes.entry_path(conn, :edit, entry))
      assert html_response(conn, 200) =~ "Edit Entry"
    end
  end

  describe "update entry" do
    setup [:create_entry]

    test "redirects when data is valid", %{conn: conn, entry: entry} do
      conn = put(conn, Routes.entry_path(conn, :update, entry), entry: @update_attrs)
      assert redirected_to(conn) == Routes.entry_path(conn, :show, entry)

      conn = get(conn, Routes.entry_path(conn, :show, entry))
      assert html_response(conn, 200) =~ "some updated creek_word"
    end

    test "renders errors when data is invalid", %{conn: conn, entry: entry} do
      conn = put(conn, Routes.entry_path(conn, :update, entry), entry: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Entry"
    end
  end

  describe "delete entry" do
    setup [:create_entry]

    test "deletes chosen entry", %{conn: conn, entry: entry} do
      conn = delete(conn, Routes.entry_path(conn, :delete, entry))
      assert redirected_to(conn) == Routes.entry_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.entry_path(conn, :show, entry))
      end
    end
  end

  defp create_entry(_) do
    entry = fixture(:entry)
    {:ok, entry: entry}
  end
end
