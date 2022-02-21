SRC_DIR="src/"
SRC_FILES= $(shell find $(SRC_DIR) -name "*.php")

dist/php-snake.phar: vendor box.json.dist tools/box.phar bin/console $(SRC_FILES) composer.lock
	./tools/box.phar compile --quiet

tools/box.phar:
	wget --directory-prefix=tools --quiet https://github.com/humbug/box/releases/download/3.16.0/box.phar
	chmod +x tools/box.phar

tools/php-cs-fixer.phar:
	wget --directory-prefix=tools --quiet https://github.com/FriendsOfPHP/PHP-CS-Fixer/releases/latest/download/php-cs-fixer.phar
	chmod +x tools/php-cs-fixer.phar

tools/phpstan.phar:
	wget --directory-prefix=tools --quiet https://github.com/phpstan/phpstan/releases/latest/download/phpstan.phar
	chmod +x tools/phpstan.phar

cs: vendor tools/php-cs-fixer.phar tools/phpstan.phar
	tools/php-cs-fixer.phar fix --dry-run --diff
	tools/phpstan.phar analyze --level=7 --no-progress bin/ src/

vendor:
	composer install --optimize-autoloader --no-dev --no-suggest --quiet

fix-cs: tools/php-cs-fixer.phar
	tools/php-cs-fixer.phar fix

dist: dist/php-snake.phar

clean:
	rm -Rf tools/ dist/ vendor/

.PHONY: clean phpcs fix-cs vendor
