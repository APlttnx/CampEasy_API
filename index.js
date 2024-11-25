//importeren express module vanuit node_modules
const express = require('express');
const bodyParser = require('body-parser');
const Database = require('./classes/database.js');
const cors = require('cors');

const app = express();

app.use(cors({
    origin:'http://localhost:8080',
    methods: ['GET', 'POST', 'PUT', 'DELETE'], // Allowed HTTP methods
    allowedHeaders: ['Content-Type','Authorization'],   
}))

//endpoints
//test
app.get('/', (req, res) => {
    res.send('Hello World!');
});

app.listen(3100, () => {
    console.log('Server is running on port 3100')
})