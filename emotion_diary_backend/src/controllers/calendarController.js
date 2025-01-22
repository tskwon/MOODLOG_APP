const { getDiariesByMonth } = require("../../src/models/month.model");
const jwt = require('jsonwebtoken');


const getDiariesController = async (req, res) => {
  const { year, month } = req.query;

  const authHeader = req.headers.authorization;

  if (!authHeader || !authHeader.startsWith("Bearer ")) {
    return res.status(401).json({ success: false, message: "Unauthorized: No token provided" });
  }
  const token = authHeader.split(" ")[1];
    const decoded = jwt.verify(token, process.env.JWT_KEY); // 비밀 키로 검증
    const userId = decoded.name;

  console.log("user: ",userId);

  try {
    const diaries = await getDiariesByMonth(userId, parseInt(year), parseInt(month));
    res.status(200).json({ success: true, diaries : diaries});
  } catch (error) {
    res.status(500).json({ success: false, message: "Failed to fetch diaries", error: error.message });
  }
};

module.exports = { 
  getDiariesController 
};