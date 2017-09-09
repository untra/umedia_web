defmodule UmediaWeb.ShowControllerTest do
  use UmediaWeb.ConnCase

  alias Umedia.Media

  @create_attrs %{show_name: "some show_name"}
  @update_attrs %{show_name: "some updated show_name"}
  @invalid_attrs %{show_name: nil}

  def fixture(:show) do
    {:ok, show} = Media.create_show(@create_attrs)
    show
  end

  describe "index" do
    test "lists all shows", %{conn: conn} do
      conn = get conn, show_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Shows"
    end
  end

  describe "new show" do
    test "renders form", %{conn: conn} do
      conn = get conn, show_path(conn, :new)
      assert html_response(conn, 200) =~ "New Show"
    end
  end

  describe "create show" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, show_path(conn, :create), show: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == show_path(conn, :show, id)

      conn = get conn, show_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Show"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, show_path(conn, :create), show: @invalid_attrs
      assert html_response(conn, 200) =~ "New Show"
    end
  end

  describe "edit show" do
    setup [:create_show]

    test "renders form for editing chosen show", %{conn: conn, show: show} do
      conn = get conn, show_path(conn, :edit, show)
      assert html_response(conn, 200) =~ "Edit Show"
    end
  end

  describe "update show" do
    setup [:create_show]

    test "redirects when data is valid", %{conn: conn, show: show} do
      conn = put conn, show_path(conn, :update, show), show: @update_attrs
      assert redirected_to(conn) == show_path(conn, :show, show)

      conn = get conn, show_path(conn, :show, show)
      assert html_response(conn, 200) =~ "some updated show_name"
    end

    test "renders errors when data is invalid", %{conn: conn, show: show} do
      conn = put conn, show_path(conn, :update, show), show: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Show"
    end
  end

  describe "delete show" do
    setup [:create_show]

    test "deletes chosen show", %{conn: conn, show: show} do
      conn = delete conn, show_path(conn, :delete, show)
      assert redirected_to(conn) == show_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, show_path(conn, :show, show)
      end
    end
  end

  defp create_show(_) do
    show = fixture(:show)
    {:ok, show: show}
  end
end
