# rickpeyton.com

My personal website. Primarily for archiving recipes and interesting programming articles.

## Docker

Development

```
docker run --rm -it --name mysql57 -e MYSQL_ROOT_PASSWORD=password -d -p 3306:3306 mysql:5.7
docker build -t rickpeyton .
docker run --rm -it --env-file .env.dev -p 8080:80 -v $(pwd):/var/www/html rickpeyton
```

Staging

`docker run --rm -it --env-file .env.staging -p 8080:80 -v $(pwd):/var/www/html rickpeyton`

## Environment variables

Set the following variables in `.env.dev`

```.env
PORT=80

WORDPRESS_DB_HOST=host.docker.internal:3306
WORDPRESS_DB_USER=root
WORDPRESS_DB_PASSWORD=password
WORDPRESS_DB_NAME=wordpress

# Regenerate at https://api.wordpress.org/secret-key/1.1/salt/
WORDPRESS_AUTH_KEY=8f17abd5cdd353f9d9e6be3fad011527ed26ea02
WORDPRESS_SECURE_AUTH_KEY=ec483b5b09823f666475de019b2fe31e7597e060
WORDPRESS_LOGGED_IN_KEY=93a8b98138e1be14ddc0ca4a8bae97676535a3ef
WORDPRESS_NONCE_KEY=e9ce6118d5e163c854c6b2e046ae5185ffe59d76
WORDPRESS_AUTH_SALT=67e8bc04fe60ff2d81b49ecb33d1972591a936bf
WORDPRESS_SECURE_AUTH_SALT=89147a12f229184a7d0e103f2b8d8d9762131bb3
WORDPRESS_LOGGED_IN_SALT=489566014f123bcd336fcd38fe27fa7f22b4c01c
WORDPRESS_NONCE_SALT=3487fa7f88b8f49987c9337c41ddeafc547557ac

AS3CF_ACCESS_KEY_ID=
AS3CF_SECRET_ACCESS_KEY=
```

# Notes

Resolve the following Heroku error [Github Issue](https://github.com/docker-library/wordpress/issues/293)

`apache2: Configuration error: More than one MPM loaded.`

with

`heroku labs:enable --app=YOUR-APP runtime-new-layer-extract`

Performing database backups and dumps

Jump into an appropriate container
`docker run --rm -it mysql:5.5 bash`

Backup
`mysqldump -hHOST -uUSER -pPASSWORD DATABASE > dump.sql`

Import
`mysql -hHOST -uUSER -pPASSWORD --database=DATABASE < dump.sql`

Helpful SQL

```sql
UPDATE wp_options
SET option_value = REPLACE(option_value, 'http://localhost:8080', 'https://rickpeyton-staging.herokuapp.com')
WHERE INSTR(option_value, 'http://localhost:8080') > 0;
```

```sql
UPDATE wp_postmeta
SET meta_value = REPLACE(meta_value, '//localhost:8080', '//rickpeyton-staging.herokuapp.com')
WHERE INSTR(meta_value, '//localhost:8080') > 0;
```

```sql
UPDATE wp_posts
SET post_content = REPLACE(post_content, 'http://localhost:8080', 'https://rickpeyton-staging.herokuapp.com')
WHERE INSTR(post_content, 'http://localhost:8080') > 0;
```
