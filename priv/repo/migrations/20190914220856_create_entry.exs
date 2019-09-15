defmodule CreekDictAdmin.Repo.Migrations.CreateEntry do
  use Ecto.Migration

  def change do
    create table(:entry) do
      add :creek_word, :string
      add :english_word, :string
      add :english_definition, :string
      add :tags, :string

      timestamps()
    end

    create unique_index(:entry, [:creek_word])
  end
end
