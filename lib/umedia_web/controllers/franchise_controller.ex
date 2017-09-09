defmodule UmediaWeb.FranchiseController do
  use UmediaWeb, :controller

  alias Umedia.Media
  alias Umedia.Media.Franchise

  def index(conn, _params) do
    franchises = Media.list_franchises()
    render(conn, "index.html", franchises: franchises)
  end

  def new(conn, _params) do
    changeset = Media.change_franchise(%Franchise{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"franchise" => franchise_params}) do
    case Media.create_franchise(franchise_params) do
      {:ok, franchise} ->
        conn
        |> put_flash(:info, "Franchise created successfully.")
        |> redirect(to: franchise_path(conn, :show, franchise))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    franchise = Media.get_franchise!(id)
    render(conn, "show.html", franchise: franchise)
  end

  def edit(conn, %{"id" => id}) do
    franchise = Media.get_franchise!(id)
    changeset = Media.change_franchise(franchise)
    render(conn, "edit.html", franchise: franchise, changeset: changeset)
  end

  def update(conn, %{"id" => id, "franchise" => franchise_params}) do
    franchise = Media.get_franchise!(id)

    case Media.update_franchise(franchise, franchise_params) do
      {:ok, franchise} ->
        conn
        |> put_flash(:info, "Franchise updated successfully.")
        |> redirect(to: franchise_path(conn, :show, franchise))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", franchise: franchise, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    franchise = Media.get_franchise!(id)
    {:ok, _franchise} = Media.delete_franchise(franchise)

    conn
    |> put_flash(:info, "Franchise deleted successfully.")
    |> redirect(to: franchise_path(conn, :index))
  end
end
