const fs = require('fs');
const https = require('https');

const options = {
    key: fs.readFileSync('server/server-key.pem'),
    cert: fs.readFileSync('server/server-crt.pem'),
    ca: fs.readFileSync('ca/ca-crt.pem'),
    crl: fs.readFileSync('ca/ca-crl.pem'),
    requestCert: true,
    rejectUnauthorized: true,
};

https
    .createServer(options, (req, res) => {
        const { connection, socket, method } = req;
        console.log(`${new Date()} ${connection.remoteAddress} ${socket.getPeerCertificate().subject.CN} ${method} ${req.url}`);
        res.writeHead(200);
        res.end('hello world\n');
    })
    .listen(4433);
