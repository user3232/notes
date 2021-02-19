
# OpenId Connect and service and provider user (browser) sessions

https://openid.net/specs/openid-connect-session-1_0.html

- In OpenID Connect, the session at the RP (relaying party / resource
  service) typically starts when the RP validates the End-User's ID
  Token.
- When the OP (Open Id Connect Provider / Identyfying-Authorizing
  service) supports session management, 
  - it MUST also return the Session State as an additional
    session_state parameter in the Authentication Response 
  - and SHOULD also return the Session State as an additional
    session_state parameter in the Authentication Error Response. 


session_state :
- JSON [RFC7159] string that represents the End-User's login state at
  the OP (id service). 
- It MUST NOT contain the space (" ") character. 
- This value is opaque to the RP. 
- This is REQUIRED if session management is supported.


The generation of suitable Session State values is based on a salted
cryptographic hash of Client ID, origin URL, and OP User Agent state.





