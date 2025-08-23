# Penny Tasks

A full-stack web application for managing a task list. This project was developed as part of a coding challenge for **PenyApp**. The app allows users to create, edit, delete, and filter tasks in a simple and intuitive interface.

## 📦 Requirements

- Ruby 3.4.5
- Rails 7.2.2.1
- PostgreSQL 15+
- Node 24.3.x+

## Features

- View a list of to-do items
- Filter tasks by **Pending**, **Complete**, and **All**
- Create new tasks
- Edit existing tasks
- Delete tasks
- Mark tasks as complete

## Tech Stack

- **Backend:** Ruby on Rails
- **Frontend:** HTML, CSS (Bootstrap), JavaScript (Stimulus + Turbo)
- **Database:** PostgreSQL
- **Deployment:** Docker or standard Rails host

## 🚀 Getting Started

### Option 1: Full Docker Setup (Recommended)

Make sure Docker and Docker Compose are installed on your machine.

Start the app in development mode:

```bash
docker compose up --build
```

> 💡 This sets up the full environment: web, database, and Redis (if configured).

Access the app at:

```
http://localhost:3000
```

Useful commands:

```bash
# Open a terminal in the web container
docker compose exec web bash

# Run migrations
docker compose exec web rails db:migrate

# Run tests
docker compose exec web rspec
```

### Option 2: Rails Local + Docker DB

If you have Ruby and Rails installed locally, you can run the app directly and use Docker only for the database.

Start the database container:

```bash
docker compose up db
```

Then, in another terminal, run:

```bash
bundle install
npm install
bin/rails db:create db:migrate
bin/dev
```

Visit `http://localhost:3000` to access the app.

## Database Seeding

Populate the database with sample tasks:

```bash
rails db:seed
```

For a clean start, reset the database:

```bash
rails db:reset
# or explicitly
rails db:drop db:create db:migrate db:seed
```

## Testing & CI

- Automated tests using **RSpec**
- Linters included: **RuboCop**, **ERB Lint**, **ESLint**
- CI configured to run tests and linters on each push

## Deployment

- No production deployment has been done yet
- App can be deployed via Docker or standard Rails hosting

## AI Tools and Workflow Assistance

- **ChatGPT**: Assisted with code review, test refactoring, Turbo/Hotwire setup, step-by-step guidance, and workflow optimization

All AI suggestions were reviewed and manually refined to maintain code quality and best practices.

