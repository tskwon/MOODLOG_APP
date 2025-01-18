require("dotenv").config();
const express = require("express");
const app = express();
const diaryRoutes = require("./src/routes/diaryRoutes");
const calendarRoutes = require("./src/routes/calendarRoutes");

const cors = require("cors");
const {connectDB} = require("./src/config/db");


// // 미들웨어 설정
app.use(cors());
app.use(express.json());
app.use(express.urlencoded( {extended: true }));

// 데이터베이스 연결 및 서버 시작
connectDB().then((db) => {
  app.locals.db = db; // 데이터베이스 객체를 전역적으로 저장

  // 라우트 설정
  app.use("/", diaryRoutes);
  app.use("/", calendarRoutes);

  const PORT = process.env.PORT || 3000;
  app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
  });
}).catch((error) => {
  console.error("Failed to connect to the database", error);
});
