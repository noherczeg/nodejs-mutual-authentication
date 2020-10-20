var fs = require('fs'); 
var https = require('https');

var options = { 
    key: fs.readFileSync('server/server-key.pem'), 
    cert: fs.readFileSync('server/server-crt.pem'), 
    ca: fs.readFileSync('ca/ca-crt.pem'), 
    crl: fs.readFileSync('ca/ca-crl.pem'), 
    requestCert: true, 
    rejectUnauthorized: true,
};

https
    .createServer(options, function (req, res) { 
        console.log(new Date()+' '+ 
            req.connection.remoteAddress+' '+ 
            req.socket.getPeerCertificate().subject.CN+' '+ 
            req.method+' '+req.url); 
        res.writeHead(200); 
        res.end("hello world\n"); 
    })
    .listen(4433);
