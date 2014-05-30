PREFIX=/usr/local
BINDIR=$(PREFIX)/bin
MANDIR=$(PREFIX)/share/man
DOCDIR=$(PREFIX)/share/doc/rudix

test:
	python -c 'import rudix'
	python tests.py

rudix.pdf: rudix.1
	groff  -Tps  -mandoc -c rudix.1 > rudix.ps
	pstopdf rudix.ps -o rudix.pdf

install: test rudix.pdf
	install -d $(DESTDIR)/$(BINDIR)
	install -m 755 rudix.py $(DESTDIR)/$(BINDIR)/rudix
	install -d $(DESTDIR)/$(MANDIR)/man1
	install -m 644 rudix.1 $(DESTDIR)/$(MANDIR)/man1/rudix.1
	install -d $(DESTDIR)/$(DOCDIR)
	install -m 644 rudix.pdf $(DESTDIR)/$(DOCDIR)

uninstall:
	rm -f $(BINDIR)/rudix
	rm -f $(MANDIR)/man1/rudix.1
	rm -f $(DOCDIR)/rudix.pdf

clean:
	rm -f *~ *.pyc *.ps *.pdf
