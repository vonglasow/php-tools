COMPOSER := $(shell curl -sS https://getcomposer.org/installer | php > /dev/null 2>&1 ; echo './composer.phar')
vendor:
	@echo 'Install dependencies';
	$(COMPOSER) install
update:
	@echo 'Update vendor';
	$(COMPOSER) update
clean:
	@echo 'Remove vendor and praspel folders'
	rm -rf vendor
.PHONY: clean update

