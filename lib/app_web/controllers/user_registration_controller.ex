defmodule AppWeb.UserRegistrationController do
  use AppWeb, :controller

  alias App.Admins
  alias App.Admins.User
  alias AppWeb.UserAuth

  def new(conn, _params) do
    changeset = Admins.change_user_registration(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Admins.register_user(user_params) do
      {:ok, user} ->
        {:ok, _} =
          Admins.deliver_user_confirmation_instructions(
            user,
            &Routes.user_confirmation_url(conn, :edit, &1)
          )

        conn
        |> put_flash(:info, "User created successfully.")
        |> UserAuth.log_in_user(user)

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
