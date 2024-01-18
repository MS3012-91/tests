const http = require('http');
const foo = require('./app');

const server = http.createServer(foo);
server.listen(3000, '127.0.0.1');

