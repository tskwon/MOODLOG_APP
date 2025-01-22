const generateFeedbackService = require("../services/TextGenerationService");

const generateFeedbackController = async (req, res) => {
    const { emotions } = req.body;
    console.log(emotions);
    if (!emotions || !Array.isArray(emotions) || emotions.length === 0) {
      return res.status(400).json({
        success: false,
        message: "Invalid input. 'emotions' should be a non-empty array.",
      });
    }

    try {
      const emotionSummary = emotions.join(", ");
      console.log(emotionSummary);
      const feedback = await generateFeedbackService(emotionSummary);
      return res.json({ success: true, feedback });
    } catch (error) {
      console.error("Error in TextGenerationController:", error.message);
      return res.status(500).json({
        success: false,
        message: "Failed to generate feedback.",
      });
    }
  }

module.exports = generateFeedbackController;
