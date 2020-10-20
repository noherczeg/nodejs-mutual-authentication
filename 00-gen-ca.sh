#!/bin/bash

# CA
openssl req -new -x509 -days 9999 -config ca/ca.cnf -keyout ca/ca-key.pem -out ca/ca-crt.pem

# Server

## Private Key
openssl genrsa -out server/server-key.pem 4096

## Signing Request
openssl req -new -config server/server.cnf -key server/server-key.pem -out server/server-csr.pem

## Sign
openssl x509 -req -extfile server/server.cnf -days 999 -passin "pass:password" -in server/server-csr.pem -CA ca/ca-crt.pem -CAkey ca/ca-key.pem -CAcreateserial -out server/server-crt.pem

# Client

openssl genrsa -out client1/client1-key.pem 4096
openssl req -new -config client1/client1.cnf -key client1/client1-key.pem -out client1/client1-csr.pem
openssl x509 -req -extfile client1/client1.cnf -days 999 -passin "pass:password" -in client1/client1-csr.pem -CA ca/ca-crt.pem -CAkey ca/ca-key.pem -CAcreateserial -out client1/client1-crt.pem
openssl verify -CAfile ca/ca-crt.pem client1/client1-crt.pem

openssl genrsa -out client2/client2-key.pem 4096
openssl req -new -config client2/client2.cnf -key client2/client2-key.pem -out client2/client2-csr.pem
openssl x509 -req -extfile client2/client2.cnf -days 999 -passin "pass:password" -in client2/client2-csr.pem -CA ca/ca-crt.pem -CAkey ca/ca-key.pem -CAcreateserial -out client2/client2-crt.pem
openssl verify -CAfile ca/ca-crt.pem client2/client2-crt.pem

# Revocation

openssl ca -revoke client2/client2-crt.pem -keyfile ca/ca-key.pem -config ca/ca.cnf -cert ca/ca-crt.pem -passin 'pass:password'
openssl ca -keyfile ca/ca-key.pem -cert ca/ca-crt.pem -config ca/ca.cnf -gencrl -out ca/ca-crl.pem -passin 'pass:password'

