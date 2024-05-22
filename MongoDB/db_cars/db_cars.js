use("cars_db")

// create a cars collection, add about 10 cars to it, have some have the same year and some have the same brand
db.cars.insertMany([
    {
        brand: "BMW",
        price: 20000,
        model: "X5",
        year: 2015,
        horsepower: 300
    },
    {
        brand: "BMW",
        price: 20200,
        model: "X3",
        year: 2017,
        horsepower: 320
    },
    {
        brand: "BMW",
        price: 22000,
        model: "X6",
        year: 2023,
        horsepower: 340
    },
    {
        brand: "Mercedes-Benz",
        price: 25000,
        model: "GLC",
        year: 2015,
        horsepower: 250
    },
    {
        brand: "Mercedes-Benz",
        price: 27000,
        model: "GLE",
        year: 2017,
        horsepower: 300
    },
    {
        brand: "Audi",
        price: 23000,
        model: "Q5",
        year: 2015,
        horsepower: 280
    },
    {
        brand: "Audi",
        price: 25000,
        model: "Q7",
        year: 2018,
        horsepower: 320
    },
    {
        brand: "Toyota",
        price: 18000,
        model: "RAV4",
        year: 2015,
        horsepower: 200
    },
    {
        brand: "Toyota",
        price: 19000,
        model: "Highlander",
        year: 2017,
        horsepower: 270
    },
    {
        brand: "Honda",
        price: 17000,
        model: "CR-V",
        year: 2015,
        horsepower: 190
    }
])

// CRUD

// *C* create and add one document in cars-collections
db.cars.insertOne(
    {
        brand: "Honda",
        price: 16600,
        model: "CR-V",
        year: 2014,
        horsepower: 190
    }
)

// *R*  findOne with id
db.cars.findOne({ _id: ObjectId("664ca0f5e7102028bd690ea3") })

// *R* findMany
db.cars.find({brand: 'BMW'})

// *U* updateOne
db.cars.updateOne({_id: ObjectId('664ca0f5e7102028bd690ea5')},{$set:{price: 22200}})

// *U* updateMany horsepower: +20 to all brand: "Toyota" in collections
db.cars.updateMany({brand: "Toyota"}, {$inc: {horsepower: 20}})

// *D* deleteOne
db.cars.deleteOne({_id: ObjectId('664ca1c1964e42e319fd4258')})

// *D* deleteMany
db.cars.deleteMany({brand: "Toyota"})

// sort with aggregate price < 20000 and print all in reverse order
db.cars.aggregate([
    { $match: { price: { $lt: 20000 } } },
    { $sort: { price: -1 } }
])

// create linked collection category
db.categories.insertMany([
    { type: "Passenger car", car_ids: [ObjectId('664ca0f5e7102028bd690ea3'), ObjectId('664ca0f5e7102028bd690ea4')] },
    { type: "Lorry truck", car_ids: [ObjectId('664ca0f5e7102028bd690ea8'), ObjectId('664ca0f5e7102028bd690ea7')] },
    { type: "Pickup", car_ids: [ObjectId('664ca0f5e7102028bd690ea5'), ObjectId('664ca0f5e7102028bd690ea6')] },
    { type: "Cabriolet", car_ids: [ObjectId('664ca0f5e7102028bd690ea9'), ObjectId('664ca0f5e7102028bd690eac')] }
])


//output values from linked collections
db.categories.aggregate([
    {
        $lookup: {
            from: "cars",
            localField: "car_ids",
            foreignField: "_id",
            as: "cars"
        }
    }
])

//show a random 4 cars
db.cars.aggregate([{ $sample: { size: 4 } }])