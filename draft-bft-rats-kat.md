---
v: 3

title: "Key Attestation Token"
abbrev: "KAT"
docname: draft-bft-rats-kat-latest
category: info
consensus: true
submissionType: IETF

ipr: trust200902
area: "Security"
workgroup: "Remote ATtestation ProcedureS"
keyword: [ evidence, key attestation, TLS ]

stand_alone: yes
smart_quotes: no
pi: [toc, sortrefs, symrefs]

author:
 - name: Mathias Brossard
   organization: arm
   email: mathias.brossard@arm.com
 - name: Thomas Fossati
   organization: arm
   email: thomas.fossati@arm.com
 - name: Hannes Tschofenig
   organization: arm
   email: hannes.tschofenig@arm.com

normative:
  I-D.tschofenig-rats-psa-token: psa-token
  I-D.ietf-rats-eat: eat
  I-D.frost-rats-eat-collection: eat-coll
  RFC8610: cddl
  RFC8747: cwt-pop
  RFC9165: cddlplus
  STD94:
    -: cbor
    =: RFC8949
  STD96:
    -: cose
    =: RFC9052

informative:
  I-D.ietf-rats-architecture: rats-arch

--- abstract

This document defines an evidence format for key attestation.

--- middle

# Introduction

This document defines an evidence format for key attestation.

TODO

# Conventions and Definitions

{::boilerplate bcp14-tagged}

In this document, CDDL {{-cddl}} {{-cddlplus}} is used to describe the
data formats.

The examples in {{examples}} use CBOR diagnostic notation defined in {{Section
8 of -cbor}} and {{Appendix G of -cddl}}.

The reader is assumed to be familiar with the vocabulary and concepts
defined in {{-rats-arch}}.

# Key Attesatation Token

## Proof-of-Possession

{{-cwt-pop}}

KAS is the Issuer
TLS-B is the Presenter
TLS-A is the Recipient

~~~ cddl
{::include cddl/kat.cddl}
~~~
{: #fig-kat-cddl artwork-align="left"
   title="KAT definition"}

## KAT Bundle

{{-eat-coll}}

~~~ cddl
{::include cddl/eat-collection.cddl}
~~~
{: #fig-kat-bundle-cddl artwork-align="left"
   title="KAT bundle definition"}

# Examples {#examples}

~~~ cbor-diag
{::include cddl/examples/kat-1.diag}
~~~
{: #fig-example-kat artwork-align="left"
   title="KAT"}

# Security Considerations

TODO Security

# IANA Considerations

TODO IANA

--- back

# Amalgamated CDDL

~~~ cddl
{::include cddl/kat-bundle-autogen.cddl}
~~~

# Acknowledgments
{:numbered="false"}

TODO acknowledge.
