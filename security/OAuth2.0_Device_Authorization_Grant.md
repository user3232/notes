??? od tego miejsca po ???KONIEC wiersze mogą być włożone/skasowane
@ OAuth 2.0 Device Authorization Grant


# Links

* [RFC 8628](https://tools.ietf.org/html/rfc8628)
* [GitHub implementation for git CLI](https://docs.github.com/en/developers/apps/authorizing-oauth-apps#device-flow)
* [GitHub implementation for GitHubApps](https://docs.github.com/en/developers/apps/authorizing-oauth-apps#device-flow)

# Intro

> The authorization flow defined by
> this specification, sometimes referred to as the "device flow",
> instructs the user to review the authorization request on a secondary
> device, such as a smartphone, which does have the requisite input and
> browser capabilities to complete the user interaction.

The operating requirements for using this authorization grant type
   are:

The operating requirements for using this authorization grant type
   are:

1. The device is already connected to the Internet.
2. The device is able to make outbound HTTPS requests.
3. The device is able to display or otherwise communicate a URI and
   code sequence to the user.
4. The user has a secondary device (e.g., personal computer or
   smartphone) from which they can process the request.

Instead of interacting directly with the end user's user agent (i.e.,
browser), the device client instructs the end user to use another
computer or device and connect to the authorization server to approve
the access request.  Since the protocol supports clients that can't
receive incoming requests, clients poll the authorization server
repeatedly until the end user completes the approval process.


Flow diagram:

```
      +----------+                                +----------------+
      |          |>---(A)-- Client Identifier --->|                |
      |          |                                |                |
      |          |<---(B)-- Device Code,      ---<|                |
      |          |          User Code,            |                |
      |  Device  |          & Verification URI    |                |
      |  Client  |                                |                |
      |          |  [polling]                     |                |
      |          |>---(E)-- Device Code       --->|                |
      |          |          & Client Identifier   |                |
      |          |                                |  Authorization |
      |          |<---(F)-- Access Token      ---<|     Server     |
      +----------+   (& Optional Refresh Token)   |                |
            v                                     |                |
            :                                     |                |
           (C) User Code & Verification URI       |                |
            :                                     |                |
            v                                     |                |
      +----------+                                |                |
      | End User |                                |                |
      |    at    |<---(D)-- End user reviews  --->|                |
      |  Browser |          authorization request |                |
      +----------+                                +----------------+
```


# Device Authorization Request

The client initiates the authorization flow by requesting a set of
verification codes from the authorization server by making an HTTP
"POST" request to the device authorization endpoint.
by including the following parameters using the 
"application/x-www-form-urlencoded" format, with a character 
encoding of UTF-8 in the HTTP request entity-body:

* client_id
* scope

For example:

```http
POST /device_authorization HTTP/1.1
Host: server.example.com
Content-Type: application/x-www-form-urlencoded

client_id=1406020730&scope=example_scope

```

All requests from the device MUST use the Transport Layer Security
(TLS) protocol.

The client authentication requirements of Section 3.2.1 of [RFC6749]
apply to requests on this endpoint, which means that confidential
clients (those that have established client credentials) authenticate
in the same manner as when making requests to the token endpoint, and
public clients provide the "client_id" parameter to identify
themselves.

Due to the polling nature of this protocol (as specified in
Section 3.4), care is needed to avoid overloading the capacity of the
token endpoint.  To avoid unneeded requests on the token endpoint,
the client SHOULD only commence a device authorization request when
prompted by the user and not automatically, such as when the app
starts or when the previous authorization session expires or fails.

# Device Authorization Response

In response, the authorization server generates a unique device
verification code and an end-user code that are valid for a limited
time and includes them in the HTTP response body using the
"application/json" format [RFC8259] with a 200 (OK) status code.  The
response contains the following parameters:

* device_code: REQUIRED. The device verification code.

* user_code: REQUIRED.The end-user verification code.

* verification_uri: REQUIRED. The end-user verification URI on the authorization
  server.  The URI should be short and easy to remember as end users
  will be asked to manually type it into their user agent.

* verification_uri_complete: OPTIONAL. A verification URI that includes the 
  "user_code" (or other information with the same function as the "user_code"),
   which is designed for non-textual transmission.

* expires_in: REQUIRED. The lifetime in seconds of the "device_code" and
  "user_code".

* interval: OPTIONAL. The minimum amount of time in seconds that the client
  SHOULD wait between polling requests to the token endpoint.  If no
  value is provided, clients MUST use 5 as the default.


Example:

```http
      HTTP/1.1 200 OK
      Content-Type: application/json
      Cache-Control: no-store

      {
        "device_code": "GmRhmhcxhwAzkoEqiMEg_DnyEysNkuNhszIySk9eS",
        "user_code": "WDJB-MJHT",
        "verification_uri": "https://example.com/device",
        "verification_uri_complete":
            "https://example.com/device?user_code=WDJB-MJHT",
        "expires_in": 1800,
        "interval": 5
      }
```

# User Interaction

After receiving a successful authorization response, the client
displays or otherwise communicates the "user_code" and the
"verification_uri" to the end user and instructs them to visit the
URI in a user agent on a secondary device (for example, in a browser
on their mobile phone) and enter the user code.

```
            +-----------------------------------------------+
            |                                               |
            |  Using a browser on another device, visit:    |
            |  https://example.com/device                   |
            |                                               |
            |  And enter the code:                          |
            |  WDJB-MJHT                                    |
            |                                               |
            +-----------------------------------------------+
```


The authorizing user navigates to the "verification_uri" and
authenticates with the authorization server in a secure TLS-protected
[RFC8446] session.  The authorization server prompts the end user to
identify the device authorization session by entering the "user_code"
provided by the client.  The authorization server should then inform
the user about the action they are undertaking and ask them to
approve or deny the request.  Once the user interaction is complete,
the server instructs the user to return to their device.

During the user interaction, the device continuously polls the token
endpoint with the "device_code", as detailed in Section 3.4, until
the user completes the interaction, the code expires, or another
error occurs.  The "device_code" is not intended for the end user
directly; thus, it should not be displayed during the interaction to
avoid confusing the end user.


# Device Access Token Request

After displaying instructions to the user, the client creates an
access token request and sends it to the token endpoint (as defined
by Section 3.2 of [RFC6749]) with a "grant_type" of
"urn:ietf:params:oauth:grant-type:device_code".  This is an extension
grant type (as defined by Section 4.5 of [RFC6749]) created by this
specification, with the following parameters:

* grant_type: REQUIRED. Value MUST be set to
  "urn:ietf:params:oauth:grant-type:device_code".

* device_code: REQUIRED. The device verification code, 
  "device_code" from the device authorization response, 
  defined in Section 3.2.

* client_id: REQUIRED if the client is not authenticating with the
   authorization server as described in Section 3.2.1. of [RFC6749].
   The client identifier as described in Section 2.2 of [RFC6749].

For example, the client makes the following HTTPS request (line
breaks are for display purposes only):

```
POST /token HTTP/1.1
Host: server.example.com
Content-Type: application/x-www-form-urlencoded

grant_type=urn%3Aietf%3Aparams%3Aoauth%3Agrant-type%3Adevice_code
&device_code=GmRhmhcxhwAzkoEqiMEg_DnyEysNkuNhszIySk9eS
&client_id=1406020730
```

If the client was issued client credentials (or assigned other
authentication requirements), the client MUST authenticate with the
authorization server as described in Section 3.2.1 of [RFC6749].

> Confidential clients are typically issued (or establish) a set of
> client credentials used for authenticating with the authorization
> server (e.g., password, public/private key pair).
> 
> The authorization server MAY establish a client authentication method
> with public clients.  However, the authorization server MUST NOT rely
> on public client authentication for the purpose of identifying the
> client.
> 
> The client MUST NOT use more than one authentication method in each
> request.
> [RFC 6749 Sect. 2.3 Client Authentication](https://tools.ietf.org/html/rfc6749#section-2.3)


# Device Access Token Response

If the user has approved the grant, the token endpoint responds with
a success response defined in Section 5.1 of [RFC6749]; otherwise, it
responds with an error, as defined in Section 5.2 of [RFC6749].

In addition to the error codes defined in Section 5.2 of [RFC6749],
the following error codes are specified for use with the device
authorization grant in token endpoint responses:

* authorization_pending: 

  The authorization request is still pending as the end user hasn't
  yet completed the user-interaction steps (Section 3.3).  The
  client SHOULD repeat the access token request to the token
  endpoint (a process known as polling).  Before each new request,
  the client MUST wait at least the number of seconds specified by
  the "interval" parameter of the device authorization response (see
  Section 3.2), or 5 seconds if none was provided, and respect any
  increase in the polling interval required by the "slow_down"
  error.

* slow_down:

  A variant of "authorization_pending", the authorization request is
  still pending and polling should continue, but the interval MUST
  be increased by 5 seconds for this and all subsequent requests.

* access_denied:

  The authorization request was denied.

* expired_token:

  The "device_code" has expired, and the device authorization
  session has concluded.  The client MAY commence a new device
  authorization request but SHOULD wait for user interaction before
  restarting to avoid unnecessary polling.

The "authorization_pending" and "slow_down" error codes define
particularly unique behavior, as they indicate that the OAuth client
should continue to poll the token endpoint by repeating the token
request (implementing the precise behavior defined above).  If the
client receives an error response with any other error code, it MUST
stop polling and SHOULD react accordingly, for example, by displaying
an error to the user.

On encountering a connection timeout, clients MUST unilaterally
reduce their polling frequency before retrying.  The use of an
exponential backoff algorithm to achieve this, such as doubling the
polling interval on each such connection timeout, is RECOMMENDED.

The assumption of this specification is that the separate device on
which the user is authorizing the request does not have a way to
communicate back to the device with the OAuth client.  This protocol
only requires a one-way channel in order to maximize the viability of
the protocol in restricted environments

# Discovery Metadata

Support for this protocol is declared in OAuth 2.0 Authorization
Server Metadata [RFC8414] as follows.  The value
"urn:ietf:params:oauth:grant-type:device_code" is included in values
of the "grant_types_supported" key, and the following new key value
pair is added:

* device_authorization_endpoint:

  OPTIONAL.  URL of the authorization server's device authorization
  endpoint, as defined in Section 3.1.




