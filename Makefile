COMPOSER := ./composer
PHP_EXTENSION := $(shell php -m | grep xsl)
GIT := $(shell basename $(shell which git))
all: vendor phpcs-security-audit
	@echo 'Install everything'

vendor: check composer
	@echo 'Install dependencies';
	$(COMPOSER) install

update: check composer
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

composer:
	@echo 'Install composer';
	$(shell curl -sS https://getcomposer.org/installer | php > /dev/null 2>&1)
	$(shell mv ./composer.phar composer)

phpcs-security-audit:
	@git clone https://github.com/Pheromone/phpcs-security-audit.git
	@ln -s `pwd`/phpcs-security-audit/Security vendor/squizlabs/php_codesniffer/CodeSniffer/Standards/Security

help:
	@echo 'all: Create everything'
	@echo 'vendor: Create vendor directory (run composer install)'
	@echo 'update: Update vendor directory (run composer update)'
	@echo 'check: Check dependencies'
	@echo 'phpcs-security-audit: install dependencies for check security'
	@echo 'clean: Remove vendor, composer'

clean:
	@echo 'Remove vendor folder and composer'
	rm -rf vendor
	rm -rf composer
	rm -rf phpcs-security-audit
	rm -rf bin

.PHONY: clean update check help

