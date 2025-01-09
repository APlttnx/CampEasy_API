//importeren express module vanuit node_modules
const express = require('express');
const cors = require('cors');
const bcrypt = require('bcrypt'); // wachtwoordbeveiliging
const jwt = require('jsonwebtoken');
require('dotenv').config()
// const JWT_SECRET = process.env.JWT_SECRET;
const JWT_SECRET = 'CampEasyPass_WebFundies_20242025_1613'; //Zit normaal gezien in .env file, maar voor schoolopdracht even hier gezet
// klasses importeren
const Database = require('./classes/database.js');
const User = require('./classes/user.js');
const Camping = require('./classes/camping.js');
const app = express();



app.use(express.json());
app.use(cors({
    origin:'http://localhost:8080',
    methods: ['GET', 'POST', 'PUT', 'DELETE'], // Allowed HTTP methods
    allowedHeaders: ['Content-Type','Authorization'],
}))
app.set('maxHeaderSize', 16 * 1024 * 1024);  // Example: increase to 16 KB


app.get('/', (req, res) => {
    res.send('Hello World!');
});

// ____________________________________________________________________________________________________________________________________
//Users
app.post('/api/users', async (req,res) => {
    try{
        const {firstName, lastName, preferredName, roleUser, email, phoneNumber, address, country, emergencyTel, password} = req.body;
        const user = new User(firstName, lastName, preferredName, roleUser, email, phoneNumber, address, country, emergencyTel, password, "", "", "");

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
app.post('/api/login', async (req, res) => {
    try {
        const {email, password} = req.body;
        const db = new Database();

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
app.get('/api/users', async (req, res) => {
    try{
        const token = req.headers['authorization'].replace('Bearer ','');
        const decoded = jwt.verify(token, JWT_SECRET);
        const userIdToken = decoded.userId

        const db = new Database();
        const result = await db.getQuery('SELECT * FROM users WHERE id = ?', [userIdToken]);

        if (result.length == 0) {
            return res.status(404).json({ error: 'User not found' });
        }
        const u = result[0];
        const user = new User(u.firstName, u.lastName, u.preferredName, u.roleUser, u.email, u.phoneNumber, u.address, u.country,u.emergencyTel,"",u.creationDate,u.updateDate, u.id);

        res.json({
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
app.put('/api/users', async(req,res) => {
    try{
        const token = req.headers['authorization'].replace('Bearer ','');
        const decoded = jwt.verify(token, JWT_SECRET);
        const userIdToken = decoded.userId

        // console.log(userIdToken);
        // console.log(req.body);

        const {firstName, lastName, preferredName, roleUser, email, phoneNumber, address, country, emergencyTel} = req.body;
        const user = new User(firstName, lastName, preferredName, roleUser, email , phoneNumber, address, country, emergencyTel, "", "", "", userIdToken);
        // console.log(user);

        const db = new Database();
        // console.log('User ID:',user.id);
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
//Campings
app.post('/api/camping', async (req,res) => {
    const token = req.headers['authorization'].replace('Bearer ','');
    const decoded = jwt.verify(token, JWT_SECRET);
    const userIdToken = decoded.userId

    const {name, type, size, price, description, address, country, images,facilities, userRole, } = req.body;
    //console.log(req.body);
    const camping = new Camping(name, type, size, price, description, address, country, userIdToken, "", "", "");

    try{
        const db = new Database();
        const result = await db.getQuery('INSERT INTO campings (name, type, size, price, description, address, country, ownerID) VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
            [camping.name, camping.type, camping.size, camping.price, camping.description, camping.address, camping.country, camping.ownerId]
        );
        if (result.insertId){
            camping.id = result.insertId;
        }else{
            const idResult = await DataView.getQuery('SELECT LAST_INSERT_ID() as id');
            camping.id = idResult[0].id;
        }
        //afbeeldingen camping in aparte tabel
        for (const picture of images) {
            await db.getQuery(
                'INSERT INTO campingpictures (campingID, picture) VALUES (?, ?)',
                [camping.id, picture]
            );
        }
        //rol aanpassen van creator als hij nog een 'user' was
        if(userRole === "user"){
            await db.getQuery(
                `UPDATE users SET roleUser = ? WHERE id = ?`,
                ['owner', camping.ownerId]
            );
            console.log("changed role to owner")
        }
        

        //facilities aanvullen
        console.log('faciliteiten: ');
        //console.log(facilities);
        for (const facilityID of facilities){
            await db.getQuery(
                'INSERT INTO campingfacilities (campingID, facilityID) VALUES (?, ?)',
                [camping.id, facilityID]
            );
        }

        console.log(`camping ${camping.name} added successfully`)
        res.status(201).send({ message: 'Camping added successfully' });
    }
    catch (error){
        res.status(500).send({ error: 'Failed to add camping', details: error })
    }
})
app.get('/api/campingGeneralData', async (req,res) => {
    const db = new Database();
    try{
        console.log("fetching campings");
        const result = await db.getQuery(`
            SELECT 
                c.*,
                u.firstName, u.lastName,
                JSON_ARRAYAGG(f.facilityName) as facilities,
                JSON_ARRAYAGG(i.picture) as imageUrls
            FROM campings c
            LEFT JOIN campingpictures i ON c.ID = i.campingID
            LEFT JOIN campingfacilities cf ON c.ID = cf.campingID
            LEFT JOIN facilities f ON cf.facilityID = f.ID
            JOIN users u ON c.OwnerID = u.ID 
            GROUP BY c.ID;
        `)
    //    console.log(result);
        const processedResult = result.map(camping => {
            const formattedDate = camping.updateDate
                ? new Date(camping.updateDate).toLocaleDateString('en-GB')
                : null;
           
            return {
                ...camping,
                image: '',
                updateDate: formattedDate,
            };
        });       

        res.json(processedResult);
    }
    catch (error){
        res.status(500).send({ error: 'failed to connect to database', details: error.message });
    }
})
app.get('/api/ownerCampings', async (req, res) =>{
    try{
        const token = req.headers['authorization'].replace('Bearer ','')
        const decoded = jwt.verify(token, JWT_SECRET);
        const userIdToken = decoded.userId

        const db = new Database();

        console.log(`fetching campings and earnings owned by user ${userIdToken}`);
        const resultTotal = await db.getQuery(`
            SELECT SUM(b.totalPrice) as total
            FROM campings c
            LEFT JOIN bookings b on c.ID = b.campingID
            WHERE c.ownerID = ?
            GROUP BY c.ownerID;`, [userIdToken]
        );
        const totalEarnings = resultTotal[0]?.total || 0;
        const campingEarnings = await db.getQuery(`
            SELECT c.ID, SUM(b.totalPrice) as campingEarnings
            FROM campings c
            LEFT JOIN bookings b on c.ID = b.campingID
            WHERE c.ownerID = ?
            GROUP BY c.ID;`, [userIdToken]
        );
        const result = {totalEarnings, campingEarnings};

        res.json(result);
    }
    catch (error){
        console.log(error);
        res.status(500).send({ error: 'failed to connect to database', details: error.message });
    }
})
app.get('/api/facilities', async(req,res) => {
    const db = new Database();
    try{
        console.log("fetching facilities")
        const result = await db.getQuery('SELECT * FROM facilities ORDER BY ID');
        res.json(result);
    }
    catch (error){
        res.status(500).send({ error: 'failed to connect to database', details: error.message });
    }
})
//bookings
app.get('/api/bookingsOverview', async (req, res) => {
    const db = new Database();
    try{
        const token = req.headers['authorization'].replace('Bearer ','')
        const decoded = jwt.verify(token, JWT_SECRET);
        const userIdToken = decoded.userId

        console.log(`fetching campings booked by user ${userIdToken}`);
        const result = await db.getQuery(`
            SELECT 
                c.ID as campingID,
                b.startDate,
                b.endDate
            FROM campings c
            JOIN bookings b on c.ID = b.campingID
                JOIN users u ON b.userID = u.ID
            WHERE u.ID = ?
            ORDER BY b.startDate;`,[userIdToken]
            
        );
        const processedResult = result.map(camping => {
            const formattedStartDate = new Date(camping.startDate).toLocaleDateString('en-GB')
            const formattedEndDate = new Date(camping.endDate).toLocaleDateString('en-GB')
            return {
                ...camping,
                startDate: formattedStartDate,
                endDate: formattedEndDate,
            };
        });

        res.json(processedResult);
    }
    catch (error){
        res.status(500).send({ error: 'failed to connect to database', details: error.message });
    }
})
app.post('/api/bookings', async(req,res) => {
    try{
        const token = req.headers['authorization'].replace('Bearer ','');
        const decoded = jwt.verify(token, JWT_SECRET);
        const userIdToken = decoded.userId;

        const {startDate, endDate, campingId, totalPrice} = req.body;
        // console.log("test1");

        if (totalPrice < 0 || !campingId){
            return res.status(401).json({ error: 'Foutieve input'});
        };
        // console.log("test2");
        const db = new Database;
        await db.getQuery(`INSERT INTO bookings(campingID, userID, startDate, endDate, totalPrice) 
            VALUES (?,?,STR_TO_DATE(?, '%Y-%m-%dT%H:%i:%s.%fZ'),STR_TO_DATE(?, '%Y-%m-%dT%H:%i:%s.%fZ'),?)`,
            [campingId, userIdToken, startDate, endDate, totalPrice]
        );

        console.log(`Booking added successfully`)
        res.status(201).send({ message: 'Booking added successfully' });

    }catch (error){
        res.status(500).send({ error: 'Failed to add booking', details: error })
    }


})
app.get('/api/bookedDates', async (req, res) => {
    const db = new Database();
    const campingID = req.query.campingID;
    try{
        console.log("fetching bookings for camping " + campingID);
        const result = await db.getQuery(`
            SELECT startDate, endDate 
            FROM bookings 
            WHERE campingID = ?
            AND endDate > CURDATE();`,
            [campingID]
        );
        // console.log(result);
        res.json(result);
    }
    catch (error){
        res.status(500).send({ error: 'failed to connect to database', details: error.message });
    }
})


app.listen(3100, () => {
    console.log('Server is running on port 3100')
})