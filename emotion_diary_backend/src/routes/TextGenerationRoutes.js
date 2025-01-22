const express = require("express");
const generateFeedbackController = require("../controllers/TextGenerationController");

const router = express.Router();

// 감정 피드백 생성 라우트
router.post("/generate-feedback", generateFeedbackController);

module.exports = router;
