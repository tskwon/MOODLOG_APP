/*살려주세요*/
/*250119 KSH */
const repository = require('./repository');
const crypto = require('crypto');
const jwt = require('./jwt');

/*repo에서도 작성 되었듯이 회원가입시 이름 이메일 비번으로 하실거면 ㅇㅇ */
/*
exports.register = async (req, res) => {
  try {
    const { phone, password, name, age, email, gender } = req.body;

    // 중복된 번호 확인
    const userExists = await repository.findByEmail(email);
    if (userExists) {
      return res.status(400).json({ result: 'fail', message: '중복된 이메일이 존재합니다.' });
    }

    // 비밀번호 암호화
    const hashedPassword = crypto.pbkdf2Sync(password, process.env.SALT_KEY, 50, 100, 'sha512').toString('base64');

    // 사용자 등록
    const newUser = await repository.register(name, age, phone, email, gender, hashedPassword);

    if (newUser) {
      // JWT 생성
      const token = jwt.sign({ id: newUser._id, name: newUser.name });
      return res.status(201).json({ result: 'ok', access_token: token });
    } else {
      return res.status(500).json({ result: 'fail', message: '사용자 등록 중 오류가 발생했습니다.' });
    }
  } catch (error) {
    console.error(error);
    // 중복 키 오류 처리
    if (error.code === 11000) {
      return res.status(400).json({ result: 'fail', message: '중복된 데이터가 존재합니다.' });
    }
    return res.status(500).json({ result: 'fail', message: '서버 오류가 발생했습니다.' });
  }
};*/

exports.register = async(req,res) =>{
  try{
    const {name, email, password} = req.body;
    // 중복된 번호 확인
    const userExists = await repository.findByEmail(email);
    if (userExists) {
      return res.status(400).json({ result: 'fail', message: '중복된 이메일이 존재합니다.' });
    }

    // 비밀번호 암호화
    const hashedPassword = crypto.pbkdf2Sync(password, process.env.SALT_KEY, 50, 100, 'sha512').toString('base64');

    // 사용자 등록
    const newUser = await repository.register(name, email, hashedPassword);

    if (newUser) {
      // JWT 생성
      const token = jwt.sign({ id: newUser._id, name: newUser.name });
      return res.status(201).json({ result: 'ok', access_token: token });
    } else {
      return res.status(500).json({ result: 'fail', message: '사용자 등록 중 오류가 발생했습니다.' });
    }
  } catch (error) {
    console.error(error);
    // 중복 키 오류 처리
    if (error.code === 11000) {
      return res.status(400).json({ result: 'fail', message: '중복된 데이터가 존재합니다.' });
    }
    return res.status(500).json({ result: 'fail', message: '서버 오류가 발생했습니다.' });
  }
}

exports.login = async (req, res) => {
  try {
    const { email, password } = req.body;

    // 비밀번호 암호화
    const hashedPassword = crypto.pbkdf2Sync(password, process.env.SALT_KEY, 50, 100, 'sha512').toString('base64');

    // 사용자 인증
    const user = await repository.login(email, hashedPassword);

    if (!user) {
      return res.status(401).json({ result: 'fail', message: '이메일 또는 비밀번호가 잘못되었습니다.' });
    }

    // JWT 생성
    const token = jwt.sign({ id: user._id, name: user.name });
    return res.status(200).json({ result: 'ok', access_token: token });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ result: 'fail', message: '서버 오류가 발생했습니다.' });
  }
};

exports.show = async (req, res) => {
  try {
    const userId = req.user.id; // 미들웨어를 통해 전달된 사용자 ID

    // 사용자 정보 조회
    const user = await repository.findId(userId);

    if (!user) {
      return res.status(404).json({ result: 'fail', message: '사용자를 찾을 수 없습니다.' });
    }

    return res.status(200).json({ result: 'ok', data: user });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ result: 'fail', message: '서버 오류가 발생했습니다.' });
  }
};

exports.update = async (req, res) => {
  try {
    const { name, profile_id } = req.body;
    const userId = req.user.id; // 미들웨어를 통해 전달된 사용자 ID

    // 사용자 정보 업데이트
    const updatedUser = await repository.update(userId, name, profile_id);

    if (!updatedUser) {
      return res.status(400).json({ result: 'fail', message: '사용자 정보를 업데이트할 수 없습니다.' });
    }

    // 업데이트된 사용자 정보 반환
    const user = await repository.findId(userId);
    return res.status(200).json({ result: 'ok', data: user });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ result: 'fail', message: '서버 오류가 발생했습니다.' });
  }
};