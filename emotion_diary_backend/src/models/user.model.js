/*
const { getDB } = require("../config/db");

const db = getDB("emotionDiary");
const collection = db.collection("UserInfo");

exports.register = async(name,email,password,profileImage) =>{
  query = { 
    "name": name,
    "email":email,
    "password":password,
    "profileImage":profileImage
   };
   console.log(query)
  const result = await collection.insertOne(query);

  return result;
}

exports.login = async (email, password) => {
  const query = {
    "email": email,
    "password": password
  }
  console.log("login", query);
  const result = await collection.findOne(query);
  return result;
};

exports.findByEmail_Name = async (value, field) => {
  const query = { [field]: value }; // 필드 동적으로 설정
  console.log("query: ", query);
  const result = await collection.findOne(query);
  return result;
};

*/
const { getDB } = require("../config/db");

let collection;

const initializeUserModel = () => {
  const db = getDB(); // connectDB 이후 호출
  collection = db.collection("UserInfo");
};

exports.initializeUserModel = initializeUserModel;

exports.register = async (name, email, password, profileImageId) => {
  if (!collection) {
    throw new Error("Collection is not initialized. Call initializeUserModel first.");
  }

  const query = {
    name,
    email,
    password,
    profileImage: profileImageId ? profileImageId : null,
  };

  console.log("Register query:", query);
  const result = await collection.insertOne(query);

  return result;
};

exports.login = async (email, password) => {
  const query = {
    email,
    password,
  };

  console.log("Login query:", query);
  const result = await collection.findOne(query);

  return result;
};

exports.findByEmail_Name= async (value, field) => {
  const query = { [field]: value }; // 필드 동적으로 설정
  console.log("Query:", query);
  const result = await collection.findOne(query);

  return result;
};




// exports.findId = async (id) => {
//   return await query(User, 'findById', id, 'id name email createdAt'); // ID로 사용자 찾기
// };

// exports.update = async (id, name, image) => {
//   const updateData = { name };
//   if (image !== undefined) updateData.profileId = image;
//   return await query(User, 'findByIdAndUpdate', id, updateData, { new: true }); // 업데이트 후 결과 반환
// };

/* 아래는 파일 ID를 이용해서 프로필 이미지 가져오는 방식 */
/*
exports.getProfileImageById = async (fileId) => {
  if (!ObjectId.isValid(fileId)) {
    throw new Error("Invalid file ID");
  }

  const gridFsDb = db.collection("profileImages.files");
  const file = await gridFsDb.findOne({ _id: new ObjectId(fileId) });

  return file;
};*/