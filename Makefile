LIBDIR := lib
include $(LIBDIR)/main.mk

$(LIBDIR)/main.mk:
ifneq (,$(shell grep "path *= *$(LIBDIR)" .gitmodules 2>/dev/null))
	git submodule sync
	git submodule update --init
else
ifneq (,$(wildcard $(ID_TEMPLATE_HOME)))
	ln -s "$(ID_TEMPLATE_HOME)" $(LIBDIR)
else
	git clone -q --depth 10 -b main \
	    https://github.com/martinthomson/i-d-template $(LIBDIR)
endif
endif

CDDL := $(wildcard cddl2/kat/*.cddl)
CDDL += $(wildcard cddl2/pat/*.cddl)
CDDL += $(wildcard cddl2/cab/*.cddl)

DIAG := $(wildcard cddl2/kat/*.diag)
DIAG += $(wildcard cddl2/pat/*.diag)
DIAG += $(wildcard cddl2/cab/*.diag)

$(drafts_xml): cddl

.PHONY: cddl
cddl: $(CDDL) $(DIAG) ; $(MAKE) -C cddl2

lint:: cddl

clean:: ; $(MAKE) -C cddl2 clean
