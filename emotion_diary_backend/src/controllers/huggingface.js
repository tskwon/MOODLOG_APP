const axios = require("axios");

class MyTextGenerationPipeline {
  static async generateFeedback(emotionSummary, retryCount = 3, retryDelay = 5000) {
    try {
      // Hugging Face API Endpoint
      const API_URL = "https://api-inference.huggingface.co/models/t5-small";

      // Hugging Face API Key
      const API_KEY = process.env.HUGGINGFACE_API; // 환경 변수에 API 키 저장

      // API 요청 본문
      const payload = {
        inputs: `
          Given the following emotions: ${emotionSummary}.
          Provide feedback to help improve the user's emotional state.
        `,
        options: { wait_for_model: true }, // 모델 로딩 대기 설정
      };

      // POST 요청 보내기
      const response = await axios.post(API_URL, payload, {
        headers: {
          Authorization: `Bearer ${API_KEY}`, // 인증 헤더에 API 키 추가
          "Content-Type": "application/json",
        },
      });

      return response.data[0]?.generated_text || "No feedback generated.";
    } catch (error) {
      // 모델 로딩 대기 처리 및 재시도 로직
      if (
        error.response &&
        error.response.data &&
        error.response.data.error &&
        error.response.data.error.includes("currently loading")
      ) {
        if (retryCount > 0) {
          console.warn(`Model is loading. Retrying in ${retryDelay / 1000} seconds...`);
          await new Promise((resolve) => setTimeout(resolve, retryDelay)); // 대기 후 재시도
          return this.generateFeedback(emotionSummary, retryCount - 1, retryDelay);
        } else {
          console.error("Model loading timed out after multiple retries.");
        }
      }

      // 에러 처리
      console.error("Error calling Hugging Face API:", error.response ? error.response.data : error.message);
      throw new Error("Failed to generate feedback using Hugging Face API.");
    }
  }
}

module.exports = { 
  MyTextGenerationPipeline 
};
