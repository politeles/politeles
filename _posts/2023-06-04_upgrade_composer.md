# Upgrading to docker compose v2
There are several ways, but one of them is to update docker desktop.

## Automatically update the code:

just add a volumes tag, like in the example:

```yaml
version: '3.9'
services:
  orfeon:
    build:
     context: .
     dockerfile: dockerfile_updated
    volumes:
      - .:/var/www/html
    ports:
      - "8090:80"
    depends_on:
      - db
  db:
    image: "mysql:8.0.33" 
    ports:
      - "3306:3306"
    volumes:
      - ./db/:/docker-entrypoint-initdb.d/
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: supersafepass
      MYSQL_DATABASE: youruser
      MYSQL_USER: youruser
      MYSQL_PASSWORD: supersafepass
volumes:
  reserved:
```