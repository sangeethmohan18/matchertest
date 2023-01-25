defmodule App.ApplicationRoutesTest do
  use App.DataCase

  alias App.ApplicationRoutes

  describe "application_routes" do
    alias App.ApplicationRoutes.ApplicationRoute

    import App.ApplicationRoutesFixtures

    @invalid_attrs %{name: nil}

    test "list_application_routes/0 returns all application_routes" do
      application_route = application_route_fixture()
      assert ApplicationRoutes.list_application_routes() == [application_route]
    end

    test "get_application_route!/1 returns the application_route with given id" do
      application_route = application_route_fixture()
      assert ApplicationRoutes.get_application_route!(application_route.id) == application_route
    end

    test "create_application_route/1 with valid data creates a application_route" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %ApplicationRoute{} = application_route} = ApplicationRoutes.create_application_route(valid_attrs)
      assert application_route.name == "some name"
    end

    test "create_application_route/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ApplicationRoutes.create_application_route(@invalid_attrs)
    end

    test "update_application_route/2 with valid data updates the application_route" do
      application_route = application_route_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %ApplicationRoute{} = application_route} = ApplicationRoutes.update_application_route(application_route, update_attrs)
      assert application_route.name == "some updated name"
    end

    test "update_application_route/2 with invalid data returns error changeset" do
      application_route = application_route_fixture()
      assert {:error, %Ecto.Changeset{}} = ApplicationRoutes.update_application_route(application_route, @invalid_attrs)
      assert application_route == ApplicationRoutes.get_application_route!(application_route.id)
    end

    test "delete_application_route/1 deletes the application_route" do
      application_route = application_route_fixture()
      assert {:ok, %ApplicationRoute{}} = ApplicationRoutes.delete_application_route(application_route)
      assert_raise Ecto.NoResultsError, fn -> ApplicationRoutes.get_application_route!(application_route.id) end
    end

    test "change_application_route/1 returns a application_route changeset" do
      application_route = application_route_fixture()
      assert %Ecto.Changeset{} = ApplicationRoutes.change_application_route(application_route)
    end
  end
end
