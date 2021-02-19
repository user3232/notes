

# JSON Web Token (JWT)

https://medium.com/@darutk/understanding-id-token-5f83f50fa02e

http://openid.net/connect/



# Structure

## JWT

JWT is memory (e.g. file) containing Base64 encoded UTF8 text
and binary data. Top level structure:

- (BOF)
- Base64Encoded UTF8 text of Header
- UTF8 dot (.) character
- Base64Encoded UTF8 text of Payload
- UTF8 dot (.) character
- Base64Encoded binary data of Signature
- (EOF)

Eg. (new line chars are ignored by Base64 encoder/decoder):

```
eyJraWQiOiIxZTlnZGs3IiwiYWxnIjoiUlMyNTYifQ.ewogImlz
cyI6ICJodHRwOi8vc2VydmVyLmV4YW1wbGUuY29tIiwKICJzdWIiOiAiMjQ4
Mjg5NzYxMDAxIiwKICJhdWQiOiAiczZCaGRSa3F0MyIsCiAibm9uY2UiOiAi
bi0wUzZfV3pBMk1qIiwKICJleHAiOiAxMzExMjgxOTcwLAogImlhdCI6IDEz
MTEyODA5NzAsCiAibmFtZSI6ICJKYW5lIERvZSIsCiAiZ2l2ZW5fbmFtZSI6
ICJKYW5lIiwKICJmYW1pbHlfbmFtZSI6ICJEb2UiLAogImdlbmRlciI6ICJm
ZW1hbGUiLAogImJpcnRoZGF0ZSI6ICIwMDAwLTEwLTMxIiwKICJlbWFpbCI6
ICJqYW5lZG9lQGV4YW1wbGUuY29tIiwKICJwaWN0dXJlIjogImh0dHA6Ly9l
eGFtcGxlLmNvbS9qYW5lZG9lL21lLmpwZyIKfQ.rHQjEmBqn9Jre0OLykYNn
spA10Qql2rvx4FsD00jwlB0Sym4NzpgvPKsDjn_wMkHxcp6CilPcoKrWHcip
R2iAjzLvDNAReF97zoJqq880ZD1bwY82JDauCXELVR9O6_B0w3K-E7yM2mac
AAgNCUwtik6SjoSUZRcf-O5lygIyLENx882p6MtmwaL1hd6qn5RZOQ0TLrOY
u0532g9Exxcm-ChymrB4xLykpDj3lUivJt63eEGGN6DH5K6o33TcxkIjNrCD
4XB1CKKumZvCedgHHF3IAK4dVEDSUoGlH9z4pP_eWYNXvqQOjGs-rDaQzUHl
6cQQWNiDpWOl_lxXjQEvQ
```


## Base64 encoding and decoding

```
BASE64URL(UTF8(JWS Protected Header)) || '.' ||
BASE64URL(JWS Payload) || '.' ||
BASE64URL(JWS Signature)
```

In c# JWT can be base64 decoded (encoded) using following functions:

```cs
// deduces padding from string length and don't add padding (=, ==)
// use with JWT
public static string JsonBase64StringToString(string s) => Base64UrlEncoder.Decode
public static string StrignToBase64String(string input) => Base64UrlEncoder.Encode

// uses padding signs if required (= , ==)
public static string Base64StringToString(string base64String) =>
  BytesToString(Convert.FromBase64String(base64String));
// uses padding signs if required (= , ==)
public static string StrignToBase64String(string input) => 
  Convert.ToBase64String(StringToBytes(input));


public static byte[] StringToBytes(string s) =>  Encoding.UTF8.GetBytes(s);
public static string BytesToString(byte[] bs) => Encoding.UTF8.GetString(bs);
```



## Header

