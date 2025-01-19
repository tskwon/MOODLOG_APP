//250119_2142_SH
/*살려주세요_2 */
/*
const User = require('../../model/user')
const { query } = require ('../../database')

exports.register = async(name, age, phone, email, gender, password) => {
    const user = new User({name, age, phone, email, gender, password,});
    return await user.save();
};

exports.login = async(email, password)=> {
    const user = await User.findOne({email,password});
    return user || null;
};

exports.findByEmail = async(email) => {
    const user = await User.findByEmail(email).select(`email`);
    return user || null;
}

exports.findId = async (id) => {
    const user = await User.findById(id).select('id name email createdAt');
    return user || null;
};
  
exports.update = async (id, name, image) => {
    const updateData = { name };
    if (image !== undefined) updateData.profileId = image;
    return await User.findByIdAndUpdate(id, updateData, { new: true }); 

};
*/

const User = require('../../model/user');
const { query } = require('../../database/query');

exports.register = async (name, age, phone, email, gender, password) => {
  const newUser = new User({name, age, phone, email, gender, password});
  return await query(newUser, 'save'); // MongoDB의 save() 호출
};

exports.login = async (email, password) => {
  return await query(User, 'findOne', { email, password}); // findOne() 호출
};

exports.findByPhone = async (email) => {
  return await query(User, 'findOne', { email }, 'email'); // 특정 필드 선택
};

exports.findId = async (id) => {
  return await query(User, 'findById', id, 'id name email createdAt'); // ID로 사용자 찾기
};

exports.update = async (id, name, image) => {
  const updateData = { name };
  if (image !== undefined) updateData.profileId = image;
  return await query(User, 'findByIdAndUpdate', id, updateData, { new: true }); // 업데이트 후 결과 반환
};
