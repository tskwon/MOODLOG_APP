/*
const user = require('../models/user.model');
const crypto = require('crypto');
require('dotenv').config();
const jwt = require('jsonwebtoken');
const upload = require('../config/multer');

exports.register = async(req,res) =>{
  try{
    const {name, email, password} = req.body;

    if (!name || !email || !password) {
        return res.status(400).json({
            success: false,
            message: "Missing required fields",
        });
    }

    // 중복된 이메일 확인
    const nameExists = await user.findByEmail_Name(name, 'name');
    const emailExists = await user.findByEmail_Name(email, 'email');

    if (nameExists != null) {
      return res.status(400).json({ success: false, message: '중복된 이름이 존재합니다.' });
    }//이거 동명이인 있을 수 있지 않을까요

    if (emailExists ) {
      return res.status(400).json({ success: false, message: '중복된 이메일이 존재합니다.' });
    }

    // 비밀번호 암호화
    const hashedPassword = crypto.pbkdf2Sync(password, process.env.SALT_KEY, 50, 100, 'sha512').toString('base64');

    //프로필 이미지 경로 설정
    //const profileImagePath = req.file ? `/uploads/${req.file.filename}` : null;
    //아래 코드는 서버 자체에 이미지를 저장하는 경우
    
    let profileImagePath = null;
    if (req.file) {
     profileImagePath = `/uploads/${req.file.filename}`;
    } else {
      console.log("No profile image uploaded.");
    }


    // 사용자 등록
    const newUser = await user.register(name, email, hashedPassword, profileImagePath);
    
    if (newUser["acknowledged"]) {
      // JWT 생성 원본: jwt.sign
      const token = jwt.sign({ id: newUser._id, name: newUser.name }, process.env.JWT_KEY);
      
      return res.status(201).json({ success: true, access_token: token });
    } else {
      return res.status(500).json({ success: false, message: '사용자 등록 중 오류가 발생했습니다.' });
    }
  } catch (error) {
    console.error(error);
    // 중복 키 오류 처리
    if (error.code === 11000) {
      return res.status(400).json({ success: false, message: '중복된 데이터가 존재합니다.' });
    }
    return res.status(500).json({ success: false, message: '서버 오류가 발생했습니다.' });
  }
}

exports.login = async (req, res) => {
  try {
    const { email, password } = req.body;

    // 비밀번호 암호화
    const hashedPassword = crypto.pbkdf2Sync(password, process.env.SALT_KEY, 50, 100, 'sha512').toString('base64');

    // 사용자 인증
    const user_auth = await user.login(email, hashedPassword);
    console.log(user_auth);

    
      if (!user_auth) {
      return res.status(401).json({ success: false, message: '이메일 또는 비밀번호가 잘못되었습니다.' });
    }

    // JWT 생성
    const token = jwt.sign({ id: user_auth._id, name: user_auth.name },process.env.JWT_KEY);
    console.log("logine completed: ", token);
    
    return res.status(200).json({ success: true, access_token: token });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ success: false, message: '서버 오류가 발생했습니다.' });
  }
};
*/

const { getBucket } = require("../config/db"); // GridFSBucket 가져오기
const crypto = require("crypto");
require("dotenv").config();
const jwt = require("jsonwebtoken");
const fs = require("fs");
const user = require("../models/user.model");

