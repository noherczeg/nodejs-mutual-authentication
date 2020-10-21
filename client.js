const fs = require('fs');
const https = require('https');

const options = {
    hostname: 'localhost',
    port: 4433,
    path: '/',
    method: 'GET',
    key: fs.readFileSync('client1/client1-key.pem'),
    cert: fs.readFileSync('client1/client1-crt.pem'),
    ca: fs.readFileSync('ca/ca-crt.pem'),
};

const req = https.request(options, (res) => {
    res.on('data', (data) => {
        process.stdout.write(data);
    });
});

req.end();

req.on('error', (e) => {
    console.error(e);
});
