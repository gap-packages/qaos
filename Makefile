# Generated automatically from Makefile.in by configure.
srcdir = .
recurs = doc
RM = rm -f

all: config.status doc mods
	for i in $(recurs); do \
	(cd $$i && $(MAKE) $(RECURSIVE_MAKE_ARGS) $@); \
	done

.PHONY:	doc
doc:
	for i in $(recurs); do \
	(cd $$i && $(MAKE) $(RECURSIVE_MAKE_ARGS) $@); \
	done

.PHONY: mostlyclean clean distclean realclean extraclean
clean:
	for i in $(recurs); do \
	(cd $$i && $(MAKE) $(RECURSIVE_MAKE_ARGS) $@); \
	done

distclean: clean
	$(RM) -R autom4te.cache
	$(RM) config.status config.log confdefs.h config-tmp-* build-install

realclean: clean distclean
	$(RM) configure PackageInfo.g

mods:
	chmod a+rX *

$(srcdir)/config.status: $(srcdir)/configure
	cd $(srcdir) && $(SHELL) ./configure
$(srcdir)/configure: $(srcdir)/configure.ac
	cd $(srcdir) && autoconf


# Tell versions [3.59,3.63) of GNU make to not export all variables.
# Otherwise a system limit (for SysV at least) may be exceeded.
.NOEXPORT:
