.PHONY: clean sources

PACKAGE := python-oath
VERSION := $(shell sed -n s/[[:space:]]*Version:[[:space:]]*//p $(PACKAGE).spec)


sources: clean
	@git archive --format=tar --prefix="$(PACKAGE)-$(VERSION)/" \
		$(shell git rev-parse --verify HEAD) | gzip > "$(PACKAGE)-$(VERSION).tar.gz"

clean:
	@rm -rf build dist $(PACKAGE).egg-info $(PACKAGE)-*.tar.gz *.egg *.src.rpm
