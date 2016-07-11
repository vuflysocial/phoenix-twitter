defmodule App.SignupController do
  use App.Web, :controller

  alias App.User

  def index(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, "index.html", changeset: changeset
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params) |> User.with_password_hash
    case Repo.insert(changeset) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "Successfully created user account.")
        |> redirect(to: page_path(conn, :index))
      {:error, changeset} ->
        render conn, "index.html", changeset: changeset
    end
  end
end
