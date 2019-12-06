FUNC=

api() {
	docker exec -it api-container bash
}

install() {
	docker exec -it api-container bash -c "php app/Install.php"
}

db() {
	docker exec -it db-container mysql -u root --password="admin" intend
}

srv() {
	docker exec -it srv-container bash
}

app() {
	docker exec -it app-container bash
}

composer_autoload() {
	docker run --rm -v $(pwd)/api:/app composer/composer dump-autoload
}

reset_db() {
	docker exec -it api-container php artisan --force migrate:fresh --seed
	install
}

quit_disgracefully() { # internal method
	usage >&2
	exit 1
}

usage() { # internal method
cat << EOT
$(basename $0) - runs various convenience commands

Usage:
	--api
		Runs Bash in the API container
	-i
		Installs any modules not currently in the database
	-a | -v | --app | --vue
		Runs Bash in the app container
	-c | --ca | --composer | --composer-autoload
		Regenerates autoload files for the API
		(use after creating new database seed files)
	-d | --db | --database
		Runs a MySQL client in the database container
	-r | --reset | --reset-db
		Wipes the database, runs all migrations and seeds the database
	-s | --srv | --server
		Runs Bash in the server container
	-h | --help
		Prints this message
EOT
}

main() {
	case $1 in
		--api)
			FUNC="api";;
		-i)
			FUNC="install";;
		-a | -v | --app | --vue)
			FUNC="app";;
		-c | --ca | --composer | --composer-autoload)
			FUNC="composer_autoload";;
		-d | --db | --database)
			FUNC="db";;
		-r | --reset | --reset-db)
			FUNC="reset_db";;
		-s | --srv | --server)
			FUNC="srv";;
		-h | --help)
			usage;;
		*)
			quit_disgracefully
	esac

	eval $FUNC
}

main "$@"
