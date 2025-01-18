const { MongoClient } = require("mongodb");
const dotenv = require("dotenv");
const path = require("path");

dotenv.config();
const connectionString = process.env.DATABASE_URI;

const client = new MongoClient(connectionString);

const connectDB = async () => {
    try {
        await client.connect();
        console.log("Connected to MongoDB");
    } catch (error) {
        console.error("Failed to connect to MongoDB", error);
        process.exit(1);
    }
};

const getDB = (dbName) => {
    return client.db(dbName); // 데이터베이스 객체 반환
};

module.exports = { connectDB, getDB };