import mongoose from 'mongoose'

const connectDatabase = () => {
    const mongoDBUrl = `mongodb://${process.env.MONGO_HOST}:${process.env.MONGO_PORT}/${process.env.MONGO_DB}`
    console.log(`Connecting to ${mongoDBUrl}`)
    mongoose.Promise = global.Promise
    // Connect to the database
    mongoose.connect(mongoDBUrl, {
        useNewUrlParser: true,
        useUnifiedTopology: true,
        useCreateIndex: true,
        useFindAndModify: false
    })
    .then(() => {
        console.log("Successfully connected to the database")
    })
    .catch((err) => {
        console.log(`Could not connect to the database. Existing now... \n${err}`)
        process.exit();
    })
}

export default connectDatabase