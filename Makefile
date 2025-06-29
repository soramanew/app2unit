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
	install -Dpm644 app2unit.1.gz -t $(man1dir)

.PHONY: install-bin
install-bin:
	install -Dpm755 app2unit -t $(bindir)
	ln -s app2unit $(bindir)/app2unit-open
	ln -s app2unit $(bindir)/app2unit-open-scope
	ln -s app2unit $(bindir)/app2unit-open-service
	ln -s app2unit $(bindir)/app2unit-term
	ln -s app2unit $(bindir)/app2unit-term-scope
	ln -s app2unit $(bindir)/app2unit-term-service

.PHONY: install
install: install-bin install-man

.PHONY: uninstall
uninstall:
	rm -f $(bindir)/app2unit
	rm -f $(bindir)/app2unit-open
	rm -f $(bindir)/app2unit-open-scope
	rm -f $(bindir)/app2unit-open-service
	rm -f $(bindir)/app2unit-term
	rm -f $(bindir)/app2unit-term-scope
	rm -f $(bindir)/app2unit-term-service

	rm -f $(man1dir)/app2unit.1.gz
