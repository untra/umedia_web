defmodule UmediaWeb.ShowController do
  use UmediaWeb, :controller

  alias Umedia.Media
  alias Umedia.Media.Show

  defp selection_tuple(selections, label_name) do
    Enum.map(selections, &({Map.get(&1, label_name), Map.get(&1, :id)}))
  end

  def index(conn, _params) do
    shows = Media.list_shows()
    render(conn, "index.html", shows: shows)
  end

  def new(conn, _params) do
    changeset = Media.change_show(%Show{})
    franchises = selection_tuple(Media.list_franchises(), :franchise_name)
    render(conn, "new.html",
      changeset: changeset,
      franchises: franchises)
  end

  def create(conn, %{"show" => show_params}) do
    case Media.create_show(show_params) do
      {:ok, show} ->
        conn
        |> put_flash(:info, "Show created successfully.")
        |> redirect(to: show_path(conn, :show, show))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    show = Media.get_show!(id)
    render(conn, "show.html", show: show)
  end

  def edit(conn, %{"id" => id}) do
    show = Media.get_show!(id)
    changeset = Media.change_show(show)
    franchises = Media.list_franchises()
    render(conn, "edit.html",
      show: show,
      changeset: changeset,
      franchises: franchises)
  end

  def update(conn, %{"id" => id, "show" => show_params}) do
    show = Media.get_show!(id)

    case Media.update_show(show, show_params) do
      {:ok, show} ->
        conn
        |> put_flash(:info, "Show updated successfully.")
        |> redirect(to: show_path(conn, :show, show))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", show: show, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    show = Media.get_show!(id)
    {:ok, _show} = Media.delete_show(show)

    conn
    |> put_flash(:info, "Show deleted successfully.")
    |> redirect(to: show_path(conn, :index))
  end
end
