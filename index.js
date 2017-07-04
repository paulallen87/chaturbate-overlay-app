'use strict';

const ChaturbateSocketServer = require('@paulallen87/chaturbate-socket-server');
const fs = require('fs');
const path = require('path');
const {Console} = require('console');
const express = require('express');
const morgan = require('morgan');
const http = require('http');
const spdy = require('spdy');

const app = express();
const bundle = process.env.FRONTEND_BUNDLE || '.';
const logging = new Console(process.stdout, process.stderr);

app.use(morgan('dev'));
app.use(express.static(bundle));
app.get('*', (req, res) => {
  res.sendFile(`${bundle}/index.html`, {root: '.'});
});

const getFileIfExists = (filePath) => {
  const file = path.join(__dirname, filePath);
  if (!fs.existsSync(file)) {
    logging.error(`File '${file}' does not exist!`);
    return undefined;
  }
  return fs.readFileSync(file);
};

const spdyOptions = {
    key: getFileIfExists('certs/server.key'),
    cert: getFileIfExists('certs/server.crt'),
};

const httpServer = http.createServer(app);
const spdyServer = spdy.createServer(spdyOptions, app);
const cb = new ChaturbateSocketServer(30000);

cb.accessControl(process.env.ACL_ENABLED == '1')
  .accessList(path.join(__dirname, 'config/acl.json'))
  .attach(httpServer)
  .attach(spdyServer);

httpServer.listen(8080, () => {
  logging.log('Listening on %d', httpServer.address().port);
});

spdyServer.listen(9090, () => {
  logging.log('Listening on %d', spdyServer.address().port);
});
