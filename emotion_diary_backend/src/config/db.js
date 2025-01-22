/*
const { MongoClient } = require("mongodb");
const dotenv = require("dotenv");

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
*/
const { MongoClient, GridFSBucket } = require("mongodb");
const dotenv = require("dotenv");

dotenv.config();
const connectionString = process.env.DATABASE_URI;

const client = new MongoClient(connectionString);
let database = null; // 데이터베이스 객체
let bucket = null; // GridFSBucket 객체

const connectDB = async () => {
  try {
    await client.connect();
    database = client.db(process.env.DB_NAME || "emotionDiary");
    bucket = new GridFSBucket(database, { bucketName: "profileImages" });
    console.log("Connected to MongoDB and GridFS initialized");
  } catch (error) {
    console.error("Failed to connect to MongoDB", error);
    process.exit(1);
  }
};

const getDB = () => {
  if (!database) {
    throw new Error("Database is not initialized. Call connectDB first.");
  }
  return database;
};

const getBucket = () => {
  if (!bucket) {
    throw new Error("Bucket is not initialized. Call connectDB first.");
  }
  return bucket;
};

module.exports = { connectDB, getDB, getBucket };
