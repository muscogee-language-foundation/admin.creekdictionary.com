defmodule CreekDictAdmin.Repo.Migrations.AlterUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :password_hash, :string
      remove :hashed_password
    end
  end
end
