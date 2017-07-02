'use strict';

const ChaturbateSocketServer = require('@paulallen87/chaturbate-socket-server');
const {Console} = require('console');
const express = require('express');
const http = require('http');

const app = express();
const bundle = process.env.FRONTEND_BUNDLE || '.';
const logging = new Console(process.stdout, process.stderr);

app.use(express.static(bundle));
app.get('*', (req, res) => {
  res.sendFile(`${bundle}/index.html`, {root: '.'});
});

const server = http.createServer(app);
const cb = new ChaturbateSocketServer(server);

/**
 * Stops all servers.
 *
 * @param {Error} e 
 */
const close = (e) => {
  if (e) {
    logging.error(e);
  }
  cb.stop();
  server.close();
};

process.on('exit', () => close(null));
process.on('SIGTERM', () => close(null));
process.on('uncaughtException', (e) => close(e));

setInterval(() => cb.cleanup(), (30 * 1000));

server.listen(8080, () => {
  logging.log('Listening on %d', server.address().port);
});
