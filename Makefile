.PHONY: clean rpm sources srpm

PACKAGE := python-oath
VERSION := $(shell rpm -q --qf "%{version}\n" --specfile $(PACKAGE).spec | head -1 || python setup.py --version)
RELEASE := $(shell rpm -q --qf "%{release}\n" --specfile $(PACKAGE).spec | head -1 ||:)

sources:
	git archive --format=tar --prefix="$(PACKAGE)-$(VERSION)/" \
		$(shell git rev-parse --verify HEAD) | gzip > "$(PACKAGE)-$(VERSION).tar.gz"

srpm: sources
	rpmbuild -bs --define "_sourcedir $(CURDIR)" \
		--define "_srcrpmdir $(CURDIR)" $(PACKAGE).spec

rpm: srpm
	rpmbuild --rebuild $(PACKAGE)-$(VERSION)-$(RELEASE).src.rpm

clean:
	rm -rf oath/*.pyc
	rm -rf $(PACKAGE)-*.tar.gz *.egg *.src.rpm "../$(PACKAGE)_$(VERSION).orig.tar.gz"
