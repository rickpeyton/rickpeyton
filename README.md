# rickpeyton.com

My personal website. Primarily for archiving recipes and interesting programming articles.

## Docker

Development

```
docker run --rm -it --name mysql57 -e MYSQL_ROOT_PASSWORD=password -d -p 3306:3306 mysql:5.7
docker build -t rickpeyton .
docker run --rm -it --env-file .env.dev -p 8080:80 -v $(pwd):/var/www/html rickpeyton
```

## Environment variables

Set the following variables in `.env.dev`

```.env
WORDPRESS_DB_HOST=host.docker.internal:3306
WORDPRESS_DB_USER=root
WORDPRESS_DB_PASSWORD=password
WORDPRESS_DB_NAME=wordpress
```