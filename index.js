//importeren express module vanuit node_modules
const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const bcrypt = require('bcrypt'); // wachtwoordbeveiliging
const jwt = require('jsonwebtoken');

// klasses importeren
const Database = require('./classes/database.js');
const User = require('./classes/user.js');
const Camping = require('./classes/camping.js');
const app = express();
const JWT_SECRET = 'CampEasyPass_WebFundies_20242025_1613';


app.use(express.json({limit: '10mb'}));
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
    console.log(req.body);
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
        res.status(500).send({ error: 'Login failed', details: error.message });
    }
})
// ____________________________________________________________________________________________________________________________________
app.get('/api/users', async (req, res) => {
    const token = req.headers['authorization'].replace('Bearer ','');
    const db = new Database();

    try{
        const decoded = jwt.verify(token, JWT_SECRET);
        const userIdToken = decoded.userId
        const result = await db.getQuery('SELECT * FROM users WHERE id = ?', [userIdToken]);

        if (result.length == 0) {
            return res.status(404).json({ error: 'User not found' });
        }
        const u = result[0];
        const user = new User(u.firstName, u.lastName, u.preferredName, u.roleUser, u.email, u.phoneNumber, u.address, u.country,u.emergencyTel,"",u.creationDate,u.updateDate, u.id);

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
        res.status(500).send({ error: 'failed to connect to database', details: error.message });
    }
})
 //________________________________________________________________________________________________________________________________-

app.put('/api/users', async(req,res) => {
    try{
        const token = req.headers['authorization'].replace('Bearer ','');
        const decoded = jwt.verify(token, JWT_SECRET);
        const userIdToken = decoded.userId
        console.log(userIdToken);
        console.log(req.body);

        const {firstName, lastName, preferredName, roleUser, email, phoneNumber, address, country, emergencyTel} = req.body;
        const user = new User(firstName, lastName, preferredName, roleUser, email , phoneNumber, address, country, emergencyTel, "", "", "", userIdToken);
        console.log(user);

        const db = new Database();
        console.log('User ID:',user.id);
        await db.getQuery(`
            UPDATE users 
            SET firstName = ?, lastName = ?, preferredName = ?, roleUser = ?, phoneNumber = ?, address = ?, country = ?, emergencyTel = ? 
            WHERE ID = ?`,
            [user.firstName, user.lastName, user.preferredName, user.roleUser, user.phoneNumber, user.address, user.country, user.emergencyTel, user.id]
        );

        res.status(201).send({ message: 'User updated successfully' });
    }catch(error){
        console.log(error);
        res.status(500).send({ error: 'Failed to update user', details: error })
    }
})
//__________________________________________________________________________________________________________________________________________

app.post('/api/camping', async (req,res) => {
    const token = req.headers['authorization'].replace('Bearer ','');
    const decoded = jwt.verify(token, JWT_SECRET);
    const userIdToken = decoded.userId
    console.log(userIdToken);


    const {name, type, size, price, description, address, country, images} = req.body;
    const camping = new Camping(name, type, size, price, description, address, country, userIdToken, "", "", "");

    console.log(camping);

    try{
        const db = new Database();
        console.log(camping.name)
        const result = await db.getQuery('INSERT INTO campings (name, type, size, price, description, address, country, ownerID) VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
            [camping.name, camping.type, camping.size, camping.price, camping.description, camping.address, camping.country, camping.ownerId]
        );
        console.log(camping.name)
        if (result.insertId){
            camping.id = result.insertId;
        }else{
            const idResult = await DataView.getQuery('SELECT LAST_INSERT_ID() as id');
            camping.id = idResult[0].id;
        }
        console.log(camping.id);

        for (const picture of images) {
            await db.getQuery(
                'INSERT INTO campingpictures (campingID, picture) VALUES (?, ?)',
                [camping.id, picture]
            );
        }
            
        
        


        res.status(201).send({ message: 'User added successfully' });
    }
    catch (error){
        res.status(500).send({ error: 'Failed to add user', details: error })
    }
})

app.listen(3100, () => {
    console.log('Server is running on port 3100')
})