SHELL := /bin/bash

%.cbor: %.diag ; diag2cbor.rb $< > $@

ifndef CDDL
  $(error CDDL must be set when including rules.mk)
endif

DIAG := $(wildcard ex-*.diag)
CBOR := $(DIAG:.diag=.cbor)

all: check-schema check-examples

check-schema: ; @cddl <(cddlc -t cddl -2 $(CDDL)) g 1

check-examples: $(CBOR)
	@for t in $(CBOR) ; do \
		echo ">> checking $$t" ; \
		cddl <(cddlc -t cddl -2 $(CDDL)) v $$t || exit 1 ; \
	done

clean: ; rm -f $(CBOR)
