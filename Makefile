COMPOSER := ./composer.phar
PHP_EXTENSION := $(shell php -m | grep xsl)
GIT := $(shell basename $(shell which git))
vendor: check composer.phar
	@echo 'Install dependencies';
	$(COMPOSER) install

update: check composer.phar
	@echo 'Update vendor';
	$(COMPOSER) update

check:
	@echo 'Check dependencies'
ifeq ($(PHP_EXTENSION)$(GIT),xslgit)
	@echo 'Dependencies are installed!'
else
	@echo 'Please install php5-xsl, git before'
	@exit 2
endif

composer.phar:
	@echo 'Install composer';
	$(shell curl -sS https://getcomposer.org/installer | php > /dev/null 2>&1)

security-cs:
	@git clone https://github.com/Pheromone/phpcs-security-audit.git

help:
	@echo 'vendor: Create vendor directory (run composer install)'
	@echo 'update: Update vendor directory (run composer update)'
	@echo 'check: Check dependencies'
	@echo 'security: install dependencies for check security'
	@echo 'clean: Remove vendor, composer'

clean:
	@echo 'Remove vendor folder and composer'
	rm -rf vendor
	rm -rf composer.phar

.PHONY: clean update check help security-cs

