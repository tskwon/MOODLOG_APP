const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
  name: { type: String, required: true },                 // 사용자 이름
  //age: { type: Number, required: true },                  // 사용자 나이
  //phone: { type: String, required: true, unique: true },  // 휴대폰 번호
  email: { type: String, required: true, unique: true },  // 이메일
  //gender: { type: String, enum: ['남', '여'], required: true }, // 성별
  password: { type: String, required: true },             // 비밀번호 (암호화된 상태)
  profileId: { type: mongoose.Schema.Types.ObjectId, ref: 'File', default: null }, // 프로필 이미지
  createdAt: { type: Date, default: Date.now },           // 생성 날짜
});

module.exports = mongoose.model('User', userSchema);
