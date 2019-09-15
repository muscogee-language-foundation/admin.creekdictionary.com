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
    |> validate_required([:creek_word, :english_word, :english_definition, :tags])
    |> unique_constraint(:creek_word)
  end

  def search_creek_and_english_words(entry, search_query) do
    split =
      search_query
      |> String.downcase()
      |> String.split()

    from(e in entry,
      select: e,
      where: e.creek_word in ^split or e.english_word in ^split
    )
  end
end
