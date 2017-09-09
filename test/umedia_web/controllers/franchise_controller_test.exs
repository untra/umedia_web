defmodule UmediaWeb.FranchiseControllerTest do
  use UmediaWeb.ConnCase

  alias Umedia.Media

  @create_attrs %{franchise_name: "some franchise_name"}
  @update_attrs %{franchise_name: "some updated franchise_name"}
  @invalid_attrs %{franchise_name: nil}

  def fixture(:franchise) do
    {:ok, franchise} = Media.create_franchise(@create_attrs)
    franchise
  end

  describe "index" do
    test "lists all franchises", %{conn: conn} do
      conn = get conn, franchise_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Franchises"
    end
  end

  describe "new franchise" do
    test "renders form", %{conn: conn} do
      conn = get conn, franchise_path(conn, :new)
      assert html_response(conn, 200) =~ "New Franchise"
    end
  end

  describe "create franchise" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, franchise_path(conn, :create), franchise: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == franchise_path(conn, :show, id)

      conn = get conn, franchise_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Franchise"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, franchise_path(conn, :create), franchise: @invalid_attrs
      assert html_response(conn, 200) =~ "New Franchise"
    end
  end

  describe "edit franchise" do
    setup [:create_franchise]

    test "renders form for editing chosen franchise", %{conn: conn, franchise: franchise} do
      conn = get conn, franchise_path(conn, :edit, franchise)
      assert html_response(conn, 200) =~ "Edit Franchise"
    end
  end

  describe "update franchise" do
    setup [:create_franchise]

    test "redirects when data is valid", %{conn: conn, franchise: franchise} do
      conn = put conn, franchise_path(conn, :update, franchise), franchise: @update_attrs
      assert redirected_to(conn) == franchise_path(conn, :show, franchise)

      conn = get conn, franchise_path(conn, :show, franchise)
      assert html_response(conn, 200) =~ "some updated franchise_name"
    end

    test "renders errors when data is invalid", %{conn: conn, franchise: franchise} do
      conn = put conn, franchise_path(conn, :update, franchise), franchise: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Franchise"
    end
  end

  describe "delete franchise" do
    setup [:create_franchise]

    test "deletes chosen franchise", %{conn: conn, franchise: franchise} do
      conn = delete conn, franchise_path(conn, :delete, franchise)
      assert redirected_to(conn) == franchise_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, franchise_path(conn, :show, franchise)
      end
    end
  end

  defp create_franchise(_) do
    franchise = fixture(:franchise)
    {:ok, franchise: franchise}
  end
end