Header is needed for unambignous description of contract.
Existance of header is also implayed agreement (contract). This way we
have (black) box but we know that this box:
- starts with instructions (for JWT implicitly, header as content
  before first `.` dot) which are: 
  - telling us what part is message (for JWT implicitly, payload as
    content between `.` dots)
  - telling us what part is signature (for JWT implicitly, payload as
    content after second `.` dot)
  - telling us what algorithm was used for signature (for JWT it is alg
    JSON key value of decoded Base64 text of header)
- this way if we know additional parameters (keys) we can make white box.


Header is UTF8 text in JSON format.

```cs
// Exemplary Base64 Encoded Header:
JsonBase64StringToString(
@"eyJraWQiOiIxZTlnZGs3IiwiYWxnIjoiUlMyNTYifQ"
);
// Exemplary Header:
/* 
{""kid"":""1e9gdk7"",""alg"":""RS256""}
*/
```

## Payload

Payload is just message.

Payload is UTF8 text in JSON format.

```cs
// Exemplary Base64 Encoded Payload:
JsonBase64StringToString(
@"ewogImlz
cyI6ICJodHRwOi8vc2VydmVyLmV4YW1wbGUuY29tIiwKICJzdWIiOiAiMjQ4
Mjg5NzYxMDAxIiwKICJhdWQiOiAiczZCaGRSa3F0MyIsCiAibm9uY2UiOiAi
bi0wUzZfV3pBMk1qIiwKICJleHAiOiAxMzExMjgxOTcwLAogImlhdCI6IDEz
MTEyODA5NzAsCiAibmFtZSI6ICJKYW5lIERvZSIsCiAiZ2l2ZW5fbmFtZSI6
ICJKYW5lIiwKICJmYW1pbHlfbmFtZSI6ICJEb2UiLAogImdlbmRlciI6ICJm
ZW1hbGUiLAogImJpcnRoZGF0ZSI6ICIwMDAwLTEwLTMxIiwKICJlbWFpbCI6
ICJqYW5lZG9lQGV4YW1wbGUuY29tIiwKICJwaWN0dXJlIjogImh0dHA6Ly9l
eGFtcGxlLmNvbS9qYW5lZG9lL21lLmpwZyIKfQ"
);
// Exemplary Payload:
/* 
{
 "iss": "http://server.example.com",
 "sub": "248289761001",
 "aud": "s6BhdRkqt3",
 "nonce": "n-0S6_WzA2Mj",
 "exp": 1311281970,
 "iat": 1311280970,
 "name": "Jane Doe",
 "given_name": "Jane",
 "family_name": "Doe",
 "gender": "female",
 "birthdate": "0000-10-31",
 "email": "janedoe@example.com",
 "picture": "http://example.com/janedoe/me.jpg"
}
*/
```


## Signature

Signature + algoritm identifier + additiona parameters (key) 
is used to prove that message content was not changed and was
created only by someone knowing private (symetric/asymetric) key.

Signature is value of function taking key, message, and other public
parameters. To verify signature against message, one who verifies
compute same function with same parameters. If values agree then ok,
if not this means that different keys was used or different messages
was used or different other parameters was used.

JWT signature is: 

```
base64(sign(alg, key)(<Base64EncHeader>.<Base64EncPayload>) = value)
``` 


