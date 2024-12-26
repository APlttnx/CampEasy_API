class User{
    constructor(firstName, lastName, preferredName, roleUser, email, phoneNumber, address, country, emergencyTel, password){
        this.firstName = firstName;
        this.lastName = lastName;
        this.preferredName = preferredName;
        this.roleUser = roleUser;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.emergencyTel = emergencyTel;
        this.address = address;
        this.country = country
        this.password = password;
        this.creationDate = null; //wordt aangemaakt in de DB
        this.updateDate = null; //wordt aangemaakt in de DB
        this.id = null; //wordt aangemaakt in de DB
    }

    isValidEmail() {
        const mailRegex = /(\w)+@\w+\.\w+/;
        return mailRegex.test(this.email);
    }

    async hashPassword() { //async --> deze methode blokkeert de rest van het programma niet wanneer deze runt, 
        const bcrypt = require('bcrypt');
        this.password = await bcrypt.hash(this.password, 10); // 10 = complexiteit van hashen, 10 = default
    }

    setOtherProps(id, updateDate) { //methode voor de props die later worden toegewezen (uDate en cDate bij Post, id in DB)
        this.id = id;
        this.creationDate = creationDate;
        this.updateDate = updateDate;
    }
} 

module.exports = User;
