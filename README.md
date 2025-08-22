# Penny Tasks

A full-stack web application for managing a task list. This project was developed as part of a coding challenge for **PenyApp**.
The app allows users to create, edit, delete, and filter tasks in a simple and intuitive interface.

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
- **Deployment:** [link to deployed app]

## Installation

1. Clone the repository:

```bash
git clone https://github.com/fabiodallazen/peny_tasks.git
cd penny-tasks
```

2. Install dependencies:

```bash
bundle install
yarn install
```

3. Setup the database:

```bash
rails db:create db:migrate db:seed
```

4. Start the server:

```bash
rails server
```

5. Visit `http://localhost:3000` to use the app.

## Running the App

### Option 1: Full Docker Setup

The project includes a `docker-compose.yml` for a full-stack setup. To run the app using Docker:

```bash
docker-compose up --build
```

This will start the Rails server, the PostgreSQL database, and any other services defined in the compose file. Visit `http://localhost:3000` to access the app.

### Option 2: Local Rails with Docker DB

If you prefer running Rails locally but using Docker for the database:

1. Start the database container:

```bash
docker-compose up db
```

2. Run Rails locally:

```bash
bin/dev
```

Visit `http://localhost:3000` to access the app.


## Testing
- Automated tests using **RSpec** for models, controllers
- Linters included: **RuboCop**, **ERB Lint**, **ESLint** for JavaScript
- CI configured to run tests and linters on each push

**Note:** Some tests were used primarily to validate jobs and services rather than full integration, focusing on maintainable and modular test coverage.

## AI Tools and Workflow Assistance
During development, **AI tools** were used thoughtfully to improve workflow:

- **ChatGPT**: Helped review code, refactor tests, configure Turbo/Hotwire setups, and provide step-by-step guidance for integrating frontend components.

All AI suggestions were reviewed manually to ensure code quality, maintainability, and alignment with best practices.

