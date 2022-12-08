const express = require('express');
const path = require('path');
const bodyParser = require('body-parser');
const app = express();
const appa = express();
const appb = express();
const appc = express();

app.listen(8080);
appa.listen(8081);
appb.listen(8082);
appc.listen(8083);

app.use(express.static('public'));
app.use((req, res, next) => {
    console.log('Req executed from Source IP', req.ip);
    next();
})
appa.use(express.static('public'));
appa.use((req, res, next) => {
    console.log('Req executed from Source IP', req.ip);
    next();
})
appb.use(express.static('public'));
appb.use((req, res, next) => {
    console.log('Req executed from Source IP', req.ip);
    next();
})
appc.use(express.static('public'));
appc.use((req, res, next) => {
    console.log('Req executed from Source IP', req.ip);
    next();
})

app.get('/', (req, res) => {
    res.json({'HOME': 'CAFESHOP', 'Host': req.hostname, 'SourceIP': req.ip})
});

app.get('/coffee', (req, res) => {
    res.json({'service': 'COFFEE', 'Host': req.hostname, 'SourceIP': req.ip})
});

app.get('/coffee/latte', (req, res) => {
    res.json({'service': 'LATTE', 'Host': req.hostname, 'SourceIP': req.ip})
});

app.get('/tea', (req, res) => {
    res.json({'service': 'TEA', 'Host': req.hostname, 'SourceIP': req.ip})
});

app.get('/tea/green', (req, res) => {
    res.json({'service': 'GREEN-TEA', 'Host': req.hostname, 'SourceIP': req.ip})
});

app.get('/healthz', (req, res) => {
    res.json({'Health': 'OK'})
});

app.get('/mode', (req, res) => {
    res.json({'Mode': 'Maintenance'})
});

appa.get('/', (req, res) => {
    res.json({'Server': 'Alpha'})
});

appb.get('/', (req, res) => {
    res.json({'Server': 'Beta'})
});

appc.get('/', (req, res) => {
    res.json({'Server': 'Gamma'})
});
