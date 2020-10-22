# Nodejs Mutual Authentication

## Init
```
./00-gen-ca.sh
```

## Server
```
node server.js
```

## Test with Client
```
node client.js
```

## Verify Server Certificate
```
openssl s_client -showcerts -connect localhost:4433
```

> If `.key` and `.crt` files are switched to `client2`, it'll properly error out given it's on the CRL.

## Source
- [https://engineering.circle.com/https-authorized-certs-with-node-js-315e548354a2](https://engineering.circle.com/https-authorized-certs-with-node-js-315e548354a2)
