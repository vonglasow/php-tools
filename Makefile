COMPOSER := ./composer.phar
PHP_EXTENSION := $(shell php -m | grep xsl)
vendor: check composer.phar
	@echo 'Install dependencies';
	$(COMPOSER) install
update: check composer.phar
	@echo 'Update vendor';
	$(COMPOSER) update
check:
ifneq ($(PHP_EXTENSION),xsl)
	@echo "Please install php5-xsl before"
	@exit 2
endif
composer.phar:
	@echo 'Install composer';
	$(shell curl -sS https://getcomposer.org/installer | php > /dev/null 2>&1)
security-cs:
	@git clone https://github.com/Pheromone/phpcs-security-audit.git
clean:
	@echo 'Remove vendor folder and composer'
	rm -rf vendor
	rm -rf composer.phar
.PHONY: clean update

