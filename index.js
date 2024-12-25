//importeren express module vanuit node_modules
const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const bcrypt = require('bcrypt'); // wachtwoordbeveiliging

// klasses importeren
const Database = require('./classes/database.js');
const User = require('./classes/user.js');
const app = express();
const JWT_SECRET = 'CampEasyPass_WebFundies_20242025_1613'


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


//User Registration
app.post('/api/users', async (req,res) => {
    const {firstName, lastName, preferredName, roleUser, email, phoneNumber, address, country, emergencyTel, password} = req.body;
    const creationDate = new Date().toISOString().slice(0, 19).replace('T', ' ');
    const user = new User(firstName, lastName, preferredName, roleUser, email, phoneNumber, address, country, emergencyTel, password, creationDate);
    console.log(user.creationDate)


 //formatting voor tijdstip in YYYY-MM-DD

    if (!user.isValidEmail()) {
        return res.status(201).send({ error: 'Invalid email format' });
    }
    await user.hashPassword();

    const db = new Database();
    db.getQuery('INSERT INTO users (firstName, lastName, preferredName, roleUser, email, phoneNumber, address, country, password, emergencyTel, creationDate) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
        [user.firstName, user.lastName, user.preferredName, user.roleUser, user.email, user.phoneNumber, user.address, user.country, user.password, user.emergencyTel, user.creationDate])
        .then(() => res.status(201).send({ message: 'User added successfully' }))
        .catch((error) => res.status(500).send({ error: 'Failed to add user', details: error }));
})

app.post('/api/login', async (req, res) => {
    const {email, password} = req.body;
    const db = new Database();

    try {
        const result = await db.getQuery('SELECT * FROM users WHERE email = ?', [email]);
        if (result.length === 0) {
            return res.status(401).json({ error: 'Foutieve ingave' });
        }
        const u = result[0];
        const validPassword = await bcrypt.compare(password, u.password);

        if (!validPassword){
            return res.status(401).json({ error: 'Foutieve ingave' });
        }

        const token = jst.sign(
            {userId: u.id, role: u.roleUser},
            JWT_SECRET,
            {expiresIn: '24h '}
        )

        res.json({
            token,
            userID: u.id,
            userRole: u.role,
            firstName: u.firstName,
            prefName: u.prefName,
            userMail: u.mail,
        })
    } catch (error){
        res.status(500).json({error: 'Login failed'});
    }
})

app.listen(3100, () => {
    console.log('Server is running on port 3100')
})