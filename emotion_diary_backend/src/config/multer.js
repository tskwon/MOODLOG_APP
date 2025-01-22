const multer = require('multer');
const path = require('path');

// Multer 설정
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, 'uploads/'); // 업로드된 파일 저장 경로
  },
  filename: (req, file, cb) => {
    const uniqueName = `${Date.now()}-${Math.round(Math.random() * 1e9)}${path.extname(file.originalname)}`;
    cb(null, uniqueName); // 고유 파일 이름 생성
  },
});

const fileFilter = (req, file, cb) => {

  console.log('File Field Name:', file.fieldname); 
  console.log('File MIME Type:', file.mimetype);
    const allowedTypes = ['image/jpeg','image/jpg', 'image/png', 'image/gif', 'image/webp'];
    const allowedExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.webp'];
  
    const ext = path.extname(file.originalname).toLowerCase();
  
    if (allowedTypes.includes(file.mimetype) && allowedExtensions.includes(ext)) {
      cb(null, true);
    } else {
      cb(new Error('이미지 파일만 업로드할 수 있습니다.'));
    }
  };
  const upload = multer({
    storage,
    fileFilter,
    limits: { fileSize: 5 * 1024 * 1024 }, // 5MB 제한
  });
  
  module.exports = upload;
  

// 파일 필터 (이미지 파일만 허용)
/*
const fileFilter = (req, file, cb) => {
  if (file.mimetype.startsWith('image/')) {
    cb(null, true);
  } else {
    cb(new Error('이미지 파일만 업로드할 수 있습니다.'));
  }
};
*/
/*
const fileFilter = (req, file, cb) => {
    const allowedTypes = ['image/jpeg','image/jpg', 'image/png', 'image/gif', 'image/webp']; // 허용할 MIME 타입 목록
    if (allowedTypes.includes(file.mimetype)) {
      cb(null, true); // 허용된 파일
    } else {
      cb(new Error('이미지 파일만 업로드할 수 있습니다.')); // 거부된 파일
    }
  };
*/