exports.register = async (req, res) => {
  try {
    const { name, email, password } = req.body;

    if (!name || !email || !password) {
      return res.status(400).json({
        success: false,
        message: "Missing required fields",
      });
    }

    // 중복된 이메일 확인
    const emailExists = await user.findByEmail_Name(email, "email");
    if (emailExists) {
      return res.status(400).json({
        success: false,
        message: "중복된 이메일이 존재합니다.",
      });
    }

    // 비밀번호 암호화
    const hashedPassword = crypto
      .pbkdf2Sync(password, process.env.SALT_KEY, 50, 100, "sha512")
      .toString("base64");

    // 프로필 이미지 업로드
    let profileImageId = null;
    if (req.file) {
      const bucket = getBucket(); // GridFSBucket 가져오기
      const uploadStream = bucket.openUploadStream(req.file.originalname, {
        contentType: req.file.mimetype,
      });
      

      const uploadResult = await new Promise((resolve, reject) => {
        fs.createReadStream(req.file.path).pipe(uploadStream);
        uploadStream.on("finish", ()=>resolve(uploadStream));
        uploadStream.on("error", reject);
      });

      profileImageId = uploadResult.id; // GridFS 파일 ID
      //profileImageId = uploadResult._id; // GridFS 파일 ID
      //profileImageId = uploadStream._id;
      
    }

    // 사용자 등록
    const newUser = await user.register(name, email, hashedPassword, profileImageId);

    if (newUser.acknowledged) {
      const token = jwt.sign({ id: newUser.insertedId, name }, process.env.JWT_KEY);
      return res.status(201).json({
        success: true,
        access_token: token,
      });
    } else {
      return res.status(500).json({ success: false, message: "사용자 등록 중 오류가 발생했습니다." });
    }
  } catch (error) {
    console.error(error);
    return res.status(500).json({ success: false, message: "서버 오류가 발생했습니다." });
  }
}
  exports.login = async (req, res) => {
    try {
      const { email, password } = req.body;
  
      // 비밀번호 암호화
      const hashedPassword = crypto.pbkdf2Sync(password, process.env.SALT_KEY, 50, 100, 'sha512').toString('base64');
  
      // 사용자 인증
      const user_auth = await user.login(email, hashedPassword);
      console.log(user_auth);
  
      
        if (!user_auth) {
        return res.status(401).json({ success: false, message: '이메일 또는 비밀번호가 잘못되었습니다.' });
      }
  
      // JWT 생성
      const token = jwt.sign({ id: user_auth._id, name: user_auth.name },process.env.JWT_KEY);
      console.log("logine completed: ", token);
      
      return res.status(200).json({ success: true, access_token: token });
    } catch (error) {
      console.error(error);
      return res.status(500).json({ success: false, message: '서버 오류가 발생했습니다.' });
    }
};


/*
const { getBucket } = require("../config/db"); // GridFSBucket 가져오기
const crypto = require("crypto");
require("dotenv").config();
const jwt = require("jsonwebtoken");
const fs = require("fs");
const user = require("../models/user.model");

exports.register = async (req, res) => {
  try {
    const { name, email, password } = req.body;

    if (!name || !email || !password) {
      return res.status(400).json({
        success: false,
        message: "Missing required fields",
      });
    }

    // 중복된 이메일 확인
    const emailExists = await user.findByEmail_Name(email, "email");
    if (emailExists) {
      return res.status(400).json({ success: false, message: "중복된 이메일이 존재합니다." });
    }

    // 비밀번호 암호화
    const hashedPassword = crypto
      .pbkdf2Sync(password, process.env.SALT_KEY, 50, 100, "sha512")
      .toString("base64");

    // 프로필 이미지 업로드
    let profileImageId = null;
    if (req.file) {
      const bucket = getBucket(); // GridFSBucket 가져오기
      const uploadStream = bucket.openUploadStream(req.file.originalname, {
        contentType: req.file.mimetype,
      });
      fs.createReadStream(req.file.path).pipe(uploadStream);

      const uploadResult = await new Promise((resolve, reject) => {
        uploadStream.on("finish", resolve);
        uploadStream.on("error", reject);
      });

      profileImageId = uploadResult._id; // GridFS 파일 ID
    }

    // 사용자 등록
    const newUser = await user.register(name, email, hashedPassword, profileImageId);

    if (newUser.acknowledged) {
      const token = jwt.sign({ id: newUser.insertedId, name }, process.env.JWT_KEY);
      return res.status(201).json({
        success: true,
        access_token: token,
      });
    } else {
      return res.status(500).json({ success: false, message: "사용자 등록 중 오류가 발생했습니다." });
    }
  } catch (error) {
    console.error(error);
    return res.status(500).json({ success: false, message: "서버 오류가 발생했습니다." });
  }
};
*/
/* 아래 코드는 프로필 사진 가져오는 방식 */
/* 이거는 마이페이지에서 할때 이런 방식으로 등록해도 될듯요? */
/*exports.getProfileImage = async (req, res) => {
  try {
    const { id } = req.params; // GridFS 파일 ID
    const objectId = new ObjectId(id);

    const downloadStream = bucket.openDownloadStream(objectId);
    res.set("Content-Type", "image/jpeg"); // MIME 타입 설정 타입 관련해서 늘려 놓으면 좀 더 파일 받아올떄 유해집니다.
    downloadStream.pipe(res);
  } catch (error) {
    console.error(error);
    res.status(500).json({
      success: false,
      message: "프로필 이미지 가져오기 실패",
    });
  }
};*/