```cs
// Base64 encoded exemplary signature:
JsonBase64StringToString(
@"rHQjEmBqn9Jre0OLykYNn
spA10Qql2rvx4FsD00jwlB0Sym4NzpgvPKsDjn_wMkHxcp6CilPcoKrWHcip
R2iAjzLvDNAReF97zoJqq880ZD1bwY82JDauCXELVR9O6_B0w3K-E7yM2mac
AAgNCUwtik6SjoSUZRcf-O5lygIyLENx882p6MtmwaL1hd6qn5RZOQ0TLrOY
u0532g9Exxcm-ChymrB4xLykpDj3lUivJt63eEGGN6DH5K6o33TcxkIjNrCD
4XB1CKKumZvCedgHHF3IAK4dVEDSUoGlH9z4pP_eWYNXvqQOjGs-rDaQzUHl
6cQQWNiDpWOl_lxXjQEvQ"
);
// exemplary signature (binary data displayed as UTF8):
/* 
�t#`j��k{C��F
��@�D*�j�ǁlM#�PtK)�7:`��9�����z
)Or��Xw"��<˼3@E�}�:	��<ѐ�o<ؐڸ%�-T};���
��N�3i�p? 4%0�):J:Q�\㹗(ȱ
��6��-���z�~Qd�4L��b�9�h=\���j�����U"��z��ރ���}�s������"��fo	�`qw �uQIJ�s��yf
^��:1����C5��Acb����q^4�
*/
```



# Signatures

Signature is not encryption, becaus signature is not decrypted (in
general), instead received signature is compared with generated
signature (specific generation may be decryption).

Signature is value to compare with value deduced from other things.

Common strategies:
- cryptographic hash of private key and message
- using encryption:
  - symetric keys algorithms:
    - AES private key encrypting message: `aes(key)(message)`. So
      signature have same length as message.
    - AES private key encrypting (any, no neccessarly cryptographic)
      hash of message: `aes(key)(hash(message))`. So signature have
      length of hash output.
  - asymetric keys algorithms:
    - RSA private key encrypt message 
    - RSA private key encrypt hash of message 


## MAC signature 

Message Authentication Code (MAC) is signature process abstraction.
MAC is used for data integrity. MAC algorithm:

- returns a tag given:
  - the key and 
  - the message. 
- A verifying algorithm efficiently verifies the authenticity of the
  message given:
  - the key and 
  - the tag and
  - the message. 

MAC is signature if only allowed parties have private key.


## HMAC signature

https://tools.ietf.org/html/rfc2104

HMAC is signature if only allowed parties have private key.
HMAC is secure. 

Hash Message Authentication Code (HMAC), 

- Strength of the HMAC depends upon the cryptographic strength of the
  underlying hash function, the size of its hash output, and the size
  and quality of the key
- HMAC does not encrypt the message. Instead, the message (encrypted
  or not) must be sent alongside the HMAC hash.
- HMAC uses two passes of hash computation. The secret key is first
  used to derive two keys – inner and outer. :
  - The first pass of the algorithm produces an internal hash derived
    from the message and the inner key.
  - The second pass produces the final HMAC code derived from the
    inner hash result and the outer key.
- An iterative hash function breaks up a message into blocks of a
  fixed size and iterates over them with a compression function. E.g.
  - SHA-256 operates on 512-bit blocks
  - The size of the output of HMAC is the same as that of the
    underlying hash function, for SHA-256 it is 256 bits

Example algotithm (https://en.wikipedia.org/wiki/HMAC):

```ts
function hmac(
  key:        Bytes,    // Array of bytes
  hash:       Function, // The hash function to use (e.g. SHA-1)
  message:    Bytes,    // Array of bytes to be hashed
  blockSize:  Integer,  // The block size of the hash function e.g.: 
                        // 64 bytes (512 bits) for SHA-1
                        // 64 bytes (512 bits) for SHA-256
  outputSize: Integer   // The output size of the hash function e.g. 
                        // 20 bytes (160 bits) for SHA-1
                        // 32 bytes (256 bits) for SHA-256
) {
  // Keys longer than blockSize are shortened by hashing them
  if (length(key) > blockSize)
      key = hash(key); // key is outputSize bytes long

  // Keys shorter than blockSize are padded 
  // to blockSize by padding with zeros on the right
  if (length(key) < blockSize)
      key = Pad(key, blockSize); // Pad key with zeros to
                                  // make it blockSize bytes long

  // o_key_pad = key xor [0x5c * blockSize]; // Outer padded key
  o_key_pad = key.map(byte => byte ^ 0x5c);  // 
  // i_key_pad = key xor [0x36 * blockSize]; // Inner padded key
  i_key_pad = key.map(byte => byte ^ 0x5c);  //

  return hash( o_key_pad.concat( hash( i_key_pad.concat(message) ) ) );
}
```


Usage:

```ts
HMAC_MD5("key", "The quick brown fox jumps over the lazy dog");
HMAC_SHA1("key", "The quick brown fox jumps over the lazy dog");
HMAC_SHA256("key", "The quick brown fox jumps over the lazy dog");

// 80070713463e7749b90c2dc24911e275
// de7c9b85b8b78aa6bc8a7a36f70a90701c9db4d9
// f7bc83f430538424b13298e6aa6fb143ef4d59a14946175997479dbc2d1a3cd8
```


HMAC is using private keys, irreversible hash functions (cryptographic
hashes e.g. SHA-256), and block cipher chaining mode algorithm.

- Result is fixed length hash obtained from message and specific parameters.
- For SHA-256 hash type, result is 256bit value.
- 2 partis (signer and verificator) must know shared secret key.

Example sign/verify:

```js

HMAC_pack = (
  key, 
  crypto_hash_func, 
  message, 
  blockBytes, 
  digestBytes
) => ({
  message: message, 
  singature: HMAC(
    key, 
    crypto_hash_func, 
    message, 
    blockBytes, 
    digestBytes
  )
});

HMAC_verify(
  key, 
  crypto_hash_func, 
  pack, 
  blockBytes, 
  digestBytes
) => 
  pack.HMAC === HMAC(key, crypto_hash_func, message, blockBytes, digestBytes)

const key = "X";
const key_tempered = "Y";
const message = "yo yo";
const message_tempered = "yo_yo";
const pack = HMAC_pack(key, SHA256, message, 64, 32);
const pack_message_tempered = {
  message: message_tempered, 
  signature: pack.signature
};
const pack_signature_tempered = {
  message: message_tempered, 
  signature: HMAC(key_tempered, SHA256, message_tempered, 64, 32)
};

assert_true (HMAC_verify(key, SHA256, pack, 64, 32));
assert_false(HMAC_verify(key, SHA256, pack_message_tempered, 64, 32));
assert_false(HMAC_verify(key, SHA256, pack_signature_tempered, 64, 32));

```



## HMAC and message encryption

Encrypted autentication may be not secure 
in following configurations:
- mac then encrypt
- mac and encrypt

This is compared to security of encryption and mac alone.

## AEAD (secure MAC and Encryption schemes)

AEAD is group of algorithms and abstract algorithms
working with building blocks algoritms checked to 
be secure for encryption and authentication.

https://tools.ietf.org/html/rfc5246#section-6.2.3.3

## AEAD: Encrypt-then-MAC (EtM) 


```cs
if(key_1 == key_2) throw new Error();
encryption(alg_1, key_1)(message) + 
  HMAC_hash(hash_func, key_2)(encryption(alg_1, key_1)(message))
```

Result is encrypted message (of message length bits) and hash of
encrypted message (of fixed length) obtained from encrypted
message and specific parameters. For SHA-256 hash type and AES
encryption, result is length(message) + 256 bit value.

## AEAD: AES GCM

GCM is block cipher operation mode allowing both
encryption and authentication - it is **AEAD**.

On Net.Core ther is class implementin algorithm for AES ciphers:

> Name: `System.Security.Cryptography.AesGcm Class`
> Assembly: `System.Security.Cryptography.Algorithms.dll`
> 
> Represents an Advanced Encryption Standard (AES) key to be used with
> the Galois/Counter Mode (GCM) mode of operation.
> 
> [From MSDN AesGcm Class](https://docs.microsoft.com/en-us/dotnet/api/system.security.cryptography.aesgcm?view=netcore-3.1)


Further description of GCM:

> In cryptography, Galois/Counter Mode (GCM) is a mode of operation
> for symmetric-key cryptographic block ciphers widely adopted for its
> performance. GCM throughput rates for state-of-the-art, high-speed
> communication channels can be achieved with inexpensive hardware
> resources. The operation is an authenticated encryption algorithm
> designed to provide both data authenticity (integrity) and
> confidentiality. GCM is defined for block ciphers with a block size
> of 128 bits. Galois Message Authentication Code (GMAC) is an
> authentication-only variant of the GCM which can form an incremental
> message authentication code. Both GCM and GMAC can accept
> initialization vectors of arbitrary length.
> 
> Different block cipher modes of operation can have significantly
> different performance and efficiency characteristics, even when used
> with the same block cipher. GCM can take full advantage of parallel
> processing and implementing GCM can make efficient use of an
> instruction pipeline or a hardware pipeline. The cipher block
> chaining (CBC) mode1 of operation incurs pipeline stalls that hamper
> its efficiency and performance. 
>
> [From Wikipedia Galois/Counter Mode](https://en.wikipedia.org/wiki/Galois/Counter_Mode)


Exemplary use:

```cs
// ****************************************************
// * using System.Secutity.Cryptography;
// * #r "System.Security.Cryptography.Algorithms.dll"
// * file enc: utf8
// ****************************************************
// *   AEAD AesGcm (Encryption/Decryption, MAC)
// ****************************************************

public static (string packageJwt, string keyBase64, string nonceBase64) AesGcmEncrypt(
  string key     = "secret key is ok but 32B is must",    // <- must be 32 bytes
  string nonce   = "123456789ABC",                        // <- must be 12 bytes
  string message = "some text to encrypt using AES GCM"
) {
  byte[] keyBytes = 
    Encoding.UTF8.GetBytes(key);
  byte[] nonceBytes =               // AES GCM requires 12 bytes
    Encoding.UTF8.GetBytes(nonce);  // The security guarantees of the
                                    // AES-GCM algorithm mode require
                                    // that the same nonce value is
                                    // never used twice with the same key.
  // new Random((int) DateTime.Now.TimeOfDay.Ticks)
  //   .NextBytes(nonceBytes);      // random nonce
  byte[] plaintextBytes = 
    Encoding.UTF8.GetBytes(message);
  byte[] ciphertextBytes = 
    new byte[plaintextBytes.Length];
  byte[] tagBytes = new byte[16];   // 12, 13, 14, 15, or 16 bytes 
                                    // (96, 104, 112, 120, or 128 bits).
  var assocData = 
    "{\"alg\"=\"AesGcm\"}";
  var assocDataBytes = 
    Encoding.UTF8.GetBytes(assocData);
  // var associatedData = JsonSerializer
  //   .SerializeToUtf8Bytes(
  //     new Dictionary<string,string>(){
  //       {"alg", "AesGcm"} 
  //     }
  //     , new JsonSerializerOptions() {
  //       WriteIndented = true     // pretty print
  //     } 
  //   );
  AesGcm aes_gcm_encrypting = new AesGcm(
    keyBytes                        // must be: 16, 24, or 32 bytes 
                                    // (128, 192, or 256 bits)
  );
  aes_gcm_encrypting.Encrypt(
    nonce: nonceBytes,              // must be: 12 bytes (96 bits)
                                    // The nonce associated with this message, 
                                    // which should be a unique value for every
                                    // operation with the same key.
    plaintext: plaintextBytes,      // message to encrypt
    ciphertext: ciphertextBytes,    // byte array wher write encrypted message
    tag: tagBytes,                  // byte array where write message MAC
                                    // must be: 12, 13, 14, 15, or 16 bytes 
                                    // (96, 104, 112, 120, or 128 bits).
    associatedData: assocDataBytes  // data not encrypted but probably signed
                                    // identical must be during decryption
                                    // or decryption will fail
  );

  var packageJwt = 
    Base64UrlEncoder.Encode(assocDataBytes) +  // header
    "." +                                      // .
    Base64UrlEncoder.Encode(ciphertextBytes) + // payload
    "." +                                      // .
    Base64UrlEncoder.Encode(tagBytes);         // signature


  return (
    packageJwt: packageJwt, 
    keyBase64: Base64UrlEncoder.Encode(key), 
    nonceBase64: Base64UrlEncoder.Encode(nonceBytes)
  );
}

public static (string message, string associatedData) AesGcmDecrypt(
  string packageJwt,
  string keyBase64,
  string nonceBase64
) {

  var parts = Regex.Split(packageJwt, @"\.");
  var headerBytes = Base64UrlEncoder.DecodeBytes(parts[0]);
  var payloadBytes = Base64UrlEncoder.DecodeBytes(parts[1]);
  var signatureBytes = Base64UrlEncoder.DecodeBytes(parts[2]);

  var keyBytes = Base64UrlEncoder.DecodeBytes(keyBase64);
  var nonceBytes = Base64UrlEncoder.DecodeBytes(nonceBase64);

  var plaintextBytes = new byte[payloadBytes.Length];

  AesGcm aes_gcm_decrypting = new AesGcm(keyBytes);
  aes_gcm_decrypting.Decrypt(
    nonce: nonceBytes,
    ciphertext: payloadBytes,
    tag: signatureBytes,
    plaintext: plaintextBytes,
    associatedData: headerBytes
  );

  return (
    message: Encoding.UTF8.GetString(plaintextBytes),
    associatedData: Encoding.UTF8.GetString(headerBytes)
  );
}

public static (string message, string associatedData) AesGcmDecrypt(
  string packageJwt, 
  string key   = "secret key is ok but 32B is must", // must be 32B passphrase
  string nonce = "123456789ABC"                      // must be 12B nonce
) {
  return AesGcmDecrypt(
    packageJwt: packageJwt, 
    keyBase64: Base64UrlEncoder.Encode(key), 
    nonceBase64: Base64UrlEncoder.Encode(nonce) 
  );
}

public static void PrintJwtAesGcmEncryptionDecryption() {
  Console.WriteLine();
  Console.WriteLine("Generating JWT using AesGcm of message:");
  var message = "some text to encrypt using AES GCM";
  Console.WriteLine(message);
  Console.WriteLine();
  Console.WriteLine("Encrypting ...:");
  (var packageJwt, _ , _ ) = AesGcmEncrypt(
    key:    "secret key is ok but 32B is must",
    nonce:  "123456789ABC",
    message: message
  );
  Console.WriteLine();
  Console.WriteLine("JWT AES GCM::");
  Console.WriteLine(packageJwt);
  Console.WriteLine();
  Console.WriteLine("Decrypting ...:");
  var decrypted = AesGcmDecrypt(
    packageJwt: packageJwt,
    key:    "secret key is ok but 32B is must",
    nonce:  "123456789ABC",
  );
  Console.WriteLine();
  Console.WriteLine("Decrypted message:");
  Console.WriteLine(decrypted);
}
```

## AEAD: AES CCM


https://docs.microsoft.com/en-us/dotnet/api/system.security.cryptography.aesccm?view=netcore-3.1


AesCcm Class Definition:

- Represents an Advanced Encryption Standard (AES) key to be used with
  the Counter with CBC-MAC (CCM) mode of operation.
- Namespace: System.Security.Cryptography 
- Assembly: System.Security.Cryptography.Algorithms.dll








# Hash algorithms

Hash is one way function producing value of fixed size.


Cryptografic hash functions:
- SHA1 (obsolate)
- SHA2 (group)
- ...

## SHA-2

https://en.wikipedia.org/wiki/SHA-2

The SHA-2 family consists of six hash functions:

- `SHA-224    ` => digest: 224 , output: 224
- `SHA-256    ` => digest: 256 , output: 256
- `SHA-384    ` => digest: 384 , output: 384
- `SHA-512    ` => digest: 512 , output: 512
- `SHA-512/224` => digest: 512 , output: 224 (truncation)
- `SHA-512/256` => digest: 512 , output: 256 (truncation)


## Hash function properties

https://en.wikipedia.org/wiki/SHA-2

For a hash function for which `L` is the number of bits in the message
digest (hash of message have L bits):

- The first criterion, finding a message that corresponds to a given
  message digest can always be done using a brute force search in
  `2^L` evaluations. This is called a preimage attack and may or may
  not be practical depending on `L` and the particular computing
  environment. 
- The second criterion, finding two different messages that produce
  the same message digest, known as a collision, requires on average
  only `2^(L/2)` evaluations using a birthday attack. 


## What is digest?


> The SHA-2 family consists of six hash functions with **digests**
> (hash values) that are 224, 256, 384 or 512 bits: SHA-224, SHA-256,
> SHA-384, SHA-512, SHA-512/224 (output truncated to 224 bits), 
> SHA-512/256 (output truncated to 256 bits). 
>
> [From Wikipedia SHA-2](https://en.wikipedia.org/wiki/SHA-2)


# Asymetric keys

Normally asymetric keys are used for
protecting only small amount of data, which allows for
- encryption
- signature: just (RSA) encrypt hash of the message with properties:
  - signer is person having private key
  - orginal hash can be recovered only knowing public key
  - this way message forgery can be detected
  - (from signature only message cannot be recovered)
  - message is visible for anyone having access to transmission chanel
- secret shared between 2 parties (each party have its own private key) (DH key exchange), 
  - this shared secret + public symetric key algoritm declaration can be used
    to encrypt messages
    - then those messages can be used to verify each using challenges (decrypt message using your private key)
      - then those messages can be used to securely exchange messages between parties
        posessing private keys
    - varification can fail, but if successful it 
      guaranties confidentiality and authority (using signatures chains, certificates
      are just signed messages, so their chains to trusted certificate/signature can
      prove oryginal certificate/signature).
    - public key of assumed party must be known to verify this party 
- shared secret only with persons possessing private key


Usages:
- encryption : rarely
- signatures
- shared secret generation

# Asymetric keys - RSA

## Key length

## Encryption

## Decryption

## Shared secret for secure anonymous chanel


# Signature

# Certificate

# JWT

# Use case

There is custom identity server which:
- stores users
  - verified by passwords
- stores apps
  - verified by certificates
- stores itself identyty
  - verified by cert
- sends tokens containig at max:
  - name, email, phone

Custom identity server provides:
- user registration (password)
- user unregistration (password)
- user informations management (password)
  - apps allowances
  - name, email, phone
- app registration (cert)
- app unregistration (cert)
- JWE tokens => anyone ability to request for token for specific app
  (or child app having parent app cert in chain)
  if successfully signed in with password or
  with active session and agreed to token request claims


Custom identity server (CIS) creates JWEs
- signed with its cert => this way anyone can verify that
  token was created by CIS
- encrypted using registered app public key => this
  way only server having private key of registered public
  key can decrypt token and decide what to do with it

CIS token can be trusted as only true user can obtain user info.
This user info can be then used to register or login user
('SingInOrRegisterAndSignIn using CIS' button).

Apps relaying on CIS tokens for signIn/register users distinguis users
only based on CIS_user_id .

Addon:
- Optionally registered app can specify that it can fransfer service
  to other entity which have app cert in chain, then token requestor
  must provide CIS valid certificates chain, then CIS will encrypt
  token using chain ending certificate.


# Use case 2

Store user things at user in open but encrypted.
Send only neccessery parts by haveing many tokens
with overlaping items.

App have in (session?) cookie password for encryption/decryption
(using for example AEAD AES GCM).

The other way is that user things must be taken every time from db by
server. 

(Check Asp.Net Core session examples) (Session cookie is cookie with
timeout 20min and reset on browser shutdown and associated host. All
Cookies matching host are send to host automatically every time
request to host is made.)
(Session cookie is not neccessery for SPA because its functionality
is indifferrent from storing data in js variable. But of course
server redirections will destroy this storage)

Tokens creator service can be accessed using password (first access
is by direct access and redirection to oryginal app service, keeping
shared password in http for further indirect communication).




