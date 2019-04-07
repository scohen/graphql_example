# Graphql Example

This project is an example project that combines Elixir, Phoenix,
Absinthe Graphql and Vue.js

## Installation:

After cloning this git repository, you'll need to do the following:

##### Set up postgres users and passwords

The postgres usernames / passwords are defined in `./api/config/dev.exs`, and default to:
```
username: graphql_example
password: graphql_example
database: graphql_example_dev
```
You can change the usernames and passwords to match those on your system, or leave them as
is. The users will need the ability to create and drop databases, as well as created and drop tables.

Once the users are created, you will need to get the graphql application up and running.
To do so, cd into the `api` directory and enter the following into your console:

```
mix do deps.get, compile, ecto.create, ecto.migrate
```

Now you have to create a user in the database. Edit `priv/repo/seeds.exs` and change the
`User.create` call to have the values you want, then run
`mix run priv/repo/seeds.exs` and your user will be created.

##### Set up the vue directory
Prior to setting up Vue, you'll need to set up [Node.js][https://nodejs.org/en/download/]
and [Yarn](https://yarnpkg.com/en/docs/install). Once both are installed, cd into the
`web` directory and type `yarn install`. Once the installation completes, run `yarn serve`.
The server should start without errors. When it does, kill it with 'Ctrl+c'.

### Running the app
To run the app, cd into the projects root directory and run `./graphql_example start`.
This will launch a tmux session with three consoles in it, `shell`, `api` and `web`.
To switch between tmux consoles, type `Ctrl+b 1` for shell, `Ctrl+b 2` for api and
`Ctrl+b 3` for web.


When the consoles come up, they should have no error messages. When the come up successfully,
go to `http://localhost:8080` and you should see a login screen. Use the username and password
combination you entered in the `seeds.exs` step to login. You should now see a welcome layout.

To stop the app, type `./graphql_example stop` into the `shell` console.
