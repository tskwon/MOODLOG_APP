/*여기는 test 코드입니다. repo 및 참조는 하지 않습니다. */
/*line 4 ~ line 122 : 유저 개인 db 생성 및 할당*/
/*
const repository = require('./repository');
const crypto = require('crypto');
const jwt = require('./jwt');
const UserRepository = require("./UserRepository");

class UserController {
    constructor() {
        this.userRepository = new UserRepository();
    }

    async createUser(req, res) {
        const { username, password } = req.body;

        try {
            await this.userRepository.createUserAndDatabase(username, password);
            res.status(201).send({ message: "User and database created successfully!" });
        } catch (error) {
            res.status(500).send({ error: "Failed to create user and database." });
        }
    }

    async register(req, res) {
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
    }

    async login(req, res) {
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
    }

    async show(req, res) {
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
    }

    async update(req, res) {
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
    }
}

module.exports = UserController;
*/
/*line 125 ~  line 222 : 유저 이메일을 기반으로 개인 db 생성 및 할당*/
/*
const repository = require('./repository');
const crypto = require('crypto');
const jwt = require('./jwt');
const UserRepository = require("./repository");

class UserController {
    constructor() {
        this.userRepository = new UserRepository();
    }

    async createUser(req, res) {
        const { username, password } = req.body;

        try {
            const formattedUsername = username.split('@')[0]; // 이메일의 앞부분을 username으로 사용
            await this.userRepository.createUserAndDatabase(formattedUsername, password);
            res.status(201).send({ message: "User and database created successfully!" });
        } catch (error) {
            res.status(500).send({ error: "Failed to create user and database." });
        }
    }

    async register(req, res) {
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
    }

    async login(req, res) {
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
    }

    async show(req, res) {
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
    }

    async update(req, res) {
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
    }
}

module.exports = UserController;

*/
