require('dotenv').config();
const express = require('express');
const cors = require('cors');
const app = express();
const port = process.env.PORT || 3720;
const router = require('./src/router');
const bodyParser = require('body-parser');
const fs = require('fs');
const path = require('path');

const uploadPath = path.join(__dirname, 'uploads');
if(!fs.existsSync(uploadPath)){fs.mkdirSync(uploadPath);}

app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

// JSON 형식의 데이터 처리
app.use(bodyParser.json());
// URL 인코딩 된 데이터 처리
app.use(bodyParser.urlencoded({ extended: true }));

// 라우터를 애플리케이션에 등록
app.use('/', router);
//cors 문제 해결을 위한 추가적 모듈
app.use(cors());

// 서버 시작
app.listen(port, () => {
  console.log(`웹서버 구동중 ${port}`);
});
