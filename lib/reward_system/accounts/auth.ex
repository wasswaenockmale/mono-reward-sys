defmodule RewardSystem.Accounts.Auth do
  import Plug.Conn
  alias RewardSystem.{Repo, Accounts.User}

  # Verify login credentials
  def authenticate(email, password) do
    case Repo.get_by(User, email: email) do
      nil -> {:error, :invalid_credentials}
      user ->
        if user.hashed_password == User.hash_password(password) do
          {:ok, user}
        else
          {:error, :invalid_credentials}
        end
    end
  end

  # Store user in session
  def login(conn, user) do
    conn
    |> put_session(:user_id, user.id)
    |> assign(:current_user, user)
  end

  # Clear session
  def logout(conn) do
    configure_session(conn, drop: true)
  end

  # Fetch current user from session
  def fetch_current_user(conn, _opts) do
    user_id = get_session(conn, :user_id)
    user = user_id && Repo.get(User, user_id)
    assign(conn, :current_user, user)
  end
end
