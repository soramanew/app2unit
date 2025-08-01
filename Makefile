DESTDIR ?=
SHELL = /bin/sh
prefix ?= /usr/local
exec_prefix ?= $(prefix)
bindir ?= $(exec_prefix)/bin
datarootdir ?= $(prefix)/share
mandir ?= $(datarootdir)/man
man1dir ?= $(mandir)/man1

app2unit.1:
	@type scdoc >/dev/null || { echo "scdoc not found in PATH" >&2; exit 127; }
	@type gzip >/dev/null || { echo "gzip not found in PATH" >&2; exit 127; }
	scdoc < app2unit.1.scd | gzip -c > app2unit.1.gz

.PHONY: all
all: app2unit.1

.PHONY: clean
clean:
	rm -f app2unit.1.gz

.PHONY: install-man
install-man: app2unit.1
	install -Dpm644 app2unit.1.gz -t $(DESTDIR)$(man1dir)

.PHONY: install-bin
install-bin:
	install -Dpm755 app2unit -t $(DESTDIR)$(bindir)
	ln -sfT app2unit $(DESTDIR)$(bindir)/app2unit-open
	ln -sfT app2unit $(DESTDIR)$(bindir)/app2unit-open-scope
	ln -sfT app2unit $(DESTDIR)$(bindir)/app2unit-open-service
	ln -sfT app2unit $(DESTDIR)$(bindir)/app2unit-term
	ln -sfT app2unit $(DESTDIR)$(bindir)/app2unit-term-scope
	ln -sfT app2unit $(DESTDIR)$(bindir)/app2unit-term-service

.PHONY: install
install: install-bin install-man

.PHONY: uninstall
uninstall:
	rm -f $(DESTDIR)$(bindir)/app2unit
	rm -f $(DESTDIR)$(bindir)/app2unit-open
	rm -f $(DESTDIR)$(bindir)/app2unit-open-scope
	rm -f $(DESTDIR)$(bindir)/app2unit-open-service
	rm -f $(DESTDIR)$(bindir)/app2unit-term
	rm -f $(DESTDIR)$(bindir)/app2unit-term-scope
	rm -f $(DESTDIR)$(bindir)/app2unit-term-service

	rm -f $(DESTDIR)$(man1dir)/app2unit.1.gz
