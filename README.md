# Remote

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:3000`](http://localhost:3000) from your browser.

## Learn more

 - GenServer is running in 1 minute frequency and updating user points in DB.
 - While seeding the DB we are using chunk size as 21845 because we have 3 parameters in a query to insert data and 21845 * 3 is the limit which PostgreSQL can afford to insert.
 - I started the GenServer as named process instead of independent one so it will be started once only on start up.
 - I also changed the dev server port, to maintain the task's requirnments.

### Feedback

This whole process is being done under only 2 state values, but it can also be done with a timer value as well so when the work is done we can cancel the timer and start procedure again.

Also I have kept the DB work into Model instead of doing bare quries in GenServer Module.



