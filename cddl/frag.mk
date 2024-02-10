#
# kat-bundle
#
KAT_BUNDLE_FRAGS := start-kat-bundle.cddl
KAT_BUNDLE_FRAGS += cmw-collection.cddl
KAT_BUNDLE_FRAGS += kat.cddl
KAT_BUNDLE_FRAGS += kat-sign1.cddl
KAT_BUNDLE_FRAGS += psa-token.cddl
KAT_BUNDLE_FRAGS += psa-token-cose.cddl
KAT_BUNDLE_FRAGS += cose.cddl

KAT_BUNDLE_EXAMPLES :=

#
# kat
#
KAT_FRAGS := start-kat.cddl
KAT_FRAGS += kat.cddl
KAT_FRAGS += cose.cddl

KAT_EXAMPLES := $(wildcard examples/kat-*.diag)

#
# kat sign1
#
KAT_SIGN1_FRAGS := start-kat-sign1.cddl
KAT_SIGN1_FRAGS += kat-sign1.cddl
KAT_SIGN1_FRAGS += kat.cddl
KAT_SIGN1_FRAGS += cose.cddl

KAT_SIGN1_EXAMPLES :=

#
# psa-token
#
PSA_TOKEN_FRAGS := start-psa-token.cddl
PSA_TOKEN_FRAGS += psa-token.cddl
PSA_TOKEN_FRAGS += cose.cddl

PSA_TOKEN_EXAMPLES := $(wildcard examples/pat-*.diag)
