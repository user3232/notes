


# Cryptography

```
public key = publicated mapping of private(!) key
mapping inverse = possible but not known
solution = 2 ways
  brute way = compute inverse
  secret way = know secret, mapped secret and new transformation
```

## Shared secure secret - Diffie Hellman key exchange

Nice example is on [Wikipedia Diffie Hellman key exchange](https://en.wikipedia.org/wiki/Diffie%E2%80%93Hellman_key_exchange) article.

Idea is as fallows:

* One way to know transformation of two secrets is to know
  both secrets and transformation process.
* Other way is to know one secret and transformation of
  other secret and transformation of those.
* If reverse complexity of any of above transformation processes grows
  at least exponentialy with linear growth of transformation parameters
  than secret is save.


Diffie Hellman key exchange scheme works because:

First there is many valued function $f_{p,g}(s)$ which $f$
maps some (secret) number s. For Diffe Helman this function
is:

$$f_{p,g}(s) = g^s \bmod p $$

Second, inverse of this function is at least exponentially 
complex. Every addition of one digit to g means much more 
numbers to check [[Wikipedia](https://en.wikipedia.org/wiki/Discrete_logarithm#Algorithms)]:

> A general algorithm for computing logb a in finite groups
> G is to raise b to larger and larger powers k until the
> desired a is found. This algorithm is sometimes called
> trial multiplication. It requires running time linear in
> the size of the group G and thus exponential in the number
> of digits in the size of the group. Therefore, it is an
> exponential-time algorithm, practical only for small
> groups G.

See also [records](https://en.wikipedia.org/wiki/Discrete_logarithm_records).


Third, there is alternative way of $f$ mapping of
multiplication of two (secret) numbers $s_1$ and $s_2$ using
$f$ mapped $s_1$ or $s_2$:
 
$$ f_{p,g}(s_1 s_2) = g^{s_1 s_2} \bmod p $$
$$ f_{p, f_{p,g}(s_1)}(s_2) = (g^{s_1} \bmod p)^{s_2} \bmod p $$
$$ f_{p, f_{p,g}(s_2)}(s_1) = (g^{s_2} \bmod p)^{s_1} \bmod p $$
$$ f_{p,g}(s_1 s_2) = f_{p, f_{p,g}(s_1)}(s_2) = f_{p, f_{p,g}(s_2)}(s_1) $$

```javascript
let p = 13n;
console.log(`> Modulus is prime = ${p}`);
let g = 17n;
console.log(`> Exponent base is = ${g}`);
let s_1 = 11n; 
console.log(`> First secret is  = ${s_1}`);
let s_2 = 15n;
console.log(`> Second secret is = ${s_2}`);

let fgp = (g, p, s) => g**s % p;

let S_12 = fgp(g, p, s_1*s_2);
console.log(`
> Common mapped secret knowing 
  both secrets is = ${S_12}`);


let S_1 = fgp(g, p, s_1);
let S_2 = fgp(g, p, s_2);
let S_12_1 = fgp(S_2, p, s_1);
console.log(`
> Common mapped secret knowing first secret 
  and mapping of second secret is = ${S_12_1}`);
let S_12_2 = fgp(S_1, p, s_2);
console.log(`
> Common mapped secret knowing second secret 
  and mapping of first secret is  = ${S_12_2}`);

console.assert(S_12 === S_12_1);
console.assert(S_12 === S_12_2);
/*
> Modulus is prime = 13
> Exponent base is = 17
> First secret is  = 11
> Second secret is = 15

> Common mapped secret knowing 
  both secrets is = 12

> Common mapped secret knowing first secret 
  and mapping of second secret is = 12

> Common mapped secret knowing second secret 
  and mapping of first secret is  = 12
*/
```


This way f mapped multiplication of (secret) numbers can be
computed knowing only one of (secret) numbers, where other
is not know explicitly (it is f mapped and f mapping is many
valued). 

Using this scheme, if two partis choose secret number, they
dont need to explicitly schare their personal secret
numbers, but steel they are able to easly compute f mapping
of secret numbers multiplication, and this way it is also
secret!

### Comment

* $f_{\infty, g}$ is strictly monotonic and invertable
* $f_{p, 0}$ is constant
* Diffie Hellman key exchange is not immune to M man in the
  meedle; M can share one secret with first party, and other
  secret with second party, then M can allude first party
  that it shares secret with second party.


## RSA

https://en.wikipedia.org/wiki/RSA_(cryptosystem)

https://en.wikipedia.org/wiki/RSA_problem

The simplest form of RSA public-private key scheme is 
based on fallowing property:

$$
\left({\text{message}}^e\right)^d \bmod n = \text{message}
$$

This means that $e$ and $d$ are inverses:

$$
de \bmod n = 1
$$

given numbers $n$ and $e$ (or $d$) - which can be arbitrarly
choosen, it is generally computationally complex to find $d$
(or $e$) but if:

$$
n = pq
$$

where $p$ is prime and $q$ is also prime, efective algorithm
exists. It is example of [trap door one way function](https://en.wikipedia.org/wiki/Trapdoor_function).

This way there are two ways to find $d$ or *message*:
* computationally trivial when knowing *d* and ${\text{message}}^e$
* computationally simple when knowing *p*, *q*, *e*, ${\text{message}}^e$
* computationally complex when knowing *n*, *e*, ${\text{message}}^e$

### Sending secure message

* To encrypt message there is needed $e$, $n$ which are made
  public by Owner. Anyone can securly converse with Owner
* To decrypt message in resonable amount of time there is
  needed: encrypted message, $d$ and $n$

### Sending signed messages

Anyone can send Owner encoded message to private-public keys
Owner.  Only Owner can decrypt such a message.

To verify Anyone, this Anyone should: 

* send his/her public key and
* send encrypted (by Owner public key)
  * message, plus
  * encrypted by Anyone private key hash value of message

This way Owner will (using its private key) decrypt message
and encrypted message hash value. Than Owner will use Anyone
public key to decrypt message hash value. If decrypted
hash value is the same as computed (by Owner) hash value of 
message, than Anyone is someone with his/her public-private key.

Such scheme is possible because of property of RSA algorithm:

$$
h={\text{hash}}(m)
$$

$$
(h^{e})^{d} \bmod n = h^{ed} \bmod n = 
h^{de} \bmod n = (h^{d})^{e} \bmod n = 
h \bmod n
$$

## Sending symetric key

https://en.wikipedia.org/wiki/Key_encapsulation

The traditional approach to sending a symmetric key with
public key systems is to first generate a random symmetric
key and then encrypt it using the chosen public key
algorithm. The recipient then decrypts the public key
message to recover the symmetric key. As the symmetric key
is generally short, padding is required for full security

## Authenticated encryption

https://en.wikipedia.org/wiki/Authenticated_encryption#Authenticated_encryption_with_associated_data

Authenticated encryption (AE) and authenticated encryption
with associated data (AEAD) are forms of encryption which
simultaneously assure the confidentiality and authenticity
of data. 

A typical programming interface for an AE implementation
provides the following functions:

* Encryption
  * Input: plaintext, key, and optionally a header in
    plaintext that will not be encrypted, but will be
    covered by authenticity protection.
  * Output: ciphertext and authentication tag (message
    authentication code).
* Decryption
  * Input: ciphertext, key, authentication tag, and
    optionally a header (if used during the encryption).
  * Output: plaintext, or an error if the authentication tag
    does not match the supplied ciphertext or header.

The header part is intended to provide authenticity and
integrity protection for networking or storage metadata for
which confidentiality is unnecessary, but authenticity is
desired. 

### Encrypt-then-MAC (EtM) approach


The plaintext is first encrypted, then a MAC is produced
based on the resulting ciphertext. The ciphertext and its
MAC are sent together. 

![Example](images/Authenticated_Encryption_EtM.png)


## Message authentication code

https://en.wikipedia.org/wiki/Message_authentication_code

In cryptography, a message authentication code (MAC),
sometimes known as a tag, is a short piece of information
used to authenticate a message—in other words, to confirm
that the message came from the stated sender (its
authenticity) and has not been changed. The MAC value
protects both a message's data integrity as well as its
authenticity, by allowing verifiers (who also possess the
secret key) to detect any changes to the message content. 

![Example MAC scheme](images/MAC.svg)

## Block cipher overview

https://en.wikipedia.org/wiki/Block_cipher

In cryptography, a block cipher is a deterministic algorithm
operating on fixed-length groups of bits, called blocks. It
uses an unvarying transformation, that is, it uses a
symmetric key. They are specified elementary components in
the design of many cryptographic protocols and are widely
used to implement the encryption of large amounts of data,
including data exchange protocols. 

Even a secure block cipher is suitable only for the
encryption of a single block of data at a time, using a
fixed key. A multitude of modes of operation have been
designed to allow their repeated use in a secure way, to
achieve the security goals of confidentiality and
authenticity. 


## Hash function

https://en.wikipedia.org/wiki/Hash_function

A hash function is any function that can be used to map data
of arbitrary size to fixed-size values. The values returned
by a hash function are called hash values, hash codes,
digests, or simply hashes.


## Padding

Padded can be blocks or stream

https://en.wikipedia.org/wiki/Padding_(cryptography)

In cryptography, padding is any of a number of distinct
practices which all include adding data to the beginning,
middle, or end of a message prior to encryption. In
classical cryptography, padding may include adding nonsense
phrases to a message to obscure the fact that many messages
end in predictable ways, e.g. sincerely yours. 

https://en.wikipedia.org/wiki/Optimal_asymmetric_encryption_padding

In cryptography, Optimal Asymmetric Encryption Padding
(OAEP) is a padding scheme often used together with RSA
encryption.


# Block cipher

https://en.wikipedia.org/wiki/Block_cipher

A block cipher consists of two paired algorithms, one for
encryption, $E$, and the other for decryption, $D$. Both
algorithms accept two inputs: an input block of size n bits
and a key of size k bits; and both yield an n-bit output
block. The decryption algorithm $D$ is defined to be the
inverse function of encryption, i.e., $D = E^{-1}$.

* For each key K, $E_K$ is a permutation (a bijective
  mapping) over the set of input blocks. 
* Each key selects one permutation from the set of $(2^n)!$
  possible permutations.


For example:, 
* a block cipher encryption algorithm might take a 128-bit
  block of plaintext as input, and output a corresponding
  128-bit block of ciphertext. The exact transformation is
  controlled using a second input – the secret key. 
* Decryption is similar: the decryption algorithm takes, in
  this example, a 128-bit block of ciphertext together with
  the secret key, and yields the original 128-bit block of
  plain text.

## Implementation

The modern design of block ciphers is based on the concept
of an iterated product cipher.  Product ciphers are means of
combining simple operations such as substitutions and
permutations. Iterated product ciphers carry out encryption
in multiple rounds, each of which uses a different subkey
derived from the original key. One widespread implementation
of such ciphers, named a Feistel network after Horst
Feistel, is notably implemented in the DES cipher.

Many other realizations of block ciphers, such as the AES,
are classified as substitution–permutation networks.

## Substitution–permutation network

One important type of iterated block cipher known as a
substitution–permutation network (SPN) takes a block of the
plaintext and the key as inputs, and applies several
alternating rounds consisting of a substitution stage
followed by a permutation stage—to produce each block of
ciphertext output.

![SPN diagram](images/SubstitutionPermutationNetwork2.png)

A substitution box (S-box) substitutes a small block of
input bits with another block of output bits. This
substitution must be one-to-one, to ensure invertibility
(hence decryption). A secure S-box will have the property
that changing one input bit will change about half of the
output bits on average, exhibiting what is known as the
avalanche effect—i.e. it has the property that each output
bit will depend on every input bit.

## Feistel cipher

In a Feistel cipher, the block of plain text to be encrypted
is split into two equal-sized halves. The round function is
applied to one half, using a subkey, and then the output is
XORed with the other half. The two halves are then swapped.

## Cipher block chaining (CBC)

https://en.wikipedia.org/wiki/Block_cipher_mode_of_operation

In CBC mode, each block of plaintext is XORed with the
previous ciphertext block before being encrypted. This way,
each ciphertext block depends on all plaintext blocks
processed up to that point. To make each message unique, an
initialization vector must be used in the first block.

CBC has been the most commonly used mode of operation. Its
main drawbacks are that encryption is sequential (i.e., it
cannot be parallelized), and that the message must be padded
to a multiple of the cipher block size. One way to handle
this last issue is through the method known as ciphertext
stealing. 

# Security libraries

* [Comparison](https://en.wikipedia.org/wiki/Comparison_of_TLS_implementations)
* [OpenSSL](https://www.openssl.org/)
* [Tink](https://github.com/google/tink) A multi-language,
  cross-platform library that provides cryptographic APIs
  that are secure, easy to use correctly, and hard(er) to
  misuse.
  * [Tink JNI
    Examples](https://github.com/google-pay/tink-jni-examples)
    - sample codes use Java Native Interface (JNI) to create
    API bridge allowing Java code to be called by native
    applications written in other languages.

# Public key certificate

[Public Key Certificate](https://en.wikipedia.org/wiki/Public_key_certificate)

[Mozilla Root Store Policy](https://www.mozilla.org/en-US/about/governance/policies/security-group/certs/policy/)


In cryptography, a public key certificate, also known as a
digital certificate or identity certificate, is an
electronic document used to prove the ownership of a 
**public key**.

* In email encryption, code signing, and e-signature
  systems, a certificate's subject is typically a person or
  organization.
* In Transport Layer Security (TLS) a certificate's subject
  is typically a computer or other device, though TLS
  certificates may identify organizations or individuals in
  addition to their core role in identifying devices.
  * TLS is notable for being a part of HTTPS


Mechanizms:
* In a typical public-key infrastructure (PKI) scheme, the
  certificate issuer is a certificate authority (CA),
  usually a company that charges customers to issue
  certificates for them.
* By contrast, in a web of trust scheme, individuals sign
  each other's keys directly, in a format that performs a
  similar function to a public key certificate.

**The most common format for public key certificates is**
**defined by X.509**


## X.509 certificate common filds

https://en.wikipedia.org/wiki/X.509

Below are some of the most common fields in certificates.
Most certificates contain a number of fields not listed
here. Also a certificate is not "flat" but contains these
fields nested in various structures within the certificate.

* **Serial Number**: Used to uniquely identify the certificate within a CA's systems. In particular this is used to track revocation information.
* **Subject**: The entity a certificate belongs to: a machine, an individual, or an organization.
* **Issuer**: The entity that verified the information and signed the certificate.
* **Not Before**: The earliest time and date on which the certificate is valid. Usually set to a few hours or days prior to the moment the certificate was issued, to avoid clock skew problems.
* **Not After**: The time and date past which the certificate is no longer valid.
* **Key Usage**: The valid cryptographic uses of the certificate's public key. Common values include digital signature validation, key encipherment, and certificate signing.
* **Extended Key Usage**: The applications in which the certificate may be used. Common values include TLS server authentication, email protection, and code signing.
* **Public Key**: A public key belonging to the certificate subject.
* **Signature Algorithm**: The algorithm used to sign the public key certificate.
* **Signature**: A signature of the certificate body by the issuer's private key.

Below is an example of a decoded SSL/TLS certificate
retrieved from SSL.com's website:

```
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number:
            72:14:11:d3:d7:e0:fd:02:aa:b0:4e:90:09:d4:db:31
        Signature Algorithm: sha256WithRSAEncryption
        Issuer: C=US, ST=Texas, L=Houston, O=SSL Corp, CN=SSL.com EV SSL Intermediate CA RSA R3
        Validity
            Not Before: Apr 18 22:15:06 2019 GMT
            Not After : Apr 17 22:15:06 2021 GMT
        Subject: C=US, ST=Texas, L=Houston, O=SSL Corp/serialNumber=NV20081614243, CN=www.ssl.com/postalCode=77098/businessCategory=Private Organization/street=3100 Richmond Ave/jurisdictionST=Nevada/jurisdictionC=US
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                RSA Public-Key: (2048 bit)
                Modulus:
                    00:ad:0f:ef:c1:97:5a:9b:d8:1e ...
                Exponent: 65537 (0x10001)
        X509v3 extensions:
            X509v3 Authority Key Identifier: 
                keyid:BF:C1:5A:87:FF:28:FA:41:3D:FD:B7:4F:E4:1D:AF:A0:61:58:29:BD

            Authority Information Access: 
                CA Issuers - URI:http://www.ssl.com/repository/SSLcom-SubCA-EV-SSL-RSA-4096-R3.crt
                OCSP - URI:http://ocsps.ssl.com

            X509v3 Subject Alternative Name: 
                DNS:www.ssl.com, DNS:answers.ssl.com, DNS:faq.ssl.com, DNS:info.ssl.com, DNS:links.ssl.com, DNS:reseller.ssl.com, DNS:secure.ssl.com, DNS:ssl.com, DNS:support.ssl.com, DNS:sws.ssl.com, DNS:tools.ssl.com
            X509v3 Certificate Policies: 
                Policy: 2.23.140.1.1
                Policy: 1.2.616.1.113527.2.5.1.1
                Policy: 1.3.6.1.4.1.38064.1.1.1.5
                  CPS: https://www.ssl.com/repository

            X509v3 Extended Key Usage: 
                TLS Web Client Authentication, TLS Web Server Authentication
            X509v3 CRL Distribution Points:

                Full Name:
                  URI:http://crls.ssl.com/SSLcom-SubCA-EV-SSL-RSA-4096-R3.crl

            X509v3 Subject Key Identifier: 
                E7:37:48:DE:7D:C2:E1:9D:D0:11:25:21:B8:00:33:63:06:27:C1:5B
            X509v3 Key Usage: critical
                Digital Signature, Key Encipherment
            CT Precertificate SCTs: 
                Signed Certificate Timestamp:
                    Version   : v1 (0x0)
                    Log ID    : 87:75:BF:E7:59:7C:F8:8C:43:99 ...
                    Timestamp : Apr 18 22:25:08.574 2019 GMT
                    Extensions: none
                    Signature : ecdsa-with-SHA256
                                30:44:02:20:40:51:53:90:C6:A2 ...
                Signed Certificate Timestamp:
                    Version   : v1 (0x0)
                    Log ID    : A4:B9:09:90:B4:18:58:14:87:BB ...
                    Timestamp : Apr 18 22:25:08.461 2019 GMT
                    Extensions: none
                    Signature : ecdsa-with-SHA256
                                30:45:02:20:43:80:9E:19:90:FD ...
                Signed Certificate Timestamp:
                    Version   : v1 (0x0)
                    Log ID    : 55:81:D4:C2:16:90:36:01:4A:EA ...
                    Timestamp : Apr 18 22:25:08.769 2019 GMT
                    Extensions: none
                    Signature : ecdsa-with-SHA256
                                30:45:02:21:00:C1:3E:9F:F0:40 ...
    Signature Algorithm: sha256WithRSAEncryption
         36:07:e7:3b:b7:45:97:ca:4d:6c ...
```

## Certificate authorities

In the X.509 trust model, a certificate authority (CA) is
responsible for signing certificates. These certificates act
as an introduction between two parties, which means that a
CA acts as a trusted third party.

![Certification process](images/PublicKeyCertificateDiagram_It.svg)

A CA processes requests from people or organizations
requesting certificates (called subscribers), verifies the
information, and potentially signs an end-entity certificate
based on that information. To perform this role effectively,
a CA needs to have one or more broadly trusted root
certificates or intermediate certificates and the
corresponding private keys.

CAs may achieve this broad trust by:

* having their root certificates included in popular software or
* by obtaining a cross-signature from another CA delegating trust.
* Other CAs are trusted within a relatively small community,
  like a business, and are distributed by other mechanisms
  like Windows Group Policy.

Some of the larger certificate authorities in the market include: 
* [IdenTrust](https://en.wikipedia.org/wiki/IdenTrust)
* [DigiCert](https://en.wikipedia.org/wiki/DigiCert)
* [Sectigo](https://en.wikipedia.org/wiki/Sectigo)

## Root programs

Some major software contain a list of certificate
authorities that are trusted by default.

The policies and processes a provider uses to decide which
certificate authorities their software should trust are
called root programs.

The most influential root programs are:

* Microsoft Root Program
* Apple Root Program
* Mozilla Root Program
* Oracle Java root program
* Adobe AATL Adobe Approved Trust List and EUTL root
  programs (used for document signing)

Browsers other than Firefox generally use the operating
system's facilities to decide which certificate authorities
are trusted. 

The Mozilla Root Program is operated publicly, and its
certificate list is part of the open source Firefox web
browser, so it is broadly used outside Firefox.

For instance, while there is no common Linux Root Program,
many Linux distributions, like Debian, include a package
that periodically copies the contents of the Firefox trust
list, which is then used by applications.

Root programs generally provide a set of valid purposes with
the certificates they include. For instance, some CAs may be
considered trusted for issuing TLS server certificates, but
not for code signing certificates. This is indicated with a
set of trust bits in a root certificate storage system. 

# Certificate types

https://en.wikipedia.org/wiki/Public_key_certificate

## End-entity or leaf certificate

Any certificate that cannot be used to sign other
certificates. For instance, TLS/SSL server and client
certificates, email certificates, code signing certificates,
and qualified certificates are all end-entity certificates. 

## Self-signed certificate

A certificate with a subject that matches its issuer, and a
signature that can be verified by its own public key. Most
types of certificate can be self-signed. Self-signed
certificates are also often called snake oil certificates to
emphasize their untrustworthiness. 

## TLS/SSL server certificate

In TLS (an updated replacement for SSL), a server is
required to present a certificate as part of the initial
connection setup. A client connecting to that server will
perform the certification path validation algorithm:

* The subject of the certificate matches the hostname (i.e.
  domain name) to which the client is trying to connect;
* The certificate is signed by a trusted certificate
  authority.

The primary hostname (domain name of the website) is listed
as the Common Name in the Subject field of the certificate.
A certificate may be valid for multiple hostnames (multiple
websites). Such certificates are commonly called Subject
Alternative Name (SAN) certificates or Unified
Communications Certificates (UCC). These certificates
contain the field Subject Alternative Name, though many CAs
will also put them into the Subject Common Name field for
backward compatibility. If some of the hostnames contain an
asterisk (*), a certificate may also be called a wildcard
certificate.

A TLS server may be configured with a self-signed
certificate. When that is the case, clients will generally
be unable to verify the certificate, and will terminate the
connection unless certificate checking is disabled.

As per the applications, SSL Certificates can be classified
into three types:

* Domain Validation SSL;
* Organization Validation SSL;
* Extended Validation SSL.

## TLS/SSL client certificate

Client certificates are less common than server
certificates, and are used to authenticate the client
connecting to a TLS service, for instance to provide access
control. Because most services provide access to
individuals, rather than devices, most client certificates
contain an email address or personal name rather than a
hostname. Also, because authentication is usually managed by
the service provider, client certificates are not usually
issued by a public CA that provides server certificates.
Instead, the operator of a service that requires client
certificates will usually operate their own internal CA to
issue them. Client certificates are supported by many web
browsers, but most services use passwords and cookies to
authenticate users, instead of client certificates.

## Root certificates

A self-signed certificate used to sign other certificates.
Also sometimes called a trust anchor. 

![Chain of trust](images/Chain_of_trust.svg)

## Intermediate certificate

A certificate used to sign other certificates. An
intermediate certificate must be signed by another
intermediate certificate, or a root certificate. 


## Email certificate

In the S/MIME protocol for secure email, senders need to
discover which public key to use for any given recipient.
They get this information from an email certificate. Some
publicly trusted certificate authorities provide email
certificates, but more commonly S/MIME is used when
communicating within a given organization, and that
organization runs its own CA, which is trusted by
participants in that email system.

## (Europay, MasterCard, and Visa) EMV certificate

EMV CA Certificate public key is loaded on ATM or POS and
used for validating Card Issuer Certificate.

## Authorization certificate

https://en.wikipedia.org/wiki/Authorization_certificate

An attribute certificate, or authorization certificate (AC)
is a digital document containing attributes associated to
the holder by the issuer. When the associated attributes are
mainly used for the purpose of authorization, AC is called
authorization certificate. AC is standardized in X.509. RFC
5755 further specifies the usage for authorization purpose
in the Internet. 

The authorization certificate works in conjunction with a
public key certificate (PKC). While the PKC is issued by a
certificate authority (CA) and is used as a proof of
identity of its holder like a passport, the authorization
certificate is issued by an attribute authority (AA) and is
used to characterize or entitle its holder.

Using attribute certificate, the service or resource host
does not need to maintain an access control list that can
potentially be large or to always be connected to a network
to access a central server like when using Kerberos. It is
similar to the idea of capabilities in which the permission
(or permissions) to use a service or resource is not stored
in the service or resource itself but in the users using a
tamper resistance mechanism. 

### Contents of a typical attribute certificate

* Version: the version of the certificate.
* Holder: the holder of the certificate.
* Issuer: the issuer of the certificate.
* Signature algorithm: the algorithm by which the
  certificate is signed.
* Serial number: the unique issuance number given by the
  issuer.
* Validity period: the validity period of the certificate.
* Attributes: the attributes associated to the certificate
  holder.
* Signature value: the signature of the issuer over the
  whole data above. 

### Example - controlled application capabilities

For example, a software developer that already has a PKC
wants to deploy its software in a computing device employing
DRM like iPad where software can only be run in the device
after the software has been approved by the device
manufacturer. The software developer signs the software with
the private key of the PKC and sends the signed software to
the device manufacturer for approval. After authenticating
the developer using the PKC and reviewing the software, the
manufacturer may decide to issue an AC granting the software
the basic capability to install itself and be executed as
well as an additional capability to use the Wi-Fi device
following the principle of least privilege. In this example,
the AC does not refer to the PKC of the developer as the
holder but to the software, for example, by storing the
developer's signature of the software in the holder field of
the AC. When the software is put into the computing device,
the device will verify the integrity of the software using
the developer's PKC before checking the validity of the AC
and granting the software access to the device
functionalities. 

### Example - company data access

A user may also need to obtain several ACs from different
issuers to use a particular service. For example, a company
gives one of its employees a company-wide AC that specifies
engineering department as the work area. To access
engineering data, however, the employee also needs a
security clearance AC from the head of the engineering
department. In this example, the resource of engineering
data needs to be preinstalled with the public keys of both
the company-wide and the engineering department AC issuers. 





# Public key infrastructure (PKI)

https://en.wikipedia.org/wiki/Public_key_infrastructure

PKI create, manage, distribute, use, store and revoke
digital certificates and manage public-key encryption.

PKI is an arrangement that binds public keys with respective
identities of entities (like people and organizations). The
binding is established through a process of registration and
issuance of certificates at and by a certificate authority
(CA). Depending on the assurance level of the binding, this
may be carried out by an automated process or under human
supervision. 

An entity must be uniquely identifiable within each CA
domain on the basis of information about that entity. A
third-party validation authority (*VA*) can provide this
entity information on behalf of the CA. 

## Organizational structure

A PKI consists of:[6][8][9]

* A certificate authority (**CA**) that stores, issues and signs
  the digital certificates;
* A registration authority (**RA**) which verifies the identity
  of entities requesting their digital certificates to be
  stored at the CA;
* A central directory—i.e., a secure location in which keys
  are stored and indexed;
* A certificate management system managing things like the
  access to stored certificates or the delivery of the
  certificates to be issued;
* A certificate policy stating the PKI's requirements
  concerning its procedures. Its purpose is to allow
  outsiders to analyze the PKI's trustworthiness.

![Public-Key-Infrastructure](images/Public-Key-Infrastructure.svg)

## Certificate signing request

https://en.wikipedia.org/wiki/Certificate_signing_request

In public key infrastructure (PKI) systems, a certificate
signing request (also CSR or certification request) is a
message sent from an applicant to a certificate authority in
order to apply for a digital identity certificate. The most
common format for CSRs is the PKCS #10 specification. It
usually contains: 

* the public key for which the certificate should be issued, 
* identifying information (such as a domain name) and 
* integrity protection (e.g., a digital signature). 

### Procedure:

Before creating a CSR, the applicant first generates a key
pair, keeping the private key secret.

The CSR contains: 
* information identifying the applicant (such as a
  distinguished name DN) which must be signed using the
  applicant's private key.
* public key chosen by the applicant
* The CSR may be accompanied by other credentials or proofs
  of identity required by the certificate authority, and the
  certificate authority may contact the applicant for
  further information.

X.509 certificate Distinguished Names (DN) fild support
attributes, some of them are listed below (full list for
example at [IBM knowledge db](https://www.ibm.com/support/knowledgecenter/SSFKSJ_7.5.0/com.ibm.mq.sec.doc/q009860_.htm)):
* CN - Common Name - eg.: *.wikipedia.org 
* O - Business name / Organization - eg.: Wikimedia Foundation, Inc.
* C - Country - eg.: US
* L - Town / City - eg.: San Francisco 
* MAIL- Email address - 


Example string: `CN=*.wikipedia.org, O=Wikimedia Foundation, Inc., C=US`

### CSR generating software

For example
[GnuTLS](https://www.gnutls.org/manual/html_node/PKCS-10-certificate-requests.html)
supports the requests defined in PKCS #10 [RFC2986].

RFC2986 can be found by:
Magnus Nystrom and Burt Kaliski, "PKCS 10 v1.7: Certification Request Syntax Specification", November 2000, Available from https://www.ietf.org/rfc/rfc2986.txt. 

### CRS format

The PKCS#10 standard defines a binary format for encoding
CSRs for use with X.509. It is expressed in ASN.1.

ASN.1 structure can be examined using OpenSSL

```console
$ openssl asn1parse -in your_request -inform PEM -i
```

## Certificates and website security

The certificate provider signs the request, thus producing a
public certificate. During web browsing, this public
certificate is served to any web browser that connects to
the web site and proves to the web browser that the provider
believes it has issued a certificate to the owner of the web
site.

For provable security, this reliance on something external
to the system has the consequence that any public key
certification scheme has to rely on some special setup
assumption, such as the existence of a certificate
authority.

A certificate provider can opt to issue three types of
certificates, each requiring its own degree of vetting
rigor. In order of increasing rigor (and naturally, cost)
they are: 

* Domain validation - A certificate provider will issue a
  Domain Validation (DV) class certificate to a purchaser if
  the purchaser can demonstrate one vetting criterion: the
  right to administratively manage a domain name.
* Organization validation - A certificate provider will
  issue an Organization Validation (OV) class certificate to
  a purchaser if the purchaser can meet two criteria: the
  right to administratively manage the domain name in
  question, and perhaps, the organization's actual existence
  as a legal entity. A certificate provider publishes its OV
  vetting criteria through its Certificate Policy. 
* Extended validation - To acquire an Extended Validation
  (EV) certificate, the purchaser must persuade the
  certificate provider of its legal identity, including
  manual verification checks by a human. As with OV
  certificates, a certificate provider publishes its EV
  vetting criteria through its Certificate Policy. 


All web browsers come with an extensive built-in list of
trusted root certificates, many of which are controlled by
organizations that may be unfamiliar to the user.[1] Each of
these organizations is free to issue any certificate for any
web site and have the guarantee that web browsers that
include its root certificates will accept it as genuine. In
this instance, end users must rely on the developer of the
browser software to manage its built-in list of certificates
and on the certificate providers to behave correctly and to
inform the browser developer of problematic certificates.

The list of built-in certificates is also not limited to
those provided by the browser developer: users (and to a
degree applications) are free to extend the list for special
purposes such as for company intranets.


# Web of Trust (WOT)

https://en.wikipedia.org/wiki/Web_of_trust

In cryptography, a web of trust is a concept used in PGP,
GnuPG, and other OpenPGP-compatible systems to establish the
authenticity of the binding between a public key and its
owner. Its decentralized trust model is an alternative to
the centralized trust model of a public key infrastructure
(PKI), which relies exclusively on a certificate authority
(or a hierarchy of such). As with computer networks, there
are many independent webs of trust, and any user (through
their identity certificate) can be a part of, and a link
between, multiple webs.

![Web of trust](images/Web_of_Trust-en.svg)

## Software

* OpenPGP
* GnuPG
* [openpgpjs](https://github.com/openpgpjs/openpgpjs)


# Transport Layer Security

TLS are cryptographic protocols designed to provide
communications security over a computer network.

When secured by TLS, connections between a client (e.g., a
web browser) and a server (e.g., wikipedia.org) should have
one or more of the following properties:

* The connection is private (or secure) because symmetric
  cryptography is used to encrypt the data transmitted.
  * The keys for this symmetric encryption are generated
    uniquely for each connection and
  * are based on a shared secret that was negotiated at the
    start of the session 
  * The server and client negotiate the details of which
    encryption algorithm and cryptographic keys to use
    before the first byte of data is transmitted
  * The negotiation of a shared secret is both: 
    * secure (the negotiated secret is unavailable to
      eavesdroppers and cannot be obtained, even by an
      attacker who places themselves in the middle of the
      connection) and 
    * reliable (no attacker can modify the communications
      during the negotiation without being detected).
* The identity of the communicating parties can be
  authenticated using public-key cryptography. 
  * This authentication can be made optional, but is
    generally required for at least one of the parties
    (typically the server).
* The connection is reliable because each message
  transmitted includes a message integrity check using a
  message authentication code to prevent undetected loss or
  alteration of the data during transmission.


## Connection initiation

Since applications can communicate either with or without
TLS (or SSL), it is necessary for the client to indicate to
the server the setup of a TLS connection.

One of the main ways of achieving this is to use a different
port number for TLS connections, for example port 443 for
HTTPS.

## Handshake overview

1. The handshake begins when a client connects to a
   TLS-enabled server requesting a secure connection and the
   client presents a list of supported cipher suites
2. From this list, the server picks a cipher and hash
   function that it also supports and notifies the client of
   the decision.
3. The server usually then provides identification in the
   form of a digital certificate. The certificate contains:
   * the server name, 
   * the trusted certificate authority (CA) that vouches for
     the authenticity of the certificate, 
   * and the server's public encryption key.
4. The client confirms the validity of the certificate
   before proceeding.
5. To generate the session keys used for the secure
   connection, the client either:
   * encrypts a random number with the server's public key
     and sends the result to the server 
     * (which only the server should be able to decrypt with
       its private key)
     * both parties then use the random number to generate a
       unique session key for subsequent encryption and
       decryption of data during the session
   * uses Diffie–Hellman key exchange to securely generate a
     random and unique session key for encryption and
     decryption that has the additional property of forward
     secrecy: if the server's private key is disclosed in
     future, it cannot be used to decrypt the current
     session, even if the session is intercepted and
     recorded by a third party.


# HTTPS

https://en.wikipedia.org/wiki/HTTPS

Public key can be freely registered at 
[Let's Encrypt](https://en.wikipedia.org/wiki/Let%27s_Encrypt).

Example of HTTP headers for HTTPsec on 
[Wikipedia HTTPsec](https://en.wikipedia.org/wiki/HTTPsec).


## Protocol

The Uniform Resource Identifier (URI) scheme HTTPS has
identical usage syntax to the HTTP scheme. However, HTTPS
signals the browser to use an added encryption layer of
SSL/TLS to protect the traffic. SSL/TLS is especially suited
for HTTP, since it can provide some protection even if only
one side of the communication is authenticated. This is the
case with HTTP transactions over the Internet, where
typically only the server is authenticated (by the client
examining the server's certificate). 

HTTPS piggybacks HTTP entirely on top of TLS, the entirety
of the underlying HTTP protocol can be encrypted, but
website addresses and port numbers are necessarily part of
the underlying TCP/IP protocols, HTTPS cannot protect their
disclosure. 

Encrypted parts includes:
* the request URL
* query parameters, 
* headers, 
* and cookies

## Trust

Web browsers know how to trust HTTPS websites based on
certificate authorities that come pre-installed in their
software. Certificate authorities are in this way being
trusted by web browser creators to provide valid
certificates. Therefore, a user should trust an HTTPS
connection to a website if and only if all of the following
are true: 

* The user trusts that the browser software correctly
  implements HTTPS with correctly pre-installed certificate
  authorities.
* The user trusts the certificate authority to vouch only
  for legitimate websites.
* The website provides a valid certificate, which means it
  was signed by a trusted authority.
* The certificate correctly identifies the website (e.g.,
  when the browser visits "https://example.com", the
  received certificate is properly for "example.com" and not
  some other entity).
* The user trusts that the protocol's encryption layer
  (SSL/TLS) is sufficiently secure against eavesdroppers.

## Technical details

* URLs begin with "https://" and use port 443 by default
* HTTP operates at the highest layer of the TCP/IP model,
  the Application layer; as does the TLS security protocol
  (operating as a lower sublayer of the same layer), which
  encrypts an HTTP message prior to transmission and
  decrypts a message upon arrival. Strictly speaking, HTTPS
  is not a separate protocol, but refers to the use of
  ordinary HTTP over an encrypted SSL/TLS connection.
* HTTPS encrypts all message contents, including the HTTP
  headers and the request/response data.
* To prepare a web server to accept HTTPS connections, the
  administrator must create a public key certificate for the
  web server.
* A number of commercial certificate authorities exist,
  offering paid-for SSL/TLS certificates of a number of
  types, including Extended Validation Certificates
* Let's Encrypt provides free and automated service that
  delivers basic SSL/TLS certificates to websites.
* The system can also be used for client authentication in
  order to limit access to a web server to authorized users.
  To do this, the site administrator typically creates a
  certificate for each user, which the user loads into their
  browser. Normally, the certificate contains the name and
  e-mail address of the authorized user and is automatically
  checked by the server on each connection to verify the
  user's identity, potentially without even requiring a
  password. 
* Perfect forward secrecy (PFS). Possessing one of the
  long-term asymmetric secret keys used to establish an
  HTTPS session should not make it easier to derive the
  short-term session key to then decrypt the conversation,
  even at a later time. Diffie–Hellman key exchange (DHE)
  and Elliptic curve Diffie–Hellman key exchange (ECDHE) are
  in 2013 the only schemes known to have that property.
* A certificate may be revoked before it expires, for
  example because the secrecy of the private key has been
  compromised. Newer versions of popular browsers such as
  Firefox, Opera, and Internet Explorer on Windows Vista
  implement the Online Certificate Status Protocol (OCSP) to
  verify that this is not the case. The browser sends the
  certificate's serial number to the certificate authority
  or its delegate via OCSP (Online Certificate Status
  Protocol) and the authority responds, telling the browser
  whether the certificate is still valid or not. The CA may
  also issue a CRL to tell people that these certificates
  are revoked.

## Simple mode TLS

SL (Secure Sockets Layer) and TLS (Transport Layer Security)
encryption can be configured to simple mode in which
authentication is only performed by the server. 

## Simple mode TLS

The mutual mode requires the user to install a personal
client certificate in the web browser for user
authentication.

## Architecture

* Because TLS operates at a protocol level below that of
  HTTP and has no knowledge of the higher-level protocols,
  TLS servers can only strictly present one certificate for
  a particular address and port combination. In the
  past, this meant that it was not feasible to use
  name-based virtual hosting with HTTPS. A solution called
  Server Name Indication (SNI) exists, which sends the
  hostname to the server before encrypting the connection,
* An SSL/TLS connection is managed by the first front
  machine that initiates the TLS connection. If, for any
  reasons (routing, traffic optimization, etc.), this front
  machine is not the application server and it has to
  decipher data, solutions have to be found to propagate
  user authentication information or certificate to the
  application server, which needs to know who is going to be
  connected.
* For SSL/TLS with mutual authentication, the SSL/TLS
  session is managed by the first server that initiates the
  connection. In situations where encryption has to be
  propagated along chained servers, session timeOut
  management becomes extremely tricky to implement.
* Security is maximal with mutual SSL/TLS, but on the
  client-side there is no way to properly end the SSL/TLS
  connection and disconnect the user except by waiting for
  the server session to expire or by closing all related
  client applications.


## Curl-loader

[curl-loader](https://en.wikipedia.org/wiki/Curl-loader) is
capable of simulating application behavior of hundreds of
thousands of HTTP/HTTPS and FTP/FTPS clients, each with its
own source IP-address. In contrast to other tools,
curl-loader is using real C-written client protocol stacks,
namely, HTTP and FTP stacks of libcurl and TLS/SSL of
openssl, and simulates user behavior with support for login
and authentication flavors. 

## cURL

[cURL](https://en.wikipedia.org/wiki/CURL) 
is a command-line tool for getting or sending data
including files using URL syntax. Since cURL uses libcurl,
it supports every protocol libcurl supports.

cURL supports HTTPS and performs SSL certificate
verification by default when a secure protocol is specified
such as HTTPS. When cURL connects to a remote server via
HTTPS, it will obtain the remote server certificate, then
check against its CA certificate store the validity of the
remote server to ensure the remote server is the one it
claims to be. Some cURL packages are bundled with CA
certificate store file. There are several options to specify
a CA certificate such as `--cacert` and `--capath`. The `--cacert`
option can be used to specify the location of the CA
certificate store file. 

# Generating key pair using OpenSSL

https://en.wikibooks.org/wiki/Cryptography/Generate_a_keypair_using_OpenSSL

[Man page for openssl genpkey](https://linux.die.net/man/1/genpkey).

Good place to start is 
[OpenSSL documentation page](https://www.openssl.org/docs/).

## Example

Extended example is on openssl wiki page 
[Command line utilities](https://wiki.openssl.org/index.php/Command_Line_Utilities)



```console
$ # first generate private and public key using RSA scheme,
$ # with key length = 2048 bits
$ # private and public keys will be in private_key.pem file
$ openssl genpkey -algorithm RSA -out private_key.pem -pkeyopt rsa_keygen_bits:2048
........................................................................................................................+++++
.+++++
$ # disallow everybody besides owner reading file 
$ # group should not read and others also should not read
$ chmod go-r private_key.pem
$ openssl rsa -pubout -in private_key.pem -out public_key.pem
writing RSA key
$ # lets view public-private keys data:
$ openssl rsa -text -in private_key.pem
RSA Private-Key: (2048 bit, 2 primes)
modulus:
    00:da:5a:df:3b:73:84:64:bc:9f:e4:f2:a1:fd:87:
    1e:29:0a:8f:8a:f1:8f:b7:33:0b:85:77:4d:1e:7d:
    e2:49:14:d4:39:b1:be:8d:fd:a9:43:f7:89:31:cd:
    82:38:64:50:9d:a9:9a:f6:53:a9:6a:f9:64:16:3f:
    8d:85:81:bb:5c:99:14:32:99:55:ca:71:c4:30:27:
    1e:f9:2d:cc:18:39:70:79:72:38:94:0f:43:31:b1:
    5b:09:9c:8b:4c:95:00:e5:03:ce:41:f8:98:a2:cd:
    2d:4f:99:42:f8:81:10:0c:02:dc:88:78:b4:8c:a0:
    05:2b:59:af:52:44:74:1a:6d:84:e6:cf:d3:e4:5f:
    15:19:78:26:89:3c:89:69:b3:e4:92:2e:01:c1:05:
    3f:3e:9f:b4:fe:36:e2:1a:c2:09:d5:b3:dd:8e:ed:
    28:d1:fb:7b:e5:2e:23:5a:ef:a9:d0:6a:d5:8d:61:
    60:4c:ac:f2:68:6f:a1:a9:e0:90:45:27:eb:c3:34:
    b5:f4:c6:de:31:34:e3:e9:33:c9:aa:a3:76:9a:fe:
    bc:10:18:88:a1:07:df:13:3c:0c:ff:b7:43:12:84:
    78:64:fa:7c:d6:88:6f:d0:7a:e8:bb:20:a8:c0:1b:
    73:97:5b:c2:a4:0e:b9:bb:89:90:fd:57:2e:dc:99:
    b4:0f
publicExponent: 65537 (0x10001)
privateExponent:
    18:1a:fe:17:ef:19:c7:91:37:49:ac:2b:8b:f4:95:
    b4:cc:30:aa:93:1e:5d:88:2a:16:72:e4:35:a0:8a:
    11:ad:55:fc:84:8d:d7:d9:10:0d:ab:cf:1e:8b:64:
    7b:db:3f:37:18:99:3d:e6:60:86:a9:bf:8d:e1:38:
    3b:6b:e6:06:43:f4:01:de:01:a5:96:c7:a4:d5:3c:
    cb:1f:6e:2f:a2:6f:b3:48:93:cc:6c:9e:eb:66:7b:
    f9:64:a9:d0:2b:86:ec:c1:6d:cc:c4:a7:fd:19:0f:
    8e:81:09:ee:ab:38:dd:4a:97:94:0d:57:49:4b:05:
    27:13:00:92:e1:71:bb:d4:f5:1e:86:64:78:09:54:
    be:e0:14:92:1b:88:aa:a4:67:84:c2:32:60:a2:0d:
    0d:d9:83:b9:8a:a8:81:86:1a:b7:39:e3:aa:b1:09:
    ed:4a:2a:9f:b0:dc:f8:92:44:a9:e6:41:04:c4:d8:
    a6:82:15:58:bb:c7:b1:1c:8b:69:84:b7:74:6a:0a:
    4a:13:c6:3d:aa:d4:ef:0e:04:62:21:10:e5:ca:57:
    9a:db:bb:e2:34:b9:96:25:3d:f1:7c:d1:00:5b:cb:
    ef:bc:51:44:e9:15:ad:16:c0:a3:d4:d0:37:47:ba:
    57:97:f8:32:7d:d3:87:35:ec:10:b4:cf:95:9d:df:
    79
prime1:
    00:f6:8c:e2:15:39:e0:9b:00:04:9b:fb:45:b7:60:
    82:c4:5d:67:7f:c1:23:35:fe:1e:f6:93:e3:08:9c:
    13:b1:50:88:94:06:52:e8:8f:40:36:9c:ea:08:9b:
    2d:eb:e6:0e:09:15:81:37:a3:85:31:38:d0:cd:58:
    e0:d1:25:76:f6:43:98:82:fc:d4:b4:e5:72:71:46:
    5a:1a:53:aa:cc:5b:9d:66:eb:5a:68:c4:01:44:98:
    24:08:9d:6c:74:47:e7:b3:11:6d:b4:be:5d:85:cb:
    d3:26:5c:4f:47:dd:17:9d:0d:a8:fb:fd:4e:7e:4d:
    b6:5a:e8:d9:1a:71:34:d6:b5
prime2:
    00:e2:b9:57:0b:e4:a2:e4:f3:50:63:bb:6d:a5:7b:
    56:33:bb:6b:7f:1a:a7:34:51:38:1d:ce:b2:76:a9:
    82:48:e7:83:92:af:ad:28:ca:2d:2c:60:97:ba:50:
    41:38:71:5a:89:7c:84:01:56:4b:e2:e9:bb:c2:0f:
    f4:a7:2a:b9:f2:85:89:7d:df:11:ad:42:ce:11:55:
    db:82:65:be:eb:0a:39:c2:81:ca:17:de:6b:6b:24:
    69:01:c6:6f:a8:fe:e1:8b:c6:1c:e6:0e:63:a6:0a:
    4d:2f:dc:a0:31:93:5e:5c:ce:9d:4e:39:8e:72:60:
    db:d5:c7:77:86:05:5d:f6:33
exponent1:
    0e:3a:57:19:ae:7b:5d:b6:84:8d:93:d4:94:1e:87:
    ad:59:4e:8d:ba:d1:93:5e:14:df:59:ed:72:23:bf:
    a7:2d:e4:93:d6:41:96:96:1d:b8:89:19:a0:61:84:
    26:e6:e1:cc:78:67:3a:94:bf:2c:f6:00:66:b9:48:
    50:09:7f:71:fa:b8:a4:66:7e:c7:e9:ad:cf:07:a6:
    4f:7a:a0:92:a6:7e:d0:df:a8:19:ff:a5:ab:15:b4:
    8e:a2:b7:0d:86:d0:c2:2e:b1:4c:0a:e8:4e:be:52:
    73:16:44:a4:fb:07:4f:d2:e7:fb:92:c4:a2:d9:4d:
    3a:b5:d1:41:8b:62:e7:39
exponent2:
    41:46:e5:96:0a:05:10:70:31:84:15:71:b3:44:78:
    84:3a:80:ef:be:87:c7:9b:5e:d1:ce:32:39:d2:02:
    2d:e5:62:4f:78:7f:1d:90:60:43:37:a8:57:bf:45:
    97:ef:a3:06:94:b0:19:06:74:a0:e7:74:e4:a1:dd:
    69:c7:f6:73:aa:18:f5:01:a5:c0:41:cc:bc:d7:00:
    75:61:bf:ff:42:19:71:34:17:30:9a:1c:49:63:d9:
    4b:e6:8b:3d:97:ec:ee:66:62:e9:a5:d8:f0:f4:64:
    56:d4:69:d6:fc:3c:1d:f2:6a:fe:1b:ba:34:9a:48:
    91:1b:76:01:43:48:53:5b
coefficient:
    00:d3:9c:54:fe:8b:30:ec:3d:14:c3:3d:09:6f:10:
    6d:4a:98:f1:be:1f:73:df:5d:87:9e:2f:83:18:a3:
    05:73:8f:62:cb:69:12:f6:22:36:af:26:05:14:01:
    28:a5:cc:7a:02:70:02:d8:da:08:52:24:6b:1c:01:
    4a:2d:b5:a4:d1:06:77:90:5b:fc:a8:51:d5:5b:db:
    50:7f:98:17:88:64:1d:47:6b:a0:7c:79:3e:81:39:
    13:04:9e:fb:c6:b9:7f:5c:22:0a:ea:a0:ef:31:4f:
    35:e4:02:61:30:5a:96:de:98:c4:32:38:eb:f2:5e:
    7b:5b:83:4d:78:1f:4b:02:58
writing RSA key
-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEA2lrfO3OEZLyf5PKh/YceKQqPivGPtzMLhXdNHn3iSRTUObG+
jf2pQ/eJMc2COGRQnama9lOpavlkFj+NhYG7XJkUMplVynHEMCce+S3MGDlweXI4
lA9DMbFbCZyLTJUA5QPOQfiYos0tT5lC+IEQDALciHi0jKAFK1mvUkR0Gm2E5s/T
5F8VGXgmiTyJabPkki4BwQU/Pp+0/jbiGsIJ1bPdju0o0ft75S4jWu+p0GrVjWFg
TKzyaG+hqeCQRSfrwzS19MbeMTTj6TPJqqN2mv68EBiIoQffEzwM/7dDEoR4ZPp8
1ohv0HrouyCowBtzl1vCpA65u4mQ/Vcu3Jm0DwIDAQABAoIBABga/hfvGceRN0ms
K4v0lbTMMKqTHl2IKhZy5DWgihGtVfyEjdfZEA2rzx6LZHvbPzcYmT3mYIapv43h
ODtr5gZD9AHeAaWWx6TVPMsfbi+ib7NIk8xsnutme/lkqdArhuzBbczEp/0ZD46B
Ce6rON1Kl5QNV0lLBScTAJLhcbvU9R6GZHgJVL7gFJIbiKqkZ4TCMmCiDQ3Zg7mK
qIGGGrc546qxCe1KKp+w3PiSRKnmQQTE2KaCFVi7x7Eci2mEt3RqCkoTxj2q1O8O
BGIhEOXKV5rbu+I0uZYlPfF80QBby++8UUTpFa0WwKPU0DdHuleX+DJ904c17BC0
z5Wd33kCgYEA9oziFTngmwAEm/tFt2CCxF1nf8EjNf4e9pPjCJwTsVCIlAZS6I9A
NpzqCJst6+YOCRWBN6OFMTjQzVjg0SV29kOYgvzUtOVycUZaGlOqzFudZutaaMQB
RJgkCJ1sdEfnsxFttL5dhcvTJlxPR90XnQ2o+/1Ofk22WujZGnE01rUCgYEA4rlX
C+Si5PNQY7ttpXtWM7trfxqnNFE4Hc6ydqmCSOeDkq+tKMotLGCXulBBOHFaiXyE
AVZL4um7wg/0pyq58oWJfd8RrULOEVXbgmW+6wo5woHKF95rayRpAcZvqP7hi8Yc
5g5jpgpNL9ygMZNeXM6dTjmOcmDb1cd3hgVd9jMCgYAOOlcZrntdtoSNk9SUHoet
WU6NutGTXhTfWe1yI7+nLeST1kGWlh24iRmgYYQm5uHMeGc6lL8s9gBmuUhQCX9x
+rikZn7H6a3PB6ZPeqCSpn7Q36gZ/6WrFbSOorcNhtDCLrFMCuhOvlJzFkSk+wdP
0uf7ksSi2U06tdFBi2LnOQKBgEFG5ZYKBRBwMYQVcbNEeIQ6gO++h8ebXtHOMjnS
Ai3lYk94fx2QYEM3qFe/RZfvowaUsBkGdKDndOSh3WnH9nOqGPUBpcBBzLzXAHVh
v/9CGXE0FzCaHElj2Uvmiz2X7O5mYuml2PD0ZFbUadb8PB3yav4bujSaSJEbdgFD
SFNbAoGBANOcVP6LMOw9FMM9CW8QbUqY8b4fc99dh54vgxijBXOPYstpEvYiNq8m
BRQBKKXMegJwAtjaCFIkaxwBSi21pNEGd5Bb/KhR1VvbUH+YF4hkHUdroHx5PoE5
EwSe+8a5f1wiCuqg7zFPNeQCYTBalt6YxDI46/Jee1uDTXgfSwJY
-----END RSA PRIVATE KEY-----
```

When viewing key-pair in context of RSA scheme:

$$
\left({\text{message}}^e\right)^d \bmod n = \text{message}
$$

$$
de \bmod n = 1
$$

$$
n = pq
$$

names means:

* modulus: is `n` - multiple of two prime numbers (`p` and `q`)
* publicExponent: (65537) is `e` - arbitrarly selected number, usually 65537
* privateExponent: is `d` private key
* prime1: is `p`
* prime2: is `q`
* exponent1, exponent2, coefficeint: dependent variables
  used for more efficient computations
* last block is: Base64 PEM encoded version of all that data, it is
  content of private_key.pem file.


