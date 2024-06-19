// http://localhost:3000/

const express = require('express');
const mysql = require('mysql2');

const connection = mysql.createConnection({
    host: 'localhost',
    user: 'admin',
    password: 'admin123.',
    database: 'railway_system',
    port: 3306,
    ssl: false
});


const bodyParser = require('body-parser');
const app = express();
app.use(bodyParser.json());





connection.connect(err => {
    if (err) {
        console.error('Error connecting to database:', err);
        return;
    }
    console.log('Connected to MySQL database');
});

app.get('/passengers', (req, res) => {
    connection.query('SELECT * FROM passenger ', (error, results, fields) => {
        if (error) {
            console.error('Error querying database:', error);
            res.status(500).json({ error: 'Internal server error' });
        } else {
            res.json(results);
        }
    });
});
app.get('/train', (req, res) => {
    connection.query('SELECT * FROM train', (error, resultstrain, fields) => {
        if (error) {
            console.error('Error querying database:', error);
            res.status(500).json({ error: 'Internal server error' });
        } else {
            res.json(resultstrain);
        }
    });
});
app.get('/malegender', (req, res) => {
    connection.query('SELECT * FROM passenger where gender = "Male"', (error, resultsmale, fields) => {
        if (error) {
            console.error('Error querying database:', error);
            res.status(500).json({ error: 'Internal server error' });
        } else {
            res.json(resultsmale);
        }
    });
});
app.get('/femalegender', (req, res) => {
    connection.query('SELECT * FROM passenger where gender = "Female"', (error, resultsfemale, fields) => {
        if (error) {
            console.error('Error querying database:', error);
            res.status(500).json({ error: 'Internal server error' });
        } else {
            res.json(resultsfemale);
        }
    });
});

app.post('/addpassenger', (req, res) => {
    const { passenger_ID, first_name, middle_name, last_name, pincode, city, state, dob, gender, age } = req.body;


    if (!passenger_ID || !first_name || !last_name || !dob || !gender || !age) {
        res.status(400).json({ error: 'Missing required fields' });
        return;
    }


    const query = 'INSERT INTO passenger (passenger_ID, first_name, middle_name, last_name, pincode, city, state, dob, gender, age) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)';
    connection.query(query, [passenger_ID, first_name, middle_name, last_name, pincode, city, state, dob, gender, age], (error, results, fields) => {
        if (error) {
            console.error('Error inserting passenger:', error.stack);
            res.status(500).send('Failed to add passenger.');
            return;
        }
        res.sendStatus(200);
    });
});

app.get('/', (req, res) => {
    res.sendFile(__dirname + '/index.html');
});


const port = process.env.PORT || 3000;
app.listen(port, () => {
    console.log(`Server listening on port ${port}`);
});
