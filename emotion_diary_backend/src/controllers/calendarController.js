const { getDiariesByMonth } = require("../../src/models/month.model");

const getDiariesController = async (req, res) => {
  const { year, month } = req.query;
  const userId = "user1"; // 인증된 사용자 ID

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