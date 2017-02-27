defmodule AtvApi.FosControllerTest do
  use AtvApi.ConnCase

  alias AtvApi.Fos
  @valid_attrs %{title: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, fos_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    fos = Repo.insert! %Fos{}
    conn = get conn, fos_path(conn, :show, fos)
    assert json_response(conn, 200)["data"] == %{"id" => fos.id,
      "title" => fos.title}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, fos_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, fos_path(conn, :create), fos: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Fos, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, fos_path(conn, :create), fos: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    fos = Repo.insert! %Fos{}
    conn = put conn, fos_path(conn, :update, fos), fos: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Fos, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    fos = Repo.insert! %Fos{}
    conn = put conn, fos_path(conn, :update, fos), fos: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    fos = Repo.insert! %Fos{}
    conn = delete conn, fos_path(conn, :delete, fos)
    assert response(conn, 204)
    refute Repo.get(Fos, fos.id)
  end
end
