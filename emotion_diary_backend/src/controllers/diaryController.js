const { saveDiary, getDiaries, modifyDiaries} = require("../../src/models/diary.model");
const jwt = require('jsonwebtoken');

const saveDiaryController = async (req, res) => {
    const { emotion, text, date } = req.body;
      
    const authHeader = req.headers.authorization;

  if (!authHeader || !authHeader.startsWith("Bearer ")) {
    return res.status(401).json({ success: false, message: "Unauthorized: No token provided" });
  }
  const token = authHeader.split(" ")[1];
    const decoded = jwt.verify(token, process.env.JWT_KEY); // 비밀 키로 검증
    const userId = decoded.name;

  console.log("user: ",userId);

    if (!userId || !emotion || !text || !date) {
        return res.status(400).json({
            success: false,
            message: "Missing required fields",
        });
    }

    try {
        const diary = { 
            userId, 
            emotion, 
            text, 
            date: date.split('T')[0], 
        };
        console.log(diary);
        
        const result = await saveDiary(diary);
        res.status(201).json({
            success: true,
            data: result,
        });
    } catch (error) {
        console.error("Error saving diary:", error);
        res.status(500).json({
            success: false,
            message: "Failed to save diary",
            error: error.message,
        });
    }
};

const modifyDiariesController = async (req, res) => {
  const { emotion, text, date } = req.body;

  const authHeader = req.headers.authorization;

  if (!authHeader || !authHeader.startsWith("Bearer ")) {
    return res.status(401).json({ success: false, message: "Unauthorized: No token provided" });
  }
  const token = authHeader.split(" ")[1];
    const decoded = jwt.verify(token, process.env.JWT_KEY); // 비밀 키로 검증
    const userId = decoded.name;

  console.log("user: ",userId);

  // Validate input fields
  if (!userId || !emotion || !text || !date) {
    return res.status(400).json({
      success: false,
      message: "Missing required fields",
    });
  }

  try {
    const diary = { userId, emotion, text, date: date.split('T')[0] };
    const result = await modifyDiaries(diary);
    console.log(result);
    // Handle the result of the update
    if (result.matchedCount > 0) {
      if (result.modifiedCount > 0) {
        return res.status(200).json({
          success: true,
          message: "Diary updated successfully",
          data: result,
        });
      } else {
        return res.status(200).json({
          success: true,
          message: "No changes made to the diary",
          data: result,
        });
      }
    } else {
      return res.status(404).json({
        success: false,
        message: "Diary not found",
      });
    }
  } catch (error) {
    console.error("Error modifying diary:", error);
    return res.status(500).json({
      success: false,
      message: "Failed to modify diary",
      error: error.message,
    });
  }
};

const getDiariesController = async (req, res) => {
    var { year, month, day} = req.query;
    const authHeader = req.headers.authorization;

  if (!authHeader || !authHeader.startsWith("Bearer ")) {
    return res.status(401).json({ success: false, message: "Unauthorized: No token provided" });
  }
  const token = authHeader.split(" ")[1];
    const decoded = jwt.verify(token, process.env.JWT_KEY); // 비밀 키로 검증
    const userId = decoded.name;

  console.log("user: ",userId);
  
    if (!year || !month || !day) {
        return res.status(400).json({
            success: false,
            message: "Year, month, and day are required",
        });
    }
    month = month.toString().padStart(2, '0');
    day = day.toString().padStart(2, '0');
    
    try {
        const date = `${year}-${month}-${day}`;
        console.log(date);
        const diaries = await getDiaries(userId, date);
        if (!diaries || diaries.length === 0)
        {
            throw new Error("No data");
        }
        res.status(200).json({
            success: true,
            diaries : diaries
        });
        
    } catch (error) {
        console.error('Get diaries error:', error);
        res.status(500).json({
            success: false,
            message: "Failed to fetch diaries",
            error: error.message
        });
    }
};

module.exports = { 
    saveDiaryController, 
    getDiariesController,
    modifyDiariesController
};