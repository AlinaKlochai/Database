use("drinks_db")

//create one document
db.drinks.insertOne({name: 'Tequila', price: 40, stronghold: 5, rating: 3.8, producer: 'USA' ,is_in_stock: true})

//create many documents
db.drinks.insertMany([
    {name: 'Whiskey', price: 70, stronghold: 5, rating: 4.8, producer: 'Scotland', is_in_stock: true},
    {name: 'Wine', price: 100, stronghold: 3, rating: 4.9, producer: 'France', is_in_stock: false},
    {name: 'Tequila', price: 57, stronghold: 4, rating: 3.8, producer: 'USA', is_in_stock: true},
    {name: 'Beer', price: 80, stronghold: 2, rating: 3.2, producer: 'Germany', is_in_stock: false},
    {name: 'Tequila', price: 49, stronghold: 4, rating: 4.6, producer: 'USA', is_in_stock: true}
])

//print all drinks sorted by name in reverse order
db.drinks.find().sort({name: -1})

//Print one drink with name 'Tequila'
db.drinks.find({name: 'Tequila'})

//Output only the last two drinks added
db.drinks.find().sort({_id: -1}).limit(2)