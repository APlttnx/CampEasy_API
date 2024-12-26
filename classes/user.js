class User{
    constructor(firstName, lastName, preferredName, roleUser, email, phoneNumber, address, country, emergencyTel, password, creationDate, updateDate, id){
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
        this.creationDate = creationDate; //wordt aangemaakt in de DB
        this.updateDate = updateDate; //wordt aangemaakt in de DB
        this.id = id; //wordt aangemaakt in de DB
    }

    isValidEmail() {
        const mailRegex = /(\w)+@\w+\.\w+/;
        return mailRegex.test(this.email);
    }

    async hashPassword() { //async --> deze methode blokkeert de rest van het programma niet wanneer deze runt, 
        const bcrypt = require('bcrypt');
        this.password = await bcrypt.hash(this.password, 10); // 10 = complexiteit van hashen/salting, 10 = default
    }
}
module.exports = User;
