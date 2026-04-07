# rails-zero

A Rails 8 starter template with everything pre-wired — PostgreSQL, Tailwind, Hotwire, GitHub OAuth, Solid Queue, and one-click Render deployment.

No Redis. No Sprockets. No wasted afternoon on setup.

## Stack

| Layer | Choice |
|---|---|
| Framework | Rails 8.1 |
| Database | PostgreSQL |
| Assets | Propshaft + Importmap |
| CSS | Tailwind CSS |
| Frontend | Hotwire (Turbo + Stimulus) |
| Auth | OmniAuth GitHub |
| Jobs | Solid Queue (no Redis) |
| Cache | Solid Cache |
| Testing | RSpec + FactoryBot + Faker + Shoulda Matchers + SimpleCov |
| Linting | Rubocop (rails-omakase) |
| Deploy | Render.com (render.yaml included) |

## Quick Start

```bash
git clone https://github.com/tuxnotfound/rails-zero myapp
cd myapp
cp .env.example .env
```

Fill in your credentials in `.env`, then:

```bash
bundle install
rails db:create db:migrate
bin/dev
```

Visit `http://localhost:3000`.

## GitHub OAuth Setup

1. Go to [github.com/settings/developers](https://github.com/settings/developers) → New OAuth App
2. Set **Homepage URL** to `http://localhost:3000` (or your production URL)
3. Set **Authorization callback URL** to `http://localhost:3000/auth/github/callback`
4. Copy the Client ID and Secret into your `.env`

For production, create a separate OAuth app with your real domain.

## Environment Variables

See `.env.example` for all available variables. The only required ones are:

```
GITHUB_CLIENT_ID=your_client_id
GITHUB_CLIENT_SECRET=your_client_secret
```

## Running Tests

```bash
bundle exec rspec
```

Coverage report is generated in `coverage/` via SimpleCov.

## Linting

```bash
bundle exec rubocop
bundle exec rubocop -a  # auto-correct safe offenses
```

## Deploy to Render

The repo includes a `render.yaml` that provisions a web service + PostgreSQL database.

1. Push to GitHub
2. Go to [render.com](https://render.com) → New → Blueprint
3. Connect your repo
4. Set the following env vars in the Render dashboard:
   - `RAILS_MASTER_KEY` (from `config/master.key`)
   - `GITHUB_CLIENT_ID`
   - `GITHUB_CLIENT_SECRET`

That's it.

## Docker

```bash
docker build -t myapp .
docker run -p 3000:3000 myapp
```

## Philosophy

Opinionated but not precious. This is the stack I reach for on every project — boring in the best way. Nothing clever, nothing that will bite you in a year.

If you want to swap something out, it's Rails. You know where things live.

## License

MIT
