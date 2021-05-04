defmodule PortalDeployment.AccessTest do
  use PortalDeployment.DataCase

  alias PortalDeployment.Access

  describe "user_sessions" do
    alias PortalDeployment.Access.UserSession

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def user_session_fixture(attrs \\ %{}) do
      {:ok, user_session} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Access.create_user_session()

      user_session
    end

    test "list_user_sessions/0 returns all user_sessions" do
      user_session = user_session_fixture()
      assert Access.list_user_sessions() == [user_session]
    end

    test "get_user_session!/1 returns the user_session with given id" do
      user_session = user_session_fixture()
      assert Access.get_user_session!(user_session.id) == user_session
    end

    test "create_user_session/1 with valid data creates a user_session" do
      assert {:ok, %UserSession{} = user_session} = Access.create_user_session(@valid_attrs)
    end

    test "create_user_session/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Access.create_user_session(@invalid_attrs)
    end

    test "update_user_session/2 with valid data updates the user_session" do
      user_session = user_session_fixture()

      assert {:ok, %UserSession{} = user_session} =
               Access.update_user_session(user_session, @update_attrs)
    end

    test "update_user_session/2 with invalid data returns error changeset" do
      user_session = user_session_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Access.update_user_session(user_session, @invalid_attrs)

      assert user_session == Access.get_user_session!(user_session.id)
    end

    test "delete_user_session/1 deletes the user_session" do
      user_session = user_session_fixture()
      assert {:ok, %UserSession{}} = Access.delete_user_session(user_session)
      assert_raise Ecto.NoResultsError, fn -> Access.get_user_session!(user_session.id) end
    end

    test "change_user_session/1 returns a user_session changeset" do
      user_session = user_session_fixture()
      assert %Ecto.Changeset{} = Access.change_user_session(user_session)
    end
  end
end
