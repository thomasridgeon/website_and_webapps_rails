# My Website and Web Apps

This README documents my Rails-based website and web applications.

---

## Project History

This project began as a learning journey in **Ruby** using **Sinatra**, a minimal web framework.

- **Static pages and simple apps** were built using **classic Sinatra style**. This required manually configuring controllers, views, and routes, giving a deep understanding of web frameworks under the hood.
- For a more **complex app** — the Encrypted Journal — I moved to **modular Sinatra** to handle authentication, database-backed models, session management, and multi-route storage. 
- Challenges with **ActiveRecord integration** in Sinatra prompted migration to **Rails**, which provides:
  - Preconfigured database setup with ActiveRecord 
  - Convention-over-configuration for routes, controllers, and models 
  - Built-in support for sessions, authentication, and background jobs 
  - Faster development and more stable workflow 

Starting with Sinatra gave valuable hands-on experience configuring web apps from scratch and increased appreciation for how Rails accelerates development.

---

## Apps

### Port Charges Calculator
A simple web app designed for customs brokers in Barbados to calculate Barbados Port Charges.

### Solar D Calculator
A web app that calculates required sun exposure to synthesize an optimum daily dose of vitamin D (1,000 IU), based on age and skin type. 
> **Note:** On localhost, the IP-based geolocation fallback defaults to Barbados if the API cannot determine a location from your local machine’s IP.

### Encrypted Journal (in progress)
A CRUD application for creating and managing notes with AES encryption. 
- Session data is stored securely in the database (nothing in cookies or on the server). 
- Currently under development in Rails.

---

## Ruby Version

```text
Ruby 3.4.5
Rails 7.x.x
```

## System Dependencies
- PostgreSQL (for development and production)
- Bundler (gem install bundler)

## Configuration
Environment Variables

Create a .env file in the project root for local development:

```text
OPENAI_API_KEY=your_api_key_here
DATABASE_USER=your_postgres_user
DATABASE_PASSWORD=your_postgres_password
```

## Database Setup
Create database:

```bash
rails db:create
```

Migrate database:

```bash
rails db:migrate
```

## Running the App
Start the Rails server locally:

```bash
rails server
```

## Notes
- This project evolved from Sinatra to Rails, illustrating the differences between minimal and full-featured frameworks.

- Configuring routes, controllers, and database connections manually in Sinatra provided insight into how Rails simplifies and accelerates development.

- Inline comments in the codebase contain study notes from my learning process.
