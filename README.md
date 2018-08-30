# Todobird

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Start Phoenix endpoint with `mix phx.server`

Take a look at `router.ex`. You'll see the routes for a JSONAPI interface. If you're using macOS, I recommend `paw`.

In order to use the ember app, you'll first need to create a user. I recommend doing so in the `iex` command interface, by creating a changeset and persisting it with `Repo.insert(user_registration_changeset)`

Possible tasks:

* create todos
* require a working Authorization: Bearer token (even if it's just an arbitrary value)
* associate a bearer token with a user account
* prevent pushing another user's todo lists to the logged-in user's window
* use Guardian to generate JWT tokens
* to support OAuth2 "password" logins you WON'T need Ueberauth

These todos get increasingly difficult. OAuth is HARD. Feel free to add other stuff, forms, improve the UI, or do whatever. Only take on OAuth if you really feel courageous.
