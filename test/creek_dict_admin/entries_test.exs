defmodule CreekDictAdmin.EntriesTest do
  use CreekDictAdmin.DataCase

  alias CreekDictAdmin.Entries

  describe "entry" do
    alias CreekDictAdmin.Entries.Entry

    @valid_attrs %{creek_word: "some creek_word", english_definition: "some english_definition", english_word: "some english_word", tags: "some tags"}
    @update_attrs %{creek_word: "some updated creek_word", english_definition: "some updated english_definition", english_word: "some updated english_word", tags: "some updated tags"}
    @invalid_attrs %{creek_word: nil, english_definition: nil, english_word: nil, tags: nil}

    def entry_fixture(attrs \\ %{}) do
      {:ok, entry} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Entries.create_entry()

      entry
    end

    test "list_entry/0 returns all entry" do
      entry = entry_fixture()
      assert Entries.list_entry() == [entry]
    end

    test "get_entry!/1 returns the entry with given id" do
      entry = entry_fixture()
      assert Entries.get_entry!(entry.id) == entry
    end

    test "create_entry/1 with valid data creates a entry" do
      assert {:ok, %Entry{} = entry} = Entries.create_entry(@valid_attrs)
      assert entry.creek_word == "some creek_word"
      assert entry.english_definition == "some english_definition"
      assert entry.english_word == "some english_word"
      assert entry.tags == "some tags"
    end

    test "create_entry/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Entries.create_entry(@invalid_attrs)
    end

    test "update_entry/2 with valid data updates the entry" do
      entry = entry_fixture()
      assert {:ok, %Entry{} = entry} = Entries.update_entry(entry, @update_attrs)
      assert entry.creek_word == "some updated creek_word"
      assert entry.english_definition == "some updated english_definition"
      assert entry.english_word == "some updated english_word"
      assert entry.tags == "some updated tags"
    end

    test "update_entry/2 with invalid data returns error changeset" do
      entry = entry_fixture()
      assert {:error, %Ecto.Changeset{}} = Entries.update_entry(entry, @invalid_attrs)
      assert entry == Entries.get_entry!(entry.id)
    end

    test "delete_entry/1 deletes the entry" do
      entry = entry_fixture()
      assert {:ok, %Entry{}} = Entries.delete_entry(entry)
      assert_raise Ecto.NoResultsError, fn -> Entries.get_entry!(entry.id) end
    end

    test "change_entry/1 returns a entry changeset" do
      entry = entry_fixture()
      assert %Ecto.Changeset{} = Entries.change_entry(entry)
    end
  end
end
