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
        this.creationDate = creationDate; 
        this.updateDate = updateDate; 
        this.id = id; 
    }

    isValidEmail() {
        const mailRegex = /(\w)+@\w+\.\w+/;
        return mailRegex.test(this.email);
    }

    async hashPassword() { //async 
        const bcrypt = require('bcrypt');
        this.password = await bcrypt.hash(this.password, 10); // 10 = complexiteit van hashen/salting, 10 = default
    }
    //covert niet alles
    areInputsValid(){
        if (!this.firstName || !this.lastName ) return false;
        if (!this.id&&(!this.email || !this.password)) return false;
        if (this.firstName.length>100 || this.lastName.length>100 || this.preferredName.length>100) return false;
        return true;
    }
}
module.exports = User;
