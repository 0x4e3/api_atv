defmodule AtvApi.FosController do
  use AtvApi.Web, :controller

  alias AtvApi.Fos

  def index(conn, _params) do
    fos = Repo.all(Fos)
    render(conn, "index.json", fos: fos)
  end

  def create(conn, %{"fos" => fos_params}) do
    changeset = Fos.changeset(%Fos{}, fos_params)

    case Repo.insert(changeset) do
      {:ok, fos} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", fos_path(conn, :show, fos))
        |> render("show.json", fos: fos)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(AtvApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    fos = Repo.get!(Fos, id)
    render(conn, "show.json", fos: fos)
  end

  def update(conn, %{"id" => id, "fos" => fos_params}) do
    fos = Repo.get!(Fos, id)
    changeset = Fos.changeset(fos, fos_params)

    case Repo.update(changeset) do
      {:ok, fos} ->
        render(conn, "show.json", fos: fos)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(AtvApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    fos = Repo.get!(Fos, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(fos)

    send_resp(conn, :no_content, "")
  end
end
