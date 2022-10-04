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
  I-D.frost-rats-eat-collection: coll
  RFC8610: cddl
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

~~~ cddl
start = []
~~~
{: #fig-cddl artwork-align="left"
   title="CDDL definition"}

# Examples {#examples}

~~~ cbor-diag
[]
~~~
{: #fig-example-TODO artwork-align="left"
   title="TODO"}

# Security Considerations

TODO Security

# IANA Considerations

TODO IANA

--- back

# Acknowledgments
{:numbered="false"}

TODO acknowledge.

-- vim: tw=72 ts=4 sw=4 et
