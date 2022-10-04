.DEFAULT_GOAL := check

SHELL := /bin/bash

include func.mk
include frag.mk

check:: check-kat-bundle check-kat-bundle-examples
check:: check-kat check-kat-examples
check:: check-kat-sign1 check-kat-sign1-examples
check:: check-psa-token check-psa-token-examples

$(eval $(call cddl_check_template,kat-bundle,$(KAT_BUNDLE_FRAGS),$(KAT_BUNDLE_EXAMPLES)))
$(eval $(call cddl_check_template,kat,$(KAT_FRAGS),$(KAT_EXAMPLES)))
$(eval $(call cddl_check_template,kat-sign1,$(KAT_SIGN1_FRAGS),$(KAT_SIGN1_EXAMPLES)))
$(eval $(call cddl_check_template,psa-token,$(PSA_TOKEN_FRAGS),$(PSA_TOKEN_EXAMPLES)))

clean: ; rm -f $(CLEANFILES)
