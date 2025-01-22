/*
require("dotenv").config();
const express = require("express");

const app = express();
const diaryRoutes = require("./src/routes/diaryRoutes");
const calendarRoutes = require("./src/routes/calendarRoutes");
const TextGenerationRoutes = require("./src/routes/TextGenerationRoutes")

const AuthRoutes = require("./src/routes/authRoutes")

const fs = require('fs');
const path = require('path');

const cors = require("cors");
const {connectDB} = require("./src/config/db");

const uploadPath = path.join(__dirname, 'uploads');
if(!fs.existsSync(uploadPath)){fs.mkdirSync(uploadPath);}

app.use('/uploads', express.static(path.join(__dirname, 'uploads')));


//const cors = require("cors");
//const {connectDB} = require("./src/config/db");


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
  app.use("/api", TextGenerationRoutes);
  app.use("/auth", AuthRoutes);
  
  const PORT = process.env.PORT || 3000;
  app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
  });
}).catch((error) => {
  console.error("Failed to connect to the database", error);
});
*/

require("dotenv").config();
const express = require("express");
const cors = require("cors");
const fs = require("fs");
const path = require("path");
const { connectDB } = require("./src/config/db");
const { initializeUserModel } = require("./src/models/user.model");

const diaryRoutes = require("./src/routes/diaryRoutes");
const calendarRoutes = require("./src/routes/calendarRoutes");
const textGenerationRoutes = require("./src/routes/TextGenerationRoutes");
const authRoutes = require("./src/routes/authRoutes");

const app = express();

// 업로드 디렉토리 확인 및 생성
const uploadPath = path.join(__dirname, "uploads");
if (!fs.existsSync(uploadPath)) {
  fs.mkdirSync(uploadPath);
}

// 정적 파일 제공
app.use("/uploads", express.static(uploadPath));

// 미들웨어 설정
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// 데이터베이스 연결 및 서버 시작
connectDB()
  .then(() => {
    initializeUserModel(); // User 모델 초기화
    console.log("Connected to MongoDB");

    // 라우트 설정
    app.use("/", diaryRoutes);
    app.use("/", calendarRoutes);
    app.use("/api", textGenerationRoutes);
    app.use("/auth", authRoutes);

    // 서버 시작
    const PORT = process.env.PORT || 3000;
    app.listen(PORT, () => {
      console.log(`Server is running on port ${PORT}`);
    });
  })
  .catch((error) => {
    console.error("Failed to connect to the database", error);
  });
