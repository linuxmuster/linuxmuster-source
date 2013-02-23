#!/usr/bin/make
# Zur Erstellung des Debian-Pakets notwendig (make DESTDIR=/root/sophomorix)
# Created by Rüdiger Beck (jeffbeck-at-web.de)
DESTDIR=

BIN=$(DESTDIR)/usr/bin
SHARE=$(DESTDIR)/usr/share/linuxmuster-source
GITHUB=$(DESTDIR)/usr/share/linuxmuster-source/repos/github

help:
	@echo ' '
	@echo 'Most common options of this Makefile:'
	@echo '-------------------------------------'
	@echo ' '
	@echo '   make help'
	@echo '      show this help'
	@echo ' '
	@echo '   make install'
	@echo '      install all stuff'
	@echo ' '
	@echo '   make deb'
	@echo '      create a debian package'
	@echo ' '


install:
	@echo '   * Installing scripts'
	@install -d -m0755 -oroot -groot $(BIN)
	@install -oroot -groot --mode=0755 scripts/linuxmuster-source $(BIN)
	@echo '   * Installing repo lists'
	@install -d -m0755 -oroot -groot $(SHARE)
	@install -d -m0755 -oroot -groot $(SHARE)/examples
	@install -oroot -groot --mode=0644 config/example.linuxmuster-source.conf $(SHARE)/examples
	@install -oroot -groot --mode=0644 config/ssh-config $(SHARE)/examples
	@install -d -m0755 -oroot -groot $(GITHUB)/linuxmuster
	@install -d -m0755 -oroot -groot $(GITHUB)/jeffbeck
	@install -oroot -groot --mode=0644 repos/github/linuxmuster/*.list $(GITHUB)/linuxmuster
	@install -oroot -groot --mode=0644 repos/github/jeffbeck/*.list $(GITHUB)/jeffbeck



# build a package
deb:
	### deb
	@echo 'Did you do a dch -i ?'
	#@sleep 8
	dpkg-buildpackage -tc -uc -us -sa -rfakeroot
	@echo ''
	@echo 'Do not forget to tag this version in git'
	@echo ''


clean:
	### clean up
	rm -rf debian/linuxmuster-source