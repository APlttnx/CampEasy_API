//importeren express module vanuit node_modules
const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const bcrypt = require('bcrypt'); // wachtwoordbeveiliging
const jwt = require('jsonwebtoken');

// klasses importeren
const Database = require('./classes/database.js');
const User = require('./classes/user.js');
const app = express();
const JWT_SECRET = 'CampEasyPass_WebFundies_20242025_1613';


app.use(express.json());
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

// ____________________________________________________________________________________________________________________________________
//User Registration
app.post('/api/users', async (req,res) => {
    const {firstName, lastName, preferredName, roleUser, email, phoneNumber, address, country, emergencyTel, password} = req.body;
    const user = new User(firstName, lastName, preferredName, roleUser, email, phoneNumber, address, country, emergencyTel, password, "", "", "");

    try{
        if (!user.isValidEmail()) {
            return res.status(201).send({ error: 'Invalid email format' });
        }
        await user.hashPassword();

        const db = new Database();
        const result = await db.getQuery('INSERT INTO users (firstName, lastName, preferredName, roleUser, email, phoneNumber, address, country, emergencyTel) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)',
            [user.firstName, user.lastName, user.preferredName, user.roleUser, user.email, user.phoneNumber, user.address, user.country, user.emergencyTel]
        );

        if (result.insertId){
            user.id = result.insertId;
        }else{
            const idResult = await DataView.getQuery('SELECT LAST_INSERT_ID() as id');
            user.id = idResult[0].id;
        }

        await db.getQuery('INSERT INTO passwords (userID, password) VALUES (?,? )',
            [ user.id, user.password]
        );

        res.status(201).send({ message: 'User added successfully' });
    }
    catch (error){
        res.status(500).send({ error: 'Failed to add user', details: error })
    }
})
// ____________________________________________________________________________________________________________________________________
app.post('/api/login', async (req, res) => {
    const {email, password} = req.body;
    const db = new Database();

    try {
        const result = await db.getQuery(
            `SELECT u.id, u.roleUser, u.firstName, u.preferredName, p.password
            FROM users u
            JOIN passwords p ON u.id = p.userID
            WHERE u.email = ?;`, 
            [email]);
        if (result.length === 0) {
            return res.status(401).json({ error: 'Foutieve ingave' });
        }
        const u = result[0];
        const validPassword = await bcrypt.compare(password, u.password);

        if (!validPassword){
            return res.status(401).json({ error: 'Foutieve ingave' });
        }

        const token = jwt.sign(
            {userId: u.id, role: u.roleUser},
            JWT_SECRET,
            {expiresIn: '24h'}
        )

        res.json({
            token,
            userRole: u.roleUser,
            userGreetName: u.preferredName || u.firstName,
            
        },
        );
    } catch (error){
        res.status(500).json({ error: 'Login failed', details: error.message });
    }
})
// ____________________________________________________________________________________________________________________________________
app.get('/api/users', async (req, res) => {
    console.log('Headers:', req.headers);
    const token = req.headers['authorization'].replace('Bearer ','');
    console.log('Token:', token);
    const db = new Database();

    try{
        const decoded = jwt.verify(token, JWT_SECRET);
        console.log('Decoded token:', decoded);
        const userIdToken = decoded.userId
        console.log('Decoded UserID:', userIdToken);

        const result = await db.getQuery('SELECT * FROM users WHERE id = ?', [userIdToken]);

        if (result.length == 0) {
            return res.status(404).json({ error: 'User not found' });
        }
        const u = result[0];
        const user = new User(u.firstName, u.lastName, u.preferredName, u.roleUser, u.email, u.phoneNumber, u.address, u.country,u.emergencyTel,"",u.creationDate,u.updateDate, u.id);
        console.log(user.firstName);


        res.json({
            id: user.id,
            firstName: user.firstName,
            lastName: user.lastName,
            preferredName: user.preferredName,
            role: user.roleUser,
            email: user.email,
            phonenumber: user.phoneNumber,
            address: user.address,
            country: user.country,
            creationDate: user.creationDate,
            updateDate: user.updateDate,
        });
    }
    catch (error){
        res.status(500).json({ error: 'failed to connect to database', details: error.message });
    }
})
 //________________________________________________________________________________________________________________________________-






app.listen(3100, () => {
    console.log('Server is running on port 3100')
})