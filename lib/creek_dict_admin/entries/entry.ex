defmodule CreekDictAdmin.Entries.Entry do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  @derive {Jason.Encoder, only: [:creek_word, :english_word, :english_definition, :tags]}

  schema "entry" do
    field :creek_word, :string
    field :english_definition, :string
    field :english_word, :string
    field :tags, :string

    timestamps()
  end

  @doc false
  def changeset(entry, attrs) do
    entry
    |> cast(attrs, [:creek_word, :english_word, :english_definition, :tags])
    |> validate_required([:creek_word, :english_word, :tags])
    |> unique_constraint(:creek_word)
  end

  def search_creek_and_english_words(entry, search_query) do
    from(e in entry,
      select: e,
      where:
        ilike(e.creek_word, ^"%#{String.replace(search_query, "%", "\\%")}%") or
          ilike(e.english_word, ^"%#{String.replace(search_query, "%", "\\%")}%")
    )
  end
end
