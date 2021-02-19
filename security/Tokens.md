

# "Simple" OAuth 2.0

OAuth advertisement:

* Instead of using the resource owner's credentials to access protected
  resources, the client obtains an access token
  * a string denoting a specific scope, lifetime, and other 
    access attributes.  
* Access tokens are issued to third-party clients 
  * by an authorization server 
  * with the approval of the resource owner.  
* The client uses the access token to access the protected resources 
  hosted by the resource server.

Entities listed:

* Authorization server
  * Authorization server credentials
* Resource server
  * Resource server credentials
* Client
  * Client credentials
* Resource owner
  * Owner credentials
* (Access )Token composite credentials:
  * resource server credentials
  * client credentials
  * resources scope
  * validity period

# OpenId Connect 1.0

Links:

* https://identityserver4.readthedocs.io/en/latest/
* https://identityserver4.readthedocs.io/en/latest/intro/specs.html


OIDC INPUTS ARE APPLICATIONS!!! DISTINGUISHED BY:
* urls                     (public clients)
* urls + users             (confidential clients)
* agreed secrets           (public clients)
* agreed secrets + users   (confidential clients)
* ... or 
  * whatever wanted 
  * & implemented
  * & agreed


## OpenId Connect endpoints

* authorize 
* token
* discovery

## Token types

* Identity Token - outcome of an authentication process. 
  It contains at a bare minimum:
  *  an identifier for the user (called the sub aka subject claim) 
  * and information about how and when the user authenticated. 
  * It can contain additional identity data.
* Access Token - allows access to an API resource. 
  * Clients request access tokens 
  * and forward them to the API.
  * Access tokens contain information about:
    * the client 
    * and the user (if present)
  * APIs use that information to authorize access to their data.


## Using Access Tokens

* request the access and refresh token at login time
* cache those tokens
* use the access token to call APIs until it expires
* use the refresh token to get a new access token
* start over

## Keeping things at developement

* Secret Manager tool can be used to keep strings separate from codebase.
* 
  ```
  $> dotnet user-secrets set ConnectionStrings.Chinook \
     "Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=Chinook"
  ```
* 
  ```
  $> dotnet ef dbcontext scaffold \
     Name=ConnectionStrings.Chinook \
     Microsoft.EntityFrameworkCore.SqlServer
  ```






## Oidc state

* for your application itself:
  * ClientId (login)
  * ClientSecret (password)

## Grant types

Grant types (how parties communicate and authorize itselfs)
(grant type + grant params are combained in request)
https://tools.ietf.org/html/rfc6749#section-1.3:

* Client credentials (OAuth2) (not neccessating interactivity):
  * secret login (stored at client and auth serv) : ClientId
  * secret password (stored at client and auth serv) : ClientSecret
