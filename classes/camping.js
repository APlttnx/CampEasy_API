class Camping{
    constructor(name, type, size, price, description, address, country, ownerId, creationDate, updateDate, id){
        this.name = name;
        this.type = type;
        this.size = size;
        this.price = price;
        this.description = description;
        this.address = address;
        this.country = country
        this.ownerId = ownerId;
        this.creationDate = creationDate; 
        this.updateDate = updateDate; 
        this.id = id; 
    }
    //covert niet alles
    areInputsValid(){
        if (!this.name || !this.type || !this.size || !this.price || !this.address || !this.country) return false;
        if (this.name.length>100 || this.description.length>2000 || this.price<0 || this.size<0) return false;
        if (this.type !== 'Tent' && this.type !== 'Caravan') return false;
        return true;
    }
}
module.exports = Camping;
