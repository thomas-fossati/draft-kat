---
v: 3

title: "Key Attestation Token"
abbrev: "KAT"
docname: draft-fossati-rats-kat-latest
category: std
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
  I-D.fossati-tls-attestation:
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

# Terminology

{::boilerplate bcp14-tagged}

The following terms are used in this document:

- Root of Trust (RoT): A set of software and/or hardware components that need
to be trusted to act as a security foundation required for accomplishing the
security goals. In our case, the RoT is expected to offer the functionality
for attesting to the state of the platform and indirectly also to attest
the integrity of the IK (public as well as private key) and the confidentiality
IK private key.

- Attestation Key (AK): Cryptographic key belonging to the RoT that is only used
 to sign attestation tokens.

- Platform Attestation Key (PAK): An AK used specifically for signing attestation
tokens relating to the state of the platform.

- Key Attestation Key (KAK): An AK used specifically for signing KATs. In some
systems only a single AK is used. In that case the AK is used as a PAK and a KAK.

- Identity Key (IK): The IK consists of a private and a public key. The private
key is used by the usage protocol. The public key is included in the Key Attestation Token.

- Usage Protocol: A (security) protocol that allows demonstrating possession of the
private key.

- Attestation Token (AT): A collection of claims that a RoT assembles (and signs) with
the purpose of informing - in a verifiable way - relying parties about the identity and
state of the platform. Essentially a type of Evidence as per the RATS architecture
terminology {{-rats-arch}}.

- Platform Attestation Token (PAT): An AT containing claims relating to the security
state of the platform, including software constituting the platform trusted computing
base (TCB). The process of generating a PAT typically involves gathering data during
measured boot.

- Key Attestation Token (KAT): An AT containing a claim with a proof-of-possession
(PoP) key. The KAT may also contain other claims, such as those indicating its validity.
The KAT is signed by the KAK. The key attestation service, which is part of the platform
root of trust (RoT), conceptually acts as a local certification authority since the KAT
behaves like a certificate.

- Combined Attestation Bundle (CAB): A structure used to bundle a KAT and a PAT together
for transport in the usage protocol. If the KAT already includes a PAT, in form of a
nested token, then it already corresponds to a CAB.

- Presenter: Party that proves possession of a private key to a recipient of a KAT.

- Recipient: Party that receives the KAT containing the proof-of-possession key information
from the presenter.

- Key Attestation Service (KAS): The issuer that creates the KAT and bundles a KAT together
with a PAT in a CAB.

The reader is assumed to be familiar with the vocabulary and concepts defined in {{-rats-arch}}.

CDDL {{-cddl}} {{-cddlplus}} is used to describe the data formats
and the examples in {{examples}} use CBOR diagnostic notation defined
in {{Section 8 of -cbor}} and {{Appendix G of -cddl}}.

# Architecture

Key attestation is an extension to the attestation functionality described in {{-rats-arch}}. 
We describe this conceptually by splitting the internals of the attester into a two parts, 
platform attestation and key attestation. This is shown in {{fig-arch}}. These are logical
roles and implementations may combine them into a single physical entity. 

Security-sensitive functionality, like attestation, has to be placed into
the trusted computing base. Since the trusted computing base itself may support different 
isolation layers, the design allows platform attestation to be separated from key attestation
whereby platform attestation requires more privilege than the key attestation code.
Cryptographic services, used by key attestation and by platform attestation, are separated
although not shown in the figure.

The protocol used for communication between the Presenter and the Recipient is referred as 
usage protocol. The usage protocol, which is outside the scope of this specification, needs to
support proof-of-possession of the private key (explained further below). An example
usage protocol is TLS with the extension defined in {{I-D.fossati-tls-attestation}}.

~~~aasvg
 +----------------------------------+ .
 | Attester                         | .
 |                                  | .
 | +-------------+  +-------------+ | .
 | | Key         |  | Platform    | | .
 | | Attestation |  | Attestation | | .
 | | Service     |  | Service     | | .
 | +-------------+  +-------------+ | .
 +----------------------------------+ .
       ^                              .
       |                              .
       |       Trusted Computing Base .
.......|...............................
       |
       |
       v
 +-----------------+                 +-----------------+
 |                 |                 |                 |
 |   Presenter     | Usage Protocol  |   Recipient     |
 |                 |---------------->|                 |
 +-----------------+                 +-----------------+
~~~
{: #fig-arch title="Architecture"}

The Presenter triggers the generation of the IK. The IK
consists of a public key (pkT) and a private key (skT).
The Presenter may, for example, use the following API call
to trigger the generation of the key pair for a given 
algorithm and to obtain a key handle (key_id).

~~~~
key_id = GenerateKeyPair(alg_id)
~~~~

The private key is created and stored such that it is only
accessible to the KAS rather than to the Presenter.

Next, the KAS needs to trigger the creation of the Platform
Attestation Token (PAT) by the Platform Attestation Service.
The PAT needs to be linked to the Key Attestation Token (KAT)
and this linkage can occur in a number of ways. One approach
is described in this specification in {{bundle}}. The Key 
Attestation Token (KAT) includes the public key of the IK 
(pkT) and is then signed with the Key Attestation Key (KAK).

To ensure freshness of the PAT and the KAT a nonce is used,
as suggested by the RATS architecture {{-rats-arch}}. Here
is the symbolic API call to request a KAT and a PAT, which
are concatinated together as the CAB.

~~~~
cab = createCAB(key_id, nonce)
~~~~

Once the CAB has been sent by the Presenter to the Recipient,
the Presenter has to demonstrate possession of the private key.
The signature operation uses the private key of the IK (skT).
How this proof-of-possession of the private key is accomplished
depends on the details of the usage protocol and is outside the
scope of this specification.

The Recipient of the CAB and the proof-of-possession data (such
as a digital signature) first extracts the PAT and the KAT. The
PAT and the KAT may need to be conveyed to a Verifier. If the 
PAT is in the form of attestation results the checks can be 
performed locally at the Recipient, whereby the following checks
are made:

- The signature protecting the PAT MUST pass verification when 
using available trust anchor(s).
- The chaining of PAT and KAT MUST be verified. The detailed
verification procedure depends on the chaining mechanism
utilized.
- The claims in the PAT MUST be matched against stored reference
values.
- The signature protecting the KAT MUST pass verification.
- The KAT MUST be checked for replays using the nonce included in
the KAT definition (see {{fig-kat-cddl}}).

Once all these steps are completed, the verifier produces the 
attestation result and includes (if needed) the IK public key (pkT).


# Key Attestation Token Format

## Proof-of-Possession

The KAT utilizes the proof-of-possession functionality defined in
{{-cwt-pop}} to encode the public key of the IK (pkT).

~~~ cddl
{::include cddl/kat.cddl}
~~~
{: #fig-kat-cddl artwork-align="left"  title="KAT Definition"}

## KAT-PAT Bundle {#bundle}

{{-eat-coll}}

~~~ cddl
{::include cddl/eat-collection.cddl}
~~~
{: #fig-kat-bundle-cddl artwork-align="left"  title="KAT Bundle Definition"}

TBD: Describe linkage technique between KAT and PAT.

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