* Code (OpenId Connect) (interactive):
  * Authorization Code Flow (with PKCE extension)
    (RFC 7636 - Proof Key for Code Exchange (PKCE)
    https://tools.ietf.org/html/rfc7636):
    * client have :
      * clientId
      * per-request secret 
      * SHA256 hash of per-request secret 
    * client sends hash of per-request secret and clientId by browser
    * auth server responds with code by browser
    * client sends code and secret (by TLS secure channel) to auth server
    * auth server responds with token
  * code idtoken (OpenID Connect Hybrid Flow)
    * same as above but instead of sending code,
      auth serv responses with code and idToken (refering also code in claim)
    * to exchange this to access token
      * client sends code and idToken to auth serv

In case of a web application talking to your server, 
it could use the authorization code grant. 
If it's an untrusted client like a mobile application 
or a JavaScript app, it should use the implicit grant.

For backend services which can't interact with a resource owner, 
you can use client credentials grant. For command line tools, 
you could use either client credentials or the resource owner


## Strategy

* client registration
  * generate client id (app login)
  * ensure that id tokens / access tokens will go to expected client:
    * if client can keep secrets (servers can) generate client secret  
      (app pass) then https and regisered url will ensure delivery
    * if client can not keep secrets (browsers) https and challange 
      (per request secret and secret verivier, app one time pass, this
      is specified as PKCE) will ensure delivery
  * client address to return auth code and perform conversation
* code flow with PKCE
* support for identity 
  * must be endpoint and option selecting this, returning id token
* support for access with scopes (access token)
  * scopes structure (mapping between scope and apis 
    and its restrictions, defined as needed)
* it is good idea if client have cookie session with auth serv
  [Silent Refresh - Refreshing Access Tokens when using the Implicit Flow](https://www.scottbrady91.com/OpenID-Connect/Silent-Refresh-Refreshing-Access-Tokens-when-using-the-Implicit-Flow)
* validation by hand: 
  https://docs.microsoft.com/en-us/office/dev/add-ins/outlook/validate-an-identity-token
* security of browser storadge:
  * browser storage can be quite secure if one uses content policy
    (third party libraries are checked and trusted)


## Public clients

most authorization servers will not issue refresh tokens 
to JavaScript apps, because they are more risky. With public 
clients, the refresh token is extremely powerful, since it 
can be used without a secret, so many providers eliminate 
this risk by just not issuing refresh tokens to any kind 
of public client.

how do we keep the user from having to authenticate again 
to get a new Access Token?

There are generally two ways, both rely on the user having 
an active session at the authorization server, which is key 
to the security of both. Either you can send the user back 
through the whole authorization code redirect flow again 
(which happens so fast they won't even see it), or you can 
use the hidden iframe technique that's part of 
OpenID Connect to do that flow invisibly.


Is it safe to store the `pkce_state` and `pkce_code_verifier` 
in localstorage? What's the likelihood of someone being able 
to access it and intercept the authorization_code before our 
app does?

  That's about the best you can do. There's always a possibility 
  something can steal data out of LocalStorage, but as long as 
  you're taking all the precautions against XSS, and have a strong 
  content security policy to limit the number of third-party JS 
  libraries on your site, that's about the best security you can 
  get in a browser. There are some good tips on browser security 
  from OWASP here: 
  https://cheatsheetseries.owasp.org/cheatsheets/HTML5_Security_Cheat_Sheet.html


# OAuth server structure


## JWT Structure

* scope - whitelist of scopes
* client_id - client (user) of token identifier
* exp - expirience date
* iat - issuance data
* sub - name of client (prefer url)
* iss - name of issuer (prfer url)
* jti - this token identifier for matching in
        access token extra data database

```
  {
    to: resuorce
    from: scoped password
    allowed by: auth server
    message type: scoped-autorization
    message data:
    {
      scope: write
    }
  }.signature
```

* OpenId JWT standard is described at:
  * RFC 7519 and 
  * OpenID Connect Core 1.0
* Useful informations about validating/signing Jwt:
  * https://stackoverflow.com/questions/35648544/validate-jwt-token-in-c-sharp-using-jwk
  * https://stackoverflow.com/questions/10055158/is-there-any-json-web-token-jwt-example-in-c
* Useful information about authorization framework in asp.net core:
  * https://docs.microsoft.com/en-us/azure/active-directory/develop/scenario-protected-web-api-verification-scope-app-roles
  * https://docs.microsoft.com/en-us/azure/active-directory/develop/scenario-protected-web-api-app-configuration#bearer-token




## Api Structure

* Authorization - ask for token
  * name: auth endpoint
  * example url: https://example.com/auth 
  * method:  GET (POST?)
* Token - get token (using info from ask)
  * name: token endpoint
  * standard: “1.4. Access Token” of RFC 6749
  * example url: https://example.com/token
  * method: POST
* Introspection (of token) - ask for token content
  * name: introspection endpoing
  * standard: RFC 7662 (OAuth 2.0 Token Introspection)
  * example url: https://example.com/introspect
* UserInfo - ask user informations using access? (id?) token
  * name: UserInfo endpoing
  * example url: https://example.com/UserInfo
  * response: JSON
* Discovery - agreed url for asking OpenId Connect server configuration
  * name: discovery endpoint, configuration endpoing
  * standard: RFC 7517
  * example url: https://example.com/.well-known/openid-configuration
* Certificates - get list of server public keys
  * name: introspection endpoint, jwks endpoing
  * standard: JWK Set document (RFC 7517)
  * example url: https://example.com/certs
* Resource server introspection - ask resource server for its signing keys url
  * name: introspection
  * standard: OAuth 2.0 Protected Resource Metadata 
    https://tools.ietf.org/html/draft-jones-oauth-resource-metadata-01
  * example url: 
    https://resource.example.com/res1/.well-known/oauth-protected-resource
  * complications: 
    introspection endpoint would like to know resource
    server private key to decrypt JWEs
    * solution 1: introspection returns error for JWEs
    * solution 2: no introspection
* Revocation
    * name: revocation endpoint
    * example url: https://example.com/revoke
    * requires: that each access token must be uniquely identifiable
    * verification: 

      When a resource server receives an access token, 
      it must check revocation status of the access token.

      * CRL (Certificate Revocation List) mechanizm: 
        the resource server will download the list of revoked 
        access tokens from somewhere and check whether the unique 
        identifier of the access token is included in the list or not.
      * OCSP (Online Certificate Status Protocol) mechanizm: 
        the resource server will pass the unique identifier of the
        access token to an API equivalent to “OCSP responder” and 
        get revocation status of the access token in return.
    * comment: 

      requirements of revocation defites adventages of 
      self-contained token, so either issue short lived 
      self-contained tokens and disable revocation, 
      or use referential tokens with enabled revocation.


# Storing tokens in databases possibilities


* EntityFramework:
  * migrations:
    https://www.learnentityframeworkcore.com/migrations
    https://medium.com/@hasangi/everything-you-wanna-know-about-ef-core-migrations-ca6f0926f71d
    https://stackoverflow.com/questions/63575132/how-to-customize-migration-generation-in-ef-core-code-first
  * reverse-engeenering:
    https://docs.microsoft.com/en-us/ef/core/managing-schemas/scaffolding
  * fundamentals: 
    https://docs.microsoft.com/en-us/ef/ef6/fundamentals
* Dapper
* Memory
* Files serialization
* vanilla SQL (System.Data.SqlClient, SqlConnection, SqlCommand)
* DBContext abstraction for Dependency Injection 


# OAuth 2.0 Client-Server

## Server

Must have:
  * certificate from PKI root cert
    (server certificate)
  * or certificate from root who
    is trusted by client
    (server company private certificate)
  * https protected endpoint with
    valid public keys for signing tokens
    (enpoint name protocol defined)
  * sign message according to protocol
  * endpoint serving responses for tokens
  * verifiable target of token (client url)


## Client

Must have:

  * access to PKI (system root certificates)
    for server verification
  * or private root certificate repository
    for server verification
  * token (signed message) is according
    to protocol (OAuth2)
  * token must have:
    * service address
  * token usage may be:
    * standarised (protocol defined endpoint)
    * per server (implied for particular server)
    
Client sends request (as token) and receives
response (as token)

# OpenId Connect 1.0 (OIdC) Server

* Endpoints of OpenIdConnect enabled server
  can be discovered by using:
  * server.com/.well-known/webfinger
  * webfinger is protocol of defined
    query parameters (call) and shape
    of returned values (JSON jrd)

# OpenId Connect 1.0 Specs notes

https://openid.net/specs/openid-connect-core-1_0.html

## 5.3.  UserInfo Endpoint

  The UserInfo Endpoint is an OAuth 2.0 Protected Resource 
  that returns Claims about the authenticated End-User. 
  To obtain the requested Claims about the End-User, the 
  Client makes a request to the UserInfo Endpoint using an 
  Access Token obtained through OpenID Connect Authentication. 
  These Claims are normally represented by a JSON object 
  that contains a collection of name and value pairs 
  for the Claims. 

## 5.5.  Requesting Claims using the "claims" Request Parameter

  OpenID Connect defines the following Authorization Request 
  parameter to enable requesting individual Claims and 
  specifying parameters that apply to the requested Claims:

    claims
        OPTIONAL. This parameter is used to request that 
        specific Claims be returned. The value is a JSON 
        object listing the requested Claims. 

  Using the claims parameter is the only way to request 
  Claims outside the standard set. It is also the only way 
  to request specific combinations of the standard Claims 
  that cannot be specified using scope values. 

## 5.6.  Claim Types

  Three representations of Claim Values are defined 
  by this specification:

    Normal Claims
      Claims that are directly asserted by the OpenID Provider. 
    Aggregated Claims
      Claims that are asserted by a Claims Provider other 
      than the OpenID Provider but are returned by 
      OpenID Provider. 
    Distributed Claims
      Claims that are asserted by a Claims Provider other 
      than the OpenID Provider but are returned as references 
      by the OpenID Provider. 

Normal Claims MUST be supported. 
Support for Aggregated Claims and Distributed Claims is OPTIONAL.

## 5.6.2.2.  Example of Distributed Claims

The OpenID Provider returns Jane Doe's Claims 
along with references to the Distributed Claims 
from Claims Provider B and Claims Provider C by sending 
the Access Tokens and URLs of locations from which 
the Distributed Claims can be retrieved: 

```json
{
  "name": "Jane Doe",
  "given_name": "Jane",
  "family_name": "Doe",
  "email": "janedoe@example.com",
  "birthdate": "0000-03-22",
  "eye_color": "blue",
  "_claim_names": {
    "payment_info": "src1",
    "shipping_address": "src1",
    "credit_score": "src2"
    },
  "_claim_sources": {
    "src1": {"endpoint":
                "https://bank.example.com/claim_source"},
    "src2": {"endpoint":
                "https://creditagency.example.com/claims_here",
              "access_token": "ksj3n283dke"}
  }
}
```

## 6.1.  Passing a Request Object by Value

## 7.  Self-Issued OpenID Provider

  OpenID Connect supports Self-Issued OpenID Providers 
  - personal, self-hosted OPs that issue self-signed ID Tokens. 
  Self-Issued OPs use the special Issuer Identifier 
  https://self-issued.me. 

## 8.  Subject Identifier Types
## 8.1.  Pairwise Identifier Algorithm

(Sector Identifier: Host component of a URL used by 
the Relying Party's organization that is an input 
to the computation of pairwise Subject Identifiers 
for that Relying Party.)

Sector Identifier used for pairwise identifier calculation 
is the host component of the registered redirect_uri. 
If there are multiple hostnames in the registered redirect_uris, 
the Client MUST register a sector_identifier_uri.

The Sector Identifier can be concatenated with a local account ID 
and a salt value that is kept secret by the Provider. 
The concatenated string is then hashed using an appropriate algorithm.

```
Calculate sub = SHA-256 ( sector_identifier || local_account_id || salt ).
```

## 9.  Client Authentication
## 15.1.  Mandatory to Implement Features for All OpenID Providers
## 15.2.  Mandatory to Implement Features for Dynamic OpenID Providers


# What is http server ?

* It is running function with: 
  * OS registered functions for 
    * receiving network messages
    * and sending network messages
  * function transforming OS messages to object representing
    network requests and responses
  * function pointers buffer for:
    * registering (user) functions which will be called
      with network request objects and would return 
      response object
* behaviour of this function can be customised:
  * before running this function
  * or dynamically by memory or OS messaging service

# What is GUI server ?
    

* It is running function with: 
  * OS registered functions for 
    * receiving mouse position messages
    * keyboard keystrokes
  * with ability to register (user) components layered
    one on other
  * with ability to register (user) handlers of those components
    which could receive mouse position messages
    only when component is top level below mouse
  * with ability to specify colour (or colour function)
    of those components
* Behaviour of this function can be customised:
  * before running this function
  * or dynamically by memory or OS messaging services
* Normally this function will be running on one thread
  and customisation will be performed from inside


