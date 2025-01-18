const { getDB } = require("../config/db");

const modifyDiaries = async (diary) => {
  const db = getDB("emotionDiary");
  const collection = db.collection("diaries");
  const { userId, emotion, text, date } = diary;

  console.log( userId, emotion, text, date )
  // Query to find the diary to update
  const query = { userId, date };
    console.log("query: ", query)
    
  // Update fields with $set
  const updateData = {
    $set: {
      emotion,
      text,
    },
  };
  // Perform the update operation
  const options = { upsert: false }; // Ensure it does not create a new document
  const result = await collection.updateOne(query, updateData, options);
  return result;
};


const saveDiary = async (diary) => {
    const db = getDB("emotionDiary"); // 데이터베이스 이름
    const collection = db.collection("diaries");
    const result = await collection.insertOne(diary);
    return result;
};

const getDiaries = async (userId, date) => {
    const db = getDB("emotionDiary");
    const collection = db.collection("diaries");
    const diaries = await collection.find({userId: userId, date : date}).toArray();
    return diaries;
};

module.exports = { saveDiary, getDiaries, modifyDiaries};
