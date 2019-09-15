defmodule CreekDictAdmin.Repo do
  use Ecto.Repo,
    otp_app: :creek_dict_admin,
    adapter: Ecto.Adapters.Postgres
end
