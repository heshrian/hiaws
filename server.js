'use strict'

const express = require('express');
const PORT = 3333;

const app = express();

app.get('/', (req,res) => {
	res.send('Hello world')
});

app.listen(PORT,() => {
	console.log(`App is listening on ${PORT}`)

});
