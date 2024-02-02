# Book API

Simple API for consumer`s books management.

## Prerequisites

Make sure you have the following installed on your machine:

- [Docker](https://www.docker.com/get-started)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Getting Started

1. Clone the repository:

    ```bash
    git clone https://github.com/yeppooss/book_api.git
    ```

2. Navigate to the project directory:

    ```bash
    cd book_api
    ```

3. Build the Docker image:

    ```bash
    docker-compose build
    ```

4. Create the database and run migrations:

    ```bash
    docker-compose run rails rake db:create
    docker-compose run rails rake db:migrate
    ```

5. Start the application:

    ```bash
    docker-compose up
    ```

The application will be accessible at `http://localhost:3000`.

You will have an API docs at `http://localhost:3000/api-docs`.


## Testing

1. For run tests:

    ```bash
    docker-compose run rails bundle exec rspec .
    ```